# flutter_try
这是一个人练手项目 欢迎大家fork start 

目前存在的问题：

1.懒加载实现  界面切换就刷新 实在是有愧于Gank主。

效果如下：

![image](https://img-blog.csdn.net/20180422221058155)

![image](https://img-blog.csdn.net/20180422221144791)

![image](https://img-blog.csdn.net/20180422221215574)

![image](https://img-blog.csdn.net/20180422221158288)

总结：

优势：说实话这个写项目奇快，没有Android的FindViewByid  也没有H5 的Css引用。
只用安静的 写一个 Container（FrameLayout） ,Warp(Wrap_content),Stack(RelativeLayout),Text(TextView),Icon(ImageView),Button
再在构造函数加参数，再hotreload一波OK!!

劣势：看了下Flutter的官方demo 貌似并没有介绍  关于视频 数据库操作 等调用原生的示例。个人还是感觉目前就只能做个展示以及简单的逻辑的App。
