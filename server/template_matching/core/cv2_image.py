import os
from pathlib import Path

import cv2
import numpy as np

from aion.logger import lprint
from template_matching.errors import TemplateMatchingException


class OpenCVImage():
    def __init__(self):
        self.color_img = None
        self.width = None
        self.height = None
        self.trim_image = None

    def load_image(self, image_path):
        path = Path(image_path)

        if not path.exists():
            lprint(f"{image_path} doesn't exists")
            raise FileNotFoundError(f"{image_path} doesn't exists")

        if path.suffix == ".npy":
            self.color_img = np.load(str(image_path))
        elif path.suffix == ".jpg":
            self.color_img = cv2.imread(str(image_path))
        else:
            lprint(f"{image_path} doesn't load as image")
            raise TemplateMatchingException(f"{image_path} doesn't load as image")

        self.height, self.width, _ = self.color_img.shape
        return

    def set_trim_image(self, trim):
        assert (
            trim[0][0] <= trim[1][0]
            and trim[0][1] <= trim[1][1]
            and trim[0][0] < self.color_img.shape[1]
            and trim[1][0] <= self.color_img.shape[1]
            and trim[0][1] < self.color_img.shape[0]
            and trim[1][1] <= self.color_img.shape[0]
        )
        self.trim_image = self.color_img[trim[0][1]:trim[1][1], trim[0][0]:trim[1][0]]
        self.trim_image_height, self.trim_image_width, _ = self.trim_image.shape
        return


class OpenCVImageInCuda(OpenCVImage):
    def __init__(self):
        super().__init__()
        self.gpu_mat = cv2.cuda_GpuMat()

    def setup_for_template_matching(self):
        self.gpu_mat.upload(self.trim_image)
        self.gpu_mat = cv2.cuda.cvtColor(self.gpu_mat, cv2.COLOR_RGB2GRAY)
        return


class OpenCVImageInCPU(OpenCVImage):
    def __init__(self):
        super().__init__()
        self.gpu_mat = None

    def setup_for_template_matching(self):
        self.gpu_mat = cv2.cvtColor(self.trim_image, cv2.COLOR_BGR2GRAY)
        return


def initialize_cv2_image():
    if os.environ.get('TEMPLATE_MATCHING_BY_OPENCV_SERVER_MODE') == 'CPU' \
            and not cv2.cuda.getCudaEnabledDeviceCount():
        # log.print('*' * 50)
        # log.print('Warning: Using OpenCVImageInCPU')
        # log.print('*' * 50)
        return OpenCVImageInCPU()

    assert cv2.cuda.getCudaEnabledDeviceCount()
    return OpenCVImageInCuda()


if __name__ == "__main__":
    cv2_img = initialize_cv2_image('file/data/Example_Full_HD.jpg')

    trim = [[400, 100], [1680, 820]]
    gpu_mat = cv2_img.setup_image(trim)
    print(gpu_mat.download().shape)
