FROM golang:alpine AS goLangBuilder

# o Alpine usa o "apk update" e "apk add", enquanto o Ubuntu usaria o "apt get update ... install"
RUN apk update && apk add --no-cache git

WORKDIR $GOPATH/src/fullcycle/codeeducation/desafio_1_docker

COPY /src/. .

RUN go get -d -v

RUN go build -o /bin/main

# o scratch é uma imagem super mínima do debian utilizado para coisas bem pequenas, como um HelloWorld
FROM scratch

#
COPY --from=goLangBuilder /bin/main /bin/main

# aqui a gente manda rodar o que está no pacote main, dentro da imagem "goLangBuilder" nossa, que será o arquivo "main.go"
ENTRYPOINT ["/bin/main"]