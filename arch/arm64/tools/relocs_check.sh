#!/bin/sh
# SPDX-License-Identifier: GPL-2.0-or-later
# Based on powerpc relocs_check.sh

# This script checks the relocations of a vmlinux for "suspicious"
# relocations.

bad_relocs=$(
${srctree}/scripts/relocs_check.sh "$@" |
	# These relocations are okay
	#	R_AARCH64_RELATIVE
	grep -F -w -v 'R_AARCH64_RELATIVE'
)

if [ -z "$bad_relocs" ]; then
	exit 0
fi

num_bad=$(echo "$bad_relocs" | wc -l)
echo "WARNING: $num_bad bad relocations"
echo "$bad_relocs"