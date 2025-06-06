# 🚝 Dynamic Installer Desktop

**Dynamic Installer Desktop** is an open-source framework adapted from the Android-focused Dynamic Installer. It streamlines Android modding and automation tasks on Linux and Windows 11+ (via WSL). 

## Directory Structure

```
DynamicInstaller_Desktop/
├── src/
│   ├── addons/             # Optional plugins
│   ├── main/
│   │   └── main.sh         # Main execution script
│   └── main.deps           # Defines project-specific dependencies
│   └── static.deps         # Defines project-specific static dependencies
├── utils/
│   ├── di/                 # Dynamic Installer Core
│   ├── log/                # Logs for DI setup process
│   └── temp/               # Temporary files for DI setup
├── di-env                  # Environment configuration
├── run.sh                  # Linux execution script
└── run.bat                 # Windows (WSL) execution script
```

## Environment Variables

| Variable | Description |
|----------|-------------|
| `$project` | Root directory of the project. |
| `$addons`  | Shortcut for the `src/addons/` directory. |
| `$main`    | Shortcut for the `src/main/` directory. |
| `$TMP`     | Temporary directory. |

## Features

- Runs on **Linux** and **Windows** 11+ (via WSL), auto-installing WSL if needed.
- Manages dependencies with a custom system called **DynDep**.
- Inherits most Dynamic Installer Android features, recreating its environment. Excels at automating patching processes for Android-related tasks feasible from a desktop, like APK/JAR patchs.
- Uses **DynDef** format to install dependencies via the system’s package manager, avoiding strict architecture dependencies and enabling easy reconfiguration for other distributions.

## Dependency Management

**DynDep** manager, integrated into this framework, handles dependencies by checking for the presence of commands (binaries) in your system's environment. It prioritizes command availability over specific versions, meaning it only cares if the command exists, not which version it is.

If a command is missing, DynDep dynamically identifies your package manager (like `APT` or `Homebrew`) to generate installation instructions. This process is guided by a structured **DynDef** format, which defines command groups and properties to build the precise installation commands.


### DynDef Format

Dependencies are defined in two files:
- **`main.deps`**: For package manager-based dependencies
  
  [Click here](pages/DynDef-main.md) for details.
- **`static.deps`**: For static dependencies from external URLs.
  
  [Click here](pages/DynDef-static.md) for details.

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/BlassGO/DynamicInstaller_Desktop.git
   ```
2. Navigate to the directory:
   ```bash
   cd DynamicInstallerDesktop
   ```
3. Run the framework:
   
   On Linux:
   ```bash
   sudo bash run.sh
   ```
   On Windows (with WSL):
   ```cmd
   run.bat
   ```
4. Customize your project:
   - Edit `src/main/main.sh` for custom scripts.
   - Define dependencies in `src/main.deps` or `src/static.deps`.
5. Before sharing, you can delete any files from ``utils/temp/*``. Some OS data is cached.

## Documentation
Refer to the [Dynamic Installer Docs](https://blassgo.github.io/DynamicInstaller_Doc/docs/introduction) for detailed guides, focusing on sections like ``Functions``. Note that sections related to the ZIP-based structure of the Android version do not apply to this desktop edition.

## Credits

- [BlassGO](https://github.com/BlassGO): Creator of `Dynamic Installer` and `Dynamic Installer Desktop`.

## License
> **Dynamic Installer Desktop** is distributed under the GNU General Public License version 3.0 (``GPLv3``). This means that anyone can use, modify and distribute the software as long as they comply with the terms of the license.

  **->** See the [LICENSE](./LICENSE) file for more information on the license terms and conditions.