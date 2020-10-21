import pytest

from src import log
from src.errors import TemplateMatchingSetTemplatesError

from src.utils import mysql


# @pytest.mark.skip()
def test_get_all_vehicles():
    dicts = mysql.get_all_vehicles()
    assert len(dicts) > 0
    log.print(dicts)
    log.print(f'Count: {len(dicts)}')
    return


# @pytest.mark.skip()
def test_get_by_vehicle_name():
    car_type = 'IS_2WD'
    dicts = mysql.get_by_vehicle_name(car_type)
    assert len(dicts) > 0
    log.print(dicts)
    log.print(f'Count: {len(dicts)}')
    return


# @pytest.mark.skip()
def test_get_end():
    dicts = mysql.get_end()
    assert len(dicts) > 0
    log.print(dicts)
    log.print(f'Count: {len(dicts)}')
    return
