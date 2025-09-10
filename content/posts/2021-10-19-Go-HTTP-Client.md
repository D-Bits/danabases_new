---
title: Writing an HTTP Client in Go
publishdate: 2021-10-25
tags:
  - go
draft: false
---

One of my new years resolutions was to learn new programming languages. Consequently, I recently set out to familiarize myself with Go. I've found that one of the best ways to learn a new programming language is to start with simple console programs, as well as re-implementing earlier projects. Therefore, I set out to write a console program in Go as a starting point.

## Project Setup

The project will a simple CLI-based HTTP client that extracts some JSON from a REST API endpoint of the user's choosing, and saves it as a `.json` file to the local file system. I won't go into how to setup a development environment for Go (*I just used Docker, and VS Code integrations*) here. However, we do need to create some files and directories first. To begin with, we need to create a `bin/` directory for executables, and a `data/` directory to save our data dumps in. To implement the actual program, we need two source files: `main.go` and `fetch.go`, where we will be writing the bulk of our logic. While it is not strictly necessary, we will also be adding a `Makefile` to simplify program compilation and execution, with the following rules:

```makefile
SHELL := /bin/bash

run:
    go run main.go fetch.go

compile:
    go build -o bin/
    GOOS=windows GOARCH=amd64 go build -o bin/
    GOOS=darwin GOARCH=amd64 go build -o bin/ 
```

## The Logic

The function we will be using to both extract and dump our data will be in the `fetch.go` file. The code is as follows:

```go
package main

import (
    "fmt"
    "io/ioutil"
    "log"
    "net/http"
    "os"
)

func getData(endpoint string, filename string) {

    // make a GET request to fetch the JSON data
    res, err := http.Get(endpoint)

    // Log any errors
    if err != nil {
        log.Fatal(err)
    }

    // store the response body in a variable
    body, err := ioutil.ReadAll(res.Body)

    if err != nil {
        log.Fatal(err)
    }

    // Create a file to write to
    file, err := os.Create("./data/" + filename + ".json")
    // Write the JSON to an external file
    file.WriteString(string(body))

    if err != nil {
        log.Fatal(err)
    } else {
        fmt.Println("Download complete. Check the 'data' directory.")
    }

}
```

As you can see, the code is actually pretty straightforward. Not necessarily Python simple, but still quite intuitive.  

## Main

Our main file will actually need to include a little bit of logic as well. 

```go
package main

import (
    "bufio"
    "fmt"
    "os"
    "strings"
)

func main() {

    // Create a reader
    reader := bufio.NewReader(os.Stdin)

    fmt.Print("Enter a URL: ")
    url, _ := reader.ReadString('\n')
    // Remove the newline before passing into getData() function
    formattedUrl := strings.TrimSuffix(url, "\n")
    fmt.Print("Enter a file name (without a file extension): ")
    filename, _ := reader.ReadString('\n')
    formattedFilename := strings.TrimSuffix(filename, "\n")

    getData(formattedUrl, formattedFilename)

    // Prompt the user to press enter to exit
    fmt.Print("Press enter to exit.")
    reader.ReadString('\n')

}
```

This will allow a user to pass in necessary values for the parameters in `fetch.go` via standard input. After our program has fulfilled its purpose, we then prompt the user to press enter to exit the program.

To run the program, we run either `go run main.go fetch.go` or `make run` from the terminal.

## Conclusions

Although this is a rather simple program, it was a pleasant introduction to Go nonetheless, and has compelled me to explore the language so more. I'm already working on a different console program in Golang. At some point in the near future, I also hope to implement something more sophisticated, like a REST API.

You can find the code for the project [here](https://github.com/D-Bits/GoSys).