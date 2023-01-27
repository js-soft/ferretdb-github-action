FROM docker:stable
COPY start-ferretdb.sh /start-ferretdb.sh
RUN chmod +x /start-ferretdb.sh
ENTRYPOINT ["/start-ferretdb.sh"]
