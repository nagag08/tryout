FROM alpine:latest

RUN apk --no-cache add nginx

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
