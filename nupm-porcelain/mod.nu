# nupm-porcelain main
export def --env main []: nothing -> nothing {
	warn "March 2024 Learning about Nushell Modules and Package Manager"
	info "https://github.com/ddupas/nupm-porcelain"
    info "> use nupm-porcelain"
}

# nupm-porcelain get env
export def "nupm get env" [] {{
	PATH : $env.PATH,
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
	open registry.nuon | select git.name | uniq
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
def "nu-complete nupm install" [] {
	nupm enter
	open registry.nuon | get git.url | uniq
	| wrap value
	| upsert description "latest"
}


# TODO: handle revisions with install / uninstall

# nupm-porcelain install from default registry, with git clone latest version
export def "nupm install" [
	command?: string@"nu-complete nupm install"
] {
	nupm enter
	cd modules
	^git clone --depth 1 $"($command).git"  	
}

# nupm-porcelain nu-complete uninstall
def "nu-complete nupm uninstall" [] {
	nupm enter
	cd modules
	ls | get name | wrap value
}

# nupm-porcelain nupm uninstall
export def "nupm uninstall" [
	command?: string@"nu-complete nupm uninstall"
] {
	nupm enter
	cd modules
	rm -rf $command
}

export def "nu-complete nupm repourl" [] {
	nupm enter
	open registry.nuon | get git 
	| select name 
	| enumerate 
	| flatten
	| upsert prompt {|row| $"($row.index):($row.name)"}
	| get prompt
	| wrap value
	| upsert description ""
}



# https://github.com/<user>/<project>/tree/<commit-hash>

# wish:
# command?: record<key:string,value:string>@"nu-complete-combo nupm repourl",
# https://github.com/amtoine/scripts/tree/main/nu-clippy

# there is an extra param in the rust source investigate


# nupm-porcelain repourl - use tab completion to select repo url from registry
export def "nupm repourl"  [
	command?: string@"nu-complete nupm repourl",
] {
		mut choiceindex = null
		try {	
			$choiceindex = ( $command | split column ':' | get column1 | into int | get 0 )
		}
		if ( $choiceindex | is-empty ) {
				nupm enter
			 	open registry.nuon | get git  gi
				| enumerate 
			 	| flatten
			    | input list -d name
				| $"($in.url)/tree/($in.revision)/($in.path)"



		} else {
			nupm enter
			open registry.nuon | get git
			| select url revision path    # path version revision
			| get $choiceindex
			| select url revision path
			| $"($in.url)/tree/($in.revision)/($in.path)"
		}
	
	}
