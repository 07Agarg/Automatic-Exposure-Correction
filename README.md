# Digital_Image_Processing_Project
This repository contains the code for the following problem statement. 

### Problem Statement
Improving Images acquired through non-optimal exposure

### Dataset
1. Part A: This part contains images captured with varying exposure settings, including one image taken in dim light.
2. Part B: This part contains images of Kodak Dataset.

### Approaches
1. [Histogram Equalisation](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Source/histogram_equalization.m) 
2. [Bi-Histogram based Histogram Equalisation](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Source/BBHE.m) [*[Paper]*](https://pdfs.semanticscholar.org/fa46/ab775794339f15e8b84b8b4fe10fa3079ec7.pdf)
3. [Contrast Limited Adaptive Histogram Equalisation](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Source/adaptive_histogram_equalisation.m) [*[Paper]*](https://ieeexplore.ieee.org/document/580378)
4. [Gamma Transformation](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Source/gamma_transformation.m) [*[Paper]*](https://arxiv.org/ftp/arxiv/papers/1709/1709.04427.pdf)
5. [Adaptive Gamma Transformation](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Source/adaptive_gamma_transform.m) [*[Paper]*](https://arxiv.org/ftp/arxiv/papers/1709/1709.04427.pdf)
6. [Weighted Adaptive Gamma Transformation](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Source/weighted_adaptive_gamma_transform.m) [*[Paper]*](https://ieeexplore.ieee.org/document/6336819)
7. [Improved Adaptive Gamma Transformation](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Source/improved_adaptive_gamma_correction.m) [*[Paper]*](https://arxiv.org/abs/1709.04427)
8. [Adaptive non-linear Stretching](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Source/adaptive_nonlinear_stretching.m) [*[Paper]*](https://ieeexplore.ieee.org/document/8365712)

### Quality Measures
1. Brisque
2. NIQE

### Prerequistes
1. Linux or Windows
2. MATLAB 

### Repository Usage
1. Clone this repository
```Shell
git clone https://github.com/07Agarg/Digital_Image_Processing_Project.git
```
2. To test the result using any approach:\
  i. cd Root/Source/ \
  ii. open the file corresponding to that approach.  \
  iii. Set variable 'D' to one of the following.\
   &nbsp; &nbsp; &nbsp; D = '../Dataset/Part A' \
   &nbsp; &nbsp; &nbsp; D = '../Dataset/Part B' \
  iv. Set variable S to image name. Example to test result on Part B, IMG_11:\
    &nbsp; &nbsp; &nbsp; S = fullfile(pwd, D, 'IMG_11.png'); 


### Results
Using Improved Adaptive Gamma Correction 


Input(Dataset/Part B/IMG_11):

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ![Input](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Dataset/Part%20B/IMG_11.png)


Output:
![Output](https://github.com/07Agarg/Digital_Image_Processing_Project/blob/master/Result/IMG_11_IAGC.png)



### References
1. R. C. Gonzalez and R. E. Woods, “Digital Image Processing”, Prentice Hall, vol. 3rd edition.
2. Yeong-Taeg Kim. 1997. Contrast enhancement using brightness preserving bi-histogram equalization. IEEE Trans. on Consum. Electron. 43, 1 (February 1997), 1-8.
3. Zuiderveld, Karel. “Contrast Limited Adaptive Histogram Equalization.” Graphic Gems IV. San Diego: Academic Press Professional, 1994. 474–485.
4. Shih-Chia Huang, Fan-Chieh Cheng, and Yi-Sheng Chiu. 2013. Efficient Contrast Enhancement Using Adaptive Gamma Correction With Weighting Distribution. Trans. Img. Proc. 22, 3 (March 2013), 1032-1041.
5. Gang Cao, Lihui Huang, Huawei Tian, Xianglin Huang, Yongbin Wang, and Ruicong Zhi. 2018. Contrast enhancement of brightness-distorted images by improved adaptive gamma correction. Comput. Electr. Eng. 66, C (February 2018).
6. G. Messina, A. Castorina, S. Battiato and A. Bosco, "Image quality improvement by adaptive exposure correction techniques," 2003 International Conference on Multimedia and Expo. ICME '03. Proceedings.
7. Mittal, A., A. K. Moorthy, and A. C. Bovik. "No-Reference Image Quality Assessment in the Spatial Domain." IEEE Transactions on Image Processing. Vol. 21, Number 12, December 2012, pp. 4695–4708.
8. Mittal, A., R. Soundararajan, and A. C. Bovik. "Making a Completely Blind Image Quality Analyzer." IEEE Signal Processing Letters. Vol. 22, Number 3, March 2013, pp. 209–212.
9. N. Venkatanath, D. Praneeth, Bh. M. Chandrasekhar, S. S. Channappayya, and S. S. Medasani. "Blind Image Quality Evaluation Using Perception Based Features", In Proceedings of the 21st National Conference on Communications (NCC). Piscataway, NJ: IEEE, 2015.
10. S. Yelmanov, Y. Romanyshyn, “Image contrast enhancement in automatic mode by nonlinear stretching”, In: Proc. 2018 XIV-th International Conference on Perspective Technologies and Methods in MEMS Design (MEMSTECH), 2018, pp. 104–108. 
