from pathlib import Path
import os
from multiprocessing import Process, Queue

import cv2
import numpy as np
from aion.logger import lprint, lprint_exception

class OutputImageWriter():
    def __init__(self, output_dir, debug=False):
        self.output_dir = output_dir
        self.debug = debug
        if debug:
            self._initialize_window()

    def _initialize_window(self):
        cv2.namedWindow("template", cv2.WINDOW_NORMAL)
        cv2.resizeWindow('template', 1280, 720)
        cv2.startWindowThread()

    def _load_image(self, image_path):
        image = None
        path = Path(image_path)
        if path.suffix == ".npy":
            image = np.load(str(image_path))
        elif path.suffix == ".jpg":
            image = cv2.imread(str(image_path))
        return image

    def _write_rectangle_with_text(self, image, points, text):
        x1 = points['x'] + points['w']
        y1 = points['y'] + points['h']
        cv2.rectangle(image, (points['x'], points['y']), (x1, y1), 255, 2)
        cv2.putText(image, text,
                    (points['x'], points['y']),
                    cv2.FONT_HERSHEY_SIMPLEX, 1,
                    (254, 0, 0), 3, cv2.LINE_AA)
        return image

    def run(self, image_path, results):
        image = self._load_image(image_path)
        if image is None:
            lprint(f'Faild to write output image.')
            return

        for result in results:
            points = result['matching_points']
            text = f"{result['matching_rate']:.5f}"
            image = self._write_rectangle_with_text(image, points, text)

        output_path = os.path.join(self.output_dir, os.path.basename(image_path))
        cv2.imwrite(output_path, image)

        if self.debug:
            cv2.imshow("template", image)
            cv2.waitKey(1)
        return


class OutputImageGenerator():
    def __init__(self, output_dir, debug=False):
        self.queue = Queue()
        self.process = Process(
            target=self._loop_output_images,
            args=(self.queue, output_dir, debug))
        self.process.start()

    def __del__(self):
        self.queue.put((None, None))
        self.process.terminate()

    def _loop_output_images(self, queue, output_dir, debug):
        image_writer = OutputImageWriter(output_dir, debug)

        while True:
            image_path, results = queue.get()

            if image_path is not None or results is not None:
                image_writer.run(image_path, results)
            else:
                break
        return

    def request(self, image_path, results):
        self.queue.put((image_path, results))
        return
