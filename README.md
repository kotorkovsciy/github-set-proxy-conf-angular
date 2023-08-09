# github-set-proxy-conf-angular

### Usage
```yml
steps:
  - uses: actions/checkout@v2
  - name: github-set-proxy-angular
    uses: kotorkovsciy/github-set-proxy-conf-angular@v0.1.0
    with:
      path: "./proxy.conf.json"
      target: "http://localhost:8080"
      url: "/api"
      secure: "false"
      pathRewriteOld: "null"
      pathRewriteNew: "null"
      changeOrigin: "null"
      logLevel: "null"
      type: "create"
```
