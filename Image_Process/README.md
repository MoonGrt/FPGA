**English | [简体中文](README_cn.md)**
<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![License][license-shield]][license-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
    <a href="https://github.com/MoonGrt/FPGA">
    <img src="../Document/images/logo.png" alt="Logo" width="80" height="80">
    </a>
<h3 align="center">FPGA</h3>
    <p align="center">
    This repository contains various image processing modules designed for FPGA, facilitating future use and expansion. Each module comes with corresponding testbench files to assist users in function verification.
    <br />
    <a href="https://github.com/MoonGrt/FPGA"><strong>Explore the docs »</strong></a>
    <br />
    <a href="https://github.com/MoonGrt/FPGA">View Demo</a>
    ·
    <a href="https://github.com/MoonGrt/FPGA/issues">Report Bug</a>
    ·
    <a href="https://github.com/MoonGrt/FPGA/issues">Request Feature</a>
    </p>
</div>




<!-- CONTENTS -->
<details open>
  <summary>Contents</summary>
  <ol>
    <li><a href="#file-tree">File Tree</a></li>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>





<!-- FILE TREE -->
## File Tree

```
└─ Project
  ├─ /Binarize/
  │ └─ /src/
  │   └─ binarization.v
  ├─ /Color_Conv/
  │ └─ /src/
  │   ├─ ycbcr_to_rgb.v
  │   ├─ yuv444_yuv422.v
  │   └─ /rgb2yuv_yuv2rgb_v1.0/
  │     ├─ rgb_to_ycbcr.v
  │     ├─ user_ycbcr2rgb_hdtv.v
  │     ├─ user_ycbcr2rgb_top.v
  │     ├─ ycbcr2rgb_2pix.v
  │     ├─ ycbcr_color_bar.v
  │     └─ yuv422_2_ycbcr444.v
  ├─ /Dither/
  │ └─ /src/
  │   └─ dither.v
  ├─ /Edge_Detect/
  │ └─ /src/
  │   ├─ matrix3x3.v
  │   └─ sobel.v
  ├─ /Filter/
  │ └─ /src/
  │   ├─ gauss.v
  │   ├─ matrix3x3.v
  │   ├─ mid_value.v
  │   └─ myram.v
  ├─ /Show_Char/
  │ └─ /src/
  │   ├─ dvi_transmitter_top.v
  │   ├─ encode.v
  │   ├─ hdmi_tx.v
  │   ├─ ram_char.v
  │   ├─ ram_char1.v
  │   ├─ ram_init_file.inithex
  │   ├─ video_display.v
  │   └─ video_driver.v
  ├─ /Test/
  │ └─ /src/
  │   ├─ color_bar.v
  │   └─ testpattern.v
  └─ /Video_Scaler/
    ├─ /sim/
    │ ├─ scalerTest.v
    │ └─ tb_scaler.v
    └─ /src/
      ├─ color_bar.v
      ├─ fill_brank.v
      ├─ pixel_cnt.v
      ├─ tb_top.v
      └─ /algorithm/
        ├─ algorithm.v
        ├─ FIFO.v
        ├─ image_cut.v
        ├─ ramDualPort.v
        ├─ ramFifo.v
        └─ streamScaler.v

```



<!-- ABOUT THE PROJECT -->
## About The Project

<p>This repository is specifically designed for FPGA, encompassing a variety of image processing modules aimed at providing efficient solutions for developers, facilitating future use and expansion. Each module comes with corresponding testbench files to assist users in function verification and performance evaluation, ensuring the reliability and accuracy of the modules. Here’s a detailed introduction to the available modules in the repository:</p>

<ul>
    <li><strong>/Binarize/</strong>: Implements image binarization, converting grayscale images into black-and-white images, suitable for image analysis and feature extraction. Binarization is a fundamental and crucial step in image processing, widely used in document analysis, edge detection, and pattern recognition.</li>
    <li><strong>/Color_Conv/</strong>: This module supports multiple color format conversions, including rgb888, rgb565, yuv444, and yuv422, enabling compatibility between different display and processing devices. With this module, users can easily handle image data to meet the requirements of various hardware platforms, ensuring consistent color representation across different environments.</li>
    <li><strong>/Dither/</strong>: Dithering processing module that employs various algorithms (such as the Floyd-Steinberg algorithm) to render images with good visual quality under low color depth conditions. This module is particularly suitable for displaying images on resource-constrained devices, effectively reducing color-related distortions and making images appear smoother and more natural.</li>
    <li><strong>/Edge_Detect/</strong>: Edge detection module that utilizes Sobel, Canny, or Prewitt algorithms to effectively identify edge information in images, widely used in image analysis, object recognition, and computer vision tasks. Edge detection is a critical step in image processing; by extracting edge information from images, users can perform more advanced image processing operations, such as object tracking and scene reconstruction.</li>
    <li><strong>/Filter/</strong>: Filtering module that includes Gaussian and median filters, effectively reducing image noise and improving image quality while maintaining edge integrity. Gaussian filtering is widely used in image preprocessing to remove fine noise, while median filtering is particularly effective for salt-and-pepper noise. The combination of both can significantly enhance image clarity and detail retention.</li>
    <li><strong>/Video_Scaler/</strong>: Image scaling module that supports bilinear and nearest neighbor interpolation algorithms, capable of efficiently resizing input images to fit different display resolutions. This module is highly practical in real-time video processing and image playback applications, allowing users to flexibly adjust image sizes to meet specific requirements while ensuring high output quality.</li>
    <li><strong>/Show_Char/</strong>: Character display module that allows characters to be displayed on monitors connected to the FPGA, suitable for information display and user interface design. This module can be used to create dynamic information interfaces, providing a user-friendly interaction experience, widely applied in embedded systems and graphical user interfaces.</li>
    <li><strong>/Test/</strong>: Test module containing various test images, such as color bars, grids, and grayscale images, used to validate the functionality and performance of other modules. By using these test images, users can quickly check the integrity and effectiveness of the image processing chain, ensuring that each module's output meets expectations.</li>
</ul>

<p>Moreover, all modules in the repository undergo rigorous unit testing and performance evaluation to ensure their stability and efficiency under various operating conditions. Developers can flexibly choose and combine modules according to project needs to accomplish specific image processing tasks.</p>

<p>The goal of this repository is to provide FPGA developers with a comprehensive and easily extendable set of image processing tools. In the future, we plan to continuously update and expand the repository by adding more image processing algorithms, optimizing the performance of existing modules, and providing additional examples and documentation to help users better understand and utilize these modules.</p>

<p align="right">(<a href="#top">top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.
If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!
1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request
<p align="right">(<a href="#top">top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.
<p align="right">(<a href="#top">top</a>)</p>



<!-- CONTACT -->
## Contact

MoonGrt - 1561145394@qq.com
Project Link: [MoonGrt/](https://github.com/MoonGrt/)
<p align="right">(<a href="#top">top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
* [Malven's Grid Cheatsheet](https://grid.malven.co/)
* [Img Shields](https://shields.io)
* [GitHub Pages](https://pages.github.com)
* [Font Awesome](https://fontawesome.com)
* [React Icons](https://react-icons.github.io/react-icons/search)
<p align="right">(<a href="#top">top</a>)</p>




<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/MoonGrt/FPGA.svg?style=for-the-badge
[contributors-url]: https://github.com/MoonGrt/FPGA/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/MoonGrt/FPGA.svg?style=for-the-badge
[forks-url]: https://github.com/MoonGrt/FPGA/network/members
[stars-shield]: https://img.shields.io/github/stars/MoonGrt/FPGA.svg?style=for-the-badge
[stars-url]: https://github.com/MoonGrt/FPGA/stargazers
[issues-shield]: https://img.shields.io/github/issues/MoonGrt/FPGA.svg?style=for-the-badge
[issues-url]: https://github.com/MoonGrt/FPGA/issues
[license-shield]: https://img.shields.io/github/license/MoonGrt/FPGA.svg?style=for-the-badge
[license-url]: https://github.com/MoonGrt/FPGA/blob/master/LICENSE

