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

  for _, node := range nodes {
    pre := exec.Command(
      "iptables",
      "-C", "INPUT",
      "-j", "ACCEPT",
      "-s", node.Address,
    )

    add := exec.Command(
      "iptables",
      "-I", "INPUT",
      "-j", "ACCEPT",
      "-s", node.Address,
    )

    if err := pre.Run(); err == nil {
      return
    }

    if err := add.Run(); err != nil {
      log.Fatal(err)
    }
  }
}
