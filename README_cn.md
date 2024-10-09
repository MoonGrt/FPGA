**简体中文 | [English](README.md)**
<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![License][license-shield]][license-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
    <a href="https://github.com/MoonGrt/FPGA-Image_Process">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
    </a>
<h3 align="center">FPGA-Image_Process</h3>
    <p align="center">
    该仓库包含了一些用于FPGA的图像处理模块，方便未来的使用与扩展。所有模块均包含相应的testbench文件，帮助用户进行功能验证。
    <br />
    <a href="https://github.com/MoonGrt/FPGA-Image_Process"><strong>Explore the docs »</strong></a>
    <br />
    <a href="https://github.com/MoonGrt/FPGA-Image_Process">View Demo</a>
    ·
    <a href="https://github.com/MoonGrt/FPGA-Image_Process/issues">Report Bug</a>
    ·
    <a href="https://github.com/MoonGrt/FPGA-Image_Process/issues">Request Feature</a>
    </p>
</div>




<!-- CONTENTS -->
<details open>
  <summary>目录</summary>
  <ol>
    <li><a href="#文件树">文件树</a></li>
    <li>
      <a href="#关于本项目">关于本项目</a>
      <ul>
      </ul>
    </li>
    <li><a href="#贡献">贡献</a></li>
    <li><a href="#许可证">许可证</a></li>
    <li><a href="#联系我们">联系我们</a></li>
    <li><a href="#致谢">致谢</a></li>
  </ol>
</details>





<!-- 文件树 -->
## 文件树

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



<!-- 关于本项目 -->
## 关于本项目

<p>该仓库专为FPGA设计，涵盖多种图像处理模块，旨在为开发者提供高效的图像处理解决方案，便于未来的使用与扩展。每个模块均附带相应的testbench文件，以帮助用户进行功能验证和性能评估，确保模块的可靠性和准确性。以下是仓库中各个模块的详细介绍：</p>

<ul>
    <li><strong>/Binarize/</strong>：实现图像的二值化处理，将灰度图像转化为黑白图像，适用于图像分析与特征提取。二值化是图像处理中一个基本而重要的步骤，广泛应用于文档分析、边缘检测和模式识别等领域。</li>
    <li><strong>/Color_Conv/</strong>：此模块支持多种颜色格式转换，包括 rgb888、rgb565、yuv444 和 yuv422，便于在不同的显示和处理设备之间进行兼容。通过此模块，用户可以轻松处理图像数据，以适应各种硬件平台的需求，确保图像在不同环境下的色彩一致性。</li>
    <li><strong>/Dither/</strong>：抖动处理模块，采用多种算法（如 Floyd-Steinberg 算法）来处理图像，使其在低色深情况下保持良好的视觉效果。此模块特别适合于在资源受限的设备上显示图像，能够有效减少色彩带来的失真，使得图像更加平滑且自然。</li>
    <li><strong>/Edge_Detect/</strong>：边缘检测模块，采用 Sobel、Canny 或 Prewitt 算法，能够有效地检测图像中的边缘信息，广泛应用于图像分析、目标识别和计算机视觉任务。边缘检测是图像处理中一个关键步骤，通过提取图像的边缘信息，用户可以实现更高级的图像处理操作，如物体跟踪和场景重建。</li>
    <li><strong>/Filter/</strong>：滤波模块，包括高斯滤波和中值滤波，能够有效减少图像噪声，提高图像质量，并在边缘保持方面表现良好。高斯滤波广泛用于图像预处理，帮助去除细微噪声，而中值滤波则在处理盐和胡椒噪声时效果显著，二者结合可以显著提升图像的清晰度和细节保留。</li>
    <li><strong>/Video_Scaler/</strong>：图像缩放模块，支持双线性和最近邻插值算法，能够对输入图像进行高效缩放，以适应不同分辨率的显示需求。此模块在实时视频处理、图像播放等应用中非常实用，可以根据用户的需求灵活调整图像的尺寸，保证输出图像的质量。</li>
    <li><strong>/Show_Char/</strong>：字符显示模块，允许在FPGA连接的显示器上显示字符，适用于信息显示和用户界面设计。此模块可以用于创建动态信息界面，提供用户友好的交互体验，广泛应用于嵌入式系统和图形用户界面。</li>
    <li><strong>/Test/</strong>：测试模块，包含多种测试图像，如彩条、网格和灰度图，用于验证其他模块的功能和性能。通过这些测试图像，用户可以快速检查图像处理链的完整性和效果，确保每个模块的输出符合预期。</li>
</ul>

<p>此外，仓库中的所有模块都经过严格的单元测试和性能评估，确保其在不同工作条件下的稳定性和高效性。开发者可以根据项目需求灵活选择和组合模块，以实现特定的图像处理任务。</p>

<p>该仓库的目标是为FPGA开发者提供一个全面且易于扩展的图像处理工具集。未来，我们计划不断更新和扩展该仓库，加入更多的图像处理算法、优化现有模块的性能，并提供更多的示例和文档，帮助用户更好地理解和使用这些模块。</p>

<p align="right">(<a href="#top">top</a>)</p>



<!-- 贡献 -->
## 贡献

贡献让开源社区成为了一个非常适合学习、互相激励和创新的地方。你所做出的任何贡献都是**受人尊敬**的。

如果你有好的建议，请复刻（fork）本仓库并且创建一个拉取请求（pull request）。你也可以简单地创建一个议题（issue），并且添加标签「enhancement」。不要忘记给项目点一个 star！再次感谢！

1. 复刻（Fork）本项目
2. 创建你的 Feature 分支 (`git checkout -b feature/AmazingFeature`)
3. 提交你的变更 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到该分支 (`git push origin feature/AmazingFeature`)
5. 创建一个拉取请求（Pull Request）
<p align="right">(<a href="#top">top</a>)</p>



<!-- 许可证 -->
## 许可证

根据 MIT 许可证分发。打开 [LICENSE](LICENSE) 查看更多内容。
<p align="right">(<a href="#top">top</a>)</p>



<!-- 联系我们 -->
## 联系我们

MoonGrt - 1561145394@qq.com
Project Link: [MoonGrt/FPGA-Image_Process](https://github.com/MoonGrt/FPGA-Image_Process)

<p align="right">(<a href="#top">top</a>)</p>



<!-- 致谢 -->
## 致谢

在这里列出你觉得有用的资源，并以此致谢。我已经添加了一些我喜欢的资源，以便你可以快速开始！

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
[contributors-shield]: https://img.shields.io/github/contributors/MoonGrt/FPGA-Image_Process.svg?style=for-the-badge
[contributors-url]: https://github.com/MoonGrt/FPGA-Image_Process/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/MoonGrt/FPGA-Image_Process.svg?style=for-the-badge
[forks-url]: https://github.com/MoonGrt/FPGA-Image_Process/network/members
[stars-shield]: https://img.shields.io/github/stars/MoonGrt/FPGA-Image_Process.svg?style=for-the-badge
[stars-url]: https://github.com/MoonGrt/FPGA-Image_Process/stargazers
[issues-shield]: https://img.shields.io/github/issues/MoonGrt/FPGA-Image_Process.svg?style=for-the-badge
[issues-url]: https://github.com/MoonGrt/FPGA-Image_Process/issues
[license-shield]: https://img.shields.io/github/license/MoonGrt/FPGA-Image_Process.svg?style=for-the-badge
[license-url]: https://github.com/MoonGrt/FPGA-Image_Process/blob/master/LICENSE

