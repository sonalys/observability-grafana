FROM debian

# Install Dependencies
RUN apt update
RUN apt install -y git musl-dev golang bash curl gnupg make wget libfontconfig1 postgresql-11
# Install Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt install yarn -y
# Configure Go
ENV GOROOT /usr/lib/go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
ENV GOOS="linux"
# Install Grafana
RUN wget -q https://dl.grafana.com/oss/release/grafana_6.4.1_amd64.deb
RUN dpkg -i grafana_6.4.1_amd64.deb
RUN rm -rf grafana*.deb
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
# Build App
COPY /app /app
WORKDIR /app
RUN make build
ENTRYPOINT [ "./run.sh" ]