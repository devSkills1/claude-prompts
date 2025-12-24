# React 开发 Prompt 模板集

React 项目开发、性能优化、架构设计相关的 Claude prompt 模板。用于结构化地规划和执行复杂的 React 代码变更，确保改动可控、可验证、可回滚。

---

## 模板列表

| 文件 | 用途 | 使用场景 |
|------|------|----------|
| **plan_architecture.md** | 架构规划 | 组件设计/状态管理/路由方案 |
| **plan_performance.md** | 性能优化 | 渲染优化/包体积/加载速度 |
| **plan_hooks.md** | Hooks 设计 | 自定义 Hooks/逻辑复用 |
| **plan_accessibility.md** | 无障碍设计 | a11y/键盘导航/屏幕阅读器 |
| **code_execute_step.md** | 执行控制 | 逐步执行修改，防止失控（最重要） |
| **review_and_rollback.md** | 审查回滚 | 代码审查和回滚策略 |
| **checklist.md** | 审计清单 | 性能/无障碍/SEO/安全检查 |

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

**案例 1：组件架构设计**
```
plan_architecture.md → code_execute_step.md → review_and_rollback.md
```

**案例 2：性能优化**
```
plan_performance.md → checklist.md（验证） → code_execute_step.md
```

**案例 3：自定义 Hooks**
```
plan_hooks.md → code_execute_step.md → review_and_rollback.md
```

---

## 设计原则

### 核心理念
- **只分析，不直接写代码**（plan 阶段）
- **偏保守方案优先**
- **每步可验证、可回滚**
- **防失控机制**（code_execute_step.md）

### 约束边界
- 遵循 React 最佳实践
- 避免过度抽象
- 控制包依赖数量和大小
- 兼容目标浏览器版本

---

## 快速开始

### 1. 选择模板

根据你的任务类型选择对应的 plan 模板：
- 架构设计 → `plan_architecture.md`
- 性能优化 → `plan_performance.md`
- Hooks 设计 → `plan_hooks.md`
- 无障碍 → `plan_accessibility.md`

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
- 性能审计（LCP/FID/CLS）
- 无障碍检查（WCAG 2.1）
- SEO 优化
- 安全漏洞（XSS/CSRF）

---

## 文件组织

```
react/
├── README.md                    # 本文档
├── checklist.md                 # 审计检查清单
├── plan_architecture.md         # 架构设计
├── plan_performance.md          # 性能优化
├── plan_hooks.md                # Hooks 设计
├── plan_accessibility.md        # 无障碍设计
├── code_execute_step.md         # 执行控制（防失控）
└── review_and_rollback.md       # 审查与回滚
```

---

## 技术栈支持

- **React** 18+
- **Next.js** 13+ (App Router / Pages Router)
- **状态管理：** Redux Toolkit / Zustand / Jotai / Recoil
- **样式方案：** CSS Modules / Tailwind CSS / Styled Components
- **构建工具：** Vite / Webpack / Turbopack

---

## 维护说明

- 各模板文件遵循统一的结构：【背景】→【目标】→【约束】→【输出】
- 所有 plan_*.md 只做分析规划，不直接生成代码
- 使用 code_execute_step.md 时，必须明确步骤编号和修改范围
- 每次大改前，建议先跑一遍 checklist.md
