package main

import (
  "os"
  "os/exec"
  "log"
  "encoding/json"
)

type Node struct {
  Node string
  Address string
}

func main() {
  dec := json.NewDecoder(os.Stdin)

  nodes := []Node{}

  if err := dec.Decode(&nodes); err != nil {
    log.Fatal(err)
  }

  flush := exec.Command(
    "iptables",
    "-F", "CLUSTER",
  )

  if err := flush.Run(); err != nil {
    log.Fatal(err)
  }

  for _, node := range nodes {
    add := exec.Command(
      "iptables",
      "-I", "CLUSTER",
      "-j", "ACCEPT",
      "-s", node.Address,
    )

    if err := add.Run(); err != nil {
      log.Fatal(err)
    }
  }
}
