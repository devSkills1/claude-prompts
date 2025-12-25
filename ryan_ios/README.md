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
ryan_ios/
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

### 1. 模板说明

#### 通用理念模板（针对 iOS 优化）

以下模板在所有技术栈中具有相同的设计理念，但本目录版本已针对 iOS 工具链和最佳实践优化：

- **code_execute_step.md** - 逐步执行控制（防 AI 失控）
  - 核心理念：一次只执行一个小步骤，确保可控可回滚
  - iOS 优化：集成 Git、Xcode 构建、单元测试验证流程
  - 示例代码：Objective-C/Swift 语法

- **review_and_rollback.md** - 代码审查与回滚
  - 核心理念：P0/P1/P2 分级审查，确保质量和可回滚性
  - iOS 优化：App Store 审核风险检查、私有 API 检测、KVO/Block 内存管理
  - 检查项：iOS 特定的崩溃率、性能指标

💡 **使用提示：** 这些模板虽然名称与其他技术栈相同，但内容已针对 iOS 深度优化，直接使用即可获得最佳体验。

#### iOS 专属模板

- **plan_architecture.md** - 架构/模块设计（iOS MVC/MVVM/VIPER）
- **plan_security.md** - 安全防护（反调试/反 Hook/越狱检测）
- **plan_performance.md** - 性能优化（主线程卡顿/OOM/启动优化）
- **plan_refactor_legacy.md** - Objective-C 老代码重构
- **plan_logging.md** - 日志系统（异步/崩溃保护）
- **checklist.md** - iOS 审计清单（安全/性能/审核）

---

### 2. 选择模板

根据你的任务类型选择对应的 plan 模板：
- 架构调整 → `plan_architecture.md`
- 安全加固 → `plan_security.md`
- 性能问题 → `plan_performance.md`
- 重构老代码 → `plan_refactor_legacy.md`
- 日志优化 → `plan_logging.md`

#### 模板选择速查表

| 任务场景 | 推荐组合 | 备注 |
|----------|----------|------|
| 大型架构演进 | `plan_architecture.md` → `code_execute_step.md` → `review_and_rollback.md` | 方案评审后再逐步实施 |
| 安全防护/越狱检测 | `plan_security.md` → `code_execute_step.md` → `checklist.md` | 重点关注 P0/P1 安全项 |
| 主线程卡顿/性能瓶颈 | `plan_performance.md` → `code_execute_step.md` → `review_and_rollback.md` | 执行阶段配合性能指标验证 |
| Objective-C 老代码重构 | `plan_refactor_legacy.md` → `code_execute_step.md` → `checklist.md` | 每次仅处理一个方法/类 |
| 日志系统/埋点优化 | `plan_logging.md` → `code_execute_step.md` → `review_and_rollback.md` | 需验证隐私/合规性 |

若任务跨多个领域，可按优先级组合多个 plan，例如“安全 + 性能”分别输出方案，再用 `code_execute_step.md` 串联执行顺序。

### 2. 填写背景信息

每个 plan 模板都包含【背景】【目标】【约束】等字段，按实际情况填写。

### 3. 获取执行计划

AI 会输出结构化的分析和执行方案。

> 建议：将 AI 输出直接保存到需求/技术方案文档中，便于评审与后续追踪。

### 4. 逐步执行

使用 `code_execute_step.md` 控制每一步的修改范围，确保不失控。

执行时可以将同一 plan 的步骤拆成编号链路（如 2.1、2.2），逐条喂给 `code_execute_step.md`，并在 diff 中标注“步骤编号 + 影响文件”，方便审查。

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
