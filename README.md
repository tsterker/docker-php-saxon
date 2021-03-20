
# PHP with Saxon/C XSLT processor

**Build:**

```sh
docker build --tag tsterker/php-saxon:7.4 -f Dockerfile.php74 .
```

**Resources:**
- [Installing Saxon/C on Linux](https://www.saxonica.com/saxon-c/documentation/index.html#!starting/installing/installingLinux)
- [Install PHP Extension](https://www.saxonica.com/saxon-c/documentation/index.html#!starting/installingphp)
- [Saxon/C PHP API](https://www.saxonica.com/saxon-c/documentation/index.html#!api/saxon_c_php_api/saxon_c_php_xsltprocessor)

**Inspiration:**
- Working PHP 5.6 Docker image: [rastu/saxon-php-fpm](https://github.com/rastu/dockerfiles/blob/master/saxon/php-fpm/5.6.25/Dockerfile)
- Bug report with example Dockerfile: https://saxonica.plan.io/issues/3117)
