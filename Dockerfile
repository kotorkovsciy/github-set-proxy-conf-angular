FROM centos:7

LABEL "com.github.actions.name"="github-set-proxy-angular"
LABEL "com.github.actions.description"="Creates a proxy for angular"
LABEL "com.github.actions.icon"="settings"
LABEL "com.github.actions.color"="black"

LABEL version="0.1.0"
LABEL repository="https://github.com/kotorkovsciy/github-set-proxy-conf-angular"
LABEL homepage="https://github.com/kotorkovsciy/github-set-proxy-conf-angular"
LABEL maintainer="kotorkovsciy <kotorkovsciy@gmail.com>"

COPY ./github-create-proxy-conf-angular.sh /

RUN chmod +x /github-create-proxy-conf-angular.sh

ENTRYPOINT ["/github-create-proxy-conf-angular.sh"]
