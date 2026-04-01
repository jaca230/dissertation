# Dissertation Workspace

Git repository for housing my disseration work.

## Setup

Run the environment/bootstrap script:

```bash
./scripts/env/setup_conda_env.sh
```

This also writes a local `.vscode/settings.json` with the correct absolute paths for the current machine.
It provisions the conda analysis environment, installs the common TinyTeX
packages used by the template, refreshes the editor helper commands, and
creates a local `.playground/` for experiments and writing templates.

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

Build the example style guide with:

```bash
make examples
```

That target builds the self-contained local playground document at
`.playground/build/examples.pdf`.

If you want to refresh the playground scaffold from the tracked template files,
run:

```bash
./scripts/env/create_playground.sh --force
```

## Layout

- `src/` contains the LaTeX source, including `src/main.tex`.
- `src/preamble/macros.tex` contains reusable shorthand for references, units,
  and common scientific notation.
- `src/bibliography/` contains the BibTeX database.
- `resources/` holds figures, tables, and data assets.
- `scripts/env/` contains environment setup helpers.
- `.playground/` is a gitignored, self-contained local sandbox for examples,
  temporary notes, and compile experiments.
