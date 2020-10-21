import os
import grpc

from aion.logger import lprint, lprint_exception
from google.protobuf.struct_pb2 import Struct
from proto import template_matcning_pb2, template_matcning_pb2_grpc

SERVER_HOST = os.environ.get("SERVER_HOST", "template-matching-by-opencv-server-001-srv")
SERVER_PORT = os.environ.get("SERVER_PORT", 50052)


class Request():
    def __init__(self):
        self.channel = None
        self.stub = None

    def __enter__(self):
        self.channel = grpc.insecure_channel(f'{SERVER_HOST}:{SERVER_PORT}')
        self.stub = template_matcning_pb2_grpc.TemplateMatchingStub(self.channel)
        return self

    def __exit__(self, exc_type, exe_value, traceback):
        if self.channel is not None:
            self.channel.close()
        self.channel = None
        self.stub = None

        if exc_type is not None:
            raise RuntimeError(exe_value)
        return

    def _reshape_templates(self, templates):
        '''
        Return:
            new_templates (list):
                examples: [
                    {
                        "template_image": {
                            "path": "path/to/file_name.jpg",
                            "trim_points": [[640, 360], [1280, 720]]  # NOTE: Not used
                        },
                        "image": {
                            "trim_points": [[640, 360], [1280, 720]],
                            "trim_points_ratio": 0
                        },
                        "metadata": {
                            "vehicle_id": -1,  # NOTE: Not used
                            "template_id": -1,
                            "pass_threshold": 0.7
                        }
                    },
                ]
        '''
        new_templates = []
        for template in templates:
            new_template = {
                "template_image": {
                    "path": template['template_path'],
                },
                "image": {
                    "trim_points": [
                        [template['left'], template['top']],
                        [template['right'], template['bottom']]
                    ],
                    "trim_points_ratio": template['trim_points_ratio']
                },
                "metadata": {
                    "vehicle_id": template['vehicle_id'],
                    "vehicle_name": template['vehicle_name'],
                    "template_id": template['template_id'],
                    "is_car_end": template['is_car_end'],
                    "pass_threshold": template['pass_threshold']
                }
            }
            new_templates.append(new_template)
        return new_templates

    def set_templates(self, templates):
        new_templates = self._reshape_templates(templates)

        json_dict = {
            'templates': new_templates,
        }
        s = Struct()
        s.update(json_dict)
        request_data = template_matcning_pb2.Set(template_data=s)
        try:
            self.stub.set_templates(request_data)
        except grpc.RpcError as e:
            lprint_exception(e)
        else:
            lprint("success to send. gRPC status: ", grpc.StatusCode.OK)
