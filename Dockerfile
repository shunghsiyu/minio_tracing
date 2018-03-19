FROM golang:1.9.4-alpine3.7
ARG user=minio
ARG dlv_version=v1.0.0
ARG minio_version=RELEASE.2018-03-16T22-52-12Z
ARG uid=1999
RUN apk update && \
    apk add build-base git
RUN adduser -D -u $uid $user
USER $user
ENV GOPATH /home/$user/go
ENV PATH $GOPATH/bin:$PATH
RUN go get -d -u github.com/derekparker/delve/cmd/dlv && \
    cd $GOPATH/src/github.com/derekparker/delve/cmd/dlv && \
    git checkout -b stable $dlv_version && \
    go install
RUN go get -d -u github.com/minio/minio && \
    cd $GOPATH/src/github.com/minio/minio && \
    git checkout -b stable $minio_version
COPY entrypoint.sh /bin/entrypoint.sh
WORKDIR /home/$user/go/src/github.com/minio/minio
ENV MINIO_ACCESS_KEY miniominio
ENV MINIO_SECRET_KEY miniominiominio
ENTRYPOINT ["/bin/entrypoint.sh"]
CMD ["github\\.com/minio/minio/cmd\\..*PutObject"]
