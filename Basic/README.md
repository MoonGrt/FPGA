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
    <a href="https://github.com/MoonGrt/FPGA-Basic">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
    </a>
<h3 align="center">FPGA-Basic</h3>
    <p align="center">
    FPGA-Basic is a repository designed to store fundamental FPGA modules for easy reuse in future projects. The collection includes a variety of drivers, algorithms, memory components, and utility modules, aimed at providing a solid foundation for FPGA development.
    <br />
    <a href="https://github.com/MoonGrt/FPGA-Basic"><strong>Explore the docs »</strong></a>
    <br />
    <a href="https://github.com/MoonGrt/FPGA-Basic">View Demo</a>
    ·
    <a href="https://github.com/MoonGrt/FPGA-Basic/issues">Report Bug</a>
    ·
    <a href="https://github.com/MoonGrt/FPGA-Basic/issues">Request Feature</a>
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
  ├─ /Algorithms/
  │ ├─ /FIR/
  │ │ ├─ Filter_Params_Gen.m
  │ │ └─ FIR_Filter.v
  │ └─ /Kalman/
  │   ├─ Kalman.v
  │   ├─ signal_gen.m
  │   └─ tb_Kalman.v
  ├─ /Driver/
  │ ├─ /EEPROM/
  │ │ ├─ eeprom_rw.v
  │ │ ├─ eeprom_top.v
  │ │ ├─ i2c_dri.v
  │ │ └─ led_alarm.v
  │ ├─ /HDMI/
  │ │ ├─ hdmi_loop.v
  │ │ ├─ /hdmi_in/
  │ │ └─ /hdmi_out/
  │ ├─ /LCD/
  │ │ ├─ clk_div.v
  │ │ ├─ lcd_display.v
  │ │ ├─ lcd_driver.v
  │ │ ├─ lcd_rgb_colorbar.v
  │ │ ├─ rd_id.v
  │ │ └─ tb_lcd_rgb_colorbar.v
  │ ├─ /LED/
  │ │ ├─ /breath_led/
  │ │ │ └─ breath_led.v
  │ │ └─ /led_twinkle/
  │ │   ├─ led_twinkle.v
  │ │   └─ tb_led_twinkle.v
  │ ├─ /SR04/
  │ │ ├─ sim_sr04.v
  │ │ └─ sr04.v
  │ ├─ /Tube/
  │ │ └─ digital_tube.v
  │ └─ /VGA/
  │   ├─ vga_disp.v
  │   └─ vga_dri.v
  ├─ /MEM/
  │ ├─ /axi_ddr_ram/
  │ │ └─ /src/
  │ │   ├─ axi_master_gen.v
  │ │   ├─ axi_ram.v
  │ │   └─ tb_top.v
  │ ├─ /FIFO/
  │ │ └─ /src/
  │ │   ├─ FIFO.v
  │ │   ├─ FIFO1.v
  │ │   └─ FIFO2.v
  │ ├─ /RAM/
  │ │ ├─ /sim/
  │ │ │ └─ tb_simple_dualport_ram.v
  │ │ └─ /src/
  │ │   ├─ ram_char.v
  │ │   └─ simple_dualport_ram.v
  │ ├─ /ROM/
  │ │ ├─ /sim/
  │ │ │ └─ tb_ROM1.v
  │ │ └─ /src/
  │ │   └─ ROM1.v
  │ └─ /Tool/
  │   ├─ B2H.py
  │   └─ H2B.py
  └─ /Others/
    ├─ /Debounce/
    │ ├─ debounce.v
    │ └─ tb_debounce.v
    └─ /Piple_Delay/
      ├─ piple_delay.v
      └─ tb_piple_delay.v

```



<!-- ABOUT THE PROJECT -->
## About The Project

<p>
FPGA-Basic is a repository designed to store and organize fundamental modules for FPGA development. It provides a modular approach to FPGA design, making it easier to integrate and reuse different hardware components across various projects. This repository is particularly useful for both beginners and experienced engineers who need ready-to-use modules in areas such as signal processing, interface drivers, memory management, and general utility functions. Each module has been optimized for performance and is thoroughly documented for ease of understanding and integration.
</p>

<h4>Structure Overview</h4>
<ul>
  <li>
    <strong>/Algorithms/</strong>: This section contains essential algorithmic modules often required in FPGA designs. Current modules include:
    <ul>
      <li><strong>FIR</strong>: A Finite Impulse Response (FIR) filter implementation for signal processing tasks.</li>
      <li><strong>Kalman</strong>: A Kalman filter module for noise reduction and state estimation in real-time systems.</li>
    </ul>
  </li>
  <li>
    <strong>/Driver/</strong>: This directory includes a range of driver modules that allow interfacing with various hardware components. Modules include:
    <ul>
      <li><strong>EEPROM</strong>: Driver for controlling EEPROM memory.</li>
      <li><strong>HDMI</strong>: HDMI driver for video output applications.</li>
      <li><strong>LCD</strong>: Driver for LCD displays.</li>
      <li><strong>LED</strong>: Simple LED control driver.</li>
      <li><strong>SR04</strong>: Ultrasonic distance measurement driver using the SR04 sensor.</li>
      <li><strong>Tube</strong>: Driver for 7-segment display modules (Tube).</li>
      <li><strong>VGA</strong>: VGA driver for video output, useful in display applications.</li>
    </ul>
  </li>
  <li>
    <strong>/MEM/</strong>: This section provides a variety of memory-related modules, such as:
    <ul>
      <li><strong>axi_ddr_ram</strong>: AXI interface DDR RAM controller.</li>
      <li><strong>FIFO</strong>: First-In-First-Out memory buffer module for data queuing.</li>
      <li><strong>RAM</strong>: Simple Random Access Memory (RAM) implementation.</li>
      <li><strong>ROM</strong>: Read-Only Memory (ROM) module for storing constants.</li>
      <li><strong>Tool</strong>: Utility tools for memory management and testing.</li>
    </ul>
  </li>
  <li>
    <strong>/Others/</strong>: Contains miscellaneous and utility modules, including:
    <ul>
      <li><strong>Debounce</strong>: A debouncing circuit module to eliminate noise from mechanical switches.</li>
      <li><strong>Piple_Delay</strong>: Pipeline delay module for timing adjustments and synchronization.</li>
    </ul>
  </li>
</ul>

<p>
This repository is constantly evolving, with plans to add more advanced modules in the future, such as DSP modules, more complex drivers, and utility components for system monitoring and performance optimization. Contributions are welcome.
</p>

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
Project Link: [MoonGrt/FPGA-Basic](https://github.com/MoonGrt/FPGA-Basic)

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
[contributors-shield]: https://img.shields.io/github/contributors/MoonGrt/FPGA-Basic.svg?style=for-the-badge
[contributors-url]: https://github.com/MoonGrt/FPGA-Basic/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/MoonGrt/FPGA-Basic.svg?style=for-the-badge
[forks-url]: https://github.com/MoonGrt/FPGA-Basic/network/members
[stars-shield]: https://img.shields.io/github/stars/MoonGrt/FPGA-Basic.svg?style=for-the-badge
[stars-url]: https://github.com/MoonGrt/FPGA-Basic/stargazers
[issues-shield]: https://img.shields.io/github/issues/MoonGrt/FPGA-Basic.svg?style=for-the-badge
[issues-url]: https://github.com/MoonGrt/FPGA-Basic/issues
[license-shield]: https://img.shields.io/github/license/MoonGrt/FPGA-Basic.svg?style=for-the-badge
[license-url]: https://github.com/MoonGrt/FPGA-Basic/blob/master/LICENSE

