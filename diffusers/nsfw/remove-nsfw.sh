#!/bin/bash
cd "$(dirname "$0")"

readonly DIFFUSERS_DIR=$(pip show diffusers | grep Location | awk '{print $2}')/diffusers

patch ${DIFFUSERS_DIR}/pipelines/stable_diffusion/pipeline_stable_diffusion.py ./patch/pipeline_stable_diffusion.patch
