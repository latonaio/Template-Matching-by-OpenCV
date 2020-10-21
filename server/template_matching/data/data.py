import copy
import os

IMAGE_PATH = os.path.join(os.path.dirname(__file__), 'images', 'default.jpg')


class IntializeData():
    def __init__(self, n_templates=15):
        assert n_templates > 1
        self.n_templates = 15

    @property
    def image_path(self):
        return IMAGE_PATH

    @property
    def templates_data(self):
        const_data = [
            {
                "template_image": {
                    "path": IMAGE_PATH,
                    "trim_points": [[640, 360], [1280, 720]]
                },
                "image": {
                    "trim_points": [[640, 360], [1280, 720]],
                    "trim_points_ratio": 0
                },
                "metadata": {
                    "template_id": -1,
                    "work_id": -1,
                    "pass_threshold": 0.7
                }
            },
            {
                "template_image": {
                    "path": IMAGE_PATH,
                    "trim_points": [[640, 360], [1280, 720]]
                },
                "image": {
                    "trim_points": [[540, 260], [1180, 620]],
                    "trim_points_ratio": 0
                },
                "metadata": {
                    "template_id": -2,
                    "work_id": -1,
                    "pass_threshold": 0.7
                }
            },
            {
                "template_image": {
                    "path": IMAGE_PATH,
                    "trim_points": [[640, 360], [1280, 720]]
                },
                "image": {
                    "trim_points": [[540, 260], [1180, 620]],
                    "trim_points_ratio": 0.5
                },
                "metadata": {
                    "template_id": -3,
                    "work_id": -1,
                    "pass_threshold": 0.7
                }
            },
            {
                "template_image": {
                    "path": IMAGE_PATH,
                    "trim_points": [[640, 360], [1280, 720]]
                },
                "image": {
                    "trim_points": [[540, 260], [1180, 620]],
                    "trim_points_ratio": 1
                },
                "metadata": {
                    "template_id": -4,
                    "work_id": -2,
                    "pass_threshold": 0.7
                }
            },
            # No template_image.trim_points
            {
                "template_image": {
                    "path": IMAGE_PATH
                },
                "image": {
                    "trim_points": [[0, 0], [1920, 1080]],
                    "trim_points_ratio": 0
                },
                "metadata": {
                    "template_id": -5,
                    "work_id": -2,
                    "pass_threshold": 0.7
                }
            },
            # No image.trim_points
            {
                "template_image": {
                    "path": IMAGE_PATH
                },
                "image": {
                    "trim_points": [[0, 0], [1920, 1080]],
                    "trim_points_ratio": 0
                },
                "metadata": {
                    "template_id": -6,
                    "work_id": -2,
                    "pass_threshold": 0.7
                }
            },
        ]

        if self.n_templates <= len(const_data):
            return const_data[:self.n_templates]

        n_lacking = self.n_templates - len(const_data)
        work_id = const_data[-1]['metadata']['work_id'] - 1
        add_data = []
        for i in range(1, n_lacking + 1):
            _dict = copy.deepcopy(const_data[0])
            _dict['metadata']['template_id'] = const_data[-1]['metadata']['template_id'] + -1 * i
            _dict['metadata']['work_id'] = work_id
            add_data.append(_dict)
        return const_data + add_data
