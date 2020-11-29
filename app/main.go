package main

import (
	"fmt"
	"math/rand"
	"net/http"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promauto"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	requestsCounter = promauto.NewCounterVec(
		prometheus.CounterOpts{
			Name: "requests_counter",
			Help: "The total number of requests",
		},
		[]string{"url", "status_code"},
	)

	requestsHistogram = promauto.NewHistogram(
		prometheus.HistogramOpts{
			Name:    "requests",
			Help:    "Histogram of requests duration by url and size",
			Buckets: prometheus.ExponentialBuckets(10, 1.8, 10),
		},
	)
)

func recordRequests() {
	for {
		switch rand.Intn(3) {
		case 0:
			{
				requestsCounter.WithLabelValues("/home", "200").Inc()
				requestsHistogram.Observe(float64(150))
				break
			}
		case 1:
			{
				requestsCounter.WithLabelValues("/messages", "300").Inc()
				requestsHistogram.Observe(float64(300))
				break
			}
		case 2:
			{
				url := fmt.Sprintf("/messages/%d", rand.Intn(5000))
				requestsCounter.WithLabelValues(url, "400").Inc()
				requestsHistogram.Observe(float64(100))
				break
			}
		}
		time.Sleep(1000 * time.Millisecond)
	}
}

func main() {
	fmt.Println("Initializing Server")
	http.Handle("/metrics", promhttp.Handler())

	fmt.Println("Initializing Routines")
	go recordRequests()

	if err := http.ListenAndServe(":8001", nil); err != nil {
		return
	}
}
