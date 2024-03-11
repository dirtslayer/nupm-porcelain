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

[My config_local_nupm.nu](https://gist.github.com/ddupas/03ef41086fe6abc91f8aff89e8b066fd#file-config_local_nupm-nu)

I source this at nu startup from config.nu to make nupm available.


4. Install nupm-porcelain with nupm

```
nupm install https://github.com/ddupas/nupm-porcelain
use nupm-porcelain

```


4. [OR] Install nupm-porcelain with git


```nu

cd $env.NUPM_HOME   # if unset go back to step 2
cd modules
git clone git@github.com:ddupas/nupm-porecelain.git --depth 1
use nupm-porcelain/

```   

## thoughts

nupm-porcelain demonstrates how you can augment packages independently with modules 

nupm is a helper for nushells use command, 
it helps use find modules by being a path manager and module installer

nu-complete only passes a single string between its caller. 
lookup keys have to be embeded as an enumeration and rehydrated once the value is selected
