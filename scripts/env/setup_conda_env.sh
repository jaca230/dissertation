#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
env_file="${repo_root}/environment.yml"

if ! command -v conda >/dev/null 2>&1; then
  echo "conda is required but was not found on PATH." >&2
  exit 1
fi

env_name="$(awk '/^name:/{print $2; exit}' "${env_file}")"

if conda env list | awk '{print $1}' | grep -qx "${env_name}"; then
  conda env update -f "${env_file}" --prune
else
  conda env create -f "${env_file}"
fi

env_prefix="$(conda env list | awk -v env="${env_name}" '$1 == env {print $NF; exit}')"

if [[ -z "${env_prefix}" ]]; then
  echo "Failed to resolve conda env prefix for ${env_name}." >&2
  exit 1
fi

tinytex_bin="${HOME}/.TinyTeX/bin/x86_64-linux"

if [[ ! -x "${tinytex_bin}/latexmk" ]]; then
  curl -sL https://yihui.org/tinytex/install-bin-unix.sh | sh
fi

"${tinytex_bin}/tlmgr" install texcount
"${tinytex_bin}/tlmgr" install synctex

echo "Conda env ready at: ${env_prefix}"
echo "Activate with: conda activate ${env_name}"
