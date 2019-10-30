# Shell Linter

A GitHub Action that performs static analysis for shell scripts using [ShellCheck](https://github.com/koalaman/shellcheck).

![](docs/images/preview.png)

<br>

## Usage

Run static analysis for all of the bash/sh scripts.
```yml
jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Lint check
        uses: azohra/shell-linter@master
```

Run static analysis for a single bash/sh script.
```yml
      - name: Lint check
        uses: azohra/shell-linter@master
        with:
          path: "setup.sh"
```

Run static analysis for multiple bash/sh scripts.
```yml
      - name: Lint check
        uses: azohra/shell-linter@master
        with:
          path: "setup.sh,deploy.sh"
```


Run static analysis for all the bash/sh scripts in a folder.
```yml
      - name: Lint check
        uses: azohra/shell-linter@master
        with:
          path: "src"
```

<br>

## Input

### `path`

Optional. Execute lint check on a specific file or folder. Default: `.`

