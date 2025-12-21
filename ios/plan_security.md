# Anti-Debug / Anti-Hook / Anti-Injection / Anti-ReSign

【背景】
- 安全阶段（开发 / 已上线）：
- 当前已有检测手段：

【攻击模型】
- 调试（lldb / ptrace）：
- Hook（fishhook / swizzle）：
- 注入（dylib / frida）：
- 重签名 / 篡改：

【约束】
- 不使用私有 API
- 不触发系统弹窗
- 不影响 App Store 审核
- 不显著增加启动时间

【请输出】
1. 各攻击真实实现路径
2. 当前方案可被绕过点
3. 多策略组合建议（runtime / compile-time）
4. iOS 版本差异
5. 误判与降级策略
6. 哪些值得 code，哪些只做监控

【禁止】
- 玄学检测
- 只列 API 不讲原理