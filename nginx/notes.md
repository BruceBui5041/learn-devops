## Create SSH certificate with OPENSSL

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout nginx.key -out nginx.crt
```

## Create client certificate with OPENSSL

```bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout client.key -out client.crt
```

## Create client certificate with CA signed

```bash
openssl req -new -newkey rsa:2048 -nodes -keyout client.key -out client.csr
openssl x509 -req -days 365 -in client.csr -CA nginx.crt -CAkey nginx.key -set_serial 01 -out client.crt
```
