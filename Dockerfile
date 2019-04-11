FROM golang:1.12

ENV CGO_ENABLED=0\
    GOOS=linux

ARG RELEASE_VER=undefined

WORKDIR /go/src/github.com/wincus/compute-pi

COPY . ./

RUN go get

RUN CGO_ENABLED=0 GOOS=linux go build -a -tags netcgo -ldflags '-w' -ldflags "-X main.version=$RELEASE_VER" -o compute-pi .

FROM alpine:latest

WORKDIR /

COPY --from=0 /go/src/github.com/wincus/compute-pi/compute-pi .

ENV PORT 80
EXPOSE 80
ENTRYPOINT ["/compute-pi"]