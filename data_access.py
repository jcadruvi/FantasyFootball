import psycopg2
import psycopg2.extras

from flask_logging import FlaskLogging

from settings import (
    SQL_HOST,
    SQL_DATABASE,
    SQL_USER_NAME,
    SQL_PASSWORD
)


class DataAccess(object):
    def __init__(self):
        self.logger = FlaskLogging().get_logger(name=__name__)

    def query(self, sql, parameters):
        """
        Will run a Postgres query.
        :param sql: The query SQL.
        :type sql: string
        :param parameters: Any parameters for the query.
        :type parameters: tuple
        :return: The results of the query.
        """

        conn = None
        cursor = None
        try:
            conn = psycopg2.connect("dbname='" + SQL_DATABASE + "' user='" +
                                    SQL_USER_NAME + "' host='" + SQL_HOST +
                                    "' password='" + SQL_PASSWORD + "'")
            cursor = conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)
            self.logger.info(sql)
            self.logger.info(parameters)
            cursor.execute(sql, parameters)
            return cursor.fetchall()
        except Exception as e:
            self.logger.exception(e)
            raise e
        finally:
            if cursor:
                cursor.close()
            if conn:
                conn.commit()
                conn.close()
