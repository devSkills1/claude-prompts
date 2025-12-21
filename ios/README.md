# iOS 开发 Prompt 模板集

iOS 项目开发、重构、安全审计相关的 Claude prompt 模板。用于结构化地规划和执行复杂的 iOS 代码变更，确保改动可控、可验证、可回滚。

---

## 模板列表

| 文件 | 用途 | 使用场景 |
|------|------|----------|
| **USAGE.md** | 📖 使用指南 | **新手必读** - 如何使用这些模板 |
| **plan_architecture.md** | 架构规划 | 大型架构改动前的分析和方案设计 |
| **plan_security.md** | 安全检测 | 反调试/反Hook/反注入/反重签名 |
| **plan_performance.md** | 性能优化 | 主线程卡顿/崩溃/OOM 问题分析 |
| **plan_refactor_legacy.md** | 老代码重构 | Objective-C 遗留代码优化 |
| **plan_logging.md** | 日志系统 | 异步日志/崩溃保护设计 |
| **code_execute_step.md** | 执行控制 | 逐步执行修改，防止失控（最重要） |
| **review_and_rollback.md** | 审查回滚 | 代码审查和回滚策略 |
| **checklist.md** | 审计清单 | 安全/性能/稳定性/审核风险检查 |

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
   对照 checklist.md 进行安全/性能审计
   确认回滚方案

4. 上线阶段 (Deploy)
   ↓
   灰度发布 + 监控告警
```

### 典型使用案例

**案例 1：重构老代码**
```
plan_refactor_legacy.md → code_execute_step.md → review_and_rollback.md
```

**案例 2：新增安全防护**
```
plan_security.md → checklist.md（验证） → code_execute_step.md → review_and_rollback.md
```

**案例 3：架构调整**
```
plan_architecture.md → code_execute_step.md（分步执行） → review_and_rollback.md
```

---

## 设计原则

### 核心理念
- **只分析，不直接写代码**（plan 阶段）
- **偏保守方案优先**
- **每步可验证、可回滚**
- **防失控机制**（code_execute_step.md）

### 约束边界
- 不使用私有 API
- 不影响审核通过率
- 不显著增加启动时间
- 不引入新的三方依赖（除非必要）

---

## 文件组织

```
ios/
├── README.md                    # 本文档
├── USAGE.md                     # 使用指南（新手必读）
├── checklist.md                 # 审计检查清单
├── plan_architecture.md         # 架构/模块设计
├── plan_security.md             # 安全防护
├── plan_performance.md          # 性能优化
├── plan_refactor_legacy.md      # 老代码重构
├── plan_logging.md              # 日志系统
├── code_execute_step.md         # 执行控制（防失控）
└── review_and_rollback.md       # 审查与回滚
```

---

## 快速开始

### 0. 新手必读

**首次使用？** 请先阅读 `USAGE.md` 了解详细的使用方法和完整案例。

### 1. 选择模板

根据你的任务类型选择对应的 plan 模板：
- 架构调整 → `plan_architecture.md`
- 安全加固 → `plan_security.md`
- 性能问题 → `plan_performance.md`
- 重构老代码 → `plan_refactor_legacy.md`
- 日志优化 → `plan_logging.md`

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
- 安全审计（反调试/反Hook/反注入）
- 性能审计（主线程/I/O/RunLoop）
- 稳定性审计（防御式编程/OOM）
- 审核风险（私有API/越权访问）

---

## 维护说明

- 各模板文件遵循统一的结构：【背景】→【目标】→【约束】→【输出】
- 所有 plan_*.md 只做分析规划，不直接生成代码
- 使用 code_execute_step.md 时，必须明确步骤编号和修改范围
- 每次大改前，建议先跑一遍 checklist.md