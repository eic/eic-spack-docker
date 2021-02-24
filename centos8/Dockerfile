# This contains the spack-builder docker container recipe for centos8.
#
# This container can be built (from the top level directory of this repository) with:
#     docker build -t electronioncollider/spack-builder:centos8 . --file centos8/Dockerfile
# This container is built automatically based on the main branch of the repository,
# and made available as docker://electronioncollider/spack-builder:centos8
#
# After building the container locally, you can also test it with singularity as follows:
#     singularity run docker-daemon://electronioncollider/spack-builder:centos8 /bin/bash
#
FROM centos:8

# Install build essentials
RUN yum install -q -y file git make automake cmake gcc gcc-c++ gcc-gfortran unzip patch python3 bzip2 rsync which diffutils crontabs

# Install spack
ENV SPACK_ROOT /cvmfs/eic.opensciencegrid.org/packages/spack/current
ENV SPACK_VERSION v0.16
RUN mkdir -p ${SPACK_ROOT}
RUN git clone --depth 1 --branch releases/${SPACK_VERSION} https://github.com/spack/spack.git ${SPACK_ROOT} \
 && chmod a+w ${SPACK_ROOT}/var/spack ${SPACK_ROOT}/share/spack

# Work in /spack
WORKDIR ${SPACK_ROOT}

# Switch to using bash instead of sh
SHELL ["/bin/bash", "-c"]

# Print arch
RUN source ${SPACK_ROOT}/share/spack/setup-env.sh \
 && spack arch
# Find compilers
RUN source ${SPACK_ROOT}/share/spack/setup-env.sh \
 && spack compiler find --scope site \
 && spack compiler list

# Install configuration
COPY config.yaml ${SPACK_ROOT}/etc/spack

# Install EIC spack
RUN git clone --depth 1 https://github.com/eic/eic-spack.git ${SPACK_ROOT}/var/spack/repos/eic-spack
RUN source ${SPACK_ROOT}/share/spack/setup-env.sh \
 && spack repo add --scope site ${SPACK_ROOT}/var/spack/repos/eic-spack

# Setup mirrors
RUN source ${SPACK_ROOT}/share/spack/setup-env.sh \
 && spack mirror add --scope site jlab-public http://spack.jlab.org/mirror

# Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/tini", "-s", "--", "/entrypoint.sh"] 
