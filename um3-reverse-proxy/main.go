package main

import (
	"net/http"
	"net/http/httputil"
	"net/url"

	"github.com/gorilla/mux"
)

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", proxyHandler("http://10.200.200.132:8080/?action=stream"))

	http.Handle("/", r)
	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		panic(err)
	}
}

func proxyHandler(target string) func(http.ResponseWriter, *http.Request) {
	remote, err := url.Parse(target)
	if err != nil {
		panic(err)
	}

	proxy := httputil.NewSingleHostReverseProxy(remote)

	return func(w http.ResponseWriter, r *http.Request) {
		r.URL.Host = remote.Host
		r.URL.Scheme = remote.Scheme
		r.Header.Set("X-Forwarded-Host", r.Header.Get("Host"))
		r.Host = remote.Host

		r.URL.Path = remote.Path
		proxy.ServeHTTP(w, r)
	}
}
