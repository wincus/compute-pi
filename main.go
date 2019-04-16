package main

import (
	"encoding/json"
	"net/http"
	"strconv"

	"github.com/claygod/PiHex"
)

var (
	version = "Build version unavailable"
)

func handler(w http.ResponseWriter, r *http.Request) {

	digitsOfPi, err := strconv.Atoi(r.URL.Path[1:])

	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")

	pi := PiHex.New()

	res := struct{ 
		Result []byte 
		Version string
		}{pi.Get(0, digitsOfPi), version}

	jData, _ := json.Marshal(&res)

	w.WriteHeader(http.StatusOK)
	w.Write(jData)

}

func main() {

	http.HandleFunc("/", handler)

	if err := http.ListenAndServe(":80", nil); err != nil {
		panic(err)
	}
}
