FROM centos:7

COPY ./github-create-proxy-conf-angular.sh /

RUN chmod +x /github-create-proxy-conf-angular.sh

ENTRYPOINT ["/github-create-proxy-conf-angular.sh"]
