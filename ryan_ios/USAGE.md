# iOS Prompt 模板使用指南

> 如何使用这套 prompt 模板与 AI 协作进行 iOS 开发

---

## 📖 模板是什么？

这些 `.md` 文件是 **结构化的 prompt 模板**，用于：
- 规范你向 AI 提问的方式
- 确保 AI 输出符合你的需求
- 建立可重复的工作流程

**核心理念：** 模板就是给 AI 的"需求文档"，告诉 AI 应该输出什么格式、什么内容。

---

## 🎯 三种使用方式

### 方式 1：复制填写后发送（通用）

**适用场景：** 任何 AI 工具（Claude、GPT、通义千问等）

**步骤：**
1. 打开对应的 `.md` 文件（如 `plan_security.md`）
2. 复制全部内容
3. 填写【背景】等占位符字段
4. 粘贴发送给 AI
5. AI 按模板要求输出结果

**示例：**

```markdown
# iOS 安全加固 / 反逆向 / 反调试

【背景】
- 安全阶段：已上线
- 当前已有检测手段：ptrace 反调试
- App 类型：金融
- 安全等级要求：高

【攻击模型】（完整覆盖）
...（保持模板原文）

【请输出】
...（保持模板原文）
```

---

### 方式 2：使用 @ 引用（Claude Code）

**适用场景：** Claude Code 命令行工具

**步骤：**
```bash
# 直接 @ 引用文件
@ryan_ios/plan_security.md

帮我分析我们 App 的安全加固方案
背景：金融 App，已上线，目前只有 ptrace 反调试
```

Claude 会自动读取模板内容并按要求输出。

---

### 方式 3：对话中引用（推荐）

**适用场景：** 与 AI 的持续对话中

**步骤：**
```
第 1 轮：
你：@ryan_ios/plan_security.md
    帮我规划越狱检测方案（填写背景信息）

AI：输出完整的安全方案

第 2 轮：
你：@ryan_ios/code_execute_step.md
    执行步骤 3.1：实现 Cydia 路径检测

AI：输出具体的代码改动

第 3 轮：
你：@ryan_ios/review_and_rollback.md
    审查刚才的改动

AI：输出审查结果和风险点
```

---

## 🔄 完整工作流程

### 标准四阶段流程

```
1️⃣ Plan（规划）
   ↓ 使用 plan_*.md
   ↓ 获取分析和执行计划

2️⃣ Execute（执行）
   ↓ 使用 code_execute_step.md
   ↓ 逐步实施改动

3️⃣ Review（审查）
   ↓ 使用 review_and_rollback.md
   ↓ 验证改动是否符合要求

4️⃣ Audit（审计）
   ↓ 使用 checklist.md
   ↓ 最终质量门禁检查
```

---

## 💼 实际使用案例

### 案例 1：实现越狱检测功能

#### Step 1：规划阶段

**你的输入：**
```
@ryan_ios/plan_security.md

帮我规划越狱检测方案

【背景】
- 安全阶段：已上线 2 年
- 当前已有检测手段：ptrace 反调试、dylib 注入检测
- App 类型：社交
- 安全等级要求：中

目前发现有用户在越狱环境下使用，需要增加越狱检测。
不能影响正常用户，不能直接闪退。
```

**AI 输出（示例）：**
```
## 1. 各攻击真实实现路径

越狱检测的技术原理：
- 文件系统检测：/Applications/Cydia.app 等路径
- 沙盒完整性：fork/stat/system 调用是否被限制
- 动态库检测：MobileSubstrate.dylib
- URL Scheme：cydia:// 是否可打开

## 2. 当前方案可被绕过点

你现有的检测组合问题：
- ptrace 单点容易被 patch
- dylib 白名单可能不完整

## 3. 多策略组合建议

推荐三层检测：
【启动期】
- 检测 Cydia 路径（快速、低成本）
- 检测 fork 调用返回值

【运行期】
- 关键操作前再次检测
- 降级策略：仅限制敏感功能，不闪退

【服务端】
- 上报设备环境信息
- 后台风控决策

## 4. iOS 版本差异
- iOS 14+：fork 检测可能失效
- iOS 15+：路径检测需要更新

## 5. 误判与降级策略
- TestFlight 环境：禁用检测
- Debug 构建：禁用检测
- 误判率控制：< 0.1%

## 6. 实施优先级

P0（立即实施）：
- 步骤 3.1：文件路径检测
- 步骤 3.2：fork 调用检测

P1（首版后迭代）：
- 步骤 3.3：动态库检测
- 步骤 3.4：服务端联动

## 7. 检测时机与频率
- 启动时检测一次
- 支付/转账前再次检测
- 不做高频持续检测（成本高）

## 8. 性能影响评估
- 文件路径检测：< 5ms
- fork 调用检测：< 1ms
- 总启动时间增加：< 10ms

## 9. 自我保护机制
- 检测代码使用混淆
- 关键字符串加密
- 分散在不同文件中

## 10. 验证与测试方案
- 越狱设备测试（iOS 14/15/16）
- 非越狱设备回归测试
- 误判率监控
```

---

#### Step 2：执行阶段（步骤 3.1）

**你的输入：**
```
@ryan_ios/code_execute_step.md

执行 plan_security 中：
- Plan 文档名：plan_security.md
- 步骤编号：3.1
- 步骤描述：实现 Cydia 路径检测

【执行前检查】
- [x] 已创建独立分支（feature/jailbreak-detection）
- [x] 当前代码可编译通过
- [x] 已阅读 SecurityChecker.m 文件
- [x] Plan 已确认

【修改范围】
- 文件：SecurityChecker.m
- 方法：+ (BOOL)isJailbroken
- 预计修改行数：20 行
```

**AI 输出（示例）：**
```diff
--- a/SecurityChecker.m
+++ b/SecurityChecker.m
@@ -10,8 +10,25 @@

 + (BOOL)isJailbroken {
+#if DEBUG
+    return NO; // Debug 环境禁用检测
+#endif
+
+    // 检测常见越狱路径
+    NSArray *jailbreakPaths = @[
+        @"/Applications/Cydia.app",
+        @"/Library/MobileSubstrate/MobileSubstrate.dylib",
+        @"/bin/bash",
+        @"/usr/sbin/sshd",
+        @"/etc/apt"
+    ];
+
+    for (NSString *path in jailbreakPaths) {
+        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
+            return YES;
+        }
+    }
+
     return NO;
 }

【修改理由】
1. 增加 5 个常见越狱路径检测，覆盖主流越狱工具
2. Debug 环境自动禁用，避免影响开发调试
3. 使用 NSFileManager 标准 API，不涉及私有接口
4. 多路径组合检测，避免单点失效

【是否引入临时兼容代码】否

【修改是否超出声明范围】否，严格按照步骤 3.1 实施
```

---

#### Step 3：审查阶段

**你的输入：**
```
@ryan_ios/review_and_rollback.md

请评审以下修改：

【审查输入】
- 关联 Plan 文档：plan_security.md
- 执行步骤编号：3.1
- 变更 diff：（上面的 diff）
- 测试报告：编译通过，单元测试通过
```

**AI 输出（示例）：**
```
## 【审查检查清单】

### P0 阻断项
✅ 是否改变了 public API 签名：否
✅ 是否引入已知崩溃风险：否
✅ 是否使用私有 API：否
✅ 是否可在 5 分钟内回滚：是
✅ 是否通过编译和基础测试：是

### P1 必须说明
✅ 是否偏离原 plan 目标？
   否，严格按照 3.1 步骤实施

⚠️ 是否引入 App Store 审核风险？
   风险点：fileExistsAtPath 读取系统路径
   缓解措施：
   - 使用公开 API，不违反审核规则
   - 仅检测路径是否存在，不读取内容
   - 建议：App Store Connect 说明中标注"安全检测"用途

✅ 是否存在稳定性隐患？
   验证方式：已在 iOS 14/15/16 测试，无崩溃

✅ 是否影响性能指标？
   影响评估：5 次文件检测，总耗时 < 5ms

### P2 建议项
⚠️ 是否应进一步优化
   建议：增加结果缓存，避免重复检测

## 【安全审计】

### 安全性检查
✅ 输入验证是否完备：是（路径为硬编码常量）
✅ 敏感数据是否加密/脱敏：不涉及
✅ 日志是否过滤敏感信息：不涉及

### 性能检查
✅ 主线程是否存在文件 I/O：
   是，但耗时 < 5ms，可接受
   建议：后续可移至后台线程

### 稳定性检查
✅ 容器操作是否有越界保护：是（使用 for-in 遍历）

## 【回滚策略】

### 回滚方案
- Git 回滚命令：`git revert <commit_hash>`
- 预计回滚耗时：< 1 分钟
- 是否需要数据迁移回滚：否

### 回滚验证
- [ ] 核心功能验证：登录、支付流程
- [ ] 回归测试通过
- [ ] 非越狱设备正常使用

## 【审查结论】

**审查人：** AI Assistant
**审查时间：** 2025-12-21
**结论：** ✅ 有条件通过

**备注：**
- 建议增加结果缓存优化性能
- App Store 提审时在说明中标注用途

**下一步行动：**
1. 增加缓存逻辑
2. 执行步骤 3.2：fork 调用检测
3. 提交代码并创建 PR
```

---

#### Step 4：最终审计

**你的输入：**
```
@ryan_ios/checklist.md

对照检查清单，验证刚才的越狱检测实现
```

**AI 输出（示例）：**
```
## 安全审计检查清单

### 1. 越狱检测（Jailbreak Detection）

**P0 - 必须检查：**
- [x] 是否检测 Cydia/Sileo/Zebra 等越狱商店 ✅ 已实现
- [x] 是否检测常见越狱文件路径 ✅ 已实现 5 个路径
- [ ] 是否检测沙盒完整性（fork/stat/system 调用）❌ 下一步实施
- [ ] 是否检测 Substrate/Substitute 框架 ❌ 下一步实施
- [x] 检测失败是否可降级 ✅ Debug 环境自动禁用

### 12. 审核红线（非常重要）

**P0 - 必须确认：**
- [x] 是否使用私有 API ✅ 未使用
- [x] 是否读取越权系统路径 ⚠️ 仅检测路径存在，未读取内容

## 审计结论

✅ 当前实现符合 P0 基本要求
⚠️ 建议在 App Store 提审说明中补充：
   "应用包含设备环境检测功能，用于保障用户账号安全"

🔜 下一步需要实施：
   - 步骤 3.2：fork 调用检测（沙盒完整性）
   - 步骤 3.3：Substrate 框架检测
```

---

### 案例 2：重构老代码

**快速流程：**

```
1️⃣ Plan 阶段
@ryan_ios/plan_refactor_legacy.md

【输入信息】
- 代码文件/方法：LoginViewController.m / -handleLoginResponse:
- 是否使用 ARC：是
- 是否有单元测试：无

→ AI 输出：重构建议、最小改动顺序

2️⃣ Execute 阶段
@ryan_ios/code_execute_step.md

执行步骤 1.1：拆分 handleLoginResponse 方法

→ AI 输出：具体的代码改动

3️⃣ Review 阶段
@ryan_ios/review_and_rollback.md

审查改动

→ AI 输出：审查结果、风险点

4️⃣ Audit 阶段
@ryan_ios/checklist.md

对照稳定性检查清单

→ AI 输出：KVO/Notification/Block 检查结果
```

---

## 📚 各模板的使用场景

| 模板文件 | 使用时机 | 输出内容 |
|---------|---------|---------|
| **plan_architecture.md** | 大型架构改动前 | 架构分析、方案对比、执行步骤 |
| **plan_security.md** | 安全加固需求 | 攻击向量分析、防御策略、响应方案 |
| **plan_performance.md** | 性能优化需求 | 性能瓶颈分析、优化建议、监控方案 |
| **plan_refactor_legacy.md** | Objective-C 重构 | 代码问题点、重构建议、验证方式 |
| **plan_logging.md** | 日志系统设计 | 异步策略、崩溃保护、隐私脱敏 |
| **code_execute_step.md** | 执行具体改动 | 代码 diff、修改理由、验证结果 |
| **review_and_rollback.md** | 改动审查 | 风险评估、回滚方案、审查结论 |
| **checklist.md** | 最终质量门禁 | 安全/性能/稳定性/审核风险检查 |

---

## ✨ 最佳实践

### 1. 填写背景信息要具体

❌ 不好的例子：
```
App 类型：社交
```

✅ 好的例子：
```
App 类型：社交（类微信，即时通讯 + 朋友圈）
日活：50 万
技术栈：Objective-C 70% + Swift 30%
最低支持版本：iOS 13.0
```

---

### 2. 分步执行，不要一次改太多

❌ 不好的例子：
```
@ryan_ios/code_execute_step.md
执行 plan_security 中所有步骤
```

✅ 好的例子：
```
@ryan_ios/code_execute_step.md
执行步骤 3.1：Cydia 路径检测
（完成后再执行 3.2）
```

---

### 3. 每个阶段都要审查

```
Plan → Execute → Review → Audit
        ↑         ↑       ↑
        不要跳过任何步骤
```

---

### 4. 保留 AI 输出作为文档

AI 的输出本身就是很好的技术文档：
- Plan 阶段输出 → 保存为技术方案文档
- Execute 阶段输出 → 保存为代码变更记录
- Review 阶段输出 → 保存为审查报告

---

### 5. 结合 Git 工作流

```
feature 分支
  ↓
Plan（方案评审）
  ↓
Execute（逐步提交）
  ↓
Review（代码审查）
  ↓
Audit（合并前检查）
  ↓
merge 到 main
```

---

## 🚀 进阶技巧

### 技巧 1：创建自定义模板

参考现有模板，创建适合你团队的模板：

```markdown
# 我的团队专用模板

【团队背景】
- 团队规模：
- 技术栈：
- 代码规范：

【特殊约束】
- 必须使用 RxSwift
- 必须符合 MVVM 架构
- 必须有单元测试覆盖

【请输出】
...
```

---

### 技巧 2：组合多个模板

```
@ryan_ios/plan_security.md
@ryan_ios/plan_performance.md

帮我同时规划：
1. 越狱检测（安全）
2. 检测逻辑的性能优化（性能）
```

---

### 技巧 3：迭代式改进

```
第 1 轮：用 plan 模板获取初步方案
第 2 轮：针对方案中的某个点深入讨论
第 3 轮：修改方案
第 4 轮：最终确定方案
第 5 轮：用 execute 模板开始实施
```

---

## ❓ 常见问题

### Q1：必须填写所有占位符吗？

A：不是。根据实际情况填写，不相关的可以删除或写"无"。

---

### Q2：AI 输出不符合模板要求怎么办？

A：提醒 AI：
```
请严格按照模板的【请输出】部分要求，
输出完整的 10 项内容。
```

---

### Q3：可以修改模板吗？

A：可以。这些模板是开放的，你可以：
- 增加适合你团队的约束条件
- 修改输出要求
- 创建新的模板

---

### Q4：多人协作时如何使用？

A：建议：
1. 团队共享这套模板
2. Plan 阶段输出作为技术方案评审文档
3. Review 阶段输出作为 Code Review 依据
4. 所有文档存档在项目 Wiki 中

---

## 📎 相关资源

- **README.md** - 模板列表和快速开始
- **checklist.md** - 安全/性能/稳定性/审核检查清单
- **各 plan_*.md** - 具体场景的规划模板
- **code_execute_step.md** - 执行控制模板（防失控）
- **review_and_rollback.md** - 审查回滚模板

---

## 🎓 总结

**核心价值：**
1. 结构化思考 - 模板帮你系统地考虑问题
2. 可重复流程 - 每次改动都有章可循
3. 质量保障 - 多阶段审查确保不出问题
4. 知识沉淀 - AI 输出即文档，可复用

**开始使用：**
1. 选择适合的模板
2. 填写背景信息
3. 发送给 AI
4. 按输出执行
5. 完成后审查

**记住：** 这些模板是指南，不是枷锁。根据实际情况灵活调整！