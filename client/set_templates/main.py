import os

from aion.microservice import main_decorator, Options
from aion.logger import initialize_logger, lprint
from utils.mysql import MySQLClient
from utils.request import Request

SERVICE_NAME = os.environ.get("SERVICE")
START_MODE = os.environ.get("START_MODE", "by-name")

initialize_logger(SERVICE_NAME)


@main_decorator(SERVICE_NAME)
def main(opt: Options):
    conn = opt.get_conn()
    num = opt.get_number()
    vehicle_data = {
        "vehicle": True,
        "vehicle_name": "",
        "end": True,
    }

    if START_MODE == "by-name":
        conn.set_kanban(SERVICE_NAME, num)
    elif START_MODE == "from-kanban":
        kanban = conn.get_one_kanban(SERVICE_NAME, num)
        metadata = kanban.get_metadata()
        vehicle_data = metadata['args']

    lprint(f"vehicle_data: {vehicle_data}")
    templates = []
    vehicle = vehicle_data['vehicle']
    vehicle_name = vehicle_data['vehicle_name']
    end = vehicle_data['end']

    try:
        ms = MySQLClient()
        if vehicle and not vehicle_name:
            templates += ms.get_all_vehicles()
            lprint("set_template all")
        elif vehicle and vehicle_name:
            templates += ms.get_by_vehicle_name(vehicle_name)
            lprint(f"set_template {vehicle_name}")

        if end:
            templates += ms.get_end()
            lprint("set_template end")

        if templates:
            with Request() as r:
                r.set_templates(templates)

    except Exception as e:
        print(str(e))


if __name__ == "__main__":
    main()
