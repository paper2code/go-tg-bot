FROM golang:1.10-alpine as builder

RUN apk --no-cache add git \
    && cd /go/src \
    && git clone https://github.com/coolrc136/go-tg-bot.git \
    && cd go-tg-bot \
    && go get ./... \
    && CGO_ENABLED=0 GOOS=linux go build


FROM alpine

ENV TOKEN "your_token"
ENV SERVER "https://youserver.com:8443"
ENV TULING "afafw"

COPY --from=0 /go/src/go-tg-bot/go-tg-bot /bot/

RUN apk upgrade && apk add --no-cache ca-certificates

CMD cd /bot && /bot/go-tg-bot -n=true -server=$SERVER -token=$TOKEN -tuling=$TULING
EXPOSE 8443
