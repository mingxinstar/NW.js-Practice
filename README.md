# NW.js Practice

这个项目用来记录个人在NW.js开发过程中的一些个人心得（坑）和经验，经过一段时间的NW.js开发，对其开发流程有了一定的了解，基本步骤如下

* 安装NW.js/NW.js sdk
* App开发和插件使用
* 应用打包
* 应用安装包(windows installer/Mac)


## 安装

* 截止目前为止最新的版本为`0.16.1`下载地址为 [https://dl.nwjs.io/v0.16.1/](https://dl.nwjs.io/v0.16.1/)

* 这里有一个点需要注意的是，由于chrome从47,48版本开始就不支持windows xp系统，所以如果你如果需要兼容xp平台，那么到目前为止你可以使用的最高的版本为`0.1.47`，下载地址为 [https://dl.nwjs.io/v0.14.7/](https://dl.nwjs.io/v0.14.7/)

    目前已知在`0.14.7`下有一个相对比较严重的问题，[issue 4855](https://github.com/nwjs/nw.js/issues/4855)，断线情况下可能会导致App在启动的时候崩溃，暂时本人还未解决

* win32 / win64 版本选择，这个依据个人的具体开发情况而定，不过在个人的开发过程中，win32相对在之后的打包和压缩的体积上比较有优势，但是如果并不care这些的话，用win64


## App开发和插件使用

一般来说用NW.js或者Electron进行App开发会有如下两种模式：
    1. 纯NW.js应用开发
    2. 混合开发，NW.js + Webview

个人在开发过程中，碰到第二种的情况会比较多，下面会讲一些可能会用到的知识点:

* [webview api doc](https://developer.chrome.com/apps/tags/webview)

    包含详细的webview的具体使用细节，有几个API和Event比较使用：

    1. `partition`,标签上的一个属性，用来做为区分ID，如果为空，那么webview中的缓存数据将缓存在内存中，关闭后释放，如果`partition`上设置了`persist:`，那么就可以使用'localStorage'等本地缓存
    2. `executeScript`，用于执行webview中的JS方法，或者自定义代码
