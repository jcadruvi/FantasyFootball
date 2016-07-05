FROM python:2.7
MAINTAINER Josh Cadruvi <jcadruvi78@yahoo.com>

RUN apt-get update && apt-get install -y \
        build-essential \
        curl \
        git \
        git-core \
        net-tools \
        vim \
        wget \
        gunicorn \
        supervisor

RUN mkdir -p /opt/fantasy_football
WORKDIR /opt/fantasy_football
COPY . /opt/fantasy_football
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

EXPOSE 5001

CMD ["supervisord", "-c", "/opt/fantasy_football/supervisord.conf"]