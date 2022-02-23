### sftp专用镜像，可升级openssh版本

#### 更换openssh版本
修改脚本中openssh版本号打包即可 /update/update_openssh.sh

#### PVC存储目录挂载
/home

#### configmap挂载账号密码配置
/etc/sftp/users.conf

users.conf

`
admin1:123456:1001:100:upload
`

`
admin2:123456:1002:100:upload
`

`
admin3:123456:1003:100:upload
`
