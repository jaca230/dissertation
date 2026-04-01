# Dissertation Workspace

Git repository for housing my disseration work.

## Setup

Run the environment/bootstrap script:

```bash
./scripts/env/setup_conda_env.sh
```

This also writes a local `.vscode/settings.json` with the correct absolute paths for the current machine.

Activate the conda environment when you want the helper tools available in a shell:

```bash
conda activate dissertation-tools
```

## Build

Compile the dissertation PDF with:

```bash
make
```

The output PDF is written to `build/main.pdf`.

## Layout

- `src/` contains the LaTeX source, including `src/main.tex`.
- `src/bibliography/` contains the BibTeX database.
- `resources/` holds figures, tables, and data assets.
- `scripts/env/` contains environment setup helpers.
