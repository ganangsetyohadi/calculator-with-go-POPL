# Step 1: Build the Go app
FROM golang:1.20-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod (without go.sum, since your project doesn't have it)
COPY go.mod ./

# Download dependencies (if any, otherwise this won't do much)
RUN go mod download

# Copy the source code
COPY . .

# Build the Go app
RUN go build -o web-calculator main.go

# Step 2: Create the final container
FROM alpine:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the built binary from the previous stage
COPY --from=build /app/web-calculator .

# Copy templates and static files
COPY --from=build /app/templates ./templates
COPY --from=build /app/static ./static

# Expose the port the app runs on
EXPOSE 8080

# Command to run the executable
CMD ["./web-calculator"]
