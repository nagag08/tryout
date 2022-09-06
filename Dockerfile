FROM alpine:latest

RUN apk --no-cache add nginx
RUN echo "Pre-Production1" > /tmp/file.txt
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
