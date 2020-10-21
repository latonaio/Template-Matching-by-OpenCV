from template_matching.core.matcher import Matcher
from template_matching.errors import TemplateMatchingException
from aion.logger import lprint


class TemplateMatching():
    def __init__(self, templates_data, image_path):
        self.matcher = Matcher(templates_data, image_path)

    def set_templates(self, templates_data):
        self.matcher.set_templates(templates_data)
        return True

    def run(self, image_path):
        results = self.matcher.run(image_path)
        return results


if __name__ == "__main__":
    import time
    from pprint import pprint

    from template_matching import IntializeData

    n_templates = 3
    data = IntializeData(n_templates)
    templates_data = data.templates_data
    image_path = data.image_path

    mather = TemplateMatching(templates_data, image_path)
    mather.set_templates(templates_data)

    s = time.time()
    matching_data = mather.run(image_path)
    e = time.time()
    pprint(matching_data)
    print(e - s)
