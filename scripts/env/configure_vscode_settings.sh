#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
vscode_dir="${repo_root}/.vscode"
settings_file="${vscode_dir}/settings.json"
tinytex_bin="${HOME}/.TinyTeX/bin/x86_64-linux"
synctex_path="${tinytex_bin}/synctex"

mkdir -p "${vscode_dir}"

if [[ ! -x "${synctex_path}" ]]; then
  synctex_path="synctex"
fi

cat > "${settings_file}" <<EOF
{
  "latex-workshop.latex.outDir": "build",
  "latex-workshop.latex.autoBuild.run": "onSave",
  "latex-workshop.view.pdf.viewer": "tab",
  "latex-workshop.synctex.afterBuild.enabled": true,
  "latex-workshop.synctex.path": "${synctex_path}",
  "latex-workshop.linting.chktex.exec.path": "${repo_root}/scripts/env/helpers/chktex",
  "latex-workshop.texcount.path": "${repo_root}/scripts/env/helpers/texcount",
  "latex-utilities.countWord.path": "${repo_root}/scripts/env/helpers/texcount",
  "latex.linter.path": "${repo_root}/scripts/env/helpers/chktex"
}
EOF

echo "Wrote ${settings_file}"
