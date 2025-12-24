# Flutter 代码执行步骤控制

> 逐步执行代码修改，防止 AI 失控

---

## 【核心原则】

**本模板的唯一目的：防止 AI 一次性修改过多代码**

每次只执行一个明确的小步骤，确保：
- ✅ 修改范围可控
- ✅ 每步可验证
- ✅ 可随时回滚
- ✅ 不偏离计划

---

## 【使用方式】

**Step 1：明确当前要执行的步骤**

从 Plan 文档（如 `plan_state_management.md`）中选择一个具体步骤：

```
Plan 文档名：plan_state_management.md
步骤编号：3.1
步骤描述：创建 UserProvider 基础结构
```

**Step 2：声明修改范围**

明确这一步要修改什么：

```
【修改范围】
- 新建文件：lib/providers/user_provider.dart
- 预计代码行数：约 50 行
- 影响范围：仅新增文件，不影响现有代码
```

**Step 3：执行前检查**

确认以下条件：
- [ ] 已创建独立的 Git 分支
- [ ] 当前代码可编译运行
- [ ] 已阅读相关代码文件
- [ ] Plan 文档步骤已确认

**Step 4：执行修改**

AI 现在可以执行这一步的代码修改。

**Step 5：执行后验证**

- [ ] 代码编译通过
- [ ] 单元测试通过（如有）
- [ ] 功能手动验证通过
- [ ] Git diff 查看改动符合预期

---

## 【输入模板】

```markdown
## 执行步骤

【来源 Plan】
- Plan 文档名：plan_xxx.md
- 步骤编号：X.X
- 步骤描述：（从 Plan 中复制）

【执行前检查】
- [ ] 已创建独立分支（feature/xxx）
- [ ] 当前代码可编译通过
- [ ] 已阅读相关文件
- [ ] Plan 已确认

【修改范围】
- 文件：（具体文件路径）
- 类/Widget：（具体类名）
- 方法：（具体方法名）
- 预计修改行数：约 XX 行

【验证方式】
- 编译测试：flutter run
- 单元测试：flutter test
- 手动验证：（具体操作步骤）
```

---

## 【AI 输出要求】

AI 必须按以下格式输出：

### 1. 确认执行步骤

```
我将执行以下步骤：
- Plan：plan_xxx.md
- 步骤：X.X - （步骤描述）
- 修改范围：（确认修改范围）
```

### 2. 代码改动

使用 `diff` 格式或完整代码展示改动：

```dart
// lib/providers/user_provider.dart

import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? _userId;
  String? _userName;

  String? get userId => _userId;
  String? get userName => _userName;

  void login(String userId, String userName) {
    _userId = userId;
    _userName = userName;
    notifyListeners();
  }

  void logout() {
    _userId = null;
    _userName = null;
    notifyListeners();
  }
}
```

### 3. 修改说明

```
【修改理由】
1. 创建基础 Provider 结构
2. 实现登录/登出状态管理
3. 使用 ChangeNotifier 实现状态通知

【是否引入临时兼容代码】
否

【修改是否超出声明范围】
否，严格按照步骤 3.1 实施
```

### 4. 验证步骤

```
【验证步骤】
1. 运行 flutter pub get
2. 运行 flutter analyze（无错误）
3. 运行 flutter test
4. 手动测试：（具体操作）
```

---

## 【严格约束】

⚠️ **禁止 AI 做以下事情：**

1. ❌ **一次修改多个步骤**
   - 必须逐步执行，一次只做一个步骤

2. ❌ **修改超出声明范围**
   - 如果发现需要修改其他文件，必须停止并说明

3. ❌ **擅自改变实现方案**
   - 必须严格按照 Plan 文档执行
   - 如有疑问，先询问用户

4. ❌ **跳过验证步骤**
   - 每步执行后必须验证
   - 验证失败必须回滚

5. ❌ **引入未声明的依赖**
   - 需要新增依赖时，必须先说明

---

## 【示例】

### 示例 1：新增 Provider

**用户输入：**
```
执行 plan_state_management.md 中：
- 步骤编号：3.1
- 步骤描述：创建 UserProvider

【执行前检查】
- [x] 已创建独立分支（feature/user-provider）
- [x] 当前代码可编译通过
- [x] 已确认 Plan

【修改范围】
- 新建文件：lib/providers/user_provider.dart
- 预计修改行数：50 行
```

**AI 输出：**
```
✅ 确认执行步骤 3.1：创建 UserProvider

【代码改动】
// lib/providers/user_provider.dart
（完整代码）

【修改理由】
1. 按照 Plan 创建基础 Provider 结构
2. 实现登录状态管理
3. 使用 ChangeNotifier 通知 UI 更新

【验证步骤】
1. flutter analyze（通过）
2. 创建简单测试验证功能
```

---

### 示例 2：修改现有代码

**用户输入：**
```
执行 plan_performance.md 中：
- 步骤编号：2.1
- 步骤描述：优化 UserList 使用 ListView.builder

【修改范围】
- 文件：lib/screens/user_list_screen.dart
- Widget：UserListScreen
- 方法：build
- 预计修改行数：15 行
```

**AI 输出：**
```
✅ 确认执行步骤 2.1：优化 UserList

【代码改动】
// lib/screens/user_list_screen.dart

- ListView(
-   children: users.map((user) => UserTile(user)).toList(),
- )

+ ListView.builder(
+   itemCount: users.length,
+   itemBuilder: (context, index) {
+     return UserTile(users[index]);
+   },
+ )

【修改理由】
1. 使用 ListView.builder 实现懒加载
2. 减少内存占用
3. 提升滚动性能

【预期收益】
- 内存占用降低约 50%（长列表场景）
- 滚动帧率提升至 60fps
```

---

## 【紧急停止】

如果 AI 在执行过程中发现以下情况，必须停止并说明：

1. **需要修改额外文件**
   ```
   ⚠️ 停止执行
   原因：发现需要同时修改 user_repository.dart
   建议：拆分为两个步骤分别执行
   ```

2. **发现 Plan 有问题**
   ```
   ⚠️ 停止执行
   原因：Plan 中的方案在实际代码中不适用
   建议：先讨论调整 Plan
   ```

3. **遇到技术风险**
   ```
   ⚠️ 停止执行
   原因：此改动可能影响现有 XX 功能
   建议：先进行影响分析
   ```

---

## 【执行完成后】

每步执行完成后，用户应该：

1. ✅ 查看 git diff
2. ✅ 运行验证测试
3. ✅ 提交代码
   ```bash
   git add .
   git commit -m "feat: 实现步骤 3.1 - 创建 UserProvider"
   ```
4. ✅ 继续下一步或进行 Code Review

---

## 【总结】

**本模板的唯一目的：让 AI 专注执行一个小步骤，不要失控。**

- 一次只做一件事
- 做完就停下
- 验证通过再继续
- 有问题立即说明

**记住：慢就是快，小步快跑！**
