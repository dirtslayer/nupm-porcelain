# 
# package nupm-porcelain
# 
# learn and extend nupm using nupm
#
#

# use nupm

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
    print $"(char newline)(get env | table -t compact -e)"
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

# nupm-porcelain ls installed modules
export def "nupm ls installed modules" [] {
	cd $env.NUPM_HOME
	cd modules
	ls | get name
}

# nupm-porcelain ls installed scripts
export def "nupm ls installed scripts" [] {
	cd $env.NUPM_HOME
	cd scripts
	ls | get name
}

# TODO: return the commit url 
# https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/autolinked-references-and-urls

# nupm install can use a folder as a parameter, 
# tab completion from registry 


			#name,
            #version,
            #url,
            #revision,
            #path


# nupm-porcelain nu-complete install from registry
def "nu-complete nupm rinstall" [] {
	cd $env.NUPM_HOME
	open registry.nuon 
	| get git 
	| upsert value {|r| $"($r.url)($r.path)"}
	| upsert desription $in.version
}

# nupm-porcelain - wrapper to select from default registry
export def "nupm rinstall" [
	--package: string@"nu-complete nupm rinstall"
] {
	# use nupm
	# nupm install $package
	print $package
}


#package  # Name, path, or link to the package
#    --registry: string@complete-registries 
#
# nupm-porcelain nupm uninstall


#
#
# nupm-porcelain nu-complete nupm uninstall

# todo gh-porcelain repo package
# todo porcelain registry package
#
