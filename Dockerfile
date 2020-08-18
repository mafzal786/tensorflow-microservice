# ARG ubuntu_version=16.04
#FROM ubuntu:${ubuntu_version}
#Use ubuntu 16:04 as your base image
FROM ubuntu:16.04
#Any label to recognise this image.
ENV APP_DIR /app
ENV NB_USER=nbuser
ENV NB_UID=1011

#install the below packages on the ubuntu image
RUN apt-get update -y && apt-get install -y gnupg2 wget openjdk-8-jre python3-pip python3-dev \
&& cd /usr/local/bin \
&& ln -s /usr/bin/python3 python \
&& pip3 install --upgrade pip setuptools


COPY ./requirements.txt $APP_DIR/requirements.txt
COPY ./training.py $APP_DIR/training.py
COPY ./app.py $APP_DIR/app.py

RUN useradd -m -s /bin/bash -N -u $NB_UID $NB_USER \
    && usermod -g root $NB_USER \
    && chown -R $NB_USER $APP_DIR 


USER $NB_UID
WORKDIR /app
RUN pip install -r requirements.txt


EXPOSE 8080






ENTRYPOINT [ "python3" ]

CMD [ "app.py" ]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
