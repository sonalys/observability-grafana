# ABOUT
Container with binary spawning fake metrics to a local prometheus server
# BUILD
* [Grafana](https://grafana.com/docs/installation)
* docker build -t observabilidade -f container.Dockerfile .
# RUN
* docker run -it -p 9090:9090 observabilidade
* docker run -d --name=grafana -p 3000:3000 grafana/grafana
# CONFIGURATION
* add source localhost:9090 inside grafana