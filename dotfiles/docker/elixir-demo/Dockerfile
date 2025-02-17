FROM debian:bookworm-slim

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    git \
    unzip \
    fontconfig \
    locales \
 && rm -rf /var/lib/apt/lists/*

# Setup Starship
RUN curl -sS https://starship.rs/install.sh | sh -s -- -y

# Get JetBrainsMono
RUN mkdir -p ~/.local/share/fonts \
    && curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip \
    -o ~/.local/share/fonts/JetBrainsMono.zip \
    && cd ~/.local/share/fonts \
    && unzip JetBrainsMono.zip \
    && rm JetBrainsMono.zip \
    && fc-cache -fv

# Configure locale: enable and generate en_US.UTF-8
RUN sed -i 's/^# *\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

# Install Nix as root (no need for sudo)
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | \
    sh -s -- install linux --init none --no-confirm

# Create a non-root user "demo" with bash as default shell
RUN useradd -m -s /bin/bash demo

# (Optional) Ensure nix directories are accessible to demo:
RUN mkdir -p /nix && chown -R demo:demo /nix

# Switch to non-root user
USER demo
WORKDIR /home/demo

# Bashrc
RUN echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Adjust PATH so that Nix is found
ENV PATH=/nix/var/nix/profiles/default/bin:$PATH
ENV TERM=xterm-256color
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Expose 4000 for elixir
EXPOSE 4000

ENTRYPOINT ["/bin/bash"]

