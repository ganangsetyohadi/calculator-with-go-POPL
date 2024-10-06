package main

import (
	"fmt"
	"html/template"
	"net/http"
	"strconv"
)

var tmpl = template.Must(template.ParseFiles("templates/index.html"))

func calculator(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		tmpl.Execute(w, nil)
		return
	}

	num1, err1 := strconv.ParseFloat(r.FormValue("num1"), 64)
	num2, err2 := strconv.ParseFloat(r.FormValue("num2"), 64)
	operation := r.FormValue("operation")
	var result float64
	var errMsg string

	if err1 != nil || err2 != nil {
		errMsg = "Invalid input, please enter numbers."
	} else {
		switch operation {
		case "add":
			result = num1 + num2
		case "subtract":
			result = num1 - num2
		case "multiply":
			result = num1 * num2
		case "divide":
			if num2 == 0 {
				errMsg = "Cannot divide by zero."
			} else {
				result = num1 / num2
			}
		default:
			errMsg = "Unknown operation."
		}
	}

	data := map[string]interface{}{
		"Num1":      num1,
		"Num2":      num2,
		"Operation": operation,
		"Result":    result,
		"ErrMsg":    errMsg,
	}

	tmpl.Execute(w, data)
}

func main() {
	http.Handle("/static/", http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))
	http.HandleFunc("/", calculator)
	fmt.Println("Server started at :8080")
	http.ListenAndServe(":8080", nil)
}
