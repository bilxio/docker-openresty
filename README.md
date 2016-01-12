# OpenResty Docker Image

I build this imaged based on ficusio/openresty:1.7.10.2-debian, and also followed the latest version (1.9.3.1) of OpenResty.

- Fixed WORKDIR command.

## How to build

build
```
docker build -t openresty .
```

make a tag
```
docker tag openresty bilxio/openresty:1.9.3.1-debian
```

push if you want
```
docker push bilxio/openresty
```

## FAQ

### Gzip
由于 Gzip 不是默认的构建模块，需要手工加上。 `--with-http_gzip_static_module`

## License

[MIT License](http://oswaldoacauan.mit-license.org/) © Bill Xiong
