# TypeScript 代码执行步骤控制

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

从 Plan 文档（如 `plan_types.md`）中选择一个具体步骤：

```
Plan 文档名：plan_types.md
步骤编号：2.1
步骤描述：定义核心 API 响应类型
```

**Step 2：声明修改范围**

明确这一步要修改什么：

```
【修改范围】
- 文件：src/types/api.ts
- 修改内容：新增 ApiResponse<T> 泛型类型
- 预计修改行数：约 20 行
```

**Step 3：执行前检查**

确认以下条件：
- [ ] 已创建独立的 Git 分支
- [ ] 当前代码可编译通过（tsc --noEmit）
- [ ] 已阅读相关代码文件
- [ ] Plan 文档步骤已确认

**Step 4：执行修改**

AI 现在可以执行这一步的代码修改。

**Step 5：执行后验证**

- [ ] tsc --noEmit 编译通过
- [ ] 类型测试通过（如有）
- [ ] ESLint 检查通过
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
- [ ] tsc --noEmit 编译通过
- [ ] 已阅读相关文件
- [ ] Plan 已确认

【修改范围】
- 文件：（具体文件路径）
- 类型/函数：（具体名称）
- 修改内容：（简述）
- 预计修改行数：约 XX 行

【验证方式】
- 类型检查：tsc --noEmit
- Lint 检查：npm run lint
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

使用 `diff` 格式或完整代码展示改动：

```typescript
// src/types/api.ts

/**
 * 统一的 API 响应类型
 * @template TData 成功时的数据类型
 * @template TError 失败时的错误类型
 */
export type ApiResponse<TData, TError = Error> =
  | { success: true; data: TData }
  | { success: false; error: TError };

/**
 * 分页响应类型
 */
export interface PaginatedResponse<T> {
  items: T[];
  total: number;
  page: number;
  pageSize: number;
}
```

### 3. 修改说明

```
【修改理由】
1. 定义统一的 API 响应类型，确保类型安全
2. 使用联合类型区分成功/失败状态
3. 支持自定义错误类型

【类型安全改进】
- 使用类型守卫可以正确推导 data/error
- 编译时检查所有 API 响应

【是否引入临时兼容代码】
否

【修改是否超出声明范围】
否，严格按照步骤 2.1 实施
```

### 4. 验证步骤

```
【验证步骤】
1. tsc --noEmit（✅ 无类型错误）
2. npm run lint（✅ 通过）
3. 类型测试：
   - ApiResponse 类型推导正确
   - 类型守卫生效
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

6. ❌ **使用 any 类型**
   - 除非在 Plan 中明确说明，否则禁止使用 any

---

## 【示例】

### 示例 1：定义 API 响应类型

**用户输入：**
```
执行 plan_types.md 中：
- 步骤编号：2.1
- 步骤描述：定义统一 API 响应类型

【执行前检查】
- [x] 已创建独立分支（feature/api-types）
- [x] tsc --noEmit 通过
- [x] 已确认 Plan

【修改范围】
- 文件：src/types/api.ts
- 新增类型：ApiResponse<T>
- 预计修改行数：15 行
```

**AI 输出：**
```
✅ 确认执行步骤 2.1：定义 API 响应类型

【代码改动】
// src/types/api.ts
（完整代码）

【修改理由】
1. 统一 API 响应格式
2. 利用联合类型实现类型安全
3. 支持泛型自定义数据类型

【类型推导验证】
// 示例使用
const response: ApiResponse<User> = await fetchUser();

if (response.success) {
  console.log(response.data);  // ✅ User 类型
} else {
  console.error(response.error);  // ✅ Error 类型
}
```

---

### 示例 2：添加类型守卫

**用户输入：**
```
执行 plan_types.md 中：
- 步骤编号：2.2
- 步骤描述：为 ApiResponse 添加类型守卫

【修改范围】
- 文件：src/types/api.ts
- 新增函数：isSuccess
- 预计修改行数：10 行
```

**AI 输出：**
```
✅ 确认执行步骤 2.2：添加类型守卫

【代码改动】
// src/types/api.ts

export function isSuccess<TData, TError>(
  response: ApiResponse<TData, TError>
): response is { success: true; data: TData } {
  return response.success;
}

【修改理由】
1. 提供类型守卫函数简化使用
2. 利用 TypeScript 的类型收窄
3. 提升代码可读性

【使用示例】
const response = await fetchUser();

if (isSuccess(response)) {
  console.log(response.data);  // ✅ 自动推导为 User
}
```

---

## 【紧急停止】

如果 AI 在执行过程中发现以下情况，必须停止并说明：

1. **需要修改额外文件**
   ```
   ⚠️ 停止执行
   原因：发现需要同时修改 user.ts 中的类型
   建议：拆分为两个步骤分别执行
   ```

2. **发现 Plan 有问题**
   ```
   ⚠️ 停止执行
   原因：Plan 中的类型设计在 TypeScript 5.x 中有更好的方案
   建议：使用 satisfies 操作符代替类型断言
   ```

3. **遇到技术风险**
   ```
   ⚠️ 停止执行
   原因：此类型修改可能破坏现有代码的类型推导
   建议：先进行影响分析
   ```

4. **类型检查失败**
   ```
   ⚠️ 停止执行
   原因：tsc 报告了 3 个类型错误
   建议：先修复类型错误
   ```

---

## 【执行完成后】

每步执行完成后，用户应该：

1. ✅ 查看 git diff
2. ✅ 运行验证测试
   ```bash
   tsc --noEmit
   npm run lint
   npm test
   ```
3. ✅ 提交代码
   ```bash
   git add .
   git commit -m "feat(types): 实现步骤 2.1 - 定义 API 响应类型"
   ```
4. ✅ 继续下一步或进行 Code Review

---

## 【总结】

**本模板的唯一目的：让 AI 专注执行一个小步骤，不要失控。**

- 一次只做一件事
- 做完就停下
- 验证通过再继续
- 有问题立即说明
- **类型安全优先**

**记住：TypeScript 的价值在于类型安全，每一步都要确保类型正确！**
