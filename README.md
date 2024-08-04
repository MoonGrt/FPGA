<div id="top"></div>

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]


<!-- PROJECT LOGO -->
<br />
<div align="center">
	<a href="https://github.com/MoonGrt/FPGA-Image_Process">
	<img src="images/logo.png" alt="Logo" width="80" height="80">
	</a>
<h3 align="center">FPGA-Image_Process</h3>
	<p align="center">
	This repository contains a collection of FPGA-based image processing projects. The projects include character display, arbitrary ratio video scaling, edge detection, filtering (median, mean, Gaussian, etc.), and digital feature recognition. Each project demonstrates various techniques and applications of image processing on FPGA platforms.
	<br />
	<a href="https://github.com/MoonGrt/FPGA-Image_Process"><strong>Explore the docs »</strong></a>
	<br />
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
  <summary>Contents</summary>
  <ol>
    <li><a href="#file-tree">File Tree</a></li>
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
  ├─ LICENSE
  ├─ README.md
  ├─ /images/
  ├─ /Show_Char/
  │ └─ /show_char.srcs/
  │   ├─ ram_init_file.inithex
  │   ├─ /sim_1/
  │   │ └─ /new/
  │   │   └─ rb_top.v
  │   └─ /sources_1/
  │     ├─ dvi_transmitter_top.v
  │     ├─ encode.v
  │     ├─ hdmi_tx.v
  │     ├─ ram_char.v
  │     ├─ ram_init_file.inithex
  │     ├─ video_display.v
  │     ├─ video_driver.v
  │     └─ /new/
  │       ├─ ram_char1.v
  │       └─ ram_init_file.inithex
  └─ /Video_Scaler/
    └─ /video_scaler.srcs/
      └─ /sources_1/
        ├─ color_bar.v
        ├─ fifo.v
        ├─ fifo2.v
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

