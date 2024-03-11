# nupm-porcelain

Extend nupm using nupm.

nupm-porcelain doesnt do much but it is an example nupm package

Comments welcome. March 2024

## install nupm-porcelain with nupm and git

0. Install nushell if not installed

[nushell.sh](http://nushell.sh)

1. Enter nushell

```sh

nu

```

2. Install nupm if not installed

[nupm - a nushell package manager](https://github.com/nushell/nupm)

> test this  
```nu

cd
cd .config/nushell

mkdir nupm
cd nupm
mkdir modules
git clone git@github.com:nushell/nupm.git --depth 1
use nupm/

```

3. [Optional] My config_local_nupm.nu

> bootstrap nupm

[My config_local_nupm.nu](https://gist.githubusercontent.com/ddupas/03ef41086fe6abc91f8aff89e8b066fd/raw/3a5d74b05bdca1c257791fc00b31bf1f50aa50b1/config_local_nupm.nu)

I add `source config_local_nupm.nu` to my nushell config.


> test this

```nu

cd 
cd .config/nushell
http get https://gist.githubusercontent.com/ddupas/03ef41086fe6abc91f8aff89e8b066fd/raw/3a5d74b05bdca1c257791fc00b31bf1f50aa50b1/config_local_nupm.nu
| save config_local_nupm.nu -f
source config_local_nupm.nu

```

4. Install nupm-porcelain


```nu

cd $env.NUPM_HOME   # if unset go back to step 2
cd modules
git clone git@github.com:ddupas/nupm-porecelain.git --depth 1
use nupm-porcelain/

```   

## thoughts

nupm-porcelain demonstrates how you can augment packages independently with modules 

nupm is a wrapper for nushells use command, 
it helps use find modules by being a path manager and module installer

nupm-porcelain does not clutter nupm's namespace and the authors of nupm do not have
to worry about nupm-porcelain breaking nupm

