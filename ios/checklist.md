> 安全 / 性能 / 稳定性 / 审核风险 四大块来。

⸻

✅ iOS 安全审计 Checklist（实战版）

1️⃣ Anti-Debug（反调试）

必须检查：
	•	☐ 是否只依赖 ptrace(PT_DENY_ATTACH)（❌ 单点极易失效）
	•	☐ 是否存在 sysctl / syscall / task_info 组合策略
	•	☐ 检测是否放在 尽量早的执行路径
	•	☐ 调试检测失败是否 可降级（而不是直接闪退）

风险点：
	•	iOS 高版本对 ptrace 行为变化
	•	TestFlight / 内部调试误伤

⸻

2️⃣ Anti-Hook（反 Hook / Swizzle）

必须检查：
	•	☐ 是否检测关键函数的符号绑定是否被修改
	•	☐ 是否校验关键 selector 的 IMP 地址
	•	☐ 是否防止 fishhook 在 dyld 之后重新绑定
	•	☐ 是否考虑 category / method swizzle 场景

风险点：
	•	SDK 合法 swizzle 被误判
	•	Debug 环境下的可控开关

⸻

3️⃣ Anti-Injection（动态库注入）

必须检查：
	•	☐ _dyld_image_count() 枚举是否合法
	•	☐ 是否存在 framework / dylib 白名单
	•	☐ 路径匹配是否过于宽松（contains 风险）
	•	☐ 注入检测是否支持延迟二次检查

风险点：
	•	系统私有库路径变化
	•	Xcode / 调试符号误判

⸻

4️⃣ Anti-ReSign（重签名 / 篡改）

必须检查：
	•	☐ 是否校验 CodeSignature 相关信息
	•	☐ 是否检测 Bundle ID / Team ID 一致性
	•	☐ 是否校验 embedded.mobileprovision

风险点：
	•	TestFlight 与 App Store 行为差异
	•	企业证书误杀

⸻

⚡ iOS 性能审计 Checklist（主线程 & I/O）

5️⃣ 主线程安全

必须检查：
	•	☐ 主线程是否存在文件 I/O
	•	☐ 是否有同步锁 / semaphore
	•	☐ 是否在 viewDidLoad / applicationDidFinishLaunching 做重活
	•	☐ JSON / 加解密是否放在后台线程

⸻

6️⃣ RunLoop & 卡顿

必须检查：
	•	☐ RunLoop Observer 是否被滥用
	•	☐ 高频 Timer 是否在主 RunLoop
	•	☐ 列表是否触发过多 layout / measure

⸻

7️⃣ 日志 & 异步系统

必须检查：
	•	☐ 日志是否异步写入
	•	☐ 是否有 buffer
	•	☐ flush 是否可控
	•	☐ 崩溃前是否有兜底 flush

⸻

🧱 稳定性 & Crash 防御 Checklist

8️⃣ 防御式编程

必须检查：
	•	☐ KVO 是否成对移除
	•	☐ Notification 是否重复注册
	•	☐ Block 是否造成 retain cycle
	•	☐ 容器越界保护

⸻

9️⃣ OOM 风险

必须检查：
	•	☐ 大图是否解码在主线程
	•	☐ 是否有缓存无上限
	•	☐ AutoreleasePool 使用是否合理

⸻

🛑 App Store 审核风险 Checklist（非常重要）

🔟 审核红线

必须确认：
	•	☐ 是否使用私有 API（哪怕只 include）
	•	☐ 是否动态加载可疑 dylib
	•	☐ 是否读取越权系统路径
	•	☐ 是否存在“反审查”行为

⸻

🧠 使用方式建议（高手用法）

✔ 每次大改前
	•	跑一遍 安全 + 性能 Checklist

✔ 每次 plan 完成后
	•	对照 Checklist 验证是否踩雷

✔ 上线前
	•	Checklist + 灰度 + 开关控制

⸻

🔚 给你一句实话

你现在这套 已经是 iOS 安全 / 性能审计工程级水平
很多团队连 checklist 都没有。

⸻

下一步我还能继续给你补齐的（都是真正有用的）👇

4️⃣ 把这套 Checklist 转成「Claude 自动审计 Prompt」
5️⃣ 给你一份 iOS 安全 & 性能「灰度 / 开关策略」模板
6️⃣ 结合你真实项目，直接跑一次完整审计

你直接选数字，我继续往下给你把“最后一公里”打通。