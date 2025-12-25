# Objective-C 老代码专用（你会很常用）

> 适用于方法级优化，不涉及架构调整

【输入信息】
- 代码文件/方法：
- iOS 最低版本：
- 是否使用 ARC：
- 是否有单元测试：
- 调用方数量：
- 是否涉及 Runtime 特性：

【目标】
- 提升可读性（单方法 < 50 行）
- 降低方法复杂度（圈复杂度 < 10）
- 保持行为完全一致（测试通过率 100%）

【约束】
- 不修改 public API
- 不改变调用顺序
- 不拆模块、不合并类
- 不删除看似无用的代码（可能被 Runtime 调用）

【Objective-C 特有风险检查】
- [ ] KVO/KVC 依赖检查
- [ ] Runtime 消息转发（forwardInvocation:）
- [ ] Category 方法冲突
- [ ] 宏定义展开影响
- [ ] Method Swizzle 影响
- [ ] Associated Objects 使用

【Swift 混编兼容性检查】（如适用）
- [ ] 是否需要更新 Bridging Header
- [ ] 公开 API 是否添加 nullability 注解（nullable/nonnull）
- [ ] 是否使用 NS_SWIFT_NAME 优化 Swift 调用体验
- [ ] 枚举是否使用 NS_ENUM/NS_OPTIONS（Swift 兼容）

【请输出】
1. 当前代码问题点列表（圈复杂度、命名、重复逻辑）
2. 方法级重构建议（拆分方法、提取常量、简化条件）
3. 最小改动执行顺序（按依赖关系排序）
4. 必须人工确认的步骤（Runtime 相关、外部依赖）
5. 每步验证方式（单元测试 / 手工测试 / 静态分析）
6. 回滚方案（Git commit hash + 验证步骤）

【禁止】
- 重命名公开方法/属性
- 修改属性声明（strong/weak/copy）
- 改变初始化顺序
- 删除未被直接调用的方法（可能被 Runtime 动态调用）
- 修改 Category 方法名

【相关文档】
- 执行时使用：`code_execute_step.md`
- 审核时使用：`review_and_rollback.md`

---
只给方案，不写代码