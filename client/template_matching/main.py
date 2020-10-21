#!/usr/bin/env python3

import os
import grpc

from google.protobuf.json_format import MessageToDict
from aion.microservice import main_decorator, Options
from aion.logger import lprint, lprint_exception, initialize_logger
from proto import template_matcning_pb2, template_matcning_pb2_grpc

SERVICE_NAME = os.environ.get("SERVICE")
SERVER_HOST = os.environ.get("SERVER_HOST", "template-matching-by-opencv-server-001-srv")
SERVER_PORT = os.environ.get("SERVER_PORT", 50052)

initialize_logger(SERVICE_NAME)


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

    def get_matching_result(self, picture_path_list):
        if picture_path_list is None:
            print("Error: npy is None")
            return None

        request_data = template_matcning_pb2.Matching(picture_file_list=picture_path_list)
        try:
            res = self.stub.get_matching_result(request_data)
            data = MessageToDict(res.data_dict)
        except grpc.RpcError as e:
            lprint_exception(e)
            return None
        else:
            return data.get('data')


@main_decorator(SERVICE_NAME)
def main(opt: Options):
    conn = opt.get_conn()
    num = opt.get_number()

    try:
        for kanban in conn.get_kanban_itr(SERVICE_NAME, num):
            lprint("recieve picture_list from select-picture-by-time")

            picture_list = kanban.get_metadata()['picture_list']
            if len(picture_list) < 1:
                raise "ERROR: no picture list"

            for image_path in picture_list:
                if not os.path.exists(image_path):
                    lprint(image_path + " dosen't exist.")
                    continue

            with Request() as r:
                matching_data_list = r.get_matching_result(picture_list)

            if len(matching_data_list) > 0:
                conn.output_kanban(
                    result=True,
                    metadata={"matching_data_list": matching_data_list},
                    process_number=num,
                )
                lprint("success to send matching_data_list as metadata")

    except Exception as e:
        print(str(e))


if __name__ == "__main__":
    main()
