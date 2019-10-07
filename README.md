# ABOUT
Container with binary spawning fake metrics to a local prometheus server
# REQUIREMENTS
* Docker
# INSTALL
* [Grafana](https://grafana.com/docs/installation)
# BUILD
* docker build -t observability -f container.Dockerfile .
# RUN
* docker run -it -p 9090:9090 observability
* docker run -d --name=grafana -p 3000:3000 grafana/grafana
# CONFIGURATION
* add source localhost:9090 inside grafana