# Flutter 开发 Prompt 模板集

Flutter 项目开发、性能优化、状态管理相关的 Claude prompt 模板。用于结构化地规划和执行复杂的 Flutter 代码变更，确保改动可控、可验证、可回滚。

---

## 模板列表

| 文件 | 用途 | 使用场景 |
|------|------|----------|
| **USAGE.md** | 📖 使用指南 | **新手必读** - 如何使用这些模板 |
| **plan_state_management.md** | 状态管理 | Provider/Riverpod/Bloc 方案选型和设计 |
| **plan_performance.md** | 性能优化 | 卡顿/内存泄漏/渲染问题分析 |
| **plan_architecture.md** | 架构规划 | 大型 Flutter 应用架构设计 |
| **plan_platform_channel.md** | 平台通道 | 原生交互/MethodChannel 设计 |
| **code_execute_step.md** | 执行控制 | 逐步执行修改，防止失控（最重要） |
| **review_and_rollback.md** | 审查回滚 | 代码审查和回滚策略 |
| **checklist.md** | 审计清单 | 性能/内存/平台兼容性检查 |

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
   对照 checklist.md 进行性能/内存审计
   确认回滚方案

4. 上线阶段 (Deploy)
   ↓
   灰度发布 + 监控告警
```

### 典型使用案例

**案例 1：状态管理选型**
```
plan_state_management.md → code_execute_step.md → review_and_rollback.md
```

**案例 2：性能优化**
```
plan_performance.md → checklist.md（验证） → code_execute_step.md → review_and_rollback.md
```

**案例 3：原生集成**
```
plan_platform_channel.md → code_execute_step.md → review_and_rollback.md
```

---

## 设计原则

### 核心理念
- **只分析，不直接写代码**（plan 阶段）
- **偏保守方案优先**
- **每步可验证、可回滚**
- **防失控机制**（code_execute_step.md）

### 约束边界
- 遵循 Flutter 最佳实践
- 避免过度嵌套的 Widget 树
- 控制包依赖数量和大小
- 兼容目标平台版本

---

## 快速开始

### 0. 新手必读

**首次使用？** 请先阅读 `USAGE.md` 了解详细的使用方法和完整案例。

### 1. 选择模板

根据你的任务类型选择对应的 plan 模板：
- 状态管理 → `plan_state_management.md`
- 性能优化 → `plan_performance.md`
- 架构设计 → `plan_architecture.md`
- 原生交互 → `plan_platform_channel.md`

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
- 性能审计（帧率/内存/包体积）
- 平台兼容性（iOS/Android/Web）
- 状态管理规范
- 资源释放检查

---

## 文件组织

```
flutter/
├── README.md                    # 本文档
├── USAGE.md                     # 使用指南（新手必读）
├── checklist.md                 # 审计检查清单
├── plan_state_management.md     # 状态管理方案
├── plan_performance.md          # 性能优化
├── plan_architecture.md         # 架构设计
├── plan_platform_channel.md     # 平台通道
├── code_execute_step.md         # 执行控制（防失控）
└── review_and_rollback.md       # 审查与回滚
```

---

## 维护说明

- 各模板文件遵循统一的结构：【背景】→【目标】→【约束】→【输出】
- 所有 plan_*.md 只做分析规划，不直接生成代码
- 使用 code_execute_step.md 时，必须明确步骤编号和修改范围
- 每次大改前，建议先跑一遍 checklist.md
