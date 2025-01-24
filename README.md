# Run with Output Action

[![CI](https://github.com/ovsds/run-with-output-action/workflows/Check%20PR/badge.svg)](https://github.com/ovsds/run-with-output-action/actions?query=workflow%3A%22%22Check+PR%22%22)
[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-Run%20with%20Output-blue.svg)](https://github.com/marketplace/actions/run-with-output)

Runs a command with stdout/stderr returned as an output.
Useful for running commands and using their output in subsequent steps.
Supports multiline commands and outputs.

## Usage

### Example

```yaml
- name: Run with Output
  uses: ovsds/run-with-output-action@v1
  with:
    run: |
      echo "Hello, World!"
      echo "Hello, World!" >&2
      echo "Hello, again!"

- name: Use Output
  run: echo "${{ steps.run.outputs.stdout }}"
```

Command should be carefully set avoiding any potential security risks. `run` input is `eval`ed in shell,
so it can cause unexpected behavior if not properly sanitized. NEVER use user input in `run` input.

### Action Inputs

| Name        | Description                                    | Default |
| ----------- | ---------------------------------------------- | ------- |
| `run`       | Command to run.                                |         |
| `envs_json` | JSON string with environment variables to set. | `{}`    |

### Action Outputs

| Name        | Description                    |
| ----------- | ------------------------------ |
| `stdour`    | Standard output of the command |
| `stderr`    | Standard error of the command  |
| `exit_code` | Exit code of the command       |

## Development

### Global dependencies

- [Taskfile](https://taskfile.dev/installation/)
- [nvm](https://github.com/nvm-sh/nvm?tab=readme-ov-file#install--update-script)
- [zizmor](https://woodruffw.github.io/zizmor/installation/) - used for GHA security scanning

### Taskfile commands

For all commands see [Taskfile](Taskfile.yaml) or `task --list-all`.

## License

[MIT](LICENSE)
