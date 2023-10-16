# Load from local hadoop_base image
FROM hadoop_base:v1.0.0

EXPOSE 9870

# Run NameNode
COPY run.sh /run.sh
RUN chmod a+x /run.sh
CMD ["/run.sh"]
