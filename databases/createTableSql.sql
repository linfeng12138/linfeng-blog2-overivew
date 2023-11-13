show databases;
create database linfeng_blog2;
use linfeng_blog2;
create table blog_user(
    user_id int primary key not null auto_increment comment '用户id',
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

create table article(
    art_id int primary key not null auto_increment comment '文章id',
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

create table tag(
    tag_id int primary key not null auto_increment comment '分类id',
    tag_name varchar(10) not null comment '分类名称',
    tag_parent_id int default 0 comment '父分类',
    status boolean default true comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '分类表';

create table diary(
    dia_id int primary key not null auto_increment comment '日记id',
    dia_content varchar(400) not null comment '日记内容',
    dia_show int default 0 comment '查看次数',
    dia_text_num int comment '日记字数',
    status boolean default true comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '日记表';

create table link(
    link_id int primary key not null auto_increment comment '友情链接主键',
    link_title varchar(20) comment '链接标题',
    link_subhead varchar(40) comment '副标题',
    link_img varchar(100) comment '链接图片url，插入时请设置默认值',
    link_url varchar(40) not null comment '链接地址，插入时请先判断长度',
    status boolean default false comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '友情链接表';

create table message(
    msg_id int primary key not null auto_increment comment '留言板id',
    msg_name varchar(20) comment '留言者',
    msg_content varchar(200) not null default '' comment '留言内容',
    msg_parent_id int default 0 comment '父留言板',
    status boolean default true comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '留言板表';

create table me(
    me_id int primary key not null primary key comment '关于我id',
    me_content varchar(200) comment '关于我的内容',
    status boolean default true comment '状态',
    create_time datetime default now() comment '创建时间',
    update_time datetime default now() comment '更新时间',
    remark varchar(100) comment '备注，预留字段'
) comment '关于我表';

create table log(
    log_id int primary key not null auto_increment comment '日志主键',
    log_title varchar(4) comment '日志title',
    log_type varchar(4) comment '操作类型',
    log_ajax varchar(7) comment '请求方式',
    log_ip varchar(15) comment '请求ip',
    create_time datetime default now() comment '创建时间',
    remark varchar(100) comment '备注'
) comment '日志表';

show tables;
