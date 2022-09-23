#!/bin/bash
cd "$(dirname "$0")"

function remote_nsfw () {
    sed -e "s/import CLIPFeatureExtractor,/import/" \
        -e "/^from \.safety_checker import StableDiffusionSafetyChecker$/ d" \
        -e "/^\s\{8\}safety_checker: \w\+,$/ d" \
        -e "/^\s\{8\}feature_extractor: CLIPFeatureExtractor,$/ d" \
        -e "/^\s\{12\}safety_checker=safety_checker,$/ d" \
        -e "/^\s\{12\}feature_extractor=feature_extractor,$/ d" \
        -e "/safety_chec\?ker_input/ d" \
        -e "s/#\srun\ssafety\schecker$/has_nsfw_concept = [False]/" \
        -i ${1}
}

readonly DIFFUSERS_DIR=$(pip show diffusers | grep Location | awk '{print $2}')/diffusers

remote_nsfw ${DIFFUSERS_DIR}/pipelines/stable_diffusion/pipeline_stable_diffusion.py
remote_nsfw ${DIFFUSERS_DIR}/pipelines/stable_diffusion/pipeline_stable_diffusion_img2img.py
remote_nsfw ${DIFFUSERS_DIR}/pipelines/stable_diffusion/pipeline_stable_diffusion_inpaint.py
remote_nsfw ${DIFFUSERS_DIR}/pipelines/stable_diffusion/pipeline_stable_diffusion_onnx.py
