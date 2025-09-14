#!/usr/bin/bash

set -euo pipefail

export LOCAL_BIN="$HOME/.local/bin"
export LOCAL_FONTS="$HOME/.local/share/fonts"

function download_install_bin() {
  local bin="$1"
  local download_url="$2"
  local tmpdir

  tmpdir="$(mktemp -d)"

  if echo "$download_url" | grep -q ".tar.gz"; then
    curl -Lo "$tmpdir/$bin.tar.gz" "$download_url"
    tar -xzf "$tmpdir/$bin.tar.gz" -C "$tmpdir"
  elif echo "$download_url" | grep -q ".zip"; then
    curl -Lo "$tmpdir/$bin.zip" "$download_url"
    unzip "$tmpdir/$bin.zip" -d "$tmpdir"
  else
    curl -Lo "$tmpdir/$bin" "$download_url"
    chmod +x "$tmpdir/$bin"
  fi

  mv "$tmpdir/$bin" "$LOCAL_BIN/$bin"
  rm -rf "$tmpdir"
}

function download_install_font() {
  local download_url="$1"
  local tmpdir
  local filename

  tmpdir="$(mktemp -d)"
  filename="$(curl --output-dir "$tmpdir" -w "%{filename_effective}" -LO "$download_url")"
  unzip "$filename" -d "$LOCAL_FONTS"
  rm -rf "$tmpdir"
}

function install_flux() {
  local bin="flux"
  local download_url="https://github.com/fluxcd/flux2/releases/download/v2.6.4/flux_2.6.4_linux_amd64.tar.gz"

  download_install_bin "$bin" "$download_url"
}

function install_lazygit() {
  local bin="lazygit"
  local download_url="https://github.com/jesseduffield/lazygit/releases/download/v0.55.0/lazygit_0.55.0_linux_x86_64.tar.gz"

  download_install_bin "$bin" "$download_url"
}

function install_minikube() {
  local bin="minikube"
  local download_url="https://github.com/kubernetes/minikube/releases/download/v1.37.0/minikube-linux-amd64"

  download_install_bin "$bin" "$download_url"
}

function install_resticprofile() {
  local bin="resticprofile"
  local download_url="https://github.com/creativeprojects/resticprofile/releases/download/v0.31.0/resticprofile_0.31.0_linux_amd64.tar.gz"

  download_install_bin "$bin" "$download_url"
}

function install_sops() {
  local bin="sops"
  local download_url="https://github.com/getsops/sops/releases/download/v3.10.2/sops-v3.10.2.linux.amd64"

  download_install_bin "$bin" "$download_url"
}

function install_terraform_docs() {
  local bin="terraform-docs"
  local download_url="https://github.com/terraform-docs/terraform-docs/releases/download/v0.20.0/terraform-docs-v0.20.0-linux-amd64.tar.gz"

  download_install_bin "$bin" "$download_url"
}

function install_terragrunt() {
  local bin="terragrunt"
  local download_url="https://github.com/gruntwork-io/terragrunt/releases/download/v0.87.2/terragrunt_linux_amd64"

  download_install_bin "$bin" "$download_url"
}

function install_tflint() {
  local bin="tflint"
  local download_url="https://github.com/terraform-linters/tflint/releases/download/v0.59.1/tflint_linux_amd64.zip"

  download_install_bin "$bin" "$download_url"
}

function install_jetbrains_mono_nerd_font() {
  local download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip"

  download_install_font "$download_url"
}

install_flux
install_sops
install_lazygit
install_minikube
install_resticprofile
install_terraform_docs
install_terragrunt
install_tflint

install_jetbrains_mono_nerd_font

fc-cache
