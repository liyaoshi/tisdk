TOOLCHAIN_PATH ??= "${STAGING_BINDIR_TOOLCHAIN}"

def eat_get_bfd_version(d):
	import subprocess,os,bb
	if os.path.exists(d.getVar('TOOLCHAIN_PATH')+'/bin/'+d.getVar('TARGET_PREFIX')+'as'):
		return subprocess.Popen([d.getVar('TOOLCHAIN_PATH')+'/bin/'+d.getVar('TARGET_PREFIX')+'as', '-v', '--version'], stderr=subprocess.STDOUT,stdout=subprocess.PIPE).communicate()[0].splitlines()[0].split()[3]

EAT_VER_BFD := "${@eat_get_bfd_version(d)}"
