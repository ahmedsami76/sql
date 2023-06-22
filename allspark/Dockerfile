# Updated version of jupyter/pyspark-notebook 
# updates:
# - reset jovyan password 
# - add jovyan to sudoers
# - install libraries for mysql and postgresql clients

ARG OWNER=jupyter
ARG BASE_CONTAINER=$OWNER/pyspark-notebook
FROM $BASE_CONTAINER

LABEL maintainer="Ahmed Sami <ahmed.samy@gmail.com>"

# Fix: https://github.com/hadolint/hadolint/wiki/DL4006
# Fix: https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# reset jovyan password in one line
RUN echo "jovyan:Passw0rd!" | chpasswd

# add jovyan to sudoers
RUN echo "jovyan ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# RSpark config
ENV R_LIBS_USER "${SPARK_HOME}/R/lib"
RUN fix-permissions "${R_LIBS_USER}"



# R pre-requisites
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    fonts-dejavu \
    gfortran \
    gcc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN apt-get update --yes && apt-get full-upgrade --yes --no-install-recommends
RUN apt-get install python3-dev --yes --no-install-recommends
RUN apt-get install libpq-dev --yes --no-install-recommends
RUN apt-get install build-essential --yes --no-install-recommends
RUN apt-get install libssl-dev --yes --no-install-recommends
RUN apt-get install default-libmysqlclient-dev --yes --no-install-recommends 
RUN apt-get install pkg-config --yes --no-install-recommends
RUN apt-get install libmysqlclient-dev --yes --no-install-recommends

USER ${NB_UID}

# R packages including IRKernel which gets installed globally.
RUN mamba install --yes \
    'r-base' \
    'r-ggplot2' \
    'r-irkernel' \
    'r-rcurl' \
    'r-sparklyr' && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"