# Comment Format: Inline Setting

One line placed directly above a non-obvious option. Describes _why_ or _what it does_ not just a restatement of the option name.

## Format

```nix
  # Why or what this setting does.
  optionName = value;
```

## Examples

```nix
  # Enable mouse support.
  mouse = "a";
```

```nix
  # Disable ctags: prevent tag file lookup and related errors.
  tags = "";
```

```nix
  # Update git status asynchronously for better performance.
  settings.git_status_async = true;
```

