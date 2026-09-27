#!/bin/sh
# Shared definitions for buildroot scripts

# The defconfig from the buildroot directory we use for qemu builds
QEMU_DEFCONFIG=configs/qemu_aarch64_virt_defconfig
# The place we store customizations to the qemu configuration
MODIFIED_QEMU_DEFCONFIG=base_external/configs/aesd_qemu_defconfig
# The defconfig from the buildroot directory we use for the project
AESD_DEFAULT_DEFCONFIG=${QEMU_DEFCONFIG}
AESD_MODIFIED_DEFCONFIG=${MODIFIED_QEMU_DEFCONFIG}
AESD_MODIFIED_DEFCONFIG_REL_BUILDROOT=../${AESD_MODIFIED_DEFCONFIG}

# Buildroot refuses to run if PATH has an entry containing a space, TAB or
# newline (typical on WSL, where Windows paths are appended). Drop such
# entries, keeping the order of the rest. POSIX sh only; safe under set -e.
_aesd_nl='
'
_aesd_tab='	'
_aesd_new=
_aesd_dropped=0
_aesd_old_ifs=$IFS
case $- in *f*) _aesd_had_noglob=1 ;; *) _aesd_had_noglob=0 ;; esac
set -f
IFS=:
for _aesd_e in $PATH; do
	case $_aesd_e in
	*" "* | *"$_aesd_tab"* | *"$_aesd_nl"*)
		_aesd_dropped=$((_aesd_dropped + 1))
		;;
	*)
		_aesd_new=${_aesd_new:+${_aesd_new}:}${_aesd_e}
		;;
	esac
done
IFS=$_aesd_old_ifs
if [ "$_aesd_had_noglob" -eq 0 ]; then set +f; fi
if [ "$_aesd_dropped" -gt 0 ]; then
	if [ -n "$_aesd_new" ]; then
		PATH=$_aesd_new
		export PATH
		echo "shared.sh: dropped $_aesd_dropped PATH entries containing whitespace (Buildroot requirement)" >&2
	else
		echo "shared.sh: WARNING: every PATH entry contains whitespace; leaving PATH unchanged, Buildroot may refuse to run" >&2
	fi
fi
unset _aesd_nl _aesd_tab _aesd_new _aesd_dropped _aesd_old_ifs _aesd_had_noglob _aesd_e
