FROM golang:1.9 as builder
WORKDIR /go/src/app
COPY . .
RUN go get -u github.com/golang/dep/cmd/dep && dep init && CGO_ENABLED=0 GOOS=linux go-wrapper install 

FROM alpine:3.7
RUN apk add --no-cache --update ca-certificates 
COPY --from=builder /go/bin/app .
CMD ["./app"]
