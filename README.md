# Shell Linter


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

Run static analysis for multiple shell scripts.
```yml
      - name: Lint check
        uses: azohra/shell-linter@v0.1.0
        with:
          path: "setup.sh,deploy.sh"
```


Run static analysis for all the shell scripts in a folder.
```yml
      - name: Lint check
        uses: azohra/shell-linter@v0.1.0
        with:
          path: "src"
```

<br>

## Input

### `path`

Optional. Execute lint check on a specific file or folder. Default: `.`

