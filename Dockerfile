# ─────────────────────────────────────────────────────────────
# Use Debian 11 “bullseye” because Google’s repository
# still ships Edge-TPU packages for bullseye, not bookworm.
# ─────────────────────────────────────────────────────────────
FROM --platform=linux/amd64 debian:bullseye-slim

# Install basic utilities and GnuPG to import the repo key
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates curl gnupg lsb-release && \
    rm -rf /var/lib/apt/lists/*

# Download the Coral repo GPG key and store it in a modern keyring
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg \
    | gpg --dearmor -o /usr/share/keyrings/coral.gpg

# Add the Coral Edge-TPU APT repository (x86-64 only) and link it to the keyring
RUN echo "deb [arch=amd64 signed-by=/usr/share/keyrings/coral.gpg] \
      https://packages.cloud.google.com/apt coral-edgetpu-stable main" \
      > /etc/apt/sources.list.d/coral-edgetpu.list

# Install the Edge-TPU compiler and clean up APT caches
RUN apt-get update && \
    apt-get install -y --no-install-recommends edgetpu-compiler && \
    rm -rf /var/lib/apt/lists/*

# Default command: open an interactive shell
CMD ["/bin/bash"]
