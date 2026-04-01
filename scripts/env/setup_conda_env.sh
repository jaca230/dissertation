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
tlmgr="${tinytex_bin}/tlmgr"
texcount_script="${HOME}/.TinyTeX/texmf-dist/scripts/texcount/texcount.pl"
env_bin="${env_prefix}/bin"

if [[ ! -x "${tinytex_bin}/latexmk" ]]; then
  curl -sL https://yihui.org/tinytex/install-bin-unix.sh | sh
fi

texlive_packages=(
  texcount
  synctex
  siunitx
  mathtools
  microtype
  caption
  float
  placeins
  enumitem
  xcolor
  cleveref
  csquotes
  threeparttable
  multirow
  makecell
  grfext
  pdflscape
)

"${tlmgr}" install "${texlive_packages[@]}"

cat > "${env_bin}/texcount" <<EOF
#!/usr/bin/env bash
set -euo pipefail
exec "${env_bin}/perl" "${texcount_script}" "\$@"
EOF

cat > "${env_bin}/synctex" <<EOF
#!/usr/bin/env bash
set -euo pipefail
exec "${tinytex_bin}/synctex" "\$@"
EOF

cat > "${env_bin}/lw-open-pdf-external" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: lw-open-pdf-external <pdf-path>" >&2
  exit 2
fi

pdf_path="$1"

if [[ ! -e "${pdf_path}" ]]; then
  echo "PDF not found: ${pdf_path}" >&2
  exit 1
fi

windows_pdf="$(wslpath -w "${pdf_path}")"
exec powershell.exe -NoProfile -NonInteractive -Command "Start-Process -FilePath '${windows_pdf}'"
EOF

chmod +x "${env_bin}/texcount" "${env_bin}/synctex" "${env_bin}/lw-open-pdf-external"

"${repo_root}/scripts/env/create_playground.sh"
"${repo_root}/scripts/env/configure_vscode_settings.sh"

echo "Conda env ready at: ${env_prefix}"
echo "Activate with: conda activate ${env_name}"
