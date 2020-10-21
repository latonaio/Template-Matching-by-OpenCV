from queue import Queue

import socketio


class TemplateMatchingNameSpace(socketio.ClientNamespace):
    def __init__(self):
        super().__init__('/template_matching')
        self.set_templates_queue = Queue()
        self.get_matching_result_queue = Queue()

    def on_connect(self):
        print('on_connect')
        return

    def on_disconnect(self):
        print('on_disconnect')
        return

    def on_set_templates_1(self, data):
        # print('on_set_templates_1', data)
        self.set_templates_queue.put(data)
        return

    def on_get_matching_result_1(self, data):
        # print('on_get_matching_result_1', data)
        self.get_matching_result_queue.put(data)
        return


class TemplateMatchingClient(socketio.Client):
    def __init__(self):
        super().__init__()
        self.namespace = TemplateMatchingNameSpace()
        self.register_namespace(self.namespace)

    def __enter__(self):
        self.connect('http://localhost:3091')
        return self

    def __exit__(self, exc_type, exc_value, traceback):
        if exc_type is not None:
            raise exc_type(exc_value)
        self.disconnect()
        return

    def emit(self, event_name, data):
        print(event_name)
        super().emit(event_name, data, namespace='/template_matching')
        return

    def set_templates(self, templates):
        data = {
            'eventName': 'set_templates',
            'sessionID': '1',
            'templates': templates
        }
        self.emit('sync_request', data)
        res = self.namespace.set_templates_queue.get(timeout=10)
        return res

    def get_matching_result(self, file_paths):
        data = {
            'eventName': 'get_matching_result',
            'sessionID': '1',
            'pictureFileList': file_paths
        }
        self.emit('sync_request', data)
        res = self.namespace.get_matching_result_queue.get(timeout=20)
        return res


if __name__ == "__main__":
    from template_matching import IntializeData

    data = IntializeData()
    templates = data.templates_data
    image_paths = [data.image_path, data.image_path]

    res1 = None
    res2 = None
    with TemplateMatchingClient() as client:
        res1 = client.set_templates(templates)
        res2 = client.get_matching_result(image_paths)
    print(res1)
    print(res2)
