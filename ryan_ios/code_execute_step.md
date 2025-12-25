# 代码执行步骤控制

> 最重要的文件（防失控）

执行 plan 中：
- Plan 文档名：
- 步骤编号：
- 步骤描述：

---

## 【执行前检查】
- [ ] 已创建独立分支（`git checkout -b feature/xxx`）
- [ ] 当前代码可编译通过
- [ ] 已阅读相关文件上下文
- [ ] Plan 已经过 review 确认
- [ ] 已记录当前 commit hash（用于回滚）

---

## 【硬约束】
- 不新增类（内部 helper struct/enum 除外）
- 不修改 public 接口（含方法签名、属性、协议）
- 不改变逻辑顺序（调用序列、生命周期回调）
- 不做额外优化（仅完成 plan 指定项，发现问题另开 issue）
- 不修改无关文件（严格控制影响范围）

---

## 【修改范围】
- 文件：
- 方法：
- 影响的关联文件（如有）：
- 预计修改行数：

---

## 【输出要求】
- diff patch（完整的代码变更）
- 每一处修改的理由（why，不是 what）
- 是否引入临时兼容代码（如有，需说明后续清理计划）
- 修改是否超出声明范围（如超出，需说明原因）

---

## 【执行后验证】
- [ ] 代码可编译通过
- [ ] 相关单元测试通过（如有）
- [ ] 手工验证核心路径
- [ ] 改动范围符合声明
- [ ] diff 符合最小改动原则

---

## 【回滚信息】
- 基准 commit hash：
- 回滚命令：`git reset --hard <hash>` 或 `git revert <hash>`
- 是否需要数据迁移回滚：☐ 是  ☐ 否
- 回滚验证步骤：

---

**只改代码，不做分析。严格按照 plan 执行。**

---

## 【示例（可直接复制填写）】

执行 plan 中：
- Plan 文档名：plan_security.md
- 步骤编号：3.1
- 步骤描述：新增越狱路径检测

【执行前检查】
- [x] 已创建独立分支（feature/jailbreak-detection）
- [x] 当前代码可编译通过
- [x] 已阅读相关文件上下文（SecurityChecker.m）
- [x] Plan 已经过 review 确认
- [x] 已记录当前 commit hash（a1b2c3d）

【修改范围】
- 文件：SecurityChecker.m
- 方法：+ (BOOL)isJailbroken
- 影响的关联文件：无
- 预计修改行数：20 行

【输出要求】
```diff
--- a/SecurityChecker.m
+++ b/SecurityChecker.m
@@
+#if DEBUG
+    return NO; // Debug 环境跳过
+#endif
+
+    NSArray *paths = @[
+        @"/Applications/Cydia.app",
+        @"/Library/MobileSubstrate/MobileSubstrate.dylib"
+    ];
+    for (NSString *path in paths) {
+        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
+            return YES;
+        }
+    }

    return NO;
```

【修改理由】
1. 新增常见越狱路径，覆盖主流工具
2. Debug 环境跳过，避免影响调试
3. 不改其他逻辑，确保可回滚

【执行后验证】
- [x] 代码可编译通过
- [x] 单元测试：SecurityCheckerTests 通过
- [x] 手工验证：越狱设备触发提示
- [x] 改动范围符合声明
- [x] diff 符合最小改动原则

【回滚信息】
- 基准 commit hash：a1b2c3d
- 回滚命令：`git revert HEAD`
- 是否需要数据迁移回滚：☐ 是  ☑ 否
- 回滚验证步骤：回归登录、支付主流程
