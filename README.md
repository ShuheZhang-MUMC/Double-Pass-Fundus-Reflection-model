<img src="https://user-images.githubusercontent.com/61624968/142919579-f012d416-371f-4b21-b594-e9aefe7c38ae.jpg" width = "800" alt="" align=center />

# A double-pass fundus reflection model for efficient retinal image enhancement
This is the MATLAB code for retinal image enhancement using Double-pass fundus reflection model.
We are happy that this research has been accepted and published on Signal Processing: https://doi.org/10.1016/j.sigpro.2021.108400
### USAGE:
Run *main_adaptive_DPFR_ycbcrITU.m* and select a retinal image. 

The gray value threshold in red channel for background padding should be adjusted if the retinal image has severe illumination problem, for example, it should be set to 2 for DiaRetdb0_image034.png. Normally, the value is set to 20. 

Other parameters are automatically and adaptively determined.

## Abstract
This study introduces a novel image formation model - the double pass fundus reflection (DPFR) model for retinal image enhancement (restoration). **The DPFR model reveals the specific double-pass fundus reflection feature that was hitherto neglected in modeling the light propagation of fundus imaging in all published reports on retinal image enhancement.** 


Based on the DPFR model, the procedures of the proposed retinal image restoration algorithm are given. The failure of the dark channel prior on retinal images in RGB color space is clarified. While a solution about how to bypass the challenge is proposed. Each step of DPFR is tested experimentally with retinal images of different degraded situations to validate its robustness. 


Moreover, the DPFR method is tested on 906 images from five public databases. Six image quality matrixes including image definition, image sharpness, image local contrast, image multiscale contrast, image entropy, and fog density are used for objective assessments. The results are compared to the state-of-art methods, showing the superiority of DPFR over the others in terms of restoration quality and implementation efficiency. 

## Forward problem: double-pass fundus reflection model 
The double-pass fundus reflection (DPFR) model is inspired by how a retinal image is formed in the fundus camera:

<img src="https://user-images.githubusercontent.com/61624968/142916047-1aa1be65-d648-4d6d-863c-526a6a8efc11.png" width = "600" alt="" align=center />

## Inverse problem: image restoration
The inverse problem is divided into four steps:
1. Retinal image back ground padding
2. Coarse illumination correction (Retinex theory)
3. Fine illumination boosting (Dark channel prior)
4. Scattering suppression (Dark channel prior) 

The flow-chat is listed below.

<img src="https://user-images.githubusercontent.com/61624968/142917655-30c88c49-48c8-474b-9367-519ddad11836.png" width = "550" alt="" align=center />

## Visual assessment

Enhancement results. Images in the first row are raw image, enhanced results of LCA, LPAR, PCA, and DPFR methods, respectively. The second third rows are enlarged parts in the corresponding yellow and magenta boxes.

*LCA:  10.1109/TBME.2017.2700627*

*LPAR: 10.1016/j.sigpro.2019.107445*

*PCA:  10.1007/978-3-030-50516-5_26*

<img src="https://user-images.githubusercontent.com/61624968/142920683-3b52abe1-9500-4ebd-98e5-7578dd69a53c.jpg" width = "750" alt="" align=center />

## Objective assessment on public databases
Six image quality matrixes including image definition, underwater image sharpness, underwater image local contrast, image multiscale contrast, image entropy, and fog density are used for objective assessments. 

**Experimental results show the superiority of the DPFR model over the others in terms of restoration quality and implementation efficiency.**

<img src="https://user-images.githubusercontent.com/61624968/142918172-0245df0d-a965-45c2-9ddc-b2eabae2579c.png" width = "700" alt="" align=center />

