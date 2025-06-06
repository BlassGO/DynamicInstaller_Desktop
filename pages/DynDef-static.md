### DynDef Format - For Static Dependencies
Static dependencies are downloaded from external URLs and verified for integrity using SHA256 checksums.

#### Behavior
- It is considered that they should always exist, so in case of any error it will abort the entire execution.

#### Rules
- There can only be one ``static`` block and all dependency groups are children of this block.
- Properties are inherited; child blocks include parent properties if not explicitly defined.
- If a child block defines an existing parent attribute, it generates its own instance without affecting the parent's property or any other blocks.
- Child blocks can access and even append content to parent properties, but this only creates a copy in their instance, not changing the original value.

#### Format
```
static {
    group-name {
        property = value
        ...
        dependency-name {
            property = value
            ...
        }
    }
}
```

#### Properties

| Property | Description |
|----------|-------------|
| `url`    | The URL to download the dependency file. |
| `checksum` | The SHA256 hash to verify the file's integrity. |
| `out`    | The full destination path for the downloaded file. |
| `type`   | The file type (`script`, `binary`, `jar`, `python`). Must be specified to ensure proper handling. |
| `wrap`   | If `true`, generates a shell wrapper function for the dependency based on its `type` (e.g., for `jar`, creates a `java -jar` wrapper named after the subblock). If `false`, no wrapper is created. |

#### Variables

| Variable | Description |
|----------|-------------|
| `$PROJECT` | Root directory of the project. |

#### Operators

| Operator | Description |
|----------|-------------|
| `=`      | Assigns a value to a property. |
| `+=`     | Copies a parent property and appends new content for the current block. |

#### Example DynDef (`static.deps`)

```
static {
    APK-JAR-TOOLS {
        out = "$PROJECT/utils/di/static/"
        apktool-jar {
            url = "https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.11.1.jar"
            checksum = "56d59c524fc764263ba8d345754d8daf55b1887818b15cd3b594f555d249e2db"
            out += "apktool.jar"
            type = jar
            wrap = false
        }
        zipsigner-jar {
            url = "https://github.com/BlassGO/ZipSigner/releases/download/zsigner-1.0.0/zipsigner-1.0.jar"
            checksum = "ff37931e8331f0a74debbc1c44a8115c264fbbce00b56b72b6c1ed9fde710bfa"
            out += "zipsigner.jar"
            type = jar
            wrap = true
        }
    }
}
```

> **NOTE:** For ``zipsigner-jar``, with ``wrap = true``, the zipsigner-jar command can be used to execute it directly without additional steps.