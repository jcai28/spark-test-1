# Build stage for compiling the Spark listener
FROM maven:3.8.4-openjdk-17 as builder

# Copy the Spark listener source into the image
COPY spark-listeners /spark-listener

# Compile and package the Spark listener
WORKDIR /spark-listener
RUN mvn package


# Use the latest Apache Spark version as the base image
FROM spark:3.5.1-scala2.12-java17-python3-ubuntu

# Set the working directory
WORKDIR /opt/spark
# Add iceberg spark runtime jar to IJava classpath
ENV IJAVA_CLASSPATH=/opt/spark/jars/*

# # Copy the compiled Spark listener JAR from the builder stage
COPY --from=builder /spark-listener/target/*.jar /opt/spark/jars/


COPY spark-defaults.conf /opt/spark/conf/
# Copy the configuration files and the entrypoint script
COPY entrypoint.sh /opt/spark/

USER root
# Make the entrypoint script executable
RUN chmod +x /opt/spark/entrypoint.sh
# # Change the ownership of the JAR file to the Spark user
# RUN chown spark:spark /opt/spark/jars/listeners-1.0-SNAPSHOT-jar-with-dependencies.jar

# Expose Spark worker's web UI port (optional)
EXPOSE 8081

# Set the PATH environment variable
ENV PATH=/opt/spark/bin:$PATH

User spark
# Set the entrypoint
ENTRYPOINT ["/opt/spark/entrypoint.sh"]