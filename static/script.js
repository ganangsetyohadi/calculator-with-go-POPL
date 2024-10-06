// Function to validate the form before submission
function validateForm() {
    const num1 = document.getElementById("num1").value;
    const num2 = document.getElementById("num2").value;
    const operation = document.getElementById("operation").value;

    if (!num1 || isNaN(num1)) {
        alert("Please enter a valid number for the first input.");
        return false;
    }
    if (!num2 || isNaN(num2)) {
        alert("Please enter a valid number for the second input.");
        return false;
    }
    if (!operation) {
        alert("Please select an operation.");
        return false;
    }

    return true;
}
