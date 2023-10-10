FROM golang:1.13-alpine as builder
# git 설치 안되어있을까봐 불안해서 한번 해보자.
RUN apk update && apk add git  
WORKDIR /usr/src/app
COPY . . 
# COPY main.go . 라고 써도 상관없다.
# 디렉 안의 go 파일들을 빌드해서 main이라는 바이너리 파일을 현재 디렉에 생성해라
RUN CGO_ENABLED=0 GOO=linux GOARCH=amd64 go build -o main .
# 다단계 빌드 때문에 작성
FROM scratch 
# 앞의 builder라는 from 절에서 /usr/src/app 디렉의 내용을 현재 디렉으로 복사
COPY --from=builder /usr/src/app . 
CMD ["/main"]