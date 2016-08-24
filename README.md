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

* webview 使用
    1.  [webview api doc](https://developer.chrome.com/apps/tags/webview) 包含详细的webview的具体使用细节

    2. `partition`,标签上的一个属性，用来做为区分ID，如果为空，那么webview中的缓存数据将缓存在内存中，关闭后释放，如果`partition`上设置了`persist:`，那么就可以使用'localStorage'等本地缓存

    3. `executeScript`，用于执行webview中的JS方法，或者自定义代码，但是这里需要注意的点是，由于浏览器的安全策略，你无法通过执行全局方法来执行webview里面的代码，如`window.xxx.xxx`，如果一定要使用这种方法的话请参考如下链接:[stackoverflow:“Chrome Apps” webview.executeScript access guest global varibles](http://stackoverflow.com/questions/26851116/chrome-apps-webview-executescript-access-guest-global-varibles)

    4. 更加优雅的和webview之间的数据通信：`Window.postMessage()`
       [postMessage doc](https://developer.mozilla.org/en-US/docs/Web/API/Window/postMessage)
       ```javascript
       //In NW.js
       webview.contentWindow.postMessage(text, "*");

       //In webview
       window.addEventListener('message', event => {
           let { data } = event;

           //handle your data
       })
       ```
    5. webview内部向NW.js发送数据，通过监听`consolemessage`事件来获取webview内部的`console.log`消息，然后通过定制log内部的消息结构以达到发送数据的目的
        ```javascript
        webview.addEventListener('consolemessage', event => {
            let { message } = event;

            // handle your message
        })
        ```

    6. 打开webview内部的form表单，webview内部默认是不允许打开新页面或者新window，当然一般来说可以通过监听`newwindow`事件去手动处理，但是碰到form表单的时候则比较麻烦，如果用`window.open`/`nw.Window.open`就无法传递form里面的数据，其实这里可以选择稍微绕一下，通过上面的`consolemessage`事件，获取到webview内部的form数据，然后在NW.js这边重新构造一个新的form表单，然后在触发submit就可以了。


* Flash插件的使用

    这里只需要区分你所需的Flash版本是32位还是64位的就可以，你可以在chrome中的plugins里面找到flash的插件文件，地址：`chrome://plugins/`，或者使用我项目里面的plugins文件，使用方法如下：

    1. 开发过程中请放到你的NW.js sdk的文件夹下，并且将目录命名成`PepperFlash`
    2. 当你需要对项目进行打包的时候，记得也要放到对应的cache的包中


* 自定义Top Bar

    在NW.js中你可以抛弃掉默认那丑陋的Top Bar，然后自己实现一个，像下面这样，So easy~
    ```html
    //html
    <header id="app-top-header" class="clearfix"><header>

    //style
    <style>
        #app-top-header {
            -webkit-box-sizing: border-box;
            box-sizing: border-box;
            width: 100%;
            height: 30px;
            line-height: 30px;
            padding: 0 10px;
            background-color: #34BF49;
            -webkit-app-region: drag;
        }
    </style>
    ```
    其实在上面的代码中`-webkit-app-region: drag; `才是真正起到效果的样式，让你的自定义top bar和系统的行为一致而不用自己去写js代码实现对应的拖拽


* Updater

    NW.js并没有和Electron一样，可以通过Squirrel框架来实现自动更新相关的功能，必须依赖第三方库，这里使用到的是[node-webkit-updater](https://github.com/edjafarov/node-webkit-updater)，github上其实已经写了一个updater的流程范例，地址是[https://github.com/edjafarov/node-webkit-updater/blob/master/examples/basic.js](https://github.com/edjafarov/node-webkit-updater/blob/master/examples/basic.js)。
    但是在使用过程中发现了一个小问题，就是在执行`upd.download()`时，可能无法执行成功，后来经过尝试，发现给他一个延时后就能解决调用无效的问题，怀疑是`upd`内部当App打开时立即调用的话可能内部的下载相关的逻辑并未准备好，所以解决代码就是:
    ```javascript
    setTimeout(() => {
        upd.download()
    }, 1000);
    ```

* Other

    1. 在NW.js中打开IE或特定浏览器
        ```javascript
        const exec = require('child_process').exec;

        exec(`start "" "iexplore" "${url}"`);
        ```

## 应用打包(package)

OK，代码写完了那么就要考虑接下来的问题了，帮你的代码打包出来，一般情况下用来做NW.js的打包最容易找到的是`nw-builder`可是尝试了很多次之后一直无法正常的编译通过
直到我使用了[grunt-nw-builder](https://github.com/nwjs/grunt-nw-builder/)，好吧，其实他们并没有什么区别，这个也只是`nw-builder`的grunt插件，可是问题是这个
用起来毫无问题。。。Anyway，总之能用就好，具体使用方法参见`grunt`和`grunt-nw-builder`文档，或者可以看这个项目中的`Gruntfile.js`

## 应用安装包(windows installer)

在windows下有比较多的安装包打包工具，比如`Windows installer`,`NSIS`或`Inno Setup`，在这里我选择使用`NSIS`，嗯，当初觉得这个可能用起来比较简单，但是实际上并！不！是！

好吧，其实另外两个也没比这个简单( 无奈脸 :( )

大致的NSIS脚本大体结构可以参考项目内的`install.nsi`文件

## 自动打包和封装安装包

在经过了一些列市场同学的蹂躏后觉得应该用grunt写一个自动化的脚本来解决越来越频发的打包需求，所以增强了下grunt功能，具体可以查看项目内的`Gruntfile.js`
