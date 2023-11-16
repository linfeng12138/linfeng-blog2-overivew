# 林风博客2.0 数据库设计

> 注意：由于为个人博客项目，所以没有建权，在后台管理系统中只有一个超级管理员权限
>
> 项目比较简单，所以也没有用rbac，只是普通的个人博客

```
|字段名|字段类型|约束|说明|备注|
```



# 用户相关

## 用户表

blog_user

| 字段名        | 字段类型     | 约束       | 说明         | 备注                  |
| ------------- | ------------ | ---------- | ------------ | --------------------- |
| user_id       | int          | 主键、自增 | 用户id       | 主键自增              |
| user_name     | varchar(20)  | 非空       | 用户名       | --                    |
| user_password | varchar(100) | 非空       | 登录密码     | --                    |
| user_email    | varchar(40)  | 非空       | 邮箱         | --                    |
| login_ip      | varchar(15)  | --         | 最后登录ip   | --                    |
| login_time    | datetime     | --         | 最后登录时间 | --                    |
| status        | boolean      | --         | 账户状态     | 默认true正常false禁用 |
| create_time   | datetime     | --         | 创建时间     | 默认值为now()         |
| update_time   | datetime     | --         | 更新时间     | 默认值为now()         |
| remark        | varchar(100) | --         | 备注         | 预留字段，暂无用      |

### sql语句

```sql
create table blog_user(
    user_id int primary key auto_increment comment '用户id',
    user_name varchar(20) not null comment '用户名',
    user_password varchar(100) not null comment '登录密码',
    user_email varchar(40) not null comment '邮箱',
    login_ip varchar(15) comment '最后登录的ip',
    login_time datetime comment '最后登录时间',
    status boolean default true comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '用户表';
```



## ~~token、验证码、人机验证码~~

~~使用redis存储~~

- key：string
- value：hash
  - userId：token

大概长这个样子：

```json
# token
"token": {
	userId: "userToken"
}
# 验证码
"authCode": {
    ip: "authCode"
}
# 人机验证码
"code": {
    ip: "code"
}
```

> 考虑到服务器应该没多少人访问，且只有一台服务器，服务器内存又比较小，所以不打算使用redis了





## token

blog_token

| 字段名       | 字段类型    | 约束       | 说明          | 备注                  |
| ------------ | ----------- | ---------- | ------------- | --------------------- |
| token_id     | int         | 主键、自增 | token id      | 主键自增              |
| token_key    | varchar(36) | 非空       | token主要内容 | --                    |
| token_expire | datetime    | 非空       | token过期时间 | create_time+过期时间  |
| status       | boolean     | --         | 账户状态      | 默认true正常false禁用 |
| create_time  | datetime    | --         | 创建时间      | 默认值为now()         |

> 验证后删除不保留
>
> 过期时间自定义

```sql
create table blog_token
(
    token_id     int primary key auto_increment comment 'token id',
    token_key    varchar(36) not null comment 'token主要内容',
    token_expire datetime    not null comment 'token过期时间',
    status       boolean  default true comment '状态',
    create_time  datetime default now() comment '创建时间'
) comment 'token表';
```



## 验证码

blog_auth_code

| 字段名           | 字段类型 | 约束       | 说明           | 备注                  |
| ---------------- | -------- | ---------- | -------------- | --------------------- |
| auth_code_id     | int      | 主键、自增 | 验证码id       | 主键自增              |
| auth_code_key    | int      | 非空       | 验证码内容     | 六位随机数            |
| auth_code_expire | datetime | 非空       | 验证码过期时间 | create_time+过期时间  |
| status           | boolean  | --         | 状态           | 默认true正常false禁用 |
| create_time      | datetime | --         | 创建时间       | 默认值为now()         |

> 后端也限定发送验证码时间
>
> 根据ip限制，且前端也进行限制

```sql
create table blog_auth_code
(
    auth_code_id     int primary key auto_increment comment '验证码id',
    auth_code_key    int      not null comment '验证码内容',
    auth_code_expire datetime not null comment '验证码过期时间',
    status           boolean  default true comment '状态',
    create_time      datetime default now() comment '创建时间'
) comment '验证码表';
```





# 文章相关

## 文章表

blog_article

| 字段名       | 字段类型     | 约束       | 说明      | 备注                  |
| ------------ | ------------ | ---------- | --------- | --------------------- |
| art_id       | int          | 主键、自增 | 文章id    | 主键自增              |
| art_title    | varchar(30)  | 非空       | 文章title | --                    |
| art_subhead  | varchar(50)  | --         | 副标题    | --                    |
| art_author   | varchar(20)  | --         | 文章作者  | --                    |
| art_content  | longtext     | --         | 文章内容  | --                    |
| art_show     | int          | --         | 查看次数  | 默认为0               |
| art_text_num | int          | --         | 文章字数  | --                    |
| art_weight   | int          | --         | 文章权重  | 默认为0               |
| art_tags     | varchar(30)  | --         | 文章分类  | 多个tag以`,`分隔      |
| status       | boolean      | --         | 文章状态  | 默认true正常false禁用 |
| create_time  | datetime     | --         | 创建时间  | 默认值为now()         |
| update_time  | datetime     | --         | 更新时间  | 默认值为now()         |
| remark       | varchar(100) | --         | 备注      | 预留字段，暂无用      |

### sql语句

```sql
create table blog_article(
    art_id int primary key auto_increment comment '文章id',
    art_title varchar(30) not null comment '文章title',
    art_subhead varchar(50) comment '副标题',
    art_author varchar(20) comment '文章作者',
    art_content longtext comment '文章内容',
    art_show int default 0 comment '查看次数',
    art_text_num int comment '文章字数',
    art_weight int default 0 comment '文章权限',
    art_tags varchar(30) comment '文章分类 多个tag以，分隔',
    status boolean default true comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '文章表';
```





## 分类表

blog_tag

| 字段名        | 字段类型     | 约束       | 说明     | 备注                  |
| ------------- | ------------ | ---------- | -------- | --------------------- |
| tag_id        | int          | 主键、自增 | 分类id   | 主键自增              |
| tag_name      | varchar(10)  | 非空       | 分类名称 | --                    |
| tag_parent_id | int          | --         | 父分类   | 默认值为0(顶级)       |
| status        | boolean      | --         | 状态     | 默认true正常false禁用 |
| create_time   | datetime     | --         | 创建时间 | 默认值为now()         |
| update_time   | datetime     | --         | 更新时间 | 默认值为now()         |
| remark        | varchar(100) | --         | 备注     | 预留字段，暂无用      |

### sql语句

```sql
create table blog_tag(
    tag_id int primary key auto_increment comment '分类id',
    tag_name varchar(10) not null comment '分类名称',
    tag_parent_id int default 0 comment '父分类',
    status boolean default true comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '分类表';
```





## 日记表

blog_diary

| 字段名       | 字段类型     | 约束       | 说明     | 备注                  |
| ------------ | ------------ | ---------- | -------- | --------------------- |
| dia_id       | int          | 主键、自增 | 主键     | 主键自增              |
| dia_content  | varchar(400) | 非空       | 日记内容 | --                    |
| dia_show     | int          | --         | 查看次数 | 默认为0               |
| dia_text_num | int          | --         | 日记字数 | --                    |
| status       | boolean      | --         | 状态     | 默认true正常false禁用 |
| create_time  | datetime     | --         | 创建时间 | 默认值为now()         |
| update_time  | datetime     | --         | 更新时间 | 默认值为now()         |
| remark       | varchar(100) | --         | 备注     | 预留字段，暂无用      |

### sql语句

```sql
create table blog_diary(
    dia_id int primary key auto_increment comment '日记id',
    dia_content varchar(400) not null comment '日记内容',
    dia_show int default 0 comment '查看次数',
    dia_text_num int comment '日记字数',
    status boolean default true comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '日记表';
```



# 其它表

## 友情链接表

blog_link

| 字段名       | 字段类型     | 约束       | 说明        | 备注                  |
| ------------ | ------------ | ---------- | ----------- | --------------------- |
| link_id      | int          | 主键、自增 | 主键        | 主键自增              |
| link_title   | varchar(20)  | --         | 连接标题    | --                    |
| link_subhead | varchar(40)  | --         | 副标题      | --                    |
| link_img     | varchar(100) | --         | 连接图片url | 默认值为自己的title   |
| link_url     | varchar(40)  | 非空       | 链接地址    | --                    |
| status       | boolean      | --         | 状态        | 默认false禁用true正常 |
| create_time  | datetime     | --         | 创建时间    | 默认值为now()         |
| update_time  | datetime     | --         | 更新时间    | 默认值为now()         |
| remark       | varchar(100) | --         | 备注        | 预留字段，暂无用      |

### sql语句

```sql
create table blog_link(
    link_id int primary key auto_increment comment '友情链接主键',
    link_title varchar(20) comment '链接标题',
    link_subhead varchar(40) comment '副标题',
    link_img varchar(100) comment '链接图片url，插入时请设置默认值',
    link_url varchar(40) not null comment '链接地址，插入时请先判断长度',
    status boolean default false comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '友情链接表';
```



## 留言板表

blog_message

| 字段名        | 字段类型    | 约束       | 说明     | 备注                  |
| ------------- | ----------- | ---------- | -------- | --------------------- |
| msg_id        | int         | 主键、自增 | 主键     | 主键自增              |
| msg_name      | varchar(20) | --         | 留言者   | --                    |
| msg_content   | varchar(66) | 非空       | 留言内容 | 默认值为''            |
| msg_parent_id | int         | --         | 父留言板 | 默认值为0             |
| status        | boolean     | --         | 状态     | 默认true正常false禁用 |
| create_time   | datetime    | --         | 创建时间 | 默认值为now()         |
| update_time   | datetime    | --         | 更新时间 | 默认值为now()         |
|               |             |            |          |                       |

### sql语句

```sql
create table blog_message
(
    msg_id        int primary key auto_increment comment '留言板id',
    msg_name      varchar(20) comment '留言者',
    msg_content   varchar(66) not null default '' comment '留言内容',
    msg_parent_id int                   default 0 comment '父留言板',
    status        boolean               default true comment '状态',
    create_time   datetime              default now() comment '创建时间',
    update_time   datetime              default now() comment '更新时间'
) comment '留言板表';
```



## 关于我表

blog_me

| 字段名      | 字段类型     | 约束       | 说明         | 备注                  |
| ----------- | ------------ | ---------- | ------------ | --------------------- |
| me_id       | int          | 主键、自增 | 主键         | 主键自增              |
| me_content  | varchar(200) | --         | 关于我的内容 | --                    |
| status      | boolean      | --         | 状态         | 默认true正常false禁用 |
| create_time | datetime     | --         | 创建时间     | 默认值为now()         |
| update_time | datetime     | --         | 更新时间     | 默认值为now()         |
| remark      | varchar(100) | --         | 备注         | 预留字段，暂无用      |

### sql语句

```sql
create table blog_me(
    me_id int primary key primary key comment '关于我id',
    me_content varchar(200) comment '关于我的内容',
    status boolean default true comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '关于我表';
```



# 系统表

## ~~客户端请求表~~(取消该表)

~~blog_request~~

| 字段名      | 字段类型     | 约束       | 说明     | 备注                  |
| ----------- | ------------ | ---------- | -------- | --------------------- |
| req_id      | int          | 主键、自增 | 主键     | 主键自增              |
| req_ip      | varchar(15)  | --         | 请求ip   | --                    |
| req_num     | int          | --         | 请求次数 | --                    |
| status      | boolean      | --         | 状态     | 默认true正常false禁用 |
| create_time | datetime     | --         | 创建时间 | 默认值为now()         |
| update_time | datetime     | --         | 更新时间 | 默认值为now()         |
| remark      | varchar(100) | --         | 备注     | 预留字段，暂无用      |

> 通过redis来限制请求频率和次数





## 日志表

blog_log

| 字段名          | 字段类型     | 约束       | 说明         | 备注                      |
| --------------- | ------------ | ---------- | ------------ | ------------------------- |
| log_id          | int          | 主键、自增 | 主键         | 主键自增                  |
| log_title       | varchar(4)   | --         | 日志title    | --                        |
| log_type        | varchar(4)   | --         | 操作类型     | --                        |
| log_ajax        | varchar(7)   | --         | 请求方式     | --                        |
| log_ip          | varchar(15)  | --         | 请求ip       | --                        |
| ~~status~~      | ~~boolean~~  | --         | ~~状态~~     | ~~默认true正常false禁用~~ |
| create_time     | datetime     | --         | 创建时间     | 默认值为now()             |
| ~~update_time~~ | ~~datetime~~ | --         | ~~更新时间~~ | ~~默认值为now()~~         |
|                 |              |            |              |                           |

### sql语句

```sql
create table blog_log(
    log_id int primary key auto_increment comment '日志主键',
    log_title varchar(4) comment '日志title',
    log_type varchar(4) comment '操作类型',
    log_ajax varchar(7) comment '请求方式',
    log_ip varchar(15) comment '请求ip',
    create_time datetime default now() comment '创建时间'
) comment '日志表';
```



## IP限制表

blog_ip

| 字段名            | 字段类型    | 约束       | 说明         | 备注                                  |
| ----------------- | ----------- | ---------- | ------------ | ------------------------------------- |
| ip_id             | int         | 主键、自增 | 主键         | 主键自增                              |
| ip_info           | varchar(15) | 非空       | ip地址       | --                                    |
| ip_expire         | datetime    | --         | 封禁过期时间 | create_time+过期时间<br />默认为now() |
| ip_frequency      | int         | --         | 请求频率     | 默认为1                               |
| ip_frequency_time | datetime    | 非空       | 快速失败时间 | 使用程序插入now()+1                   |
| status            | boolean     | --         | 账户状态     | 默认true正常false禁用                 |
| create_time       | datetime    | --         | 创建时间     | 默认值为now()                         |

> 每次发送请求都会触发，判断每秒请求次数是否过多，超过指定次数不允许访问或返回指定页面。然后请求频率+1，超过一秒重置为1
>
> 首先判断是否有记录ip，若没有则可以正常使用，并插入当前时间或当前时间-1
>
> 然后判断status，若为false则表示ip被永久封禁
>
> 若为true，则根据时间来判断是否允许使用
>
> 若允许则删除这条记录

```sql
create table blog_ip
(
    ip_id             int primary key auto_increment comment '主键',
    ip_info           varchar(15) not null comment 'IP地址',
    ip_expire         datetime default now() comment '封禁过期时间',
    ip_frequency      int      default 1 comment '请求频率',
    ip_frequency_time datetime    not null comment '快速失败时间',
    status            boolean  default true comment '状态',
    create_time       datetime default now() comment '创建时间'
) comment 'IP限制表';
```



## 测试表

blog_demo

```sql
create table blog_demo(
    demo_id int primary key auto_increment comment '主键',
    demo_content varchar(40) comment '文本信息',
    create_time datetime default now() comment '创建时间'
) comment '测试表';
insert into blog_demo values (default, '林风提示：如果你看到了这条消息，就说明你已经成功了', default);
```

该表仅用于测试服务器是否成功启动

