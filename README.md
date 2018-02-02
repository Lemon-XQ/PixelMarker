# PixelMarker
## Introdution
- 一款基于**Matlab**的像素级图像标记工具，支持**FITS、jpg、png**等图像格式；
- 可对图像进行**放大、缩小、拖动、像素标注**等操作；
- 支持**撤消**，最多可回退3次标记结果；
- 可将所有**标记点的坐标导出**成txt格式；
## Requirement
- OS: **Windows系统**
- Runtime: **Matlab R2017a**
## Download
- `git clone  https://github.com/Lemon-XQ/PixelMarker.git`
- 已有Matlab R2017a：直接运行 **PixelMarker.exe** 即可
- 无Matlab R2017a：
  - **安装Runtime From WEB:**  运行**PixelMarkerInstaller_web.exe**
	  - 注：如提示网络错误需要翻墙后再运行
  - 直接安装整个Runtime：

##Use
#### 1.打开一张图片
#### 2.使用放大缩小工具缩放至像素级时，按标记按钮进行标记

![](http://okwl1c157.bkt.clouddn.com/PM2.png)

#### 3.快捷键：
- Ctrl+Z 撤消
- Ctrl+O 打开图片
- Ctrl+S 保存标记点坐标
- Esc 结束标记
#### 4.导出的标记点坐标如下：
 
![](http://okwl1c157.bkt.clouddn.com/PM1.png)
