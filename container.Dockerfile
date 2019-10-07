FROM alpine

RUN apk add bash
RUN apk add yarn

# Add Go
RUN apk add --no-cache git make musl-dev go
# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
ENV GOOS="linux"
# Build App
COPY /app /app
WORKDIR /app
RUN make build
# Install prometheus
WORKDIR /
RUN wget -q https://github.com/prometheus/prometheus/releases/download/v2.13.0/prometheus-2.13.0.linux-amd64.tar.gz
RUN mkdir prometheus
RUN tar xvfz prometheus-*.tar.gz
RUN mv prometheus-2.13.0.linux-amd64/* /prometheus
COPY prometheus_config.yml /prometheus/config.yml
RUN rm -rf prometheus-*
# Configure Entrypoint script
COPY run.sh /run.sh
RUN chmod +x run.sh
ENTRYPOINT [ "./run.sh" ]