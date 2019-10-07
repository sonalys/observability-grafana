FROM alpine

COPY api /api

RUN apk add bash
RUN wget -q https://github.com/prometheus/prometheus/releases/download/v2.13.0/prometheus-2.13.0.linux-amd64.tar.gz
RUN mkdir prometheus
RUN tar xvfz prometheus-*.tar.gz
RUN mv prometheus-2.13.0.linux-amd64 prometheus
COPY prometheus_config.yml /prometheus/config.yml

COPY run.sh /run.sh
RUN chmod +x run.sh

ENTRYPOINT [ "./run.sh" ]