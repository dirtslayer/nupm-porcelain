# nupm-porcelain main
export def --env main []: nothing -> nothing {
	warn "March 2024 Learning about Nushell Modules and Package Manager"
	info "https://github.com/ddupas/nupm-porcelain"
	info "git clone git@github.com:ddupas/nupm-porcelain.git"
    info "> use nupm-porcelain"
}

# nupm-porcelain get env
export def "nupm get env" [] {{
	PATH : ( $env.PATH? | default $env.Path ),
	GIT_REPOS_HOME : $env.GIT_REPOS_HOME,
	XDG_CONFIG_HOME : $env.XDG_CONFIG_HOME,
	NU_HOME : $env.NU_HOME,
	NUPM_HOME : $env.NUPM_HOME,	
	NUPM_CACHE : $env.NUPM_CACHE,
	NUPM_TEMP : $env.NUPM_TEMP,
	NU_LIB_DIRS : $env.NU_LIB_DIRS
}}

# nupm-porcelain print env
export def "nupm print env" [] {
    print $"(char newline)(nupm get env | table -t compact -e)"
}

# nupm-porcelain enter
export def --env "nupm enter" [] {
	cd $env.NUPM_HOME
}

# TODO: look at the registry and install commands of nupm

# nupm-porcelain lsregistry
export def "nupm lsregistry" [] {
	nupm enter
	open registry.nuon | select git.name | uniq | flatten
}

# TODO: handle packages that are installed as subfolder 
# in same repo ie nu-themes is part of nu-scripts,
# see earlier note about registry and install commands of nupm

# nupm-porcelain installed modules
export def "nupm installed modules" [] {
	nupm enter
	cd modules
	ls | get name
}

# nupm-porcelain installed scripts
export def "nupm installed scripts" [] {
	nupm enter
	cd scripts
	ls | get name
}

# nupm-porcelain nu-complete install from registry
def "nu-complete nupm-porcelain install" [] {
	nupm enter
	open registry.nuon | get git.url | str replace 'https://github.com/' '' | uniq
	| wrap value
	| upsert description "latest"
}


# TODO: handle revisions with install / uninstall

# nupm-porcelain install current from github,  nushell/nupm 
export def "nupm-porcelain install" [
	command?: string@"nu-complete nupm-porcelain install"
] {
	nupm enter
	cd modules
	#"git clone git@github.com:ddupas/nupm-porcelain.git"
	^git clone --depth 1 $"git@github.com:($command).git"  	
}

# nupm-porcelain nu-complete uninstall
def "nu-complete nupm-porcelain uninstall" [] {
	nupm enter
	cd modules
	ls | get name | wrap value
}

# nupm-porcelain nupm uninstall
export def "nupm-porcelain uninstall" [
	command?: string@"nu-complete nupm-porcelain uninstall"
] {
	nupm enter
	cd modules
	rm -rf $command
}



# https://github.com/<user>/<project>/tree/<commit-hash>

# wish:
# command?: record<key:string,value:string>@"nu-complete-combo nupm repourl",
# https://github.com/amtoine/scripts/tree/main/nu-clippy

# there is an extra param in the rust source investigate


# nupm-porcelain repourl - select repo to get url from registry
export def "nupm repourl"  [
	command?: string@"nupm repourl",
] {
				nupm enter
			 	open registry.nuon | get git
				| enumerate 
			 	| flatten
			    | input list -d name
				| $"($in.url)/tree/($in.revision)/($in.path)"
}
