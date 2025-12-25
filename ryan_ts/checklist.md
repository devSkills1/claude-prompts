# TypeScript 开发审计检查清单

> 发布前/Code Review 时的完整检查清单

---

## 使用说明

**用途：** 在以下场景使用此清单
- 重要功能发布前
- Code Review 时
- 类型重构后验证
- 定期代码审计

**使用方式：**
1. 逐项检查，标记 `[x]` 表示通过
2. 发现问题记录并修复
3. 全部通过后方可发布

---

## 1. 类型安全检查

### 1.1 类型覆盖率

**P0 - 必须检查：**
- [ ] tsc --noEmit 编译通过（无错误）
- [ ] 无显式 any 类型（除非必要）
- [ ] 无隐式 any（noImplicitAny: true）
- [ ] 无类型断言滥用（尽量避免 as）
- [ ] 函数返回值有明确类型

**P1 - 建议检查：**
- [ ] 使用 unknown 替代 any
- [ ] 复杂类型有注释说明
- [ ] 第三方库有类型定义（@types/*）

**检查工具：**
```bash
# 严格编译检查
tsc --noEmit --strict

# 查找 any 使用
grep -r ": any" src/
```

---

### 1.2 空值安全

**P0 - 必须检查：**
- [ ] strictNullChecks 已启用
- [ ] 可空值使用 Optional Chaining (?.)
- [ ] 默认值使用 Nullish Coalescing (??)
- [ ] 函数参数可选性明确（?: vs | undefined）

**示例：**
```typescript
// ✅ 好的做法
const name = user?.profile?.name ?? 'Guest';

// ❌ 避免
const name = user && user.profile && user.profile.name || 'Guest';
```

---

### 1.3 类型推导

**P0 - 必须检查：**
- [ ] 泛型约束正确（extends）
- [ ] 类型守卫正确实现（is/in）
- [ ] 联合类型正确区分
- [ ] 字面量类型使用 as const

**P1 - 建议检查：**
- [ ] 复杂推导有类型测试
- [ ] 避免过度嵌套（< 5 层）
- [ ] 使用 satisfies 验证类型

---

## 2. 代码质量

### 2.1 类型定义规范

**P0 - 必须检查：**
- [ ] 接口命名清晰（无 I 前缀）
- [ ] 类型别名 vs 接口使用合理
- [ ] 枚举使用 const enum（如适用）
- [ ] 泛型命名有意义（不只是 T）

**命名规范：**
```typescript
// ✅ 好的命名
interface User { }
type UserId = string;
type ApiResponse<TData, TError> = ...

// ❌ 避免
interface IUser { }  // 不使用 I 前缀
type T1 = ...        // 无意义命名
```

---

### 2.2 类型组织

**P0 - 必须检查：**
- [ ] 类型定义文件位置合理
- [ ] 共享类型统一管理
- [ ] 类型导入使用 import type
- [ ] 避免循环依赖

**文件组织：**
```
src/
├── types/
│   ├── index.ts       # 统一导出
│   ├── user.ts        # 用户相关
│   └── api.ts         # API 相关
│
├── models/
│   └── User.ts        # 业务模型
```

---

### 2.3 严格模式配置

**P0 - 必须检查：**
- [ ] strict: true 已启用
- [ ] noImplicitAny: true
- [ ] strictNullChecks: true
- [ ] strictFunctionTypes: true
- [ ] noUnusedLocals: true
- [ ] noUnusedParameters: true

**tsconfig.json 检查：**
```json
{
  "compilerOptions": {
    "strict": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true,
    "noImplicitReturns": true,
    "noFallthroughCasesInSwitch": true
  }
}
```

---

### 2.4 API 使用规范

**P0 - 必须检查：**
- [ ] **是否使用已废弃 (deprecated) 的 API**
  - 检查 TypeScript 编译警告中的 deprecated 提示
  - 必须替换为官方推荐的新 API
  - 使用 ESLint 规则 `deprecation/deprecation` 检测
- [ ] 第三方库是否使用已废弃的 API
- [ ] 自定义代码使用 @deprecated 标记废弃功能

**P1 - 建议检查：**
- [ ] 定期检查依赖库的 CHANGELOG 和 Breaking Changes
- [ ] 使用 TypeScript 最新稳定版本的新特性

**废弃 API 检测工具：**

```bash
# 安装 ESLint 废弃检测插件
npm install -D eslint-plugin-deprecation @typescript-eslint/parser

# .eslintrc.json 配置
{
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "project": "./tsconfig.json"
  },
  "plugins": ["deprecation"],
  "rules": {
    "deprecation/deprecation": "error"
  }
}

# 运行检测
npm run lint
```

**使用 @deprecated 标记示例：**

```typescript
/**
 * @deprecated 使用 getUserById() 替代，将在 v3.0 移除
 */
function getUser(id: string): User {
  return getUserById(id);
}

/**
 * 推荐的新 API
 */
function getUserById(id: string): User {
  // ...
}
```

**常见废弃场景：**

```typescript
// ❌ 使用了标记为 @deprecated 的 API
import { oldFunction } from 'some-lib';
oldFunction();  // TypeScript 会显示删除线警告

// ✅ 使用推荐的新 API
import { newFunction } from 'some-lib';
newFunction();
```

**TypeScript 原生 @deprecated 支持：**
- TypeScript 4.0+ 原生支持 @deprecated JSDoc 标签
- IDE 会显示删除线（strikethrough）提示
- 编译器本身不会报错，只有 IDE 和 ESLint 插件会提示
- 无需额外配置即可在 tsconfig.json 中使用

---

## 3. 性能检查

### 3.1 编译性能

**P0 - 必须检查：**
- [ ] 编译时间 < 30 秒（中型项目）
- [ ] 类型检查时间合理
- [ ] 无不必要的类型重计算

**P1 - 建议检查：**
- [ ] 使用增量编译（incremental: true）
- [ ] 合理拆分 tsconfig.json
- [ ] 使用 Project References

**性能监控：**
```bash
# 分析编译性能
tsc --extendedDiagnostics

# 查看类型检查耗时
tsc --diagnostics
```

---

### 3.2 运行时性能

**P0 - 必须检查：**
- [ ] 枚举使用 const enum（减少 bundle）
- [ ] 类型工具不影响运行时
- [ ] 装饰器使用合理

**Bundle 优化：**
```typescript
// ✅ const enum（编译时内联）
const enum Direction {
  Up,
  Down
}

// ⚠️ 普通 enum（生成运行时代码）
enum Direction {
  Up = 'UP',
  Down = 'DOWN'
}
```

---

## 4. 错误处理

### 4.1 类型安全的错误处理

**P0 - 必须检查：**
- [ ] 错误类型明确定义
- [ ] 使用 Result<T, E> 模式（如适用）
- [ ] 异步错误正确处理
- [ ] 自定义错误类型有类型守卫

**错误类型设计：**
```typescript
// Result 模式
type Result<T, E = Error> =
  | { success: true; data: T }
  | { success: false; error: E };

// 自定义错误
class ValidationError extends Error {
  constructor(public field: string) {
    super(`Validation failed: ${field}`);
  }
}

// 类型守卫
function isValidationError(error: unknown): error is ValidationError {
  return error instanceof ValidationError;
}
```

---

## 5. 第三方库集成

### 5.1 类型定义

**P0 - 必须检查：**
- [ ] 所有依赖有类型定义
- [ ] @types/* 版本与库版本匹配
- [ ] 自定义类型声明正确

**P1 - 建议检查：**
- [ ] 检查 DefinitelyTyped 更新
- [ ] 缺失类型自行补充（types/）

**类型声明示例：**
```typescript
// types/my-lib.d.ts
declare module 'my-lib' {
  export function doSomething(arg: string): void;
}
```

---

### 5.2 框架特定检查

**React + TypeScript：**
- [ ] 组件 Props 有类型定义
- [ ] 事件处理器类型正确
- [ ] Hooks 使用类型正确
- [ ] ref 类型正确

**Node.js + TypeScript：**
- [ ] Express 类型扩展正确
- [ ] 环境变量有类型定义
- [ ] 中间件类型正确

---

## 6. 可维护性

### 6.1 类型复杂度

**P0 - 必须检查：**
- [ ] 复杂类型有注释
- [ ] 类型嵌套 < 5 层
- [ ] 条件类型有示例
- [ ] 泛型参数 < 4 个

**可读性示例：**
```typescript
// ✅ 有注释的复杂类型
/**
 * 深度转换对象所有属性为只读
 * @example
 * type A = { a: { b: number } }
 * type B = DeepReadonly<A>  // { readonly a: { readonly b: number } }
 */
type DeepReadonly<T> = {
  readonly [K in keyof T]: T[K] extends object
    ? DeepReadonly<T[K]>
    : T[K];
};
```

---

### 6.2 类型重用

**P0 - 必须检查：**
- [ ] 重复类型已提取
- [ ] 通用类型工具已封装
- [ ] 类型别名有意义

**P1 - 建议检查：**
- [ ] 建立类型工具库
- [ ] 类型有使用文档

---

## 7. 测试覆盖

### 7.1 类型测试

**P0 - 必须检查：**
- [ ] 核心类型有测试
- [ ] 泛型推导有测试
- [ ] 类型守卫有测试

**类型测试工具：**
```typescript
// 使用 tsd
import { expectType, expectError } from 'tsd';

// 测试类型推导
expectType<string>(getUserName());

// 测试类型错误
expectError(processUser(123));  // 应该报错
```

---

### 7.2 单元测试

**P0 - 必须检查：**
- [ ] 核心功能有单元测试
- [ ] 类型守卫有测试
- [ ] 边界情况有测试

---

## 8. 文档和注释

### 8.1 类型文档

**P0 - 必须检查：**
- [ ] 公共 API 有 JSDoc 注释
- [ ] 泛型参数有说明
- [ ] 复杂类型有示例

**JSDoc 示例：**
```typescript
/**
 * 获取用户信息
 * @param userId - 用户 ID
 * @returns 用户对象，如果不存在返回 null
 * @example
 * const user = await getUser('123');
 */
async function getUser(userId: string): Promise<User | null> { }
```

---

### 8.2 类型注释

**P1 - 建议检查：**
- [ ] 非显而易见的类型有注释
- [ ] 类型变换有解释
- [ ] 已知限制有说明

---

## 9. 迁移和兼容性

### 9.1 JavaScript 兼容

**P0 - 必须检查：**
- [ ] allowJs 配置正确
- [ ] checkJs 渐进启用
- [ ] 迁移路径清晰

---

### 9.2 版本兼容

**P0 - 必须检查：**
- [ ] TypeScript 版本 >= 5.0
- [ ] 使用的特性在目标版本支持
- [ ] target 配置合理

---

## 10. 发布准备

### 10.1 构建检查

**P0 - 必须检查：**
- [ ] npm run build 成功
- [ ] 类型声明文件生成（.d.ts）
- [ ] 源码映射正确（sourceMap）
- [ ] package.json types 字段正确

**发布配置：**
```json
{
  "main": "dist/index.js",
  "types": "dist/index.d.ts",
  "files": ["dist"]
}
```

---

### 10.2 最终验证

**P0 - 必须检查：**
- [ ] 所有 TypeScript 错误已修复
- [ ] ESLint 通过
- [ ] 单元测试通过
- [ ] 类型测试通过

**检查命令：**
```bash
# 完整检查流程
npm run type-check  # tsc --noEmit
npm run lint       # eslint
npm run test       # jest/vitest
npm run build      # 构建
```

---

## 审计结论模板

**审计时间：** YYYY-MM-DD

**审计范围：** （功能模块/包）

**TypeScript 配置：**
- 版本：X.X.X
- strict 模式：✅/❌
- 目标版本：ES2020

**检查结果：**
- ✅ 通过项：XX 项
- ⚠️ 警告项：XX 项（需优化但不阻塞发布）
- ❌ 阻断项：XX 项（必须修复）

**类型覆盖率：**
- any 使用次数：XX 次
- 类型错误数：XX 个
- 编译时间：XX 秒

**阻断问题：**
1. 问题描述
   - 严重程度：P0
   - 修复方案：
   - 预计修复时间：

**结论：** ✅ 可发布 / ❌ 需修复后再发布

**审计人：** XXX
