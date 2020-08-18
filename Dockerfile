# ARG ubuntu_version=16.04
#FROM ubuntu:${ubuntu_version}
#Use ubuntu 16:04 as your base image
FROM ubuntu:16.04
#Any label to recognise this image.


#install the below packages on the ubuntu image
RUN apt-get update -y && apt-get install -y gnupg2 wget openjdk-8-jre python3-pip python3-dev \
&& cd /usr/local/bin \
&& ln -s /usr/bin/python3 python \
&& pip3 install --upgrade pip setuptools

COPY ./requirements.txt /app/requirements.txt
COPY ./training.py /app/training.py

WORKDIR /app
RUN pip install -r requirements.txt


EXPOSE 8080



COPY . /app

ENTRYPOINT [ "python3" ]

CMD [ "app.py" ]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
