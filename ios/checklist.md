# iOS 审计检查清单

> 安全 / 性能 / 稳定性 / 审核风险四大审计维度
> 配合 `review_and_rollback.md` 使用

---

## ✅ 安全审计检查清单

### 1. 越狱检测（Jailbreak Detection）

**P0 - 必须检查：**
- [ ] 是否检测 Cydia/Sileo/Zebra 等越狱商店
- [ ] 是否检测常见越狱文件路径（/Applications/Cydia.app 等）
- [ ] 是否检测沙盒完整性（fork/stat/system 调用）
- [ ] 是否检测 Substrate/Substitute 框架
- [ ] 检测失败是否可降级（警告而非直接闪退）

**风险点：**
- 越狱检测方法容易失效（iOS 版本更新）
- 误判影响正常用户体验
- 部分企业设备可能被误判

---

### 2. 反调试（Anti-Debug）

**P0 - 必须检查：**
- [ ] 是否只依赖 ptrace(PT_DENY_ATTACH)（❌ 单点极易失效）
- [ ] 是否存在 sysctl / syscall / task_info 组合策略
- [ ] 检测是否放在尽量早的执行路径（+load 或 main 之前）
- [ ] 调试检测失败是否可降级（而不是直接闪退）
- [ ] 是否对检测代码本身做混淆保护

**风险点：**
- iOS 高版本对 ptrace 行为变化
- TestFlight / 内部调试误伤
- Xcode 调试环境需要开关控制

---

### 3. 反 Hook（Anti-Hook / Swizzle）

**P1 - 必须检查：**
- [ ] 是否检测关键函数的符号绑定被修改
- [ ] 是否校验关键 selector 的 IMP 地址
- [ ] 是否防止 fishhook 在 dyld 之后重新绑定
- [ ] 是否考虑 category / method swizzle 场景
- [ ] 是否检测 MSHookFunction 等 Cydia Substrate 函数

**风险点：**
- SDK 合法 swizzle 被误判（需要白名单）
- Debug 环境下的可控开关
- 性能影响（检测耗时）

---

### 4. 反注入（Anti-Injection）

**P0 - 必须检查：**
- [ ] _dyld_image_count() 枚举是否合法
- [ ] 是否存在 framework / dylib 白名单
- [ ] 路径匹配是否过于宽松（避免 contains，使用 hasPrefix）
- [ ] 注入检测是否支持延迟二次检查
- [ ] 是否检测可疑库（FridaGadget.dylib / cycript 等）

**风险点：**
- 系统私有库路径变化（iOS 版本差异）
- Xcode / 调试符号误判
- 白名单维护成本

---

### 5. 反重签名（Anti-ReSign / 篡改检测）

**P0 - 必须检查：**
- [ ] 是否校验 CodeSignature 相关信息
- [ ] 是否检测 Bundle ID / Team ID 一致性
- [ ] 是否校验 embedded.mobileprovision
- [ ] 是否校验可执行文件哈希值
- [ ] 是否检测资源文件完整性（_CodeSignature 目录）

**风险点：**
- TestFlight 与 App Store 行为差异
- 企业证书误杀
- 热更新场景的影响

---

### 6. SSL Pinning / 中间人攻击防护

**P1 - 必须检查：**
- [ ] 是否实现证书固定（Certificate Pinning）
- [ ] 是否实现公钥固定（Public Key Pinning）
- [ ] 是否验证证书链完整性
- [ ] 是否处理证书过期的降级策略
- [ ] 是否检测系统代理设置

**风险点：**
- 证书更新时需要发版
- Charles/Fiddler 调试受影响（需要 Debug 开关）
- CDN 多证书场景处理

---

## ⚡ 性能审计检查清单

### 7. 主线程安全

**P0 - 必须检查：**
- [ ] 主线程是否存在文件 I/O（NSFileManager 操作）
- [ ] 主线程是否有同步锁 / semaphore 阻塞
- [ ] viewDidLoad 是否有同步网络请求
- [ ] viewDidLoad 是否有大数据加载（> 1MB）
- [ ] applicationDidFinishLaunching 耗时是否 > 100ms
- [ ] JSON 解析 / 加解密是否放在后台线程

**风险点：**
- 主线程阻塞导致 ANR（Application Not Responding）
- 启动耗时影响用户体验
- Instruments Time Profiler 检测

---

### 8. RunLoop & 卡顿

**P1 - 必须检查：**
- [ ] RunLoop Observer 是否被滥用（监听过多事件）
- [ ] 高频 Timer 是否在主 RunLoop（> 10 次/秒）
- [ ] 列表滚动是否触发过多 layout / measure
- [ ] 是否使用 CADisplayLink 监控主线程卡顿
- [ ] 单次 RunLoop 耗时是否 > 16.67ms（60fps）

**风险点：**
- 复杂 UI 布局导致掉帧
- AutoLayout 性能问题
- 高频率刷新影响电量

---

### 9. 日志 & 异步系统

**P1 - 必须检查：**
- [ ] 日志是否异步写入（使用 DispatchQueue）
- [ ] 是否有内存缓冲区（避免频繁 I/O）
- [ ] flush 时机是否可控（后台、内存警告、定时）
- [ ] 崩溃前是否有兜底 flush（Signal Handler / mmap）
- [ ] 日志文件是否有轮转策略（大小限制、保留天数）

**风险点：**
- 同步写入阻塞主线程
- 崩溃时日志丢失
- 日志文件占用空间过大

---

## 🧱 稳定性审计检查清单

### 10. 防御式编程

**P0 - 必须检查：**
- [ ] KVO 是否成对移除（removeObserver）
- [ ] Notification 是否成对移除（removeObserver）
- [ ] Block 是否造成 retain cycle（使用 weak self）
- [ ] 容器操作是否有越界保护（数组、字典）
- [ ] 网络回调是否检查对象有效性（weak-strong dance）

**风险点：**
- KVO 未移除导致崩溃（观察者已释放）
- Notification 重复注册导致多次回调
- 循环引用导致内存泄漏

---

### 11. OOM（内存溢出）风险

**P1 - 必须检查：**
- [ ] 大图解码是否在主线程（> 2MB 图片）
- [ ] 图片缓存是否有上限（NSCache / LRU）
- [ ] 是否有无限增长的数组/字典
- [ ] AutoreleasePool 使用是否合理（循环中使用）
- [ ] 是否监听内存警告（didReceiveMemoryWarning）

**风险点：**
- 高分辨率图片解码占用大量内存
- 缓存未设置上限导致 OOM
- 循环中创建大量临时对象

---

## 🛑 App Store 审核风险检查清单

### 12. 审核红线（非常重要）

**P0 - 必须确认：**
- [ ] 是否使用私有 API（哪怕只 include 头文件）
- [ ] 是否动态加载可疑 dylib（Runtime dlopen）
- [ ] 是否读取越权系统路径（/var/mobile/Library）
- [ ] 是否存在"反审查"行为（检测审核环境）
- [ ] 是否收集 IDFA 但未声明用途
- [ ] 是否有热更新 / 动态执行代码（JSPatch 等）

**风险点：**
- 使用私有 API 直接被拒
- 动态加载代码违反 App Store 政策
- IDFA 收集需要 ATTrackingManager 授权
- 热更新功能可能被拒（非 H5）

---

## 📋 使用建议

### 使用时机

**每次大改前：**
- 跑一遍安全 + 性能检查清单
- 识别潜在风险点

**每次 plan 完成后：**
- 对照检查清单验证是否踩雷
- 补充遗漏的检查项

**上线前：**
- 完整过一遍所有检查清单
- 配合灰度发布 + 功能开关控制
- 准备回滚方案

### 检查优先级

| 优先级 | 说明 | 不通过后果 |
|--------|------|-----------|
| P0 | 必须检查，影响上线 | 阻断发布 |
| P1 | 建议检查，影响质量 | 有条件通过 |
| P2 | 可选检查，优化项 | 不阻断 |

---

## 扩展阅读

如需更深入的审计策略和实施方案，可参考：
- `plan_security.md` - 安全加固完整方案
- `plan_performance.md` - 性能优化方案
- `plan_logging.md` - 日志系统设计
- `review_and_rollback.md` - 审查与回滚流程