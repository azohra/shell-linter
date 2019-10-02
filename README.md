# Magic Shell Linter Action

This action executes lint check on bash scripts

<br>

## Inputs

### `path`

Required. Path to the bash script.

<br>

## Example usage

```yml
jobs:
  # Run job that executes the bash script
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name: Lint check
        uses: azohra/magic-shell-linter-action@master
        with:
          path: "template.sh"
```
