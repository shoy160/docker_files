******************************************************
*** Jexus web server for linux V5.8.x 版的安装使用 ***
******************************************************

Jexus web server for linux 是一款基于mono环境，运行于Linux/unix操作系统之上，以支持ASP.NET为核心功能的高性能WEB服务器。
www.linuxdot.net是Jexus web server官方网站，也是国内最权威的mono技术、.NET跨平台开发技术的综合社区。
为了确保可持续良性发展，Jexus已开始接受各位爱心人士的资金捐助，支付宝帐号是 j66x@163.com 。


Jexus V5.8.x有如下功能特点：
01、高性能ASP.NET服务器。这是Jexus的核心功能。不管是稳定性、易用性还是并发承载能力、并行处理速度，Jexus对ASP.NET的支持都是非常优秀的；
02、支持Fast-CGI协议。通Fast-CGI，Jexus能支持包括PHP在内的所有拥有Fast-CGI服务功能的WEB应用；
03、具有强劲的反向代理功能，同时支持多目标负载均衡。灵活运用Fast-CGI以及反向代理，Jexus可以让你的网站与各种不同类型资源（如aspx/php/jsp）实现无缝整合。
04、具有比反向代理更轻量速度更快的“端口转发”功能，适合于整合具备http侦听功能的本机应用程序，比如Asp.net Core或者Tomcat.
05、具备基于正则表达式的强大的URL重写功能；
06、拥有强大的流媒体支持能力，支持FLV/F4V视频文件拖动播放，支持微软平滑流媒体技术；
07、具备可控的“ASP.NET前置缓存”，能大大提升ASP.NET网站的承载能力和响应速度；
08、支持Https，具有SSL加密数据安全传输能力；
09、具有基础而实用的入侵检测功能，能自动终止已被识别的非法请求；
10、提供符合OWIN标准的应用层接口，支持Nancy、SignalR等符合OWIN标准的应用框架，支持WebSocket；
11，提供AppHost管理器功能，能将asp.net core或node.js、tomcat等“自宿主”式的以控制台方式运行的web应用程序与网站整合，纳入jexus统一管理；



一、安装：

安装前的准备工作：

* 需要libc2.3.2或更高版本的支持（可用ldd --version查询版本情况），如果需要启用https，系统中还需具备libssl库文件，比如libssl.so.0.9.8。
* 除Jexus独立版外，系统需要安装好mono 3.12.1 或更高版本（当前最新正式版本是mono 4.4.2.11）。
  Mono的官方网址是：www.go-mono.com。
  Mono的下载地址：http://www.go-mono.com/mono-downloads/download.html 。
  Mono的具体安装办法，请参考 www.linuxdot.net 上的有关文章。

A、独立版安装：
  cd /tmp
  wget linuxdot.net/down/jexus-5.8.2-x64.tar.gz
  tar -zxvf jexus-5.8.2.tar.gz
  sudo mv jexus /usr/
  sudo rm jexus-*
  cd /usr/jexus

B、通用版安装与更新：
  安装命令： curl jexus.org/5.8.x/install | sh
  更新命令： curl jexus.org/5.8.x/upgrade | sh

二、运行测试
    复制完Jexus的文件后，Jexus就可以正常工作了。
    所以，如果你的系统只要mono已经成功安装，jexus就可以直接使用，甚至连进一步的配置也完全不需要。

    如果是升级安装，你只需要用运行 “sudo ./jws start”即可启动JWS，如果不能正常工作，常常是新版本的配置方式可能有变，你可以查查jws.conf等配置文件。
    强调：如果你服务器安装有其它的WEB服务器，而且该服务正在运行，请停止它，以免造成端口冲突而造成Jexus无法启动。

    如果是全新安装，请首先建立一个默认的网站文件夹:/var/www/default，并在里面新建一个简单的网页，比如index.html。
    然后在Jexus工作文件夹(/usr/jexus/)中执行“sudo ./jws start”命令(需要root身份)，启动jexus。
    1、用cat log/jws.log,看看jws日志文件有没有什么出错的提示。
    2、如果没有错误提示，请访问一下这台服务器，看看是否有jexus的欢迎页，网址是：http://服务器IP地址/info
    3、如果已经在网站中放有首页或其它网页，你就可以访问这些网页了。



三、Jexus web server 配置（不是必须的，这儿写出来，是为了用户更好的理解jexus的工作原理）：

在 jexus 的工作文件夹中（一般是“/usr/jexus”）有一个基本的配置文件，文件名是“jws.conf”。

jws.conf 中至少有 SiteConfigDir 和 SiteLogDir 两行信息：
SiteConfigDir=siteconf      #指的是存放网站配置文件放在siteconf这个文件夹中，可以使用基于jws.exe文件的相对路径
SiteLogDir=log              #指的是jexus日志文件放在log这个文件夹中，可以使用基于jws.exe文件的相对路径

重要提示：
必须为Jexus指定并创建两个专用文件夹：一个是用于存放日志文件的“日志文件夹”，一个是存放网站配置文件的“网站配置文件夹”。
日志文件夹必须让jexus系统有写入权，因为它会在这儿写入jexus系统日志、网站访问日志等重要内容,安装程序中已经建了一个文件夹，名字是log。
网站配置文件夹是用存放网站配置文件的地方(安装包中已经建了这个文件夹，名字是siteconf)，既使只有一个网站，也必须有这个文件夹，因为jexus启动时会从这个文件夹读取网站配置的内容。
即，默认情况下，Jexus的文件夹结构是：
/usr/jexus             #JWS工作目录
/usr/jexus/siteconf    #网站配置目录
/usr/jexus/log         #日志目录



四、网站配置

Jexus支持多站点，可以用不同的端口、域名、虚拟路径设置任意多的网站。
必须把所有网站配置文件放到jws.conf指定的网站配置文件夹内（这个文件夹常常jws工作目录内的“siteconf”文件夹），这个文件夹除了网站配置文件，不能有其它任何文件，因为jexus会认为这儿的任何一个文件都代表着一个不同的网站。
每个网站有且只有一个配置文件，配置文件的文件名就是这个网站的名称，比如 www.mysite.cn这个网站，配置文件名可以写成“mysite”，当然也可以写成其它文件名，以便管理员容易记忆和识别，但要特别注意：文件名不能有空格！
一个网站可以拥有任意多的域名，不同网站不能有相同的域名，没有域名的网站只能有一个，这个没有域名的网站叫做“默认网站”，而一台服务器最多只能有一个默认网站。

*** 再次强调：
    1、网站配置文件的文件名不能有空格；
    2、网站配置文件夹中只能有网站配置文件，不能有其它文件文件存在，因为这里的每一个文件，都被视为网站配置文件。

下面以www.mysite.cn为例，说说网站的配置
在网站配置文件夹中建立一个文件，这个文件的名称应该有一些意义（至少要能让服务器管理员了解这个配置文件是属于哪一个网站的）
设这个网站的配置文件的文件名为：mysite

sudo miv mysite

A、网站配置的基本内容：
port=80                          # jexus WEB服务器侦听端口（必填。当然可以是其它端口）
root=/ /var/www/mysite           # 网站URL根路径（虚拟目录）和对应的物理路径，两个路径字串之间必须用空格分开（必填。既使这个网站是一个纯粹的反向代理站，也得填）

#可选项
hosts=mysite.cn,www.mysite.cn    # 网站域名（建议填写），可以用泛域名，比如：*.mysite.cn（不填此项或只填一个“*”号表示这是默认网站，一个端口只能有一个默认站）
indexs=index.aspx,index.htm      # 首页文件名，可以写多个，用英文逗号分开（可以不填。因为JWS系统含有常用首页名）
addr=0.0.0.0                     # 绑定到服务器本机的某个IP地址，默认情况下是所有地址，即“0.0.0.0”。
aspnet_exts=mspx,ttt             # 添加新出现的或自定义的ASP.NET扩展名（不建议填。多个扩展名用英文逗号分开，不加点号。系统含有常用扩展名）


B、最简配置示例
最简配置只需port和root两项，如：
port=80
root=/ /var/www/default
注：以上两个条目的含义：“port=80”指本网站的服务端口是80（标准的WEB服务端口）；“root=/ /var/www/default”是指该网站的的虚拟根路径是“/”，所对应的物理文件夹的绝对路径是“/var/www/default”，即网站的内容必须放到“/var/www/default”这个文件夹中。


C、网站配置的高级选项 （阅读建议：建议初学者跳过本小节）
网站配置的高级选项全是可选项，应该根据网站的实际需要选填。
灵活使用高级选项，可以架设出一台与众不同的、功能强大的服务器平台或者服务器群组。

1、使用“URL重写”功能
URL重写是指WEB服务器将访问者的请求URL路径资源按指定的匹配规则解释和匹配为另外的一个真实RUL路径资源。

比如，希望别人访问“.php”类型的文件时，服务器返回 /404.html 这个文件：
rewrite=^/.+?\.(asp|php|cgi)$ /404.html
# 格式：
# “rewrite=”的后面是两部分阻成，两部分之间由一个空格分开。
  空格前是匹配的条件：用正则表达式描述URL的匹配条件。
  空格后是匹配的目标：指的是如果用户访问的路径合乎前面的匹配条件，服务器将以哪个规则回应。

又如：
把“/bbs”解析为“/bbs/index.aspx”，把“/bbs/file-1” 匹配为 “/bbs/show.aspx?id=1”：
rewrite=^/bbs$ /bbs/index.aspx
rewrite=^/bbs/file-([0-9]{1,6})$ /bbs/show.aspx?id=$1
格式解释：rewrite的等号后含有两部分内容，用空隔分开。前半部分是一个正则表达式，用于描述需要URL重写的（用户浏览器中的）url路径样式，后半部分是当用户的URL合乎前面的正则表达式时，JWS应该重写和访问的真实URL路径。

2、禁止或允许某IP或IP段访问网站
A、只允许某些IP地址访问网站（白名单功能）
    默认情况下，允许所有IP地址访问。如果手工设置IP地址白名单，那么，白名单之外的IP地址会自动归入黑名单。
    配置格式，形如：
    allowfrom=1.2.3.*
    AllowFrom=2.2.3.3
B、禁止某IP或某IP端访问网站（黑名单功能）
    默认情况下，本配置为空。如果手工添加需要禁止访问的IP地址（段），必须合乎一个规则：黑名单必须是白名单的真子集。
    配置格式，形如：
    denyfrom=111.222.111.*
    denyfrom=101.201.1.132

3、禁止访问某文件夹及其子文件夹中的内容
DenyDirs=网站文件夹路径的URL路径，如 “/abcfiles”或 “~/abcfiles”，多个路径，用英文逗号分开

4、是否对请求的URL等进行安全检测
本选项默认是true，即需要检查，除非你的确需要关掉这个选项，否则可以不填，格式如下：
checkquery=false
（关掉本项可以提高服务器速度，但就安全而言，不建议关掉它）

5、NOFILE（无文件）功能
nofile=/mvc/controller.aspx
（注：这是Jexus特有的功能，指的是如果服务器不存在用户要访问的文件，服务器将使用什么文件应答。）
（提示：路由后，原RUL路径会存贮在Jexus特有一个服务器变量“X-Real-Uri”中）
（技巧：用这个功能，或者再加上URL Rewrite功能，你完全可以把URL路径与真实路径隔离开来，达到信息隐藏和简化URL的作用。）

6、NOLOG（无日志）功能
nolog=yes
（注：禁用网站日志功能会提高WEB服务器系统的的处理速度，但不足也是明显的，就是你无法详细了解网站的访问情况了）

7、长连接开关
keep_alive=true
注：默认使用长连接，可以不填。

8、反向代理功能
reproxy= /abc/ http://www.xxxx.com:890/abc/
参数的值由本站RUL根路径和目标网站URL根路径两部分组成，之间用空隔分开。
*技巧：反向代量的目标地址可以有多个，用英文逗号分隔，如：
reproxy=/abc/ http://192.168.0.3/abc/,http://192.168.0.4/abc/
这时，当用户访问/abc/时，jexus就会随机选择一台服务器进行访问，达到负载均衡或服务器集群的效果。

9、接受FAST-CGI提供的服务
对于TCP连接：
fastcgi.add=需要fast-cgi处理的文件扩展名|tcp:fast-cgi服务的IP地址:端口
如：fastcgi.add=php,php3|tcp:127.0.0.1:9000
对于unix sockets：
fastcgi.add=需要fcgi处理的文件扩展名|socket:路径
如:fastcgi.add=php,php3|socket:/tmp/phpsvr


10、启用gzip压缩功能
UseGzip=true    # 默认已启用

解释：启用这个功能后，当用户访问“.htm”“.js”等文件时，Jexus会将这些文件进行GZIP压缩后发送给用户浏览器，这样，可以节约更多的网络带宽。

11、让Jexus的工作进程和网站工作于指定的用户权限（身份）下
在jws.conf中，添加一句：httpd.user=系统中已经存在的一个用户名，如httpd.user=www-data

12、让Jexus的工作进程和ASP.NET网站工作在指定的ASP.NET版本环境中
在jws.conf中，添加一句：Runtime=版本号，如：Runtime=v4.0.30319
注：本项配置只适合jexus5.6及以下低版本。

13、启用“ASP.NET前置高速缓存”，提高网站ASP.NET应用的反应速度，减小服务器压力
这是Jexus特有的功能。功能很强劲、很实用。
方法是：在需要启用WEB平台级高速缓存的ASPX页面中加入“<%Response.AddHeader("PageCache-Time","60");%>”一句就行了，其中“60”是超时时间，单位为秒。

14、启用HTTPS进行SSL安全传输
  A、添加全服务器使用的SSL配置：如果需要，可以添加一个ssl配置为所有没有单独配置ssl的网站提供共享，这个配置，对支持泛域名的证书提供了方便。
     方法是，修改jws.conf中的“CertificateFile”和“CertificateKeyFile”项，分别填写证书文件和私钥文件（绝对路径）。
  B、为指定的网站添加SSL配置：方法是修改网站配置文件，分别为“ssl.certificate”和“ssl.certificatekey”条目填写证书文件和私钥文件（绝对路径）。
注1：网站启用https，port必须设为443，并且UseHttps的值设为true。
注2：Jexus Https需要名为libssl的函数库支持，如果你服务器没有libss.so.xxx文件，需要安装openssl。
     对于通用版，把libssl注册到 /usr/etc/mono/config中，即向这个文件添加一行（假设libssl的文件名是"libssl.so.1.0.0"）：
     “<dllmap dll="libssl" target="/lib/x86_64-linux-gnu/libssl.so.1.0.0" />”
     对于独立版，只需要把libssl软连到 jexus的runtime/lib文件夹中就行，如：
     “sudo ln -s //lib/x86_64-linux-gnu/libssl.so.1.0.0  /usr/jexus/runtime/lib/libssl.so”
注3：如果单独为网站配备SSL证书，那么该站的hosts项填写的域名需要与SSL证书支持的域名一致。

15、启用多进程并行服务
默认配置下，jexus是以单进程模式工作的，单进程的好处是配置简单，节约内存，但弱点也很明显，比如，难以充分发挥多cpu多核的性能优势，大并发承受力、容灾力较多进程弱等等。
因此，在多CPU（核）的服务器上开启多进程，有利于提高处理速度、大并发承载能力以及服务的稳定性和容错能力。
开启多个工作进程的办法：修改jws.conf文件中的httpd.processes行，去掉前边的#号，并在等于后填上需要开启的进程数量（不超过cpu核数+1，同时，最多不超过24个）。
强调：开启多进程后，ASP.NET网站的Session状态服务不能再使用inproc模式，而应该使用“StateServer”等其它模式并在Web.config中配置“machineKey”，否则会出现Session数据丢失等现象。

16、限制每个工作进程对内存和cpu资源的消耗量
这是5.5版开始启用的参数，在jws.conf中设置，格式是。
httpd.MaxTotalMemory=所有工作进程可消耗的物理内存总量。单位是“兆字节”，可取值范围是256-服务器可用物理内存大小的整数，同时，平均到每个工作进程不能少于128m，0表示由jexus根据物理内存的大小自动设置。
httpd.MaxCpuTime=单个工作进程可消耗Cpu资源的总时间。单位是“秒”，可取值范围是300-14400的整数。0表示禁用此项

17、应用程序端口转发
  格式：AppHost.Port=端口号
  本配置指的是将当前配置的网站端口的数据转发到应用程序侦听端口，比如可以把该站80端口的请求转发到Asp.net Core应用程序的5000端口上。
  端口转发与反向代理功能相近，但端口转发的性能更高。
  注意：一是端口转发不能用于虚拟路径不是“/”的网站；二是端口转发只能在同一服务器上进行。

18、AppHost功能：驱动自宿主WEB应用程序
  格式：AppHost={CmdLine=命行行; AppRoot=工作路径; Port=端口号}
  说明：CmdLine:必选项。表示启动这个web应用程序的命令（含参数），如 CmdLine=/var/www/mysite/webapp
        AppRoot:必选项。表示这个应用程序的工作目录，如：AppRoot=/var/www/mysite
        Port:可选项。表示这个应用程序的侦听端口，多个端口用英文逗号分隔（注：如果没有填写这一项，就请在AppHost.port或reproxy中填写端口号，否则，请求数据无法转发给应用程序）。
        Env:可选参数。表示这个应用程序工作时需要的环境变量，如 Env=(PATH=/myhost/bin:$PATH),多个设置用英文逗号分开。
        ErrLog:可选项。表示将这个应用程序的异常输出重定向到指定的文件（需填写完整路径）；
        OutLog:可选项。表示将这个应用程序的控制台输出重定向到指定的文件（需填写完整路径）；
        User: 可选项。以指定的用户身份运行该应用程序，默认为root身份。
  注意：
    1，AppHost像AppHost.Port一样，不支持虚拟路径；
    2，AppHost功能是将指定的具有http服务能力的web应用程序纳入jexus工作进程进行管理，对Asp.Net Core或Node.js等自宿主web程序用于生产环境具有重要的意义。

五、操作Jexus：
1、基本操作：
   原jws.start等命令在Jexus V5.8.x中已经合并为一个单一命令，即“jws”，这是一个shell脚本文件。

   命令参数与对应的功效：
   jws start           : 启动Jexus；
   jws start 网站名    : 启动指定的网站
   jws restart         : 重启Jexus
   jws restart 网站名  : 重启指定的网站
   jws stop            : 停止Jexus
   jws stop 网站名     : 停止指定的网站
   jws regsvr          : 注册jexus所需要的全局程序集（本命令只在安装或更新jexus后才用，而且必须用一次，jexus独立版不需要本命令）。
   jws status          : Jexus是否在运行中
   jws -v              : 显示Jexus的版本号

   注意，这些脚本的拥有者应该是root，并且拥有可执行权限。

2、让Jexus能随服务器的启动而自动启动：
   方法是：在/etc/rc.local文件的加入“/usr/jexus/jws start”一行。注意，路径应该是你系统中JWS的实际路径，不要把路径写错了。



六、卸载：
  1、在rc.local文件中删除你手工添加的开机自动启动Jexus的命令行（如果本来就没有添加过，这步操作就不必做了）
  2、删除jexus文件夹及全部内容（建议只删除*.exe和*.dll，其它的，比如网站配置文件等不必删除，以便将来重新启用）。



七、信息反馈、技术交流等联系方式：
  官方网站：www.jexus.org
  技术社区：www.linuxdot.net
  QQ群号码：102732979，103810355
  邮箱地址：j66x@163.com


八、重要声明：
  1，Jexus V5.8.x 是免费软件，可以自由下载、传播和使用。但Jexus作者、发布者、维护者不对Jexus的用途、作用、效果、技术支持以及其它相关内容作任何明确或暗含的承诺，不负担任何直接或间接的责任。
  2，为了确保Jexus的良性发展并为您提供更好的服务，Jexus需要得到广大用户和支持免费软件发展事业的热心人的大力支持：
    A、您可以利用各种机会宣传Jexus优良品质、实用价值及成功案例，为Jexus的发展进步摇旗助威；
    B、您可以为初学者解难答疑，发布使用心得和技术理论，为推广、普及Jexus的部署和应用作出贡献；
    C、你可以将Jexus的一些重要的技术文档翻译为英文或其它文字并公开、免费发布，为Jexus跨出国门走向国际添砖加瓦；
    D、您可以利用开发新工程或升级旧工程的机会，利用Jexus把原来部署在WINDOWS上的WEB应用部署到Linux上；
    E、您可以通过Jexus社区、QQ群、邮箱等各种渠道及时反馈Jexus的BUG，或者向Jexus的开发者、维护者提供富有建设性意义的各种建议；
    F、您可以为Jexus提供广告支持，或向开发者提供适量的经费赞助，为Jexus的持续发展提供动力源泉，Jexus作者的支付宝账号是 j66x@163.com 。




