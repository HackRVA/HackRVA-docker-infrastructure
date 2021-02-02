package main

import (
	"errors"
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
)

// Response -- struct for PrintJob Json response
type Response struct {
	UUID      string `json:"uuid"`
	Name      string `json:"name"`
	TotalTime int64  `json:"time_total"`
	State     string
}

func getEnv(envvar string) (string, error) {
	v := os.Getenv(envvar)

	if len(v) == 0 {
		return "", errors.New("that environment variable is not set")
	}

	return v, nil
}

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	slackHook, err := getEnv("SLACK_HOOK")

	if err != nil {
		fmt.Errorf("error getting slackHook %s", err.Error())
		return
	}

	um3URI, err := getEnv("UM3_URI")

	if err != nil {
		fmt.Errorf("error getting um3URI %s", err.Error())
		return
	}

	lastJob := readFile()
	currJob := getJob(um3URI)
	finishes := howLong(currJob.TotalTime)

	if string(lastJob) != currJob.UUID {
		if currJob.State != "printing" {
			return
		}
		writeFile([]byte(currJob.UUID))
		newMsg := fmt.Sprint("woot! new printjob:\n\t`",
			currJob.Name, "`\n ```time: ",
			secondsToHuman(currJob.TotalTime),
			"\nfinishes: ",
			finishes,
			"``` https://ultimaker.hackrva.org")

		postJob(newMsg, slackHook)
	}
}
