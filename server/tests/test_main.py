import copy
import time
import subprocess
from pprint import pprint

import pytest

from template_matching import ImagePaths, IntializeData
from tests.clients.template_matching import TemplateMatchingClient


@pytest.fixture(scope='function', autouse=True)
def run_server():
    process = subprocess.Popen('python3 main.py', shell=True)
    # Wait to start server
    time.sleep(2)
    yield process
    process.kill()
    return


@pytest.fixture(scope='function')
def client():
    with TemplateMatchingClient() as client:
        yield client
    return


@pytest.fixture(scope='function')
def image_paths():
    data = IntializeData()
    image_paths = [data.image_path, data.image_path]
    return image_paths


@pytest.fixture(scope='function')
def templates():
    data = IntializeData()
    return data.templates_data


def assert_set_templates(res):
    pprint(res)
    assert res['status']
    return


def assert_not_set_templates(res):
    pprint(res)
    assert res['message']
    return


def assert_get_matching_result(res):
    pprint(res)
    data = res.get('data')
    assert data
    for d in data:
        assert d.get('input_path')
        assert d.get('output_path')
        templates = d.get('templates')
        assert templates
        for t in templates:
            matching_points = t.get('matching_points')
            assert matching_points
            assert matching_points.get('x')
            assert matching_points.get('y')
            assert matching_points.get('w')
            assert matching_points.get('h')
            assert t.get('matching_rate')
    return


def assert_get_matching_result_for_empty(res):
    pprint(res)
    data = res.get('data')
    assert data
    for d in data:
        assert d.get('input_path')
        assert d.get('output_path')
        templates = d.get('templates')
        assert templates == []
    return


def assert_not_get_matching_result(res):
    pprint(res)
    assert res['message']
    return


@pytest.mark.skip()
def test_1(client, templates):
    # set_templates(): OK
    res = client.set_templates(templates)
    assert_set_templates(res)
    return


@pytest.mark.skip()
def test_2(client, image_paths):
    # get_matching_result(): OK
    res = client.get_matching_result(image_paths)
    assert_get_matching_result(res)
    return


@pytest.mark.skip()
def test_3(client, image_paths, templates):
    # set_templates(): OK
    # get_matching_result(): OK
    res = client.set_templates(templates)
    assert_set_templates(res)
    res = client.get_matching_result(image_paths)
    assert_get_matching_result(res)
    return


# @pytest.mark.skip()
def test_4(client, image_paths):
    # set_templates(): OK
    #   description: templates is empty.
    # get_matching_result(): OK
    templates = []
    res = client.set_templates(templates)
    assert_set_templates(res)
    res = client.get_matching_result(image_paths)
    assert_get_matching_result_for_empty(res)
    return


@pytest.mark.skip()
def test_error_1(client, image_paths, templates):
    # set_templates(): NG
    #   description: "template_image"."path" is wrong.
    # run(): NG
    # set_templates(): OK
    # run(): OK
    wrong_templates = copy.deepcopy(templates)
    wrong_templates[0]['template_image']['path'] = 'path/to/wrong_image.jpg'
    res = client.set_templates(wrong_templates)
    assert_not_set_templates(res)

    res = client.get_matching_result(image_paths)
    assert_not_get_matching_result(res)

    res = client.set_templates(templates)
    assert_set_templates(res)

    res = client.get_matching_result(image_paths)
    assert_get_matching_result(res)
    return


@pytest.mark.skip()
def test_error_2(client, image_paths, templates):
    # set_templates(): OK
    # run(): NG
    #   description: "image"."trim_points" is wrong.
    # set_templates(): OK
    # run(): OK
    wrong_templates = copy.deepcopy(templates)
    res = client.set_templates(wrong_templates)
    assert_set_templates(res)

    res = client.get_matching_result(image_paths)
    assert_not_get_matching_result(res)

    res = client.set_templates(templates)
    assert_set_templates(res)

    res = client.get_matching_result(image_paths)
    assert_get_matching_result(res)
    return


@pytest.mark.skip()
def test_error_3(client, image_paths, templates):
    # set_templates(): OK
    # run(): NG
    #   description: image_paths[0] is wrong.
    # set_templates(): OK
    # run(): OK
    res = client.set_templates(templates)
    assert_set_templates(res)

    wrong_image_paths = copy.deepcopy(image_paths)
    wrong_image_paths[0] = 'path/to/wrong_image.jpg'
    res = client.get_matching_result(wrong_image_paths)
    assert_not_get_matching_result(res)

    res = client.set_templates(templates)
    assert_set_templates(res)

    res = client.get_matching_result(image_paths)
    assert_get_matching_result(res)
    return


@pytest.mark.skip()
def test_error_4(client, image_paths, templates):
    # set_templates(): OK
    # run(): NG
    #   description: image_paths[0] is a empty file.
    # set_templates(): OK
    # run(): OK
    res = client.set_templates(templates)
    assert_set_templates(res)

    wrong_image_paths = copy.deepcopy(image_paths)
    wrong_image_paths[0] = ImagePaths.EMPTY
    res = client.get_matching_result(wrong_image_paths)
    assert_not_get_matching_result(res)

    res = client.set_templates(templates)
    assert_set_templates(res)

    res = client.get_matching_result(image_paths)
    assert_get_matching_result(res)
    return
