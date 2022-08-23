FROM docker:latest
# Make sure the package repository is up to date.
RUN yum update && \
    yum install -qy git && \
# Install a basic SSH server
    yum install -qy openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
# Install JDK 11
    yum install -qy default-jdk && \
# Install maven
    yum install -qy maven && \
# Cleanup old packages
    yum -qy autoremove && \
# Add user jenkins to the image
    adduser --quiet jenkins && \
# Set password for the jenkins user (you may want to alter this).
    echo "jenkins:password" | chpasswd && \
    mkdir /home/jenkins/.m2

# Copy authorized keys
COPY .ssh/authorized_keys /home/jenkins/.ssh/authorized_keys

# Standard SSH port
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D" ]
