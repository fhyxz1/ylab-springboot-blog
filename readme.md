# springboot-blog-ylab   博客后端服务

## TODO

### 前台接口

文章接口：获取文章与分类，并根据文章d渲染对应的文章页面

消息中心接口：简单实现公告与点赞收藏等的通知/消息的查询与插入

个人中心接口：对个人用户数据的修改，例如签名、头像、邮箱等/alter

留言板接口：存取用户的留言板信息存储到留言信息总表，并展示近期30条留言

收藏接口：根据用户id获取收藏的文章内容

文章导入接口：支持markdown的导入解析与存取，主要集成marked等库实现

### 后台接口

用户的增删查改接口：对用户信息进行增删查改

文章的增删查改接口：集成wangeditor实现文章的编写与存取

评论与的增删查改接口：对评论进行增删查改，增加置顶等功能（待定）

公告与对应用户的通知接口：（待定）

留言板接口：管理用户的留言，去重等等（待定）

权限管理接口（待定）

日志管理接口：用户的操作日志（待定，视后期架构而定）

用户分析接口：返回浏览量、分类标签频率趋势、用户量等集成data-v与echarts进行词云等统计图绘制