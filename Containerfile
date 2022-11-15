FROM registry.access.redhat.com/ubi8/ubi-minimal

LABEL name="therevoman/exim-smtp" \
      maintainer="Nate Revo" \
      version="1.0.0" \
      release="1" \
      summary="exim on ubi8" \
      description="This application enables a smtp relay."

# howto ubi8-minimal with epel
USER root
#RUN microdnf repoquery exim && microdnf install -y exim
RUN rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
    && microdnf update -y \
    && microdnf install exim \
    && microdnf clean all
#RUN dnf update -y \
#    && dnf install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y \
#    && dnf install exim -y \
#    && dnf clean all

COPY start-smtp.sh /bin/
COPY set-exim4-update-conf /bin/

RUN chmod a+x /bin/start-smtp.sh && \
    chmod a+x /bin/set-exim4-update-conf

EXPOSE 25
#ENTRYPOINT ["/bin/start-smtp.sh"]
CMD ["exim", "-bd", "-q15m", "-v"]
