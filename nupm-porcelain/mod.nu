# 
# package nupm-porcelain
# 
# learn and extend nupm using nupm
#
#

use nupm

# nupm-porcelain main
export def --env main []: nothing -> nothing {
	warn "March 2024 Learning about Nushell Modules and Package Manager"
	
	info "https://github.com/ddupas/nupm-porcelain"
    info "> use nupm-porcelain"
}


# warn "warn"
def warn [ msg: string ] {
	print -n '[warn] nupm-porcelain: '
	print $msg
}

# info "info"
def info [ msg : string ] {
	print -n '[info] nupm-porcelain: '
	print $msg
}

# will crash and burn if env is not good
# nupm-porcelain get env
export def "nupm get env" [] {{
	PATH : $env.PATH,
	XDG_CONFIG_HOME : $env.
	NU_HOME : $env.NU_HOME,
	NUPM_HOME : $env.NUPM_HOME,	
	NUPM_CACHE : $env.NUPM_CACHE,
	NUPM_TEMP : $env.NUPM_TEMP,
	NU_LIB_DIRS : $env.NU_LIB_DIRS
}}

# nupm-porcelain print env
export def "nupm print env" [] {
    print $"(char newline)(nupm-porcelain get env | table -t compact -e)"
}

# nupm-porcelain enter
export def --env "nupm enter" [] {
	cd $env.NUPM_HOME
}

# TODO: look at the registry and install commands of nupm

# nupm-porcelain ls local registry
export def "nupm ls local registry" [] {
	cd $env.NUPM_HOME
	open registry.nuon | get git.name | uniq
}

# TODO: handle packages that are installed as subfolder 
# in same repo ie nu-themes is part of nu-scripts,
# see earlier note about registry and install commands of nupm

# nupm-porcelain ls installed
export def "nupm ls installed" [] {
	cd $env.NUPM_HOME
	cd modules
	ls | get name
}

# TODO: return the commit url 
# https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/autolinked-references-and-urls

# nupm install can use a folder as a parameter, 
tab completion from registry 

# nupm-porcelain install from registry
def "nupm install from registry" [] {
	cd $env.NUPM_HOME
	open registry.nuon 
	| get git | get name | uniq 
	| wrap value | upsert desription ""
}

# nupm
