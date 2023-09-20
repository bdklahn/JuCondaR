FROM julia:1.9.3-bookworm as julia_install

FROM continuumio/miniconda3:23.5.2-0 as conda_install

FROM r-base:4.3.1

RUN apt-get update && \
    apt-get install --assume-yes \
    git \
    jq

COPY --from=julia_install /usr/local/julia /usr/local/julia
ENV JULIA_PATH /usr/local/julia
ENV PATH $JULIA_PATH/bin:$PATH

COPY --from=conda_install /opt/conda /opt/conda
ENV PATH /opt/conda/bin:$PATH

RUN pip install ipython jsonschema scif

ENTRYPOINT ["/bin/bash"]