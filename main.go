package main

import (
	"fmt"
	"net/http"
)

func main() {
	http.Handle("/", http.FileServer(http.Dir("./static")))

	http.HandleFunc("/api/hello", func(w http.ResponseWriter, r *http.Request) {
		fmt.Fprintf(w, "Hello CI/CD 🚀")
	})

	fmt.Println("Server running at :8080")
	http.ListenAndServe(":8080", nil)
}