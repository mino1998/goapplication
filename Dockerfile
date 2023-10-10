FROM golang:1.13-alpine as builder
# git 설치 안되어있을까봐 불안해서 한번 해보자.
RUN apk update && apk add git  
WORKDIR /usr/src/app
COPY . . 
# COPY main.go . 라고 써도 상관없다.
RUN CGO_ENABLED=0 GOO=linux GOARCH=amd64 go build -o main .

FROM scratch 
COPY --from=builder /usr/src/app . 
CMD ["/main"]