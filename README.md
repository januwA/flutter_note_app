## 记事本app

- [x] 可添加信息
- [x] 用列表展示每条信息
- [x] 可删除
- [x] 可批量删除
- [ ] 可修改
- [x] 可顶置
- [x] 在用户本地持久储存
- [ ] 删除后进入回收站列表
- [ ] 删除后可恢复
- [ ] 删除后默认三天后从回收站清理 
- [x] 可查看每条信息的详情


## mobx,需要开一个控制台来运行编译脚本
```
flutter packages pub run build_runner build   // 执行一次build命令
flutter packages pub run build_runner watch  // 文件更改自动打包
flutter packages pub run build_runner watch --delete-conflicting-outputs  // 删除旧文件在打包
```