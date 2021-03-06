package main

import (
	"encoding/json"
	"log"
	"os"
	"os/exec"
)

const (
	iptables = "iptables"
)

type node struct {
	Address string
}

func main() {
	dec := json.NewDecoder(os.Stdin)
	nodes := []node{}

	if err := dec.Decode(&nodes); err != nil {
		log.Fatal(err)
	}

	flush := exec.Command(
		iptables,
		"-F", "CLUSTER",
	)

	if err := flush.Run(); err != nil {
		log.Fatal(err)
	}

	for _, node := range nodes {
		add := exec.Command(
			iptables,
			"-A", "CLUSTER",
			"-j", "ACCEPT",
			"-s", node.Address,
		)

		if err := add.Run(); err != nil {
			log.Fatal(err)
		}
	}
}
