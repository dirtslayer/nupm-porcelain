# 
# package nupm-porcelain
# 
# learn and extend nupm using nupm
#
#

export use nupm

# nupm-porcelain main
export def --env main []: nothing -> nothing {
	warn "March 2024 Learning about Nushell Modules and Package Manager"
	set-env
	print-env

info "TODO: make suggestion to declutter $env by creating $env.NUPM_ENV instead of 4 NUPM_"
info " $env.NUPM_ENV = ( nupm-porcelain get-env ) "

	warn "testing"
	nupm-home-prompt --no-confirm=false
	
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

# info "does not clobber"
#

# nupm-porcelain set-env
def --env "set-env" [] {

	info "check for XDG_CONFIG_HOME"
	# TODO: windows setup XDG_CONFIG_HOME
	mut xdgc_h = $env.XDG_CONFIG_HOME?
	if ( $xdgc_h | is-empty ) { 
		warn "unset XDG_CONFIG_HOME"
		$xdgc_h = $env.HOME + (char psep) + '.config'
		warn $"setting XDG_CONFIG_HOME to ($xdgc_h)"
		$env.XDG_CONFIG_HOME =  $xdgc_h
	} 

	info "check for NU_HOME"
	mut nu_h = $env.NU_HOME?
	if ( $nu_h | is-empty ) { 
		warn "unset NU_HOME"
		$nu_h = $xdgc_h + (char psep) + 'nushell'
		warn $"setting NU_HOME to ($nu_h)"
		$env.NU_HOME = $nu_h
	}

	info "check for NUPM_HOME"
	mut nupm_h = $env.NUPM_HOME?
	if ( $nupm_h | is-empty ) { 
		warn "unset NUPM_HOME"
		$nupm_h = $nu_h +  (char psep) + 'nupm'

		info $"check if ($nupm_h) exists"
		if not ($nupm_h | path exists) {
			warn $"creating NUPM_HOME at ($nupm_h)"
			mkdir $nupm_h
		}
		
		warn $"setting NUPM_HOME to ($nupm_h)"
		$env.NUPM_HOME =  $nupm_h
	}

	info "check for NUPM_CACHE"
	mut nupm_c = $env.NUPM_CACHE?
	if ( $nupm_c | is-empty ) { 
		warn "unset NUPM_CACHE"
		$nupm_c = $nupm_h +  (char psep) + 'cache'

		info $"check if ($nupm_c) exists"
		if not ($nupm_c | path exists) {
			warn $"creating NUPM_CACHE at ($nupm_c)"
			mkdir $nupm_c
		}
		
		warn $"setting NUPM_CACHE to ($nupm_c)"
		$env.NUPM_CACHE =  $nupm_c
	}

	info "check for NU_LIB_DIRS"
	mut nu_l =  $env.NU_LIB_DIRS?
	if ( $nu_l | is-empty ) { 
		warn "unset NU_LIB_DIRS"
		
		$nu_l = [$nupm_h +  (char psep) + 'modules']

		info $"check if ($nu_l.0) exists"
		if not ($nu_l.0 | path exists) {
			warn $"creating NU_LIB_DIRS at ($nu_l.0)"
			mkdir $nu_l.0
		}
		
		warn $"setting NU_LIB_DIRS to ($nu_l)"
		$env.NU_LIB_DIRS =  $nu_l
	} else {
		info "check if NU_LIB_DIRS contains modules"
		let nupm_m = $nupm_h +  (char psep) + 'modules'
		if not ($nupm_m in $nu_l) {
			warn $"adding ($nupm_m) to NU_LIB_DIRS"
			$env.NU_LIB_DIRS ++=  $nupm_m 
		}
	}

	info "check if scripts is in path"
	let nupm_p = $nupm_h + (char psep) + 'scripts'
	if not ($nupm_p in $env.PATH) {
		warn $"adding ($nupm_p) to PATH"
		# TODO: is there a char env path seperator or is it always :?
		$env.PATH ++= $":($nupm_p)"
	}

	info "check for NUPM_TEMP"
	mut nupm_t = $env.NUPM_TEMP?
	if ( $nupm_t | is-empty ) {
		warn "unset NUPM_TEMP"
		$nupm_t =  (mktemp -d)
		warn $"setting NUPM_TEMP to ($nupm_t)"
		$env.NUPM_TEMP = $nupm_t
	}	
}

# nupm-porcelain get-env
export def "get-env" [] {{
	PATH : $env.PATH,
	NU_HOME : $env.NU_HOME,
	NUPM_HOME : $env.NUPM_HOME,	
	NUPM_CACHE : $env.NUPM_CACHE,
	NUPM_TEMP : $env.NUPM_TEMP,
	NU_LIB_DIRS : $env.NU_LIB_DIRS
}}

# nupm-porcelain print-env
export def "print-env" [] {
    print $"(char newline)(nupm-porcelain get-env | table -t compact -e)"
}

# nupm-porcelain enter
export def --env "enter" [] {
	cd $env.NUPM_HOME
}

export def "ls-pkgs" [] {
	cd $env.NUPM_HOME
	open registry.nuon | get git.name | uniq
}

# TODO: handle packages that are installed as subfolder in same repo ie nu-themes is part of nu-scripts
#

# nupm-porcelain ls-installed
export def "ls-installed" [] {
	cd $env.NUPM_HOME
	cd modules
	ls | get name | parse "{name}-{ver}" | get name
}

# TODO: put completion in the actual package so its not in the command ns
# TODO: return the commit url https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/autolinked-references-and-urls

# nupm-porcelain nu-complete install
export def "nu-complete install" [] {
	cd $env.NUPM_HOME
	open registry.nuon 
	| get git | get name | uniq 
	| wrap value | upsert desription ""
}


