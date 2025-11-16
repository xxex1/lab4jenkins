FROM jenkins/jenkins:lts

USER root

# Установка Python и pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Установка Python зависимостей
RUN pip3 install --break-system-packages Flask && \
    pip3 install --break-system-packages unittest-xml-reporting

USER jenkins
