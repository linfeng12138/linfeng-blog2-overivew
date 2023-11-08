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

| 字段名        | 字段类型     | 约束             | 说明         | 备注                  |
| ------------- | ------------ | ---------------- | ------------ | --------------------- |
| user_id       | int          | 主键、非空、自增 | 用户id       | 主键自增              |
| user_name     | varchar(20)  | 非空             | 用户名       | --                    |
| user_password | varchar(100) | 非空             | 登录密码     | --                    |
| user_email    | varchar(40)  | 非空             | 邮箱         | --                    |
| login_ip      | varchar(15)  | --               | 最后登录ip   | --                    |
| login_time    | datetime     | --               | 最后登录时间 | --                    |
| status        | boolean      | --               | 账户状态     | 默认true正常false禁用 |
| create_time   | datetime     | --               | 创建时间     | 默认值为now()         |
| update_time   | datetime     | --               | 更新时间     | 默认值为now()         |
| remark        | varchar(100) | --               | 备注         | 预留字段，暂无用      |



## token、验证码、人机验证码

使用redis存储

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



# 文章相关

## 文章表

article

| 字段名       | 字段类型     | 约束             | 说明      | 备注                  |
| ------------ | ------------ | ---------------- | --------- | --------------------- |
| art_id       | int          | 主键、非空、自增 | 文章id    | 主键自增              |
| art_title    | varchar(30)  | 非空             | 文章title | --                    |
| art_subhead  | varchar(50)  | --               | 副标题    | --                    |
| art_author   | varchar(20)  | --               | 文章作者  | --                    |
| art_content  | longtext     | --               | 文章内容  | --                    |
| art_show     | int          | --               | 查看次数  | 默认为0               |
| art_text_num | int          | --               | 文章字数  | --                    |
| art_weight   | int          | --               | 文章权重  | 默认为0               |
| art_tags     | varchar(30)  | --               | 文章分类  | 多个tag以`,`分隔      |
| status       | boolean      | --               | 文章状态  | 默认true正常false禁用 |
| create_time  | datetime     | --               | 创建时间  | 默认值为now()         |
| update_time  | datetime     | --               | 更新时间  | 默认值为now()         |
| remark       | varchar(100) | --               | 备注      | 预留字段，暂无用      |



## 分类表

tag

| 字段名        | 字段类型     | 约束             | 说明     | 备注                  |
| ------------- | ------------ | ---------------- | -------- | --------------------- |
| tag_id        | int          | 主键、非空、自增 | 分类id   | 主键自增              |
| tag_name      | varchar(10)  | 非空             | 分类名称 | --                    |
| tag_parent_id | int          | --               | 父分类   | 默认值为0(顶级)       |
| status        | boolean      | --               | 状态     | 默认true正常false禁用 |
| create_time   | datetime     | --               | 创建时间 | 默认值为now()         |
| update_time   | datetime     | --               | 更新时间 | 默认值为now()         |
| remark        | varchar(100) | --               | 备注     | 预留字段，暂无用      |





## 日记表

diary

| 字段名       | 字段类型     | 约束             | 说明     | 备注                  |
| ------------ | ------------ | ---------------- | -------- | --------------------- |
| dia_id       | int          | 主键、非空、自增 | 主键     | 主键自增              |
| dia_content  | varchar(400) | 非空             | 日记内容 | --                    |
| dia_show     | int          | --               | 查看次数 | 默认为0               |
| dia_text_num | int          | --               | 日记字数 | --                    |
| status       | boolean      | --               | 状态     | 默认true正常false禁用 |
| create_time  | datetime     | --               | 创建时间 | 默认值为now()         |
| update_time  | datetime     | --               | 更新时间 | 默认值为now()         |
| remark       | varchar(100) | --               | 备注     | 预留字段，暂无用      |



# 其它表

## 友情链接表

link

| 字段名       | 字段类型     | 约束             | 说明        | 备注                  |
| ------------ | ------------ | ---------------- | ----------- | --------------------- |
| link_id      | int          | 主键、非空、自增 | 主键        | 主键自增              |
| link_title   | varchar(20)  | --               | 连接标题    | 默认值为null          |
| link_subhead | varchar(40)  | --               | 副标题      | 默认值为null          |
| link_img     | varchar(100) | --               | 连接图片url | 默认值为自己的title   |
| status       | boolean      | --               | 状态        | 默认false禁用true正常 |
| create_time  | datetime     | --               | 创建时间    | 默认值为now()         |
| update_time  | datetime     | --               | 更新时间    | 默认值为now()         |
| remark       | varchar(100) | --               | 备注        | 预留字段，暂无用      |





## 留言板表

message

| 字段名        | 字段类型     | 约束             | 说明     | 备注                  |
| ------------- | ------------ | ---------------- | -------- | --------------------- |
| msg_id        | int          | 主键、非空、自增 | 主键     | 主键自增              |
| msg_name      | varchar(20)  | --               | 留言者   | --                    |
| msg_content   | varchar(200) | 非空             | 留言内容 | 默认值为''            |
| msg_parent_id | int          | --               | 父留言板 | 默认值为0             |
| status        | boolean      | --               | 状态     | 默认true正常false禁用 |
| create_time   | datetime     | --               | 创建时间 | 默认值为now()         |
| update_time   | datetime     | --               | 更新时间 | 默认值为now()         |
| remark        | varchar(100) | --               | 备注     | 预留字段，暂无用      |





## 关于我表

me

| 字段名      | 字段类型     | 约束             | 说明         | 备注                  |
| ----------- | ------------ | ---------------- | ------------ | --------------------- |
| me_id       | int          | 主键、非空、自增 | 主键         | 主键自增              |
| me_content  | varchar(200) | --               | 关于我的内容 | --                    |
| status      | boolean      | --               | 状态         | 默认true正常false禁用 |
| create_time | datetime     | --               | 创建时间     | 默认值为now()         |
| update_time | datetime     | --               | 更新时间     | 默认值为now()         |
| remark      | varchar(100) | --               | 备注         | 预留字段，暂无用      |





# 系统表

## 客户端请求表

request

| 字段名      | 字段类型     | 约束             | 说明     | 备注                  |
| ----------- | ------------ | ---------------- | -------- | --------------------- |
| req_id      | int          | 主键、非空、自增 | 主键     | 主键自增              |
| req_ip      | varchar(15)  | --               | 请求ip   | --                    |
| req_num     | int          | --               | 请求次数 | --                    |
| status      | boolean      | --               | 状态     | 默认true正常false禁用 |
| create_time | datetime     | --               | 创建时间 | 默认值为now()         |
| update_time | datetime     | --               | 更新时间 | 默认值为now()         |
| remark      | varchar(100) | --               | 备注     | 预留字段，暂无用      |

> 通过redis来限制请求频率和次数





## 日志表

log

| 字段名      | 字段类型     | 约束             | 说明      | 备注                  |
| ----------- | ------------ | ---------------- | --------- | --------------------- |
| log_id      | int          | 主键、非空、自增 | 主键      | 主键自增              |
| log_title   | varchar(4)   | --               | 日志title | --                    |
| log_type    | varchar(2)   | --               | 操作类型  | --                    |
| log_ajax    | varchar(7)   | --               | 请求方式  | --                    |
| log_ip      | varchar(15)  | --               | 请求ip    | --                    |
| status      | boolean      | --               | 状态      | 默认true正常false禁用 |
| create_time | datetime     | --               | 创建时间  | 默认值为now()         |
| update_time | datetime     | --               | 更新时间  | 默认值为now()         |
| remark      | varchar(100) | --               | 备注      | 预留字段，暂无用      |















