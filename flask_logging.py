import logging

from settings import LOGGING_LEVEL


class FlaskLogging(object):
    _logger = None

    def get_logger(self, name):
        logger = self._logger
        if not logger:
            logger = logging.getLogger(name)
            logger.setLevel(LOGGING_LEVEL)
            logger.propagate = False
            file_handler = logging.FileHandler(filename="flask.log", encoding="UTF-8")
            file_handler.setLevel(LOGGING_LEVEL)
            formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
            file_handler.setFormatter(formatter)
            logger.addHandler(file_handler)
            self._logger = logger
        return logger