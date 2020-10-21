import copy

import pytest

from template_matching import IntializeData
from template_matching.run.multiprocess import TemplateMatchingByMultiprocess
from template_matching.errors import TemplateMatchingException


@pytest.fixture(scope='function', autouse=True)
def data():
    n_templates = 4
    data = IntializeData(n_templates)
    return data


@pytest.fixture(scope='function')
def template_matching(data):
    templates_data = data.templates_data
    image_path = data.image_path
    n_process = 2

    template_matching = TemplateMatchingByMultiprocess(templates_data, image_path, n_process=n_process)
    return template_matching


# @pytest.mark.skip()
def test_1(data, template_matching):
    # set_templates(): OK
    # run(): OK
    n_templates = data.n_templates
    templates_data = data.templates_data
    image_path = data.image_path

    template_matching.set_templates(templates_data)
    results = template_matching.run(image_path)
    assert n_templates == len(results)
    return


# @pytest.mark.skip()
def test_error_1(data, template_matching):
    # set_templates(): NG
    # run(): NG
    # set_templates(): OK
    # run(): OK
    n_templates = data.n_templates
    templates_data = data.templates_data
    image_path = data.image_path

    wrong_templates_data = copy.deepcopy(templates_data)
    wrong_templates_data[0] = {}
    with pytest.raises(Exception):
        template_matching.set_templates(wrong_templates_data)

    with pytest.raises(Exception):
        results = template_matching.run(image_path)

    template_matching.set_templates(templates_data)

    results = template_matching.run(image_path)
    assert n_templates == len(results)
    return


# @pytest.mark.skip()
def test_error_2(data, template_matching):
    # set_templates(): OK
    # run(): NG
    # run(): OK
    n_templates = data.n_templates
    templates_data = data.templates_data
    image_path = data.image_path

    template_matching.set_templates(templates_data)

    wrong_image_path = 'wrong_path/to/image.jpg'
    with pytest.raises(Exception):
        results = template_matching.run(wrong_image_path)

    results = template_matching.run(image_path)
    assert n_templates == len(results)
    return
