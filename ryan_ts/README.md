# TypeScript 开发 Prompt 模板集

TypeScript 项目开发、类型系统设计、重构相关的 Claude prompt 模板。用于结构化地规划和执行复杂的 TypeScript 代码变更，确保改动可控、可验证、可回滚。

---

## 模板列表

| 文件 | 用途 | 使用场景 |
|------|------|----------|
| **plan_types.md** | 类型系统设计 | 类型定义/泛型设计/类型推导优化 |
| **plan_migration.md** | JS 迁移 TS | JavaScript 项目迁移到 TypeScript |
| **plan_refactor.md** | 代码重构 | 类型安全重构/消除 any |
| **code_execute_step.md** | 执行控制 | 逐步执行修改，防止失控（最重要） |
| **review_and_rollback.md** | 审查回滚 | 代码审查和回滚策略 |
| **checklist.md** | 审计清单 | 类型安全/性能/可维护性检查 |

---

## 使用流程

### 标准工作流

```
1. 规划阶段 (Plan)
   ↓
   选择对应的 plan_*.md 模板
   填写背景信息和约束条件
   获取分析结果和执行计划

2. 执行阶段 (Execute)
   ↓
   使用 code_execute_step.md 逐步执行
   每步修改范围明确、可验证

3. 审查阶段 (Review)
   ↓
   使用 review_and_rollback.md 进行审查
   对照 checklist.md 进行质量审计
   确认回滚方案

4. 上线阶段 (Deploy)
   ↓
   灰度发布 + 监控告警
```

### 典型使用案例

**案例 1：JavaScript 迁移到 TypeScript**
```
plan_migration.md → code_execute_step.md → checklist.md
```

**案例 2：类型系统设计**
```
plan_types.md → code_execute_step.md → review_and_rollback.md
```

**案例 3：消除 any 类型**
```
plan_refactor.md → code_execute_step.md → checklist.md
```

---

## 设计原则

### 核心理念
- **只分析，不直接写代码**（plan 阶段）
- **偏保守方案优先**
- **每步可验证、可回滚**
- **防失控机制**（code_execute_step.md）

### TypeScript 最佳实践
- 启用 strict 模式
- 避免使用 any 类型
- 合理使用泛型
- 优先使用 type 而非 interface（除非需要声明合并）
- 使用 const assertions 和 as const

---

## 快速开始

### 1. 选择模板

根据你的任务类型选择对应的 plan 模板：
- 类型设计 → `plan_types.md`
- JS 迁移 → `plan_migration.md`
- 代码重构 → `plan_refactor.md`

### 2. 填写背景信息

每个 plan 模板都包含【背景】【目标】【约束】等字段，按实际情况填写。

### 3. 获取执行计划

AI 会输出结构化的分析和执行方案。

### 4. 逐步执行

使用 `code_execute_step.md` 控制每一步的修改范围，确保不失控。

### 5. 审查和验证

使用 `review_and_rollback.md` 和 `checklist.md` 进行质量门禁检查。

---

## 注意事项

⚠️ **code_execute_step.md 是最重要的文件**
- 防止 AI 一次性修改过多代码
- 确保每步修改可验证
- 保证可回滚

⚠️ **checklist.md 用于最终验证**
- 类型安全检查（无 any/unknown 滥用）
- 编译检查（tsc --noEmit 通过）
- 类型推导优化
- 可维护性审计

---

## 技术栈支持

- **TypeScript** 5.0+
- **构建工具：** tsc / esbuild / swc
- **框架集成：** React + TS / Vue + TS / Node.js + TS
- **配置：** tsconfig.json strict 模式

---

## 文件组织

```
typescript/
├── README.md                    # 本文档
├── checklist.md                 # 审计检查清单
├── plan_types.md                # 类型系统设计
├── plan_migration.md            # JS 迁移 TS
├── plan_refactor.md             # 代码重构
├── code_execute_step.md         # 执行控制（防失控）
└── review_and_rollback.md       # 审查与回滚
```

---

## 维护说明

- 各模板文件遵循统一的结构：【背景】→【目标】→【约束】→【输出】
- 所有 plan_*.md 只做分析规划，不直接生成代码
- 使用 code_execute_step.md 时，必须明确步骤编号和修改范围
- 每次大改前，建议先跑一遍 checklist.md
