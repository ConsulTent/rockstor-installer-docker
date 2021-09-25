ARG TAG=15.2
FROM opensuse/leap:${TAG}

# use -privileged to run docker

RUN zypper up
#RUN zypper addrepo http://download.opensuse.org/repositories/Virtualization:/Appliances:/Builder/openSUSE_Leap_$TAG/ appliance-builder
RUN zypper in -y git-core python3-kiwi python3-pip python3-devel 
RUN zypper in -y btrfsprogs gptfdisk e2fsprogs squashfs qemu-tools mkdosfs xorriso gfxboot gcc make 
RUN zypper in -y bzip2 zip xz gfxboot-branding-upstream gfxboot-devel
RUN python3 -m pip install --upgrade pip

WORKDIR /rock
RUN mkdir /tmp/images
RUN git clone https://github.com/rockstor/rockstor-installer.git


RUN cd rockstor-installer/; python3 -m venv kiwi-env
RUN /rock/rockstor-installer/kiwi-env/bin/python3 -m pip install --upgrade pip
RUN /rock/rockstor-installer/kiwi-env/bin/pip install kiwi kiwi-boxed-plugin

CMD /rock/rockstor-installer/kiwi-env/bin/kiwi-ng --profile=Leap15.2.x86_64 --type oem system build --description /rock/rockstor-installer/. --target-dir /tmp/images/


# CMD ["/bin/bash"]

