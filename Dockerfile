# Build arguments
ARG SOURCE_IMAGE_NAME=julia
ARG SOURCE_IMAGE_TAG=1.10-bookworm

FROM ${SOURCE_IMAGE_NAME}:${SOURCE_IMAGE_TAG}

ARG DESTINATION_IMAGE_NAME=julia-vscode
ARG DESTINATION_IMAGE_TAG=1.10-bookworm

# Set image metadata
LABEL org.opencontainers.image.licenses="GPL-2.0-or-later" \
    org.opencontainers.image.source="https://github.com/insightsengineering/julia-images" \
    org.opencontainers.image.vendor="Insights Engineering" \
    org.opencontainers.image.authors="Insights Engineering <insightsengineering@example.com>"

ENV DEBIAN_FRONTEND=noninteractive \
    SHELL=/bin/bash \
    PATH=$PATH:/usr/local/julia

WORKDIR /workspace

# Copy installation scripts
COPY --chmod=0755 [\
    "scripts/install_sysdeps.sh", \
    "scripts/install_apps.sh", \
    "scripts/install_packages.jl", \
    "./"\
]

COPY --chmod=0755 init-vscode /init-vscode
COPY config/vs-code-config.yaml /root/.config/code-server/config.yaml

RUN ./install_sysdeps.sh ${DESTINATION_IMAGE_NAME}
RUN ./install_apps.sh ${DESTINATION_IMAGE_NAME}
RUN julia install_packages.jl ${DESTINATION_IMAGE_NAME}

WORKDIR /

EXPOSE 8081

ENTRYPOINT ["/init"]
