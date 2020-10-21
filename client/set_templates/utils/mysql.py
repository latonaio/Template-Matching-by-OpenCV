from aion import mysql
from aion.logger import lprint


DB_NAME = 'Vehicle'
TABLE_NAME = 'vehicle'
RIGHT_TABLE_NAME = 'template'


class MySQLClient():
    def _get_query_list(self, sql):
        dicts = []
        with mysql.BaseMysqlAccess(DB_NAME) as db:
            dicts = db.get_query_list(100, sql)
        return dicts

    def get_all_vehicles(self):
        sql = f'''
            SELECT
                vehicle.id as vehicle_id, vehicle.vehicle_name,
                template.id as template_id, template.is_car_end, template.template_path,
                template.left, template.top, template.right, template.bottom,
                template.trim_points_ratio, template.pass_threshold
            FROM {DB_NAME}.{TABLE_NAME} as vehicle
            INNER JOIN {DB_NAME}.{RIGHT_TABLE_NAME} as template
            ON vehicle.id = template.vehicle_id
            WHERE template.is_car_end = 0;
        '''
        return self._get_query_list(sql)

    def get_by_vehicle_name(self, vehicle_name):
        sql = f"""
            SELECT
                vehicle.id as vehicle_id, vehicle.vehicle_name,
                template.id as template_id, template.is_car_end, template.template_path,
                template.left, template.top, template.right, template.bottom,
                template.trim_points_ratio, template.pass_threshold
            FROM {DB_NAME}.{TABLE_NAME} as vehicle
            INNER JOIN {DB_NAME}.{RIGHT_TABLE_NAME} as template
            ON vehicle.id = template.vehicle_id
            WHERE vehicle.vehicle_name = '{vehicle_name}'
                and template.is_car_end = 0;
        """
        return self._get_query_list(sql)

    def get_end(self):
        sql = f"""
            SELECT
                vehicle.id as vehicle_id, vehicle.vehicle_name,
                template.id as template_id, template.is_car_end, template.template_path,
                template.left, template.top, template.right, template.bottom,
                template.trim_points_ratio, template.pass_threshold
            FROM {DB_NAME}.{TABLE_NAME} as vehicle
            INNER JOIN {DB_NAME}.{RIGHT_TABLE_NAME} as template
            ON vehicle.id = template.vehicle_id
            WHERE template.is_car_end > 0;
        """
        return self._get_query_list(sql)
