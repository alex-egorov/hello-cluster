FROM argoproj/argocd:v2.2.1

USER root

COPY secrets.sh /usr/local/bin

RUN apt-get update \
 && apt-get install -y curl unzip groff \
 && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
 && aws --version \
 && chmod +x /usr/local/bin/secrets.sh \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER 999