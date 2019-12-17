# Shell Linter

[![Release](https://img.shields.io/github/release/azohra/shell-linter.svg)](https://github.com/azohra/shell-linter/releases)
[![Marketplace](https://img.shields.io/badge/GitHub-Marketplace-red.svg)](https://github.com/marketplace/actions/shell-linter)
<!-- [![Pipeline](https://img.shields.io/badge/pipeline-passes-green.svg)](https://github.com/azohra/shell-linter/actions?query=branch%3Atest_branch) -->

[![Actions Status](https://github.com/azohra/shell-linter/workflows/PR-workflow/badge.svg)](https://github.com/azohra/shell-linter/actions)

A GitHub Action that performs static analysis for shell scripts using [ShellCheck](https://github.com/koalaman/shellcheck).

![](docs/images/preview.png)

<br>

## Usage

Shell Linter can perform static analysis in various ways. You can use it to lint all the shell scripts in your project or lint a a specific file or folder using the `path` parameter. Specific use cases are shown below:

Run static analysis for all of the shell scripts.
```yml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Lint check
        uses: azohra/shell-linter@v0.1.0
```

Run static analysis for a single shell script.
```yml
      - name: Lint check
        uses: azohra/shell-linter@v0.1.0
        with:
          path: "setup.sh"
```

Run static analysis for multiple shell scripts **with or without** extension.
```yml
      - name: Lint check
        uses: azohra/shell-linter@v0.1.0
        with:
          path: "setup,deploy.sh"
```

Run static analysis for all the shell scripts in a folder.
```yml
      - name: Lint check
        uses: azohra/shell-linter@v0.1.0
        with:
          path: "src"
```

Run static analysis using a **wildcard** path
```yml
      - name: Lint check
        uses: azohra/shell-linter@v0.1.0
        with:
          path: "src/*.sh"
```
<br>

## Input

### `path`

Optional. Execute lint check on a specific file or folder. Default: `.`

