package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
)

func getJob(URI string) Response {

	req, err := http.NewRequest("GET", URI, nil)
	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()

	body, _ := ioutil.ReadAll(resp.Body)

	response1 := Response{}
	jsonErr := json.Unmarshal(body, &response1)
	if jsonErr != nil {
		log.Fatal(jsonErr)
	}

	return response1
}

func postJob(msg string, hook string) {
	fmt.Println(msg)

	newMsg := fmt.Sprint(`{"text":'`, msg, `'}`)
	var jsonStr = []byte(newMsg)
	req, err := http.NewRequest("POST", hook, bytes.NewBuffer(jsonStr))
	req.Header.Set("Content-Type", "application/json")

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()
}
