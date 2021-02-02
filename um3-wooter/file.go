package main

import (
	"fmt"
	"io/ioutil"
	"os"
)

func createFile() {
	// detect if file exists
	var _, err = os.Stat("lastJob.txt")

	// create file if not exists
	if os.IsNotExist(err) {
		var file, err = os.Create("lastJob.txt")
		if err != nil {
			panic(err)
		}
		defer file.Close()
	}

	fmt.Println("==> done creating file", "lastJob.txt")
}

func readFile() (b []byte) {
	createFile()
	// read the whole file at once
	b, err := ioutil.ReadFile("lastJob.txt")
	if err != nil {
		panic(err)
	}
	return
}

func writeFile(b []byte) {
	// write the whole body at once
	err := ioutil.WriteFile("lastJob.txt", b, 0644)
	if err != nil {
		panic(err)
	}
}
