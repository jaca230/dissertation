# Dissertation Workspace

Git repository for housing my disseration work.

## Setup

Run the environment/bootstrap script:

```bash
./scripts/env/setup_conda_env.sh
```

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
- `resources/` holds figures, tables, and data assets.
- `scripts/env/` contains environment setup helpers.
