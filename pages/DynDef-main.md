### DynDef Format - For System Binaries
Dependencies are installed via system package managers, with DynDep checking for command existence in specified paths before and after installation.

#### Behavior
- When append content to a ``path`` or ``cmd`` attribute, a separator is automatically included for convenience.

#### Rules
- Properties are inherited; child blocks include parent properties if not explicitly defined.
- If a child block defines an existing parent attribute, it generates its own instance without affecting the parent's property or any other blocks.
- Child blocks can access and even append content to parent properties, but this only creates a copy in their instance, not changing the original value.

#### Format
```
manager-name {
    property = value
    ...
    command-name {
        property = value
        ...
    }
}
```

#### Properties

| Property | Description |
|----------|-------------|
| `cmd`    | The base installation command (e.g., `apt install -y`). |
| `name`   | The package name used in the `cmd` (e.g., `openjdk-11-jdk`). |
| `path`   | Possible paths to locate the desired command. DynDep checks these paths before running ``cmd``. You don't need to specify exact paths; the search is recursive within subfolders of each path. If the command is found, DynDep updates your **PATH** environment variable and skips installation. This also applies even after a successful installation: if your PATH hasn't updated yet, DynDep will automatically search these paths and update it for you. |
| `needed` | If `true`, aborts framework execution (before project execution) if the command is not found after all attempts. If `false`, issues a warning but continues execution. |

#### Variables

| Variable | Description |
|----------|-------------|
| `$BREW_PREFIX` | Represents the Homebrew installation prefix (e.g. `/opt/homebrew`). |

#### Operators

| Operator | Description |
|----------|-------------|
| `=`      | Assigns a value to a property. |
| `+=`     | Copies a parent property and appends new content for the current block. |

#### Example DynDef (`main.deps`)

```
apt {
    cmd = "apt install -y"
    path = "/usr/bin:/usr/local/bin"
    java {
        name = "openjdk-11-jdk"
        path += "/usr/lib/jvm:/usr/lib64/jvm"
        needed = true
    }
    zipalign {
        name = "android-sdk"
        path += "/usr/lib/android-sdk"
        needed = true
    }
}

brew {
    cmd = "brew install"
    path = "/usr/bin:/usr/local/bin:$BREW_PREFIX/Cellar"
    java {
        name = "openjdk@11"
        needed = true
    }
    zipalign {
        name = "android-sdk"
        cmd += "--cask"
        path += "/Library/Android/sdk"
        needed = true
    }
}
```