
# rongcloud

## 用前须知

### 替换自己的appkey,contacts.plist 模拟用户需要自己去注册
### pod repo update pod install

- 项目是依据IMKit构建的快速开发页面，如果需要高度自定义的可使用IMClient


- 融云不维护用户关系
   - 比如好友关系，群组关系

- 融云是会话产生会话聊表，简单理解就是，有人发消息，SDK会产生会话列表,列表是缓存在客户端本地的，所以，换机，卸载都会丢失消息。
- 融云商用版功能，可解适当解决此类问题，详情请咨询客服
  - 历史消息存储
  - 离线缓存
