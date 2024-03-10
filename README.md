# nupm-porcelain
Extend nupm using nupm.

This is a continuation of a gist I wanted to turn into a package to test
the nupm package manager and learn about nushell modules.

[original gist](https://gist.github.com/ddupas/03ef41086fe6abc91f8aff89e8b066fd#file-config_local_nupm-nu)

Provide some convience functions for nupm.

Comments welcome. March 2024

## install nupm-porcelain with nupm and git

```nu
cd
cd .config/nushell

mkdir nupm
cd nupm/modules
git clone git@github.com:nushell/nupm.git --depth 1

cd 
cd .config/nushell
http get https://gist.githubusercontent.com/ddupas/03ef41086fe6abc91f8aff89e8b066fd/raw/3a5d74b05bdca1c257791fc00b31bf1f50aa50b1/config_local_nupm.nu
| save config_local_nupm.nu -f
source config_local_nupm.nu

use nupm

git clone git@github.com:ddupas/nupm-porecelain.git --depth 1

nupm install --force --path nupm-porcelain/

use nupm-porcelain

# start using nupm-porcelain
```   

- config_local_nupm.nu is not minimal and clutters your namespace but is a learning bootstrap file
- TODO: minimal nupm bootstrap gist 
