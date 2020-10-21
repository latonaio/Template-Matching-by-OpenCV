import sys
import more_itertools
import multiprocessing
import traceback

from template_matching.core.matcher import Matcher
from template_matching.errors import TemplateMatchingException
from aion.logger import lprint, lprint_exception


def pool_template_matching(args_queue, return_queue, templates_data, image_path):
    matcher = Matcher(templates_data, image_path)

    while True:
        exit_status = True
        return_value = None

        function_name, kwargs = args_queue.get()
        try:
            if function_name == 'set_templates':
                matcher.set_templates(kwargs['templates_data'])

            elif function_name == 'run':
                return_value = matcher.run(kwargs['image_path'])

            else:
                raise TemplateMatchingException('pool_matching() recieve Invalid function name ({function_name}).')

        except Exception as e:
            exit_status = False
            lprint_exception(e)
            # lprint_exception(e)

        return_queue.put((exit_status, return_value))
    return


class _TemplateMatchingByChildProcess():
    def __init__(self, templates_data, image_path):
        # ctx = multiprocessing.get_context('spawn')
        ctx = multiprocessing.get_context()
        self.args_queue = ctx.Queue()
        self.return_queue = ctx.Queue()
        self.process = ctx.Process(
            target=pool_template_matching,
            args=(self.args_queue, self.return_queue, templates_data, image_path),
            daemon=True)
        self.process.start()

    def __del__(self):
        self.terminate()

    def terminate(self):
        if hasattr(self, 'process'):
            self.process.terminate()
        return

    def start_set_templates(self, templates_data):
        self.args_queue.put(('set_templates', {'templates_data': templates_data}))
        return

    def start_template_matching(self, image_path):
        lprint("start_template_matching...")
        self.args_queue.put(('run', {'image_path': image_path}))
        return

    def get_from_return_queue(self):
        exit_status, return_value = self.return_queue.get()
        return exit_status, return_value


class TemplateMatchingByMultiprocess():
    def __init__(self, templates_data, image_path, n_process=8):
        assert len(templates_data) > n_process

        self.n_process = n_process
        self.processes = []

        divided_templates_data = [list(x) for x in more_itertools.divide(self.n_process, templates_data)]
        for _templates_data in divided_templates_data:
            process = _TemplateMatchingByChildProcess(_templates_data, image_path)
            process.is_active = True
            self.processes.append(process)

    def __del__(self):
        self.terminate_all()

    def terminate_all(self):
        for process in self.processes:
            process.terminate()
        return

    def set_templates(self, templates_data):
        divided_templates_data = [list(x) for x in more_itertools.divide(self.n_process, templates_data)]
        for process, _templates_data in zip(self.processes, divided_templates_data):

            if _templates_data:
                process.start_set_templates(_templates_data)
                process.is_active = True
            else:
                process.is_active = False

        all_exit_status = []
        for process in self.processes:
            if process.is_active:
                exit_status, _ = process.get_from_return_queue()
                all_exit_status.append(exit_status)

        if not all(all_exit_status):
            msg = 'MultiprocessMatching.set_templates() is faild.'
            print(msg)
            raise TemplateMatchingException(msg)
        return

    def run(self, image_path):
        for process in self.processes:
            if process.is_active:
                process.start_template_matching(image_path)

        all_exit_status = []
        results = []
        for process in self.processes:
            if process.is_active:
                exit_status, _results = process.get_from_return_queue()
                all_exit_status.append(exit_status)
                if _results:
                    results.extend(_results)

        if not all(all_exit_status):
            msg = 'MultiprocessMatching.get_matching_result()'
            print(msg)
            raise TemplateMatchingException(msg)

        return results
