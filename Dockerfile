FROM sabayon/base

# ssh-keygen -A generates all necessary host keys (rsa, dsa, ecdsa, ed25519) at default location.
RUN  equo update \
    && equo i openssh \
    && mkdir /root/.ssh \
    && chmod 0700 /root/.ssh \
    && ssh-keygen -A \
    && sed -i s/^#PasswordAuthentication\ yes/PasswordAuthentication\ no/ /etc/ssh/sshd_config
RUN mkdir -p /sabayon/bin/
COPY bump_weekly.py /sabayon/bin/update-sabayon-weekly-repository
RUN chmod +x /sabayon/bin/update-sabayon-weekly-repository
RUN wget https://github.com/mudler/yip/releases/download/0.5.1/yip-0.5.1-linux-amd64 -O /usr/bin/yip
RUN chmod +x /usr/bin/yip
# This image expects AUTHORIZED_KEYS environment variable to contain your ssh public key.

COPY docker-entrypoint.sh /

EXPOSE 22

ENTRYPOINT ["/docker-entrypoint.sh"]

# -D in CMD below prevents sshd from becoming a daemon. -e is to log everything to stderr.
CMD ["/usr/sbin/sshd", "-D", "-e"]


