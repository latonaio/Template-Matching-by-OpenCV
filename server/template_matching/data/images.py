import os

PWD = os.path.dirname(__file__)
IMAGE_DIR = os.path.join(PWD, 'images')


class ImagePaths:
    DEFAULT = os.path.join(IMAGE_DIR, 'default.jpg')
    EMPTY = os.path.join(IMAGE_DIR, 'empty.jpg')
