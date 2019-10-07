# ABOUT
Container with binary spawning fake metrics to a local prometheus server
# REQUIREMENTS
* Docker
# BUILD
* docker build -t observability -f container.Dockerfile .
# RUN
* docker run -it -p 3000:3000 observability