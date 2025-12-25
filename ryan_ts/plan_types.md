# TypeScript 类型系统设计规划

> 本模板用于规划 TypeScript 项目的类型系统设计

---

## 【使用说明】

**目的：** 输出结构化的类型系统设计方案，不直接写代码。

**适用场景：**
- 新项目类型架构设计
- 复杂业务类型建模
- 泛型设计和类型推导优化
- 类型工具函数设计

---

## 【背景】

### 项目基本信息
- **TypeScript 版本：** （如 5.3.0）
- **项目类型：** （库/应用/工具）
- **编译目标：** （ES2020/ESNext）
- **严格模式：** （是否启用 strict）

### 类型设计需求
- **业务领域：** （电商/社交/工具等）
- **复杂度：** （简单/中等/复杂）
- **类型安全要求：** （宽松/标准/严格）
- **现有类型问题：** （any 滥用/类型推导失效/循环依赖）

### 约束条件
- **兼容性要求：** （是否需要向后兼容）
- **性能要求：** （编译速度/类型检查速度）
- **团队熟悉度：** （初级/中级/高级）
- **现有依赖：** （第三方库的类型定义）

---

## 【请输出】

### 1. 类型架构设计

**核心类型层次：**
```typescript
// 示例结构
基础类型 (primitives)
  ↓
领域模型 (domain models)
  ↓
业务逻辑类型 (business logic)
  ↓
UI/API 类型 (interfaces)
```

**类型组织方式：**
- 按模块组织 vs 按类型组织
- 类型文件命名规范
- 类型导出策略

---

### 2. 泛型设计方案

**常见泛型场景：**

**场景 1：API 响应类型**
```typescript
// 问题：如何设计统一的 API 响应类型？
type ApiResponse<T> = ...

// 考虑点：
- 成功/失败状态
- 错误类型
- 分页数据
- 元数据
```

**场景 2：表单数据类型**
```typescript
// 问题：如何从业务模型自动生成表单类型？
type FormData<T> = ...

// 考虑点：
- 可选字段处理
- 嵌套对象
- 数组字段
```

**场景 3：状态管理类型**
```typescript
// 问题：如何设计类型安全的状态管理？
type State<T> = ...

// 考虑点：
- 不可变更新
- 深度只读
- 部分更新
```

---

### 3. 类型推导优化

**优化策略：**

**1. 利用 const assertions**
```typescript
// 优化前
const config = { api: 'https://api.example.com' };  // string

// 优化后
const config = { api: 'https://api.example.com' } as const;  // literal type
```

**2. 使用泛型约束**
```typescript
// 优化前
function get<T>(obj: any, key: string): T { }

// 优化后
function get<T, K extends keyof T>(obj: T, key: K): T[K] { }
```

**3. 条件类型**
```typescript
// 实现类型变换
type Nullable<T> = T extends object ? { [K in keyof T]: T[K] | null } : T | null;
```

---

### 4. 高级类型技巧

**实用类型工具：**

**1. DeepPartial**
```typescript
// 递归 Partial
type DeepPartial<T> = T extends object
  ? T extends Array<infer U>
    ? Array<DeepPartial<U>>
    : T extends Function
    ? T
    : { [K in keyof T]?: DeepPartial<T[K]> }
  : T;
```

**2. RequireAtLeastOne**
```typescript
// 至少需要一个属性
type RequireAtLeastOne<T, Keys extends keyof T = keyof T> =
  Pick<T, Exclude<keyof T, Keys>> & {
    [K in Keys]-?: Required<Pick<T, K>> & Partial<Pick<T, Exclude<Keys, K>>>
  }[Keys];
```

**3. StrictOmit**
```typescript
// 严格的 Omit（避免拼写错误）
type StrictOmit<T, K extends keyof T> = Pick<T, Exclude<keyof T, K>>;
```

---

### 5. 类型安全实践

**避免 any：**
- 何时可以使用 unknown
- 何时使用类型断言 as
- 如何处理第三方库的 any

**处理 null/undefined：**
- 使用 strictNullChecks
- Optional Chaining (?.)
- Nullish Coalescing (??)

**联合类型和类型守卫：**
```typescript
type Result<T, E> =
  | { success: true; data: T }
  | { success: false; error: E };

function isSuccess<T, E>(result: Result<T, E>): result is { success: true; data: T } {
  return result.success;
}
```

---

### 6. 性能优化

**类型检查性能：**
- 避免过深的类型嵌套（< 5 层）
- 合理使用类型别名缓存
- 避免循环引用

**编译性能：**
- 使用增量编译（incremental）
- 合理拆分 tsconfig.json
- 使用 Project References

---

### 7. 类型测试

**类型测试工具：**
```typescript
// 使用 @typescript-eslint/no-unnecessary-type-assertion
// 使用 tsd 进行类型断言测试

import { expectType } from 'tsd';

expectType<string>(getUserName());
expectType<number | undefined>(getAge());
```

**关键类型测试场景：**
- 泛型推导是否正确
- 类型守卫是否生效
- 条件类型是否符合预期

---

### 8. 与框架集成

**React + TypeScript：**
```typescript
// 组件 Props 类型
type ButtonProps = React.ComponentProps<'button'> & {
  variant: 'primary' | 'secondary';
};

// Hooks 类型
const [state, setState] = useState<User | null>(null);
```

**Node.js + TypeScript：**
```typescript
// Express 请求类型扩展
declare global {
  namespace Express {
    interface Request {
      user?: User;
    }
  }
}
```

---

### 9. 常见问题解决

**问题 1：循环依赖**
```typescript
// 问题
// user.ts
import { Post } from './post';
export interface User { posts: Post[] }

// post.ts
import { User } from './user';
export interface Post { author: User }

// 解决方案：使用类型导入
import type { Post } from './post';
```

**问题 2：类型过宽**
```typescript
// 问题
function process(data: any) { }

// 解决方案：使用泛型约束
function process<T extends { id: string }>(data: T) { }
```

**问题 3：第三方库类型缺失**
```typescript
// 创建 types/ 目录
// types/my-lib.d.ts
declare module 'my-lib' {
  export function doSomething(): void;
}
```

---

### 10. 实施计划

**阶段 1：基础类型定义**
- [ ] 定义核心业务模型类型
- [ ] 定义 API 响应类型
- [ ] 定义错误类型

**阶段 2：高级类型工具**
- [ ] 实现通用类型工具
- [ ] 设计泛型组件类型
- [ ] 优化类型推导

**阶段 3：类型测试和文档**
- [ ] 编写类型测试
- [ ] 编写类型使用文档
- [ ] Code Review 规范

**时间评估：**
- 基础类型：X 天
- 高级类型：X 天
- 测试文档：X 天

**风险评估：**
- 风险 1：团队学习曲线 → 缓解：提供培训
- 风险 2：编译性能下降 → 缓解：性能监控

---

## 【输出要求】

1. **完整性：** 必须输出以上 10 项内容
2. **具体性：** 给出具体的类型定义示例
3. **可操作性：** 每个建议都要可落地执行
4. **最佳实践：** 遵循 TypeScript 最佳实践

---

## 【注意事项】

⚠️ **本模板仅做规划分析，不直接生成代码**

✅ **输出后续步骤：**
1. 将输出结果作为技术方案文档
2. 团队评审确认方案
3. 使用 `code_execute_step.md` 逐步实施
4. 使用 `review_and_rollback.md` 审查改动
5. 使用 `checklist.md` 最终验证
