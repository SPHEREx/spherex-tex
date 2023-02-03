# Dockerized spherex-tex
#
# This is a multi-stage docker build composed of three images:
# 1. "base" is an official Python image with additional system dependencies
#    (such as texlive) installed via the "docker/install-base-packages.sh"
#    script. Add additional apt-get dependencies through that script.
# 2. "dependencies" installs the Python dependencies defined in
#    requirements.txt.
# 3. "runtime" is the final image for end users. It is based on the "base"
#    image and includes both the Python depndencies and a copy of spherex-tex.

FROM python:3.9-slim-buster AS base

# Copy a file to prevent docs from being installed
COPY docker/01_nodoc /etc/dpkg/dpkg.cfg.d

# Update system packages
COPY docker/install-base-packages.sh .
RUN ./install-base-packages.sh

FROM base AS dependencies

# Create a Python virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python -m venv $VIRTUAL_ENV
# Make sure we use the virtualenv
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
# Put the latest pip and setuptools in the virtualenv
RUN pip install --upgrade --quiet --no-cache-dir pip setuptools wheel
# Install the Python runtime dependencies
COPY requirements.txt .
RUN pip install --quiet --no-cache-dir -r requirements.txt

FROM base AS runtime

# Create a directory for the spherex-tex installation
RUN mkdir spherex-tex

# Disable git safe directory checks
RUN git config --global --add safe.directory '*'

# Point $TEXMFHOME to the container's texmf. This environment variable
# exists for container runs by a user.
ENV TEXMFHOME "/spherex-tex/texmf"

# Make sure we use the virtualenv; also add spherex-tex's scripts to the path.
ENV PATH="/spherex-tex/bin:/opt/venv/bin:$PATH"

# Install Python dependencies
COPY --from=dependencies /opt/venv /opt/venv

# Copy spherex-tex repo into /spherex-tex/
COPY . /spherex-tex

CMD ["/bin/echo", "See https://github.com/spherex/spherex-tex for usage."]
