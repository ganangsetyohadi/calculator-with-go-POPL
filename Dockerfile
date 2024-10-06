# Step 1: Build the Go app
FROM golang:1.20-alpine AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Go modules file (go.mod) to the container
COPY go.mod ./

# Since there are no dependencies, skip go mod download
# Uncomment the following line if you use dependencies
# RUN go mod download

# Copy the source code to the container
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
