#!/bin/sh

make -C pipeline_module clean && make -C pipeline_module
make -C pipeline_module_unapproved clean && make -C pipeline_module_unapproved
make -C technote clean && make -C technote
make -C ssdc-if clean && make -C ssdc-if
