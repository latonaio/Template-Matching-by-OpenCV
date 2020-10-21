import os
import cv2

from aion.logger import lprint


class OpencvTemplateMatchingInCuda():
    def __init__(self):
        assert cv2.cuda.getCudaEnabledDeviceCount()

        self.cv2_template_matching = cv2.cuda.createTemplateMatching(cv2.CV_8UC1, cv2.TM_CCOEFF_NORMED)

    def run(self, gpu_mat, template_gpu_mat):
        res = self.cv2_template_matching.match(gpu_mat, template_gpu_mat)
        res_download = res.download()
        _, val, _, loc = cv2.minMaxLoc(res_download)
        return val, loc


class OpencvTemplateMatchingInCPU():
    def __init__(self):
        self.cv2_template_matching = None

    def run(self, image, template_image):
        # TODO: Return dummy value
        return 99999, [100, 100]


def initialize_template_matching():
    if os.environ.get('TEMPLATE_MATCHING_BY_OPENCV_SERVER_MODE') == 'CPU' \
            and not cv2.cuda.getCudaEnabledDeviceCount():
        # log.print('*' * 50)
        # log.print('Warning: Using OpencvTemplateMatchingInCPU')
        # log.print('*' * 50)
        return OpencvTemplateMatchingInCPU()

    assert cv2.cuda.getCudaEnabledDeviceCount()
    return OpencvTemplateMatchingInCuda()
