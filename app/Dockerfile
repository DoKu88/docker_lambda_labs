# 1. Base Image
FROM nvidia/cuda:12.8.1-cudnn-devel-ubuntu22.04

# 2. Environment Setup
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /home/ubuntu

# 3. Copy all necessary files (no tar's to keep down bloat)
COPY Miniconda3-latest-Linux-x86_64.sh /home/ubuntu/

# 4. Install dependencies and Miniconda
RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    curl \
    libgl1-mesa-glx \
    libosmesa6-dev \
    tmux \
    libglib2.0-0 \
    unzip \
    vim \ 
    git \
    && rm -rf /var/lib/apt/lists/*

# Download and install Miniconda
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /home/ubuntu/miniconda3

# Set Conda environment variables
ENV PATH=/home/ubuntu/miniconda3/bin:$PATH
ENV CONDA_AUTO_UPDATE_CONDA=false

SHELL ["/bin/bash", "-c"]
RUN echo "source /home/ubuntu/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc

# Get the tar's and put them in the right place 
# =============================================================================================
RUN mkdir -p /home/ubuntu/miniconda3/envs/nerfstudio
RUN mkdir -p /home/ubuntu/miniconda3/envs/robodiff
RUN mkdir -p /home/ubuntu/miniconda3/envs/feature_splatting2

RUN curl -O http://127.0.0.1:8000/nerfstudio.tar && \
    curl -O http://127.0.0.1:8000/robodiff.tar && \
    curl -O http://127.0.0.1:8000/feature_splatting2.tar && \
    tar -xvf nerfstudio.tar -C /home/ubuntu/miniconda3/envs/nerfstudio && \
    tar -xvf robodiff.tar -C /home/ubuntu/miniconda3/envs/robodiff && \
    tar -xvf feature_splatting2.tar -C /home/ubuntu/miniconda3/envs/feature_splatting2 --strip-components=1 && \
    rm /home/ubuntu/nerfstudio.tar && rm /home/ubuntu/robodiff.tar && rm /home/ubuntu/feature_splatting2.tar 
# =============================================================================================

RUN conda config --append envs_dirs /home/ubuntu/miniconda3/envs

# Optional: Activate one default environment (e.g., the first one listed)
# Replace 'env_name' with the name from a specific YAML file
# ENV CONDA_DEFAULT_ENV=env_name
# RUN echo "conda activate $CONDA_DEFAULT_ENV" >> ~/.bashrc

# Default working directory
WORKDIR /home/ubuntu

