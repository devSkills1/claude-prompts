# React 代码执行步骤控制

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

从 Plan 文档（如 `plan_performance.md`）中选择一个具体步骤：

```
Plan 文档名：plan_performance.md
步骤编号：2.1
步骤描述：使用 React.lazy 实现组件懒加载
```

**Step 2：声明修改范围**

明确这一步要修改什么：

```
【修改范围】
- 文件：src/App.tsx
- 组件：App
- 修改内容：将 Dashboard 组件改为懒加载
- 预计修改行数：约 5 行
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
- [ ] 当前代码可编译通过（npm run build）
- [ ] 已阅读相关文件
- [ ] Plan 已确认

【修改范围】
- 文件：（具体文件路径）
- 组件/函数：（具体名称）
- 修改内容：（简述）
- 预计修改行数：约 XX 行

【验证方式】
- 编译测试：npm run build
- 开发测试：npm run dev
- 单元测试：npm test
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

使用 `diff` 格式展示改动：

```diff
// src/App.tsx

- import Dashboard from './Dashboard';
+ import { lazy, Suspense } from 'react';
+ const Dashboard = lazy(() => import('./Dashboard'));

  function App() {
    return (
+     <Suspense fallback={<div>Loading...</div>}>
        <Dashboard />
+     </Suspense>
    );
  }
```

### 3. 修改说明

```
【修改理由】
1. 实现组件懒加载
2. 减少初始 Bundle 大小
3. 提升首屏加载速度

【是否引入临时兼容代码】
否

【修改是否超出声明范围】
否，严格按照步骤 2.1 实施
```

### 4. 验证步骤

```
【验证步骤】
1. npm run build（成功）
2. npm run dev（页面正常显示）
3. 检查 Network：Dashboard.js 独立加载
4. Lighthouse 测试：FCP 提升 XX ms
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

### 示例 1：组件懒加载

**用户输入：**
```
执行 plan_performance.md 中：
- 步骤编号：2.1
- 步骤描述：使用 React.lazy 实现组件懒加载

【执行前检查】
- [x] 已创建独立分支（feature/lazy-loading）
- [x] 当前代码可编译通过
- [x] 已确认 Plan

【修改范围】
- 文件：src/App.tsx
- 组件：App
- 预计修改行数：5 行
```

**AI 输出：**
```
✅ 确认执行步骤 2.1：实现组件懒加载

【代码改动】
（diff 格式代码）

【修改理由】
1. Dashboard 组件较大（100KB+）
2. 懒加载可减少初始 Bundle 40%
3. 提升 FCP 约 500ms

【预期收益】
- 初始 Bundle：300KB → 180KB
- FCP：2.5s → 2.0s
```

---

### 示例 2：使用 React.memo 优化

**用户输入：**
```
执行 plan_performance.md 中：
- 步骤编号：2.2
- 步骤描述：使用 React.memo 优化 UserCard 组件

【修改范围】
- 文件：src/components/UserCard.tsx
- 组件：UserCard
- 预计修改行数：3 行
```

**AI 输出：**
```
✅ 确认执行步骤 2.2：优化 UserCard

【代码改动】
// src/components/UserCard.tsx

- export function UserCard({ user }) {
+ export const UserCard = React.memo(({ user }) => {
    return <div>{user.name}</div>;
- }
+ });

【修改理由】
1. UserCard 在列表中重复渲染
2. user prop 引用稳定，适合使用 memo
3. 减少不必要的渲染

【验证】
使用 React DevTools Profiler：
- 优化前：每次父组件更新都重渲染
- 优化后：仅 user 变化时重渲染
```

---

## 【紧急停止】

如果 AI 在执行过程中发现以下情况，必须停止并说明：

1. **需要修改额外文件**
   ```
   ⚠️ 停止执行
   原因：发现需要同时修改 UserList.tsx
   建议：拆分为两个步骤分别执行
   ```

2. **发现 Plan 有问题**
   ```
   ⚠️ 停止执行
   原因：Plan 中的方案在 React 18 中已过时
   建议：使用新的 Concurrent Features
   ```

3. **遇到技术风险**
   ```
   ⚠️ 停止执行
   原因：此改动可能破坏现有的 Error Boundary
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
   git commit -m "perf: 实现步骤 2.1 - 组件懒加载"
   ```
4. ✅ 继续下一步或进行 Code Review

---

## 【总结】

**本模板的唯一目的：让 AI 专注执行一个小步骤，不要失控。**

- 一次只做一件事
- 做完就停下
- 验证通过再继续
- 有问题立即说明

**记住：小步快跑，持续迭代！**
