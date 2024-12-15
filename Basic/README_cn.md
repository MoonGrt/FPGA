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
    <a href="https://github.com/MoonGrt/FPGA">
    <img src="../Document/images/logo.png" alt="Logo" width="80" height="80">
    </a>
<h3 align="center">FPGA</h3>
    <p align="center">
    FPGA仓库用于存储一些基础的FPGA模块，方便在未来项目中调用。该集合包含多种驱动程序、算法、内存组件和实用模块，旨在为FPGA开发提供一个坚实的基础。
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



<!-- 关于本项目 -->
## 关于本项目

<p>
FPGA仓库旨在存储和组织FPGA开发中常用的基础模块，提供一种模块化的设计方法，方便在不同项目中集成和复用各类硬件组件。该仓库非常适合需要现成模块的初学者和有经验的工程师，涵盖信号处理、接口驱动、内存管理及通用实用功能等领域。每个模块都经过性能优化，并附有详细的文档说明，便于理解和集成。
</p>

<h4>结构概览</h4>
<ul>
  <li>
    <strong>/Algorithms/</strong>：该部分包含常用的算法模块，这些模块在FPGA设计中经常使用。当前模块包括：
    <ul>
      <li><strong>FIR</strong>：有限脉冲响应滤波器(FIR)，适用于信号处理任务。</li>
      <li><strong>Kalman</strong>：卡尔曼滤波器模块，用于实时系统中的噪声抑制和状态估计。</li>
    </ul>
  </li>
  <li>
    <strong>/Driver/</strong>：该目录下存放了多种硬件接口驱动模块，便于与不同硬件设备的交互。模块包括：
    <ul>
      <li><strong>EEPROM</strong>：用于控制EEPROM存储器的驱动程序。</li>
      <li><strong>HDMI</strong>：用于视频输出的HDMI驱动程序。</li>
      <li><strong>LCD</strong>：LCD显示屏驱动程序。</li>
      <li><strong>LED</strong>：简单的LED控制驱动程序。</li>
      <li><strong>SR04</strong>：用于超声波距离测量的SR04传感器驱动程序。</li>
      <li><strong>Tube</strong>：数码管（Tube）驱动程序，用于7段数码管显示模块。</li>
      <li><strong>VGA</strong>：VGA视频输出驱动程序，适用于显示应用。</li>
    </ul>
  </li>
  <li>
    <strong>/MEM/</strong>：该部分提供多种内存相关模块，包括：
    <ul>
      <li><strong>axi_ddr_ram</strong>：AXI接口的DDR RAM控制器。</li>
      <li><strong>FIFO</strong>：先进先出(FIFO)内存缓冲模块，用于数据排队。</li>
      <li><strong>RAM</strong>：简单的随机存取存储器(RAM)实现。</li>
      <li><strong>ROM</strong>：只读存储器(ROM)模块，用于存储常量数据。</li>
      <li><strong>Tool</strong>：用于内存管理和测试的实用工具模块。</li>
    </ul>
  </li>
  <li>
    <strong>/Others/</strong>：该部分包含杂项和实用工具模块，包括：
    <ul>
      <li><strong>Debounce</strong>：去抖动电路模块，消除机械开关的噪声。</li>
      <li><strong>Piple_Delay</strong>：流水线延迟模块，用于调整时序和同步。</li>
    </ul>
  </li>
</ul>

<p>
该仓库将持续更新，计划未来增加更多高级模块，例如DSP模块、更复杂的驱动程序以及用于系统监控和性能优化的实用组件。欢迎贡献代码。
</p>

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

根据 MIT 许可证分发。打开 [LICENSE.txt](LICENSE.txt) 查看更多内容。
<p align="right">(<a href="#top">top</a>)</p>



<!-- 联系我们 -->
## 联系我们

MoonGrt - 1561145394@qq.com
Project Link: [MoonGrt/FPGA](https://github.com/MoonGrt/FPGA)

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

