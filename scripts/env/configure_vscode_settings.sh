#!/usr/bin/env bash

set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
vscode_dir="${repo_root}/.vscode"
settings_file="${vscode_dir}/settings.json"

mkdir -p "${vscode_dir}"

cat > "${settings_file}" <<EOF
{
  "latex-workshop.latex.outDir": "../build",
  "latex-workshop.latex.autoBuild.run": "onSave",
  "files.autoSave": "afterDelay",
  "files.autoSaveDelay": 750,
  "latex-workshop.view.pdf.viewer": "tab",
  "latex-workshop.synctex.afterBuild.enabled": true,
  "latex-workshop.synctex.path": "synctex",
  "latex-workshop.linting.chktex.exec.path": "chktex",
  "latex-workshop.texcount.path": "texcount",
  "latex-workshop.view.pdf.external.viewer.command": "lw-open-pdf-external",
  "latex-workshop.view.pdf.external.viewer.args": [
    "%PDF%"
  ],
  "latex-utilities.countWord.path": "texcount",
  "latex.linter.path": ""
}
EOF

echo "Wrote ${settings_file}"
