FROM devkitpro/devkitppc:20231110 AS build

WORKDIR /workspace

# Match the packages and Python setup used by .github/workflows/ci.yml.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        ca-certificates \
        curl \
        gcc-arm-none-eabi \
        genisoimage \
        git \
        golang \
        nodejs \
        python3-distutils \
        python3-setuptools \
    && curl -fsSL https://bootstrap.pypa.io/pip/3.9/get-pip.py -o /tmp/get-pip.py \
    && python3 /tmp/get-pip.py \
    && rm -f /tmp/get-pip.py \
    && rm -rf /var/lib/apt/lists/*

COPY patches/scripts/requirements.txt patches/scripts/requirements.txt
RUN pip3 install --no-cache-dir -r patches/scripts/requirements.txt

# Keep both libraries below their 2026 devkitPPC runtime API requirements.
ARG LIBOGC2_REV=4f48e2a38dbdbba94aee8bde3e01cd9e391f8519
ARG LIBFAT_REV=c0fd53712ad2ef33d4f6a35e920d55094e6f5af9

RUN git init /tmp/libogc2 \
    && git -C /tmp/libogc2 remote add origin https://github.com/extremscorner/libogc2.git \
    && git -C /tmp/libogc2 fetch --depth 1 origin ${LIBOGC2_REV} \
    && git -C /tmp/libogc2 checkout --detach FETCH_HEAD \
    && make -C /tmp/libogc2 cube \
    && mkdir -p /opt/devkitpro/libogc2/gamecube/lib \
    && cp -a /tmp/libogc2/include /opt/devkitpro/libogc2/gamecube/ \
    && cp /tmp/libogc2/lib/cube/*.a /opt/devkitpro/libogc2/gamecube/lib/ \
    && cp /tmp/libogc2/*_license.txt /tmp/libogc2/*_rules /opt/devkitpro/libogc2/ \
    && rm -rf /tmp/libogc2 \
    && git init /tmp/libfat \
    && git -C /tmp/libfat remote add origin https://github.com/extremscorner/libfat.git \
    && git -C /tmp/libfat fetch --depth 1 origin ${LIBFAT_REV} \
    && git -C /tmp/libfat checkout --detach FETCH_HEAD \
    && sed -i '/rice/d' /tmp/libfat/Makefile \
    && make -C /tmp/libfat cube-release \
    && cp -a /tmp/libfat/include /opt/devkitpro/libogc2/gamecube/ \
    && cp /tmp/libfat/libogc2/gamecube/lib/libfat.a /opt/devkitpro/libogc2/gamecube/lib/ \
    && rm -rf /tmp/libfat

COPY . .

RUN make -C entry clean \
    && make -C entry \
    && mkdir -p dist/next \
    && mv cubeboot/cubeboot.dol dist/next/cubeboot.dol

# Extract the CI-equivalent artifact with:
# docker build --output type=local,dest=./dist .
FROM scratch AS artifact
COPY --from=build /workspace/dist/next/cubeboot.dol /cubeboot.dol
