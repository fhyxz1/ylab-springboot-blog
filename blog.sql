-- --------------------------------------------------------
-- 主机:                           127.0.0.1
-- 服务器版本:                        8.0.32 - MySQL Community Server - GPL
-- 服务器操作系统:                      Win64
-- HeidiSQL 版本:                  12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- 导出 blog 的数据库结构
DROP DATABASE IF EXISTS `blog`;
CREATE DATABASE IF NOT EXISTS `blog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `blog`;

-- 导出  表 blog.categories 结构
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` varchar(255) NOT NULL COMMENT '分类名称',
  `description` text COMMENT '分类描述',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  blog.categories 的数据：~21 rows (大约)
DELETE FROM `categories`;
INSERT INTO `categories` (`category_id`, `category_name`, `description`) VALUES
	(1, 'Web开发', '与Web开发相关的文章'),
	(2, '机器学习', '关于机器学习与人工智能的文章'),
	(3, '数据分析', '数据分析和数据科学相关的文章'),
	(4, '全部文章', '包含所有的文章内容'),
	(5, 'Web开发', 'Web开发相关的技术和框架'),
	(6, '移动端开发', '移动端开发相关技术和框架'),
	(7, 'Progressive Web Apps', '渐进式Web应用开发技术'),
	(8, '机器学习', '机器学习技术和框架'),
	(9, 'Cloud Computing', '云计算平台与服务'),
	(10, 'Blockchain', '区块链相关技术与平台'),
	(11, '数据结构与算法', '数据结构与算法的学习与应用'),
	(12, '数据分析', '数据分析相关技术与工具'),
	(13, '全部文章', '包含所有的文章内容'),
	(14, 'Web开发', 'Web开发相关的技术和框架'),
	(15, '移动端开发', '移动端开发相关技术和框架'),
	(16, 'Progressive Web Apps', '渐进式Web应用开发技术'),
	(17, '机器学习', '机器学习技术和框架'),
	(18, 'Cloud Computing', '云计算平台与服务'),
	(19, 'Blockchain', '区块链相关技术与平台'),
	(20, '数据结构与算法', '数据结构与算法的学习与应用'),
	(21, '数据分析', '数据分析相关技术与工具'),
	(22, '技术文章', NULL),
	(23, '产品介绍', NULL),
	(24, '市场营销', NULL),
	(25, '技术文章', NULL),
	(26, '产品介绍', NULL),
	(27, '市场营销', NULL);

-- 导出  表 blog.category_tag 结构
DROP TABLE IF EXISTS `category_tag`;
CREATE TABLE IF NOT EXISTS `category_tag` (
  `category_id` int NOT NULL COMMENT '分类ID',
  `tag_id` int NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`category_id`,`tag_id`),
  KEY `fk_tag` (`tag_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_tag` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  blog.category_tag 的数据：~4 rows (大约)
DELETE FROM `category_tag`;
INSERT INTO `category_tag` (`category_id`, `tag_id`) VALUES
	(1, 1),
	(1, 2),
	(2, 3),
	(2, 4);

-- 导出  表 blog.comments 结构
DROP TABLE IF EXISTS `comments`;
CREATE TABLE IF NOT EXISTS `comments` (
  `comment_id` int NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `post_id` int NOT NULL COMMENT '文章ID，关联 posts 表',
  `user_id` int NOT NULL COMMENT '用户ID，关联 user 表',
  `content` text NOT NULL COMMENT '评论内容',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  PRIMARY KEY (`comment_id`),
  KEY `post_id` (`post_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  blog.comments 的数据：~0 rows (大约)
DELETE FROM `comments`;

-- 导出  表 blog.login_inf 结构
DROP TABLE IF EXISTS `login_inf`;
CREATE TABLE IF NOT EXISTS `login_inf` (
  `login_time` datetime NOT NULL,
  `user_id` int NOT NULL,
  `role` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  blog.login_inf 的数据：~0 rows (大约)
DELETE FROM `login_inf`;

-- 导出  表 blog.posts 结构
DROP TABLE IF EXISTS `posts`;
CREATE TABLE IF NOT EXISTS `posts` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '网站html页面',
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `abstract` varchar(255) NOT NULL COMMENT '摘要',
  `fb_date` datetime DEFAULT NULL COMMENT '发布日期',
  `imgurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '文章的预览图，可以没有',
  `author` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '作者名',
  `category_id` int DEFAULT NULL,
  `tags_id` int DEFAULT NULL,
  PRIMARY KEY (`post_id`),
  KEY `索引 2` (`author`) USING BTREE,
  CONSTRAINT `autor_post` FOREIGN KEY (`author`) REFERENCES `user` (`full_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  blog.posts 的数据：~6 rows (大约)
DELETE FROM `posts`;
INSERT INTO `posts` (`post_id`, `content`, `title`, `abstract`, `fb_date`, `imgurl`, `author`, `category_id`, `tags_id`) VALUES
	(1, '<!doctype html>\n<html>\n<head>\n<meta charset=\'UTF-8\'><meta name=\'viewport\' content=\'width=device-width initial-scale=1\'>\n<title>Vue3入门笔记</title></head>\n<body>\n<h2>一、项目构建方式</h2>\n<h3>CDN或者script引入</h3>\n<p>在script标签中直接写入src即可，是比较传统的vue项目构建方法，如需使用es模块化开发，则只需在script文件中引入esm-brower.js即可</p>\n<p>CDN</p>\n<pre><code class=\'language-javascript\' lang=\'javascript\'>&lt;script src=&quot;https://unpkg.com/vue@3/dist/vue.global.js&quot;&gt;&lt;/script&gt;\n//传统引入\nimport { createApp, ref } from &#39;https://unpkg.com/vue@3/dist/vue.esm-browser.js&#39;\n//Es引入，下文有示例无需在意\n</code></pre>\n<h3>脚手架直接构建（入门不建议）</h3>\n<p>首先安装好node.js前端环境并配置好环境变量，选择需要创建项目的目录，win+r打开命令行，输入以下代码构建：</p>\n<pre><code class=\'language-cmd\' lang=\'cmd\'>npm install vue/cli -g\nvue create $项目名\n</code></pre>\n<p>上面命令会先安装脚手架再进行项目的构建，在项目的构建中会有许多选项，选择好对应的版本、router单页开发与自己需要的功能即可，无需过多引入.</p>\n<h3>可视化构建</h3>\n<p>也可以使用vue自带ui，这种方法带有可视化界面(建议)</p>\n<pre><code>npm install vue-ui\nvue ui\n</code></pre>\n<p>至此，你已经完成了一个基本vue项目的构建，下面开始实战吧。</p>\n<h2>二、第一段Vue代码</h2>\n<p>下面是一段使用传统方式引入实现的vue代码，将一个实例挂载到一个id为app的div上实现渲染(注意以下全为本地文件引入，没有换成CDN即可)</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;vue&lt;/title&gt;\n    &lt;script src=&quot;vue.global.js&quot;&gt;&lt;/script&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;{{msg}}&lt;/div&gt;\n    &lt;script&gt;\n        Vue.createApp({\n        //setup用于设置响应的数据与方法\n            setup() {\n                msg = &#39;Hello Vue!&#39;//响应数据\n                return {\n                    msg\n                }\n            }\n            \n        }).mount(&#39;#app&#39;)//挂载到id为app的标签上\n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>es模块化的代码(改变了引入方式与开发方式，有较大大区别,展示需要在本地服务器打开：vscode下载live sever插件，hbulider使用内置服务器)</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;vue&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;&lt;div id=&quot;app&quot;&gt;{{msg}}&lt;/div&gt;\n &lt;script type=&quot;module&quot;&gt;\n        import { createApp, ref, reactive } from &#39;./vue.esm-browser.js&#39;\n        \n        createApp({\n            setup() {\n            		msg:&quot;Hello Vue!&quot;\n    			}\n                return {\n                    msg\n                }\n            }\n        }).mount(&#39;#app&#39;) // 挂载\n    &lt;/script&gt;\n    &lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<h2>三、使用rective与ref存储值</h2>\n<p>在上文的代码中我们定义了一个setup方法来存储值，那么当需要存储一组对应的数据时，这种方法显然是复杂繁琐的，于是我们引入了rective来存储对象的一组属性值。</p>\n<pre><code class=\'language-javascript\' lang=\'javascript\'> const web = reactive({\n                    title: &quot;页面&quot;,\n                    url: &quot;www.我是网址.com&quot;,\n                    user:0\n                })//使用reactive存储对象值\n</code></pre>\n<p>当只需存储一组线性的数组值或者单个值时，我们可以使用ref方法</p>\n<pre><code class=\'language-javascript\' lang=\'javascript\'>                const number = ref(10)//使用ref存储单个值\n                number.value=20//修改number的值\n				const numberlist=ref([1,2,3,4,6,9])\n</code></pre>\n<p>在使用以上方法存储完属性及数据之后，不要忘记在return中挂载哦。</p>\n<h2>四、v-on事件绑定以及简写</h2>\n<p>在网页中对数据以及样式的动态效果，通常需要js的事件绑定来实现，vue也不例外，在vue中一般通过v-on接事件或者简写方式@接事件来实现事件的绑定，下面是一段按钮与文本框实现的事件绑定以及值的动态渲染。</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;index&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n        {{ message }}  \n        &lt;h1&gt;{{ web.title }}&lt;/h1&gt;\n        &lt;h2&gt;{{ web.url }}&lt;/h2&gt;  \n        &lt;h3&gt;{{ number }}&lt;/h3&gt; \n        &lt;h1&gt;{{ web.user }}&lt;/h1&gt;\n        &lt;hr&gt;\n        &lt;input type=&quot;button&quot; value=&quot;修改网站地址&quot; v-on:click=&quot;wz()&quot; style=&quot;color: aqua;&quot;&gt; &lt;br&gt;\n        add&lt;input type=&quot;text&quot; @keyup.enter=&quot;add(1,2)&quot;&gt;&lt;br&gt;\n        空格&lt;input type=&quot;text&quot; @keyup.space=&quot;add(4,5)&quot;&gt;&lt;br&gt;\n        tab &lt;input type=&quot;text&quot; @keydown.tab=&quot;add(7,8)&quot;&gt;&lt;br&gt;\n        w &lt;input type=&quot;text&quot; @keyup.w=&quot;add(10,11)&quot;&gt;&lt;br&gt;\n        ctrl+enter &lt;input type=&quot;text&quot; @keyup.ctrl.enter=&quot;add(13,14)&quot;&gt;&lt;br&gt;\n    &lt;/div&gt;\n\n    &lt;script type=&quot;module&quot;&gt;\n        import { createApp, ref, reactive } from &#39;./vue.esm-browser.js&#39;\n        \n        createApp({\n            setup() {\n                const number = ref(10)//使用ref存储单个值\n                number.value=20//修改number的值\n                const wz = () =&gt; { \n                    web.url = &quot;www.amns.com&quot;\n                }//按钮事件\n                const add=(a,b)=&gt;{web.user+=a+b}//文本框的增加事件\n                //使用箭头函数的方法简化\n                const web = reactive({\n                    title: &quot;页面&quot;,\n                    url: &quot;www.baidu.com&quot;,\n                    user:0\n                })//使用reactive存储对象值\n                return {\n                    message:&quot;这是一段消息挂载&quot;,\n                    web,\n                    number,\n                    wz,\n                    add\n                }//需要渲染到元素上的值\n            }\n        }).mount(&#39;#app&#39;) // 挂载应用程序\n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n\n</code></pre>\n<p>可以看到通过简写的方法可以更快的实现事件的绑定，在实际开发中，为了减少代码量，我们通常会使用简写的方法来书写代码。</p>\n<h2>五、v-show条件渲染控制</h2>\n<p>在浏览各种动态网页时，我们常常可以看到各种元素的动态隐藏效果，这种效果对于网页的设计有时可谓是锦上添花，在vue中，有多种方法来进行元素的渲染展示控制，这里我们学习最入门的一种：v-show，下面是使用v-show与按钮事件的渲染展示小示例：</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n        &lt;h1&gt;\n            渲染内容&lt;br&gt;{{msg}}\n        &lt;/h1&gt;\n        &lt;p v-show=&quot;hh.show&quot;&gt;v-show&lt;/p&gt;\n        &lt;h2&gt;{{hh.show}}&lt;/h2&gt;\n        &lt;button value=&quot;点击&quot; @click=&quot;show()&quot;&gt;点击&lt;/button&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n             const msg=ref(&quot;wow&quot;)\n             const hh=reactive({show:true})\n             const show= ()=&gt;{\n                hh.show=!hh.show\n             }\n                return {\n                msg,\n                hh,\n                show\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>通过这种方法可以实现简单的显示与隐藏控制，但不妨想想，当需要展示与隐藏的元素多起来的时，是不是代码量就会相对增加呢？</p>\n<p>当然，对于多条件的显示与隐藏的渲染，还有另外几种方法，v-show的使用场景显然只适合条件较少的渲染展示中。</p>\n<h2>六、v-if与else条件渲染控制</h2>\n<p>在Vue中，对于多条件的渲染，v-show显然过于繁琐，因此对于多条件的渲染，我们选择使用v-if的条件渲染，结合上文的代码修改，得到以下代码：</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;index&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n        {{ message }}  \n        &lt;h1&gt;{{ web.title }}&lt;/h1&gt;\n        &lt;h2&gt;{{ web.url }}&lt;/h2&gt;  \n        &lt;h3&gt;{{ number }}&lt;/h3&gt; \n        &lt;h1&gt;{{ web.user }}&lt;/h1&gt;\n        &lt;hr&gt;\n        &lt;input type=&quot;button&quot; value=&quot;修改网站地址&quot; v-on:click=&quot;wz()&quot; style=&quot;color: aqua;&quot;&gt; &lt;br&gt;\n        add&lt;input type=&quot;text&quot; @keyup.enter=&quot;add(1,2)&quot;&gt;&lt;br&gt;\n        空格&lt;input type=&quot;text&quot; @keyup.space=&quot;add(4,5)&quot;&gt;&lt;br&gt;\n        tab &lt;input type=&quot;text&quot; @keydown.tab=&quot;add(7,8)&quot;&gt;&lt;br&gt;\n        w &lt;input type=&quot;text&quot; @keyup.w=&quot;add(10,11)&quot;&gt;&lt;br&gt;\n        ctrl+enter &lt;input type=&quot;text&quot; @keyup.ctrl.enter=&quot;add(13,14)&quot;&gt;&lt;br&gt;\n        &lt;p v-if=&quot;web.user&lt;10&quot;&gt;小于10&lt;/p&gt;\n        &lt;p v-else-if=&quot;web.user&gt;30&quot;&gt;大于30&lt;/p&gt;\n    &lt;/div&gt;\n\n    &lt;script type=&quot;module&quot;&gt;\n        import { createApp, ref, reactive } from &#39;./vue.esm-browser.js&#39;\n        \n        createApp({\n            setup() {\n                const number = ref(1)//使用ref存储单个值\n                number.value=2//修改number的值\n                const wz = () =&gt; { \n                    web.url = &quot;www.amns.com&quot;\n                }//按钮事件\n                const add=(a,b)=&gt;{web.user+=a+b}//文本框的增加事件\n                //使用箭头函数的方法简化\n                const web = reactive({\n                    title: &quot;页面&quot;,\n                    url: &quot;www.baidu.com&quot;,\n                    user:0\n                })//使用reactive存储对象值\n                return {\n                    message:&quot;这是一段消息挂载&quot;,\n                    web,\n                    number,\n                    wz,\n                    add\n                }//需要渲染到元素上的值\n            }\n        }).mount(&#39;#app&#39;) // 挂载应用程序\n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n\n</code></pre>\n<p>当user小于10时，小于10渲染展示，大于30时大于30渲染展示。</p>\n<h2>七、v-bind单向属性绑定</h2>\n<p>当网页中的数据并非静态而是动态改变的值时，我们可以使用v-bind实现值的动态绑定：</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n        &lt;input type=&quot;text&quot; v-bind:value=&quot;wz1.url&quot;&gt;\n        //简写\n        &lt;input type=&quot;text&quot; :value=&quot;wz1.url&quot;&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n             const wz1=reactive({\n                url:&quot;www.com&quot;,\n                name:&quot;wow&quot;\n            })\n                return {\n                    wz1\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>这段代码通过v-bind以及简写的方式实现了动态的值绑定，实现了值的动态变化，这个值既可以是对象的某个属性值，也可以是一个变量值。</p>\n<p>另外，v-bind还可以使用一个布尔值来控制css等效果，具体写法如下：</p>\n<pre><code class=\'language-html\' lang=\'html\'>//假设我有一个定义好的class样式vl与布尔值wz1.t\n&lt;p :class=&quot;{vl:wz1.t}&quot;&gt;布尔绑定&lt;/p&gt;\n</code></pre>\n<h2>八、v-for结构遍历</h2>\n<p>在某个属性存在多个值时，我们想要给它全部展示出来或者展示特定的值时，可以使用v-for进行多值数据的遍历，这个多值数据可以是数组 or 对象，以下是一段遍历的使用v-for来wz1对象的user属性的代码示例：</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n        &lt;li v-for=&quot;value in wz1.user&quot;&gt;{{value}}&lt;/li&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n             const wz1=reactive({\n                url:&quot;www.com&quot;,\n                name:&quot;wow&quot;,\n                user:[{name:&quot;张三&quot;,age:20},{name:&quot;李四&quot;,age:25} ]\n            })\n                return {\n                    wz1,\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>这样，就实现了wz1的user属性的遍历。</p>\n<h2>九、双向数据绑定v-model</h2>\n<p>在上文，我们使用v-bind实现了数据的单向绑定，将js对象的值与文本框value进行了单向的绑定，对文本框进行修改并不会影响到js对象的值，如果在网页之中需要实现实时的数据变化怎么办呢？这里就要引出我们的v-model了，它同v-bind用法相同，不同的是，在使用v-model进行绑定后，修改文本框的值对象的值也会对应的改变。下面是一段v-model与v-bind的对比代码：</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n\n        &lt;h1&gt;\n            渲染内容&lt;br&gt;{{msg}}\n        &lt;/h1&gt;\n        &lt;p v-show=&quot;hh.show&quot;&gt;v-show&lt;/p&gt;\n        &lt;h2&gt;{{hh.show}}&lt;/h2&gt;\n        &lt;button value=&quot;点击&quot; @click=&quot;show()&quot;&gt;点击&lt;/button&gt;&lt;br&gt;\n        v-bind&lt;input type=&quot;text&quot; v-bind:value=&quot;wz1.url&quot;&gt;\n        //简写\n        &lt;input type=&quot;text&quot; :value=&quot;wz1.url&quot;&gt;\n        v-model &lt;input type=&quot;text&quot; v-model=&quot;wz1.url&quot;&gt;\n        &lt;p&gt;绑定的属性：{{wz1.url}}&lt;/p&gt;\n        &lt;li v-for=&quot;value in wz1.user&quot;&gt;{{value}}&lt;/li&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n             const msg=ref(&quot;wow&quot;)\n             const hh=reactive({show:true})\n             const wz1=reactive({\n                url:&quot;www.com&quot;,\n                name:&quot;wow&quot;,\n                user:[{name:&quot;张三&quot;,age:20},{name:&quot;李四&quot;,age:25} ]\n            })\n             const show= ()=&gt;{\n                hh.show=!hh.show\n             }\n                return {\n                    wz1,\n                msg,\n                hh,\n                show\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>实际操作可以发现，对v-bind绑定的文本框进行输入并不会改变原本的值，在对v-model绑定的文本框进行输入时会改变原本的值。</p>\n<h3>表单用法</h3>\n<p>在表单之中也可以使用v-model，用法如下</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n        选框&lt;br&gt;值{{wz1.name}} &lt;br&gt;\n      &lt;input type=&quot;radio&quot; v-model=&quot;wz1.name&quot; value=&quot;wow&quot;&gt;\n        1\n        &lt;input type=&quot;radio&quot; v-model=&quot;wz1.name&quot; value=&quot;nice&quot;&gt;\n        2 &lt;br&gt;复选{{wz1.xx}}\n        &lt;input type=&quot;checkbox&quot; v-model=&quot;wz1.xx&quot; value=&quot;1&quot;&gt;\n        &lt;input type=&quot;checkbox&quot; v-model=&quot;wz1.xx&quot; value=&quot;2&quot;&gt;\n        &lt;br&gt;{{wz1.xz}}\n        &lt;input type=&quot;checkbox&quot; v-model=&quot;wz1.xz&quot; value=&quot;true&quot;&gt;\n        &lt;br&gt;下拉框{{wz1.xl}}\n        &lt;select V-model=&quot;wz1.xl&quot;&gt;&lt;option value=&quot;a&quot;&gt;a&lt;/option&gt;\n        &lt;option value=&quot;b&quot;&gt;b&lt;/option&gt;\n        &lt;option value=&quot;c&quot;&gt;c&lt;/option&gt;\n        &lt;/select&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n             const msg=ref(&quot;wow&quot;)\n             const hh=reactive({show:true})\n             const wz1=reactive({\n                url:&quot;www.com&quot;,\n                name:&quot;wow&quot;,\n                user:[{name:&quot;张三&quot;,age:20},{name:&quot;李四&quot;,age:25} ],\n                xx:[],\n                xz:false,\n                xl:false\n            })\n             const show= ()=&gt;{\n                hh.show=!hh.show\n             }\n                return {\n                    wz1,\n                msg,\n                hh,\n                show\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<h3>修饰符</h3>\n<p>有三种，具体代码示例：</p>\n<pre><code class=\'language-html\' lang=\'html\'>        修饰符 lazy（失去焦点或按下回车后渲染）\n&lt;input type=&quot;text&quot; v-model.lazy=&quot;xxx属性&quot;&gt;&lt;br&gt;\n        修饰符 number（仅获取前数字，如前面有文字还是会展示）\n&lt;input type=&quot;text&quot; v-model.number=&quot;xxx属性2&quot;&gt;{{xxx属性2}}&lt;br&gt;\n        修饰符 trim（自动去除首尾空格）\n&lt;input type=&quot;text&quot; v-model.trim=&quot;xxx属性&quot;&gt;&lt;br\n</code></pre>\n<h2>十、渲染数据v-text与v-html</h2>\n<p>在上文展示对象属性时，我们通常使用{{}}插值表达式来进行渲染，当插值表达式过多时，对于阅读代码显然是不方便的，所以这里我们用两个属性来实现同样的效果：v-text与v-html，这两个属性一个是渲染纯文本一个是渲染html代码，下面是示例代码：</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n        &lt;p v-text=&quot;wz1.url&quot;&gt;&lt;/p&gt;\n        &lt;p v-html=&quot;wz1.dm&quot;&gt;&lt;/p&gt;\n\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n             const msg=ref(&quot;wow&quot;)\n             const hh=reactive({show:true})\n             const wz1=reactive({\n                url:&quot;www.com&quot;,\n                name:&quot;wow&quot;,\n                user:[{name:&quot;张三&quot;,age:20},{name:&quot;李四&quot;,age:25} ],\n                dm:&quot;&lt;h1 style=&#39;color:red&#39;&gt;wow&lt;/h1&gt;&quot;,\n                xx:[],\n                xz:false,\n                xl:false,\n                rs:10\n            })\n             const show= ()=&gt;{\n                hh.show=!hh.show\n             }\n                return {\n                    wz1,\n                msg,\n                hh,\n                show\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>可以看到，v-text与v-html都正常渲染了内容（注意：v-text解析不了html代码）</p>\n<h2>十一、计算属性computed</h2>\n<p>Vue 的计算属性（<code>computed</code>）是 Vue.js 中非常重要的一个概念。它允许你在 Vue 组件中定义一些计算逻辑，这些逻辑会依赖于 Vue 的响应式数据，并且具有缓存机制，只有在依赖数据发生改变时才会重新计算，从而提高性能，举个例子：对于多次相同的add方法，js需要调用多次，而computed只需要一次，因此大大节省了空间。</p>\n<p>	代码示例：</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n  &lt;p&gt;{{add()}}&lt;/p&gt;\n  &lt;p&gt;{{add()}}&lt;/p&gt;\n  &lt;p&gt;{{jf()}}&lt;/p&gt;\n  &lt;p&gt;{{sub}}&lt;/p&gt;\n&lt;input type=&quot;text&quot; v-model.number=&quot;wz1.x&quot;&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive,computed} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n             const wz1=reactive({\n                x:10,\n                y:10\n            })\n             const add= ()=&gt;{\n                console.log(&quot;add&quot;)\n                return wz1.x+wz1.y\n             }\n             const jf= ()=&gt;{\n                console.log(&quot;-&quot;)\n                return wz1.x+wz1.y\n             }\n             const sub = computed(() =&gt; {\n                console.log(&quot;sub&quot;)  \n                return wz1.x + wz1.y\n            })\n                return {\n                    wz1,\n                    add,\n                    jf,\n                    sub\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<h2>十二、侦听器watch</h2>\n<p>对于单独的属性，我们想时刻得到它的变化，可以使用watch来进行监听，这样对于值的每一次变化都能实时记录下来，在执行某些异步逻辑时watch至关重要。</p>\n<p>	代码示例：</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n  &lt;p&gt;{{add()}}&lt;/p&gt;\n  &lt;p&gt;{{add()}}&lt;/p&gt;\n  &lt;p&gt;{{jf()}}&lt;/p&gt;\n  &lt;p&gt;{{sub}}&lt;/p&gt;\n&lt;input type=&quot;text&quot; v-model.number=&quot;wz1.x&quot;&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive,computed,watch} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n             const wz1=reactive({\n                x:10,\n                y:10\n            })\n             const add= ()=&gt;{\n                console.log(&quot;add&quot;)\n                return wz1.x+wz1.y\n             }\n             watch(()=&gt;wz1.x,(newValue,oldValue)=&gt;{\n                console.log(&quot;new&quot;,newValue,&quot;old&quot;,oldValue)\n                console.log(\n                    wz1.x,\n                    wz1.y\n                )\n            })\n             const jf= ()=&gt;{\n                console.log(&quot;-&quot;)\n                return wz1.x+wz1.y\n             }\n             const sub = computed(() =&gt; {\n                console.log(&quot;sub&quot;)  \n                return wz1.x + wz1.y\n            })\n                return {\n                    wz1,\n                    add,\n                    jf,\n                    sub\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>这段代码实现了对wz1.x这个属性进行的监听，并获取到了它的新旧值在控制台中打印。</p>\n<h3>自动侦听器WatchEffects</h3>\n<p>watch只能实现对单个属性的侦听因此又被称为手动监听，如果当我们不知道应该监听何种属性时应该怎么办呢，这种情况watch显然过于乏力，由此我们引入自动监听WatchEffects，它无需指定监听属性，自动监听return所渲染的属性，下面是代码示例：</p>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n  &lt;p&gt;{{add()}}&lt;/p&gt;\n  &lt;p&gt;{{add()}}&lt;/p&gt;\n  &lt;p&gt;{{jf()}}&lt;/p&gt;\n  &lt;p&gt;{{sub}}&lt;/p&gt;\n&lt;input type=&quot;text&quot; v-model.number=&quot;wz1.x&quot;&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive,computed,watchEffect} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n             const wz1=reactive({\n                x:10,\n                y:10\n            })\n             const add= ()=&gt;{\n                console.log(&quot;add&quot;)\n                return wz1.x+wz1.y\n             }\n  watchEffect(() =&gt; {\n    console.log(&quot;监听开始&quot;)\n    if(wz1.x&gt;=10){\n        console.log(&quot;x&gt;10&quot;)\n    }\n    console.log(&quot;监听结束&quot;)\n  })\n             const jf= ()=&gt;{\n                console.log(&quot;-&quot;)\n                return wz1.x+wz1.y\n             }\n             const sub = computed(() =&gt; {\n                console.log(&quot;sub&quot;)  \n                return wz1.x + wz1.y\n            })\n                return {\n                    wz1,\n                    add,\n                    jf,\n                    sub\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>这段代码实现了对属性的自动监听，并在监听到wz1.x值大于10时在控制台打印。</p>\n<h2>十三、微实战案例</h2>\n<h3>轮播图</h3>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n&lt;img :src=`${number}.jpg` alt=&quot;&quot; style=&quot;width: 50%;height: 50%;&quot;@click=&quot;next&quot;&gt;&lt;hr&gt;\n&lt;input type=&quot;button&quot; value=&quot;next&quot; @click=&quot;next&quot;&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive,computed,watchEffect} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n            const number=ref(1)\n             const add= ()=&gt;{\n                console.log(&quot;add&quot;)\n                return wz1.x+wz1.y\n             }\n             const next=()=&gt;{    \n                number.value++\n                if(number.value&gt;=6){\n                    number.value=1\n                }\n            }\n\n                return {\n                    number,\n                    next\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<h3>crud记事本</h3>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n&lt;input type=&quot;text&quot; v-model=&quot;data.df&quot;&gt;\n&lt;button @click=&quot;add&quot;&gt;add&lt;/button&gt;\n&lt;ul&gt;\n    &lt;li v-for=&quot;(item,index) in data.list&quot; :key=&quot;index&quot;&gt;{{item}} \n        &lt;button @click=&quot;del(index)&quot;&gt;delete&lt;/button&gt;\n    &lt;/li&gt;&lt;button @click=&quot;data.list=[]&quot;&gt;clear&lt;/button&gt;&lt;hr&gt;&lt;p&gt;{{data.list.length}}&lt;/p&gt;\n     &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import{createApp,ref,reactive,computed,watchEffect} from &#39;./vue.esm-browser.js&#39;;\n        createApp({\n            setup(){\n            const data=reactive ({\n                df:&#39;abc&#39;,\n                list:[&quot;wwwww&quot;,&quot;bbbbb&quot;]\n            })\n            const add =()=&gt;{\n                data.list.push(data.df)\n                console.log(data.list)\n            }\n            const del=(index)=&gt;{ \n                data.list.splice(index,1)\n                console.log(data.list)\n            }\n                return {\n                data,\n                add,\n                del,\n                length\n            }\n            }         \n        }).mount(&#39;#app&#39;)\n               \n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<h3>购物车</h3>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;meta name=&quot;viewport&quot; content=&quot;width=device-width, initial-scale=1.0&quot;&gt;\n    &lt;title&gt;demo&lt;/title&gt;\n    &lt;style&gt;\n        table {\n            background-color: antiquewhite;\n        }\n    &lt;/style&gt;\n&lt;/head&gt;\n&lt;body&gt;\n    &lt;div id=&quot;app&quot;&gt;\n        &lt;table&gt;\n            &lt;thead&gt;\n                &lt;tr&gt;\n                    &lt;th&gt;&lt;input type=&quot;checkbox&quot; v-model=&quot;sp.xz&quot; @change=&quot;changeAll&quot;&gt;&lt;/th&gt;\n                    &lt;th&gt;商品名称&lt;/th&gt;\n                    &lt;th&gt;价格&lt;/th&gt;\n                    &lt;th&gt;库存&lt;/th&gt;\n                    &lt;th&gt;操作&lt;/th&gt;\n                &lt;/tr&gt;\n            &lt;/thead&gt;\n            &lt;tbody&gt;\n                &lt;tr v-for=&quot;(value, index) in sp.list&quot; :key=&quot;value.id&quot;&gt;\n                    &lt;td&gt;&lt;input type=&quot;checkbox&quot; v-model=&quot;sp.xzlist&quot; :value=&quot;value&quot; @change=&quot;jc&quot;&gt;&lt;/td&gt;\n                    &lt;td&gt;{{ value.name }}&lt;/td&gt;\n                    &lt;td&gt;{{ value.price }}&lt;/td&gt;\n                    &lt;td&gt;{{ value.stock }}&lt;/td&gt;\n                    &lt;td&gt;\n                        &lt;button @click=&quot;sub(value)&quot;&gt;-&lt;/button&gt;\n                        {{ value.number }}\n                        &lt;button @click=&quot;add(value)&quot;&gt;+&lt;/button&gt;\n                    &lt;/td&gt;\n                    &lt;td&gt;&lt;button @click=&quot;del(index,value.id)&quot;&gt;删除&lt;/button&gt;&lt;/td&gt;\n                &lt;/tr&gt;\n            &lt;/tbody&gt;\n            &lt;tfoot&gt;\n                &lt;tr&gt;\n                    &lt;td&gt;总计&lt;/td&gt;\n                    &lt;td&gt;{{ zj() }}&lt;/td&gt;\n                &lt;/tr&gt;\n            &lt;/tfoot&gt;\n        &lt;/table&gt;\n    &lt;/div&gt;\n    &lt;script type=&quot;module&quot;&gt;\n        import { createApp, reactive } from &#39;./vue.esm-browser.js&#39;;\n        \n        createApp({\n            setup() {\n                const sp = reactive({\n                    xz: false,\n                    xzlist: [],\n                    list: [\n                        { id: 1, name: &#39;苹果&#39;, price: 10, number: 1 ,stock:10},\n                        { id: 2, name: &#39;大香蕉&#39;, price: 15, number: 1 ,stock:10},\n                        { id: 3, name: &#39;西瓜&#39;, price: 12, number: 1, stock:10 },\n                        { id: 4, name: &#39;草莓&#39;, price: 13, number: 1 , stock:10 },\n                        { id: 5, name: &#39;葡萄&#39;, price: 11, number: 1 ,stock:10 }\n                    ]\n                });\n\n                const changeAll = () =&gt; {\n                    console.log(sp.xz);\n                    if (sp.xz) {\n                        sp.xzlist = sp.list\n                    } else {\n                        sp.xzlist = [];\n                    }\n                    console.log(sp.xzlist);\n                }\n                const jc = () =&gt; {\n                    if(sp.xzlist.length == sp.list.length&amp;&amp;sp.list!=0){\n                       sp.xz=true\n                    }else{\n                      sp.xz=false\n                    }\n                }\n               //总价计算，可以换成computed\nconst zj =()=&gt;{\n  let sum=0\n for(let i=0;i&lt;sp.xzlist.length;i++){\n   sum+=sp.xzlist[i].number * sp.xzlist[i].price\n }\n return sum\n}\n//减少事件\nconst sub=(value)=&gt;{\n  value.number--\n  if(value.number&lt;=-1){\n    value.number=0\n    alert(&#39;商品数量不能小于0&#39;)\n  }\n}\n//增加事件\nconst add=(value)=&gt;{\n  value.number++\n  if(value.number&gt;=value.stock){\n    value.number=value.stock\n\n  }\n}\nconst del = (index, id) =&gt; {\n  sp.list.splice(index, 1);\n\n  let newArr = sp.xzlist.filter((value, index) =&gt; {\n    return value.id !== id;\n  });\n  sp.xzlist = newArr;\n  // 更新全选状态\n  if (sp.list.length === 0) {\n    sp.xz = false; // 如果列表为空，则将全选状态置为false\n  } else {\n    let isSelectedAll = true;\n    for (let item of sp.list) {\n      if (!sp.xzlist.includes(item)) {\n        isSelectedAll = false;\n        break;\n      }\n    }\n    sp.xz = isSelectedAll;\n  }\n}\n\n                return {\n                    sp,\n                    changeAll,\n                    jc,\n                    zj,\n                    sub,\n                    add,\n                    del\n                }\n            }\n        }).mount(&#39;#app&#39;);\n    &lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n\n</code></pre>\n<p>这段购物车代码采用基本绑定实现，通过使用watch侦听与computed可以实现再次优化：侦听选中状态与总价的计算。</p>\n<h2>十四、基于vite构建项目并改造成基础模板</h2>\n<p>对于创建vue3项目，我们还可以使用vite来构建</p>\n<p>首先打开需要创建项目的目录，执行以下代码（确保安装node.js环境）</p>\n<pre><code class=\'language-cmd\' lang=\'cmd\'>npm create vue@latest\n</code></pre>\n<p>执行完后命令行会出现三行命令，即cd、install，run dev，复制这些命令并执行。</p>\n<p>执行完后会自动跳转到vue项目的基本模板界面，确保无误后ctrl+c选择y关闭项目</p>\n<h3>改造为无内容可以直接编辑的模板</h3>\n<h4>app.vue</h4>\n<pre><code class=\'language-html\' lang=\'html\'>&lt;script setup&gt;\n//导入后续的组件\n&lt;/script&gt;\n&lt;template&gt;\n  &lt;div id=&quot;app&quot;&gt;\n&lt;h1&gt;app&lt;/h1&gt;&lt;/div&gt;\n&lt;/template&gt;\n</code></pre>\n<h4>main.js</h4>\n<pre><code class=\'language-javascript\' lang=\'javascript\'>import { createApp } from &#39;vue&#39;\nimport App from &#39;./App.vue&#39;\nconst app = createApp(App)\napp.mount(&#39;#app&#39;)\n</code></pre>\n<p>当然，实际的开发往往需要不会将内容全部放到一个app.vue里，那样代码太过冗长可读性较差并且不利于维护。</p>\n<p>在创建完项目之后，可以看到很多个.vue文件，但它们并未一一打开，却能在基本项目转直接看到它们的内容，不妨想想，这是如何实现的呢？</p>\n<h2>十五、组件化</h2>\n<p>内容先欠着</p>\n<h2>十六、常见错误</h2>\n<p>内容先欠着</p>\n</body>\n</html>', 'vue3入门笔记', '本文简单概述了vue3的基本语法，并结合案例进行快速上手', '2024-11-29 21:11:54', '/image/PixPin_2024-06-18_08-48-48.jpg', NULL, 1, 2),
	(2, '本文将介绍Vue.js框架的核心概念和使用技巧...', '深入了解Vue.js', 'Vue.js', NULL, NULL, NULL, 1, NULL),
	(3, '本文介绍了机器学习的基本概念以及如何使用TensorFlow...', '机器学习入门', '', NULL, NULL, NULL, 2, NULL),
	(4, '<h1>如何使用Vue.js开发高效的前端应用</h1><p>本文将介绍如何使用Vue.js来构建现代的前端应用，涵盖基本的架构、状态管理、组件化设计等内容。</p>', '如何使用Vue.js开发高效的前端应用', 'Vue.js是当前流行的前端框架，本文介绍如何高效使用它进行开发。', '2024-12-30 10:00:00', 'https://example.com/images/vuejs.jpg', '张三', 1, 3),
	(6, '<h1>如何使用Vue.js开发高效的前端应用</h1><p>本文将介绍如何使用Vue.js来构建现代的前端应用，涵盖基本的架构、状态管理、组件化设计等内容。</p>', '如何使用Vue.js开发高效的前端应用', 'Vue.js是当前流行的前端框架，本文介绍如何高效使用它进行开发。', '2024-12-30 10:00:00', 'https://example.com/images/vuejs.jpg', '张三', 1, 3),
	(7, '<h1>如何使用Vue.js开发高效的前端应用</h1><p>本文将介绍如何使用Vue.js来构建现代的前端应用，涵盖基本的架构、状态管理、组件化设计等内容。</p>', '如何使用Vue.js开发高效的前端应用', 'Vue.js是当前流行的前端框架，本文介绍如何高效使用它进行开发。', '2024-12-30 10:00:00', 'https://example.com/images/vuejs.jpg', '张三', 1, 3);

-- 导出  表 blog.post_star 结构
DROP TABLE IF EXISTS `post_star`;
CREATE TABLE IF NOT EXISTS `post_star` (
  `user_id` int DEFAULT NULL COMMENT '用户id',
  `post_id` int DEFAULT NULL COMMENT '文章id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  blog.post_star 的数据：~0 rows (大约)
DELETE FROM `post_star`;

-- 导出  表 blog.post_tags 结构
DROP TABLE IF EXISTS `post_tags`;
CREATE TABLE IF NOT EXISTS `post_tags` (
  `post_id` int NOT NULL COMMENT '文章ID，关联 posts 表',
  `tag_id` int NOT NULL COMMENT '标签ID，关联 tags 表',
  PRIMARY KEY (`post_id`,`tag_id`),
  KEY `tag_id` (`tag_id`),
  CONSTRAINT `post_tags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`post_id`) ON DELETE CASCADE,
  CONSTRAINT `post_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  blog.post_tags 的数据：~0 rows (大约)
DELETE FROM `post_tags`;

-- 导出  表 blog.roles 结构
DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(50) NOT NULL COMMENT '角色名称，例如 User, Blogger, Admin',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  blog.roles 的数据：~3 rows (大约)
DELETE FROM `roles`;
INSERT INTO `roles` (`role_id`, `role_name`) VALUES
	(1, 'User'),
	(2, 'Blogger'),
	(3, 'admin');

-- 导出  表 blog.tags 结构
DROP TABLE IF EXISTS `tags`;
CREATE TABLE IF NOT EXISTS `tags` (
  `tag_id` int NOT NULL AUTO_INCREMENT COMMENT '标签ID，自增主键',
  `tag_name` varchar(50) NOT NULL COMMENT '标签名称',
  `description` text COMMENT '标签描述',
  PRIMARY KEY (`tag_id`),
  UNIQUE KEY `unique_tag_name` (`tag_name`) COMMENT '确保标签名称唯一'
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章标签表';

-- 正在导出表  blog.tags 的数据：~24 rows (大约)
DELETE FROM `tags`;
INSERT INTO `tags` (`tag_id`, `tag_name`, `description`) VALUES
	(1, 'Vue.js', 'Web开发框架'),
	(2, 'React', 'Web开发框架'),
	(3, 'Node.js', 'Web后端框架'),
	(4, 'Flutter', '跨平台移动端开发框架'),
	(5, 'React Native', '跨平台移动端开发框架'),
	(6, 'Swift', 'iOS开发语言'),
	(7, 'Service Workers', 'Progressive Web Apps 核心技术之一'),
	(8, 'Web App Manifest', '定义PWA安装信息的文件'),
	(9, 'Caching Strategies', 'PWA中常用的缓存策略'),
	(10, 'TensorFlow', '机器学习框架'),
	(11, 'PyTorch', '机器学习框架'),
	(12, 'Scikit-Learn', '机器学习库'),
	(13, 'AWS', '亚马逊云服务'),
	(14, 'Azure', '微软云服务'),
	(15, 'Google Cloud', '谷歌云服务'),
	(16, 'Ethereum', '区块链平台'),
	(17, 'Solana', '高性能区块链'),
	(18, 'Bitcoin', '区块链的鼻祖'),
	(19, 'Sorting', '数据结构与算法 - 排序算法'),
	(20, 'Graph Theory', '数据结构与算法 - 图论'),
	(21, 'Dynamic Programming', '数据结构与算法 - 动态规划'),
	(22, 'SQL', '数据分析中的查询语言'),
	(23, 'Python', '数据分析编程语言'),
	(24, 'R', '数据分析和统计编程语言');

-- 导出  表 blog.user 结构
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '自增主键',
  `username` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户名',
  `password` varchar(20) DEFAULT NULL COMMENT '密码',
  `role_id` int DEFAULT '1' COMMENT '用户角色',
  `full_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '用户自定名称，没有时默认为用户名',
  `email` varchar(50) DEFAULT NULL COMMENT '用户邮箱',
  `register_time` datetime DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `constraint_name` (`full_name`),
  KEY `索引 2` (`full_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- 正在导出表  blog.user 的数据：~9 rows (大约)
DELETE FROM `user`;
INSERT INTO `user` (`user_id`, `username`, `password`, `role_id`, `full_name`, `email`, `register_time`) VALUES
	(1, 'ylab27699858', '227685', 3, 'ylab', '', NULL),
	(2, '3333', NULL, 2, NULL, NULL, NULL),
	(3, 'user', '123456', 1, '张三', '123456@test.com', NULL),
	(4, 'ylab', '123456', 3, NULL, NULL, NULL),
	(5, '114514', '123456', 1, NULL, NULL, NULL),
	(6, 'test', '123456', NULL, '', NULL, NULL),
	(7, 'test2', '123456', NULL, NULL, NULL, NULL),
	(8, 'fhy', '123456', NULL, NULL, NULL, NULL),
	(9, '123456', '123456', NULL, '123456079', NULL, '2024-12-29 22:30:39');

-- 导出  触发器 blog.before_user_insert 结构
DROP TRIGGER IF EXISTS `before_user_insert`;
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `before_user_insert` BEFORE INSERT ON `user` FOR EACH ROW BEGIN
    -- 检查用户名是否为空
    IF NEW.username IS NULL OR NEW.username = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '用户名不能为空';
    END IF;

    -- 如果用户未设置 full_name，则默认使用 username + 三位随机数
    IF NEW.full_name IS NULL OR NEW.full_name = '' THEN
        SET NEW.full_name = CONCAT(NEW.username, LPAD(FLOOR(RAND() * 1000), 3, '0'));
    END IF;

    -- 自动设置注册时间为当前时间
    SET NEW.register_time = NOW();
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
