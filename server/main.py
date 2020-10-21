#!/usr/bin/env python3

from concurrent import futures
from google.protobuf.json_format import MessageToDict
from google.protobuf.struct_pb2 import Struct
import grpc
import os
from proto import template_matcning_pb2
from proto import template_matcning_pb2_grpc
from aion.logger import initialize_logger, lprint
from template_matching import IntializeData, TemplateMatchingByMultiprocess

SERVICE_NAME = os.environ.get("SERVICE")
SERVER_PORT = 50052
OUTPUT_PATH = "/var/lib/aion/Data"
N_TEMPLATES = 15
N_PROCESS = 5

initialize_logger(SERVICE_NAME)


class TemplateMatchingServicer(template_matcning_pb2_grpc.TemplateMatchingServicer):
    def __init__(self):
        super().__init__()
        self.struct = Struct()

    def set_templates(self, request, context):
        lprint("connect from template-matching-set-templates")

        required_keys = ['templates']
        data = MessageToDict(request.template_data)
        for key in required_keys:
            if key not in data:
                raise ServerFunctionFailedException(f"Bad Request: not found 'templates' in request")
                return template_matcning_pb2.SetResult(result=False)

        templates_data = data['templates']
        self.match.set_templates(templates_data)
        return template_matcning_pb2.SetResult(result=True)

    def get_matching_result(self, request, context):
        lprint("connect from template-matching-by-opencv")

        if self.match.n_process < 1:
            raise ServerFunctionFailedException("there are no templates")

        picture_file_list = request.picture_file_list
        if picture_file_list is None:
            raise ServerFunctionFailedException("there is no picture_file_list in request")

        for image_path in picture_file_list:
            if not os.path.exists(image_path):
                lprint(image_path + " dosen't exist.")
                self.struct.update({'data': ''})
                return template_matcning_pb2.MatchingResult(data_dict=self.struct)

        data_list = []
        for image_path in picture_file_list:
            try:
                results = self.match.run(image_path)
                # Write output image
                # self.output_image_generator.request(image_path, results)
                output_path = os.path.join(OUTPUT_PATH, os.path.basename(image_path))

                data_list.append({
                    'input_path': image_path,
                    'output_path': output_path,
                    'templates': results
                })
            except Exception as e:
                lprint(e)

        self.struct.update({'data': data_list})
        return template_matcning_pb2.MatchingResult(data_dict=self.struct)

    @classmethod
    def initialize(cls, templates_data, image_path, n_process):
        cls.match = TemplateMatchingByMultiprocess(templates_data, image_path, n_process)
        cls.match.set_templates([])

    @classmethod
    def destructor(cls):
        del cls.match


class ServerFunctionFailedException(Exception):
    def __init__(self, message):
        self.message = message

    def __str__(self):
        return (self.message)


def main():
    try:
        data = IntializeData(N_TEMPLATES)
        TemplateMatchingServicer.initialize(data.templates_data, data.image_path, N_PROCESS)
        server = grpc.server(futures.ThreadPoolExecutor(max_workers=5))
        template_matcning_pb2_grpc.add_TemplateMatchingServicer_to_server(
            TemplateMatchingServicer(), server
        )
        server.add_insecure_port('[::]:' + str(SERVER_PORT))
        server.start()
        server.wait_for_termination()
    finally:
        TemplateMatchingServicer.destructor()


if __name__ == "__main__":
    main()
