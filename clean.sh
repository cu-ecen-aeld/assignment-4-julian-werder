#!/bin/bash
# Remove Buildroot configuration and build output so the next ./build.sh
# starts from scratch (defconfig phase, then build phase).
# Idempotent: safe on a fresh clone and safe to run repeatedly.
cd "$(dirname "$0")"
set -e

# rm -rf / rm -f succeed on missing paths, so this is a no-op if absent.
# Plain removal is used instead of 'make clean' because that requires a
# valid buildroot/.config and fails without one.
rm -rf buildroot/output
rm -f buildroot/.config
