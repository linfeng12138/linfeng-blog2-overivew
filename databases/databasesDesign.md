# 林风博客2.0 数据库设计

> 注意：由于为个人博客项目，所以没有建权，在后台管理系统中只有一个超级管理员权限
>
> 项目比较简单，所以也没有用rbac，只是普通的个人博客



# 用户相关

## 用户表

blog_user

| 字段名        | 字段类型     | 约束             | 说明         | 备注              |
| ------------- | ------------ | ---------------- | ------------ | ----------------- |
| user_id       | int          | 主键、非空、自增 | 用户id       | 主键自增          |
| user_name     | varchar(20)  | 非空             | 用户名       | --                |
| user_password | varchar(100) | 非空             | 登录密码     | --                |
| user_email    | varchar(40)  | 非空             | 邮箱         | --                |
| login_ip      | varchar(15)  | --               | 最后登录ip   | --                |
| login_time    | datetime     | --               | 最后登录时间 | --                |
| status        | boolean      | 非空             | 账户状态     | true正常false禁用 |
| create_time   | datetime     | 非空             | 创建时间     | 默认值为now()     |
| update_time   | datetime     | 非空             | 更新时间     | 默认值为now()     |
| remark        | varchar(100) | --               | 备注         | 预留字段，暂无用  |



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



