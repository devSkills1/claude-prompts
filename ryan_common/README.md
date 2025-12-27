# ryan_common - 通用分析模板

这个目录包含跨技术栈的通用分析和接手模板，适用于项目评估、接手和可行性分析场景。

## 📚 模板列表

### 1. Idea-Feasibility-Analysis.md
**创意可行性分析模板**

用于评估从 0 到 1 的产品想法是否值得投入开发。

**核心功能：**
- 目标用户与真实需求分析
- 竞品与市场格局评估
- 技术可行性与商业化分析
- 量化估算（用户规模、LTV、CAC）
- 结构化风险矩阵
- MVP 建议与时间线规划
- Go/No-Go/Conditional Go 三级决策

**适用场景：**
- 评估新产品创意
- 个人/小团队创业决策
- 内部创新项目立项评审

**引用方式：**
```
@ryan_common/Idea-Feasibility-Analysis.md

我有一个想法：[描述你的想法]
```

---

### 2. Project-Handover-Guide.md
**GitHub 项目接手指南模板**

快速理解并接手 GitHub 开源项目或他人维护的代码仓库。

**核心功能：**
- 项目本质与技术栈分析
- 环境搭建与验证（可直接执行的命令）
- 系统架构理解（多类型 Mermaid 图表）
- 核心业务链路与异常处理分析
- 关键代码地图
- 项目健康度评分矩阵
- 3 天接手计划

**适用场景：**
- 接手离职同事的项目
- 学习开源项目源码
- 快速理解新团队代码库

**引用方式：**
```
@ryan_common/Project-Handover-Guide.md

这是我的项目：[项目路径或描述]
```

---

### 3. SDK-Handover-Guide.md
**公司 SDK 接手指南模板**

安全接手公司内部 SDK、基础库或平台型项目。

**核心功能：**
- SDK 本质判断与对外能力分析
- 文档与知识资产评估
- 版本兼容性设计分析
- 依赖关系与外部集成
- 内部架构拆解（多类型 Mermaid 图表）
- 质量保障与验证机制
- "不可轻动区" 识别
- 安全接手与演进建议

**适用场景：**
- 接手公司核心 SDK
- 维护多业务依赖的基础库
- 接管历史遗留的平台项目

**引用方式：**
```
@ryan_common/SDK-Handover-Guide.md

这是我们公司的 SDK：[SDK 路径或描述]
```

---

### 4. Bug-Root-Cause-Analysis.md
**Bug 调试与根因分析模板**

系统化定位 Bug 根本原因，并给出可验证、可回滚的修复方案。

**核心功能：**
- 问题现象完整描述
- 复现路径与条件
- 相关证据收集（日志、网络请求、数据库状态）
- 问题定位与模块分析
- 根因分析（5 Whys 方法）
- 修复方案对比（临时方案 vs 根本方案）
- 回归验证清单
- 防止复发措施

**适用场景：**
- 线上 bug 紧急修复
- 复杂 bug 的系统性排查
- 防止"治标不治本"

**引用方式：**
```
@ryan_common/Bug-Root-Cause-Analysis.md

我遇到了一个 Bug：[问题描述]
```

---

### 5. Architecture-Decision-Record.md
**技术选型与架构决策记录模板 (ADR)**

系统化对比候选方案，输出结构化的架构决策记录。

**核心功能：**
- 决策背景与约束条件
- 候选方案列表（至少 2-3 个）
- 方案对比矩阵（1-5 分制，10+ 维度）
- 风险评估（每个方案的风险矩阵）
- 成本收益分析
- 实施路径与时间规划
- 决策后的行动计划
- 决策复盘机制

**适用场景：**
- 选择状态管理方案（Redux vs MobX vs Zustand）
- 选择数据库（MySQL vs PostgreSQL vs MongoDB）
- 选择部署方案（Docker vs Kubernetes vs Serverless）

**引用方式：**
```
@ryan_common/Architecture-Decision-Record.md

我们需要选择：[技术选型场景]
```

---

### 6. Production-Incident-Postmortem.md
**生产事故复盘模板 (Post-mortem)**

遵循 Blameless 原则，系统化复盘事故，提炼经验教训。

**核心功能：**
- 事故基本信息（等级、类型、影响范围）
- 事故时间线（精确到分钟级别）
- 根本原因分析（5 Whys）
- 影响范围详细评估
- 应急响应过程评估
- 临时修复 vs 长期改进措施
- 监控与告警改进
- 知识沉淀与团队培训

**适用场景：**
- 线上故障后的复盘
- 定期事故回顾会议
- 新人培训案例

**引用方式：**
```
@ryan_common/Production-Incident-Postmortem.md

我们遇到了一次线上故障：[事故描述]
```

---

### 7. Large-Scale-Refactor-Plan.md
**大规模重构计划模板**

制定"安全、可控、可回滚"的分阶段重构计划，确保业务连续性。

**核心功能：**
- 重构动机与技术债量化评估
- 重构范围界定（明确包含/不包含）
- 目标技术架构（As-Is vs To-Be）
- 影响面评估
- 分阶段实施计划（每阶段可独立验证和回滚）
- 风险管控与应急预案
- 测试策略与灰度发布
- 成本收益分析

**适用场景：**
- 迁移到新框架（React Class → Hooks）
- 重构核心模块
- 技术债集中偿还

**引用方式：**
```
@ryan_common/Large-Scale-Refactor-Plan.md

我们需要重构：[重构目标]
```

---

### 8. Dependency-Upgrade-Assessment.md
**依赖升级影响评估模板**

系统化评估升级影响，制定"安全、可控、可回滚"的升级方案。

**核心功能：**
- 升级动机与版本对比
- Breaking Changes 详细分析
- 依赖树分析（间接依赖冲突）
- 安全漏洞修复分析
- 影响范围评估
- 测试策略
- 升级实施计划（分阶段）
- 回滚预案
- 成本收益分析

**适用场景：**
- 升级 React 17 → 18
- Node.js LTS 版本切换
- 第三方 SDK 大版本升级

**引用方式：**
```
@ryan_common/Dependency-Upgrade-Assessment.md

我们需要升级：[依赖名称] 从 vX.Y.Z 到 vA.B.C
```

---

### 9. API-Design-Review.md
**API 设计评审清单模板**

从"可用性、可维护性、安全性、性能、兼容性"五个维度评审 API 设计。

**核心功能：**
- RESTful 规范检查（资源命名、HTTP 方法、状态码）
- 参数设计评审（命名、校验、分页）
- 响应格式评审（成功/错误/列表响应）
- 向后兼容性评审（版本管理、废弃流程、Breaking Changes）
- 安全性评审（认证、授权、输入验证、敏感信息保护）
- 性能优化建议（响应优化、限流与熔断）
- 文档完整性评审

**适用场景：**
- SDK 公开 API 设计
- 微服务接口设计
- 开放平台 API 发布

**引用方式：**
```
@ryan_common/API-Design-Review.md

请评审以下 API 设计：[API 文档或描述]
```

---

## 🎯 核心设计理念

### 1. 量化评估优先
所有模板都包含量化维度（评分矩阵、规模估算、风险等级），避免纯定性分析。

### 2. 防乐观偏差
特别是 Idea-Feasibility-Analysis.md，明确要求 AI "不做情绪价值输出"，必须指出不成立的地方。

### 3. 可执行性
所有输出都要求具体可执行，如环境搭建命令、3 天接手计划、MVP 时间线等。

### 4. 图表可视化
要求输出 Mermaid 图表（架构图、时序图、状态图、数据流图），帮助快速理解复杂系统。

### 5. 风险与边界意识
强调"不可轻动区"、"改动风险"、"知识断层"等概念，确保安全接手和演进。

---

## 🔧 使用技巧

### 配合技术栈模板使用
```
# 先用通用模板理解项目
@ryan_common/Project-Handover-Guide.md

# 然后用技术栈模板执行具体改动
@ryan_ios/code_execute_step.md
```

### 多轮深入探索
这些模板设计为交互式工作流，第一轮输出后可继续深入：
- "详细解释 [模块名] 的实现细节"
- "如果要添加 [功能]，应该改哪些地方"
- "评估重构 [模块] 的工作量和风险"

### 输出即文档
AI 的分析输出可直接保存为项目交接文档、技术评审报告或决策依据。

---

## 📊 模板对比

### 项目分析与接手类

| 模板 | 用途 | 输出重点 | 决策类型 |
|------|------|---------|---------|
| Idea-Feasibility-Analysis | 评估新想法 | 商业可行性 + 技术可行性 | Go/No-Go/Conditional Go |
| Project-Handover-Guide | 接手 GitHub 项目 | 快速理解 + 3 天计划 | 接手难度评估 |
| SDK-Handover-Guide | 接手公司 SDK | 风险识别 + 不可轻动区 | 安全演进路径 |

### 问题排查与决策类

| 模板 | 用途 | 输出重点 | 决策类型 |
|------|------|---------|---------|
| Bug-Root-Cause-Analysis | Bug 调试分析 | 根因定位 + 修复方案对比 | 临时方案 vs 根本方案 |
| Architecture-Decision-Record | 技术选型决策 | 方案对比矩阵 + 风险评估 | 多方案对比决策 |
| Production-Incident-Postmortem | 生产事故复盘 | Blameless 复盘 + 长期改进 | 时间线分析 + 改进计划 |

### 重构与升级类

| 模板 | 用途 | 输出重点 | 决策类型 |
|------|------|---------|---------|
| Large-Scale-Refactor-Plan | 大规模重构计划 | 分阶段实施 + 风险管控 | 阶段划分 + 灰度策略 |
| Dependency-Upgrade-Assessment | 依赖升级评估 | Breaking Changes + 依赖树分析 | 升级路径规划 |
| API-Design-Review | API 设计评审 | 规范性检查 + 安全性评审 | 发布 Go/No-Go |

---

## 🚀 快速开始

1. **配置软链接**（如果还没配置）
   ```bash
   cd /path/to/claude-prompts
   ./setup.sh
   ```

2. **在任意项目中使用**
   ```
   # 项目分析与接手类
   @ryan_common/Idea-Feasibility-Analysis.md
   @ryan_common/Project-Handover-Guide.md
   @ryan_common/SDK-Handover-Guide.md

   # 问题排查与决策类
   @ryan_common/Bug-Root-Cause-Analysis.md
   @ryan_common/Architecture-Decision-Record.md
   @ryan_common/Production-Incident-Postmortem.md

   # 重构与升级类
   @ryan_common/Large-Scale-Refactor-Plan.md
   @ryan_common/Dependency-Upgrade-Assessment.md
   @ryan_common/API-Design-Review.md
   ```

3. **根据提示输入信息**
   AI 会按照模板结构输出完整的分析报告。

---

## 📝 最佳实践

### 按场景选择模板

1. **新项目立项前**
   - 用 Idea-Feasibility-Analysis 评估创意是否值得做
   - 用 Architecture-Decision-Record 记录关键技术选型

2. **接手已有项目**
   - 用 Project-Handover-Guide 或 SDK-Handover-Guide 建立认知
   - 先理解再修改，降低风险

3. **遇到 Bug**
   - 用 Bug-Root-Cause-Analysis 系统性排查
   - 区分临时方案和根本方案，防止治标不治本

4. **线上故障后**
   - 用 Production-Incident-Postmortem 进行 Blameless 复盘
   - 提炼经验教训，防止类似问题再发生

5. **计划大规模重构**
   - 用 Large-Scale-Refactor-Plan 制定分阶段计划
   - 确保每个阶段可独立验证和回滚

6. **准备升级依赖**
   - 用 Dependency-Upgrade-Assessment 评估 Breaking Changes
   - 提前识别依赖冲突，制定测试策略

7. **发布对外 API**
   - 用 API-Design-Review 评审设计规范性
   - 确保向后兼容和安全性

### 通用最佳实践

1. **保存 AI 输出** - 分析结果可作为长期文档，供团队复用
2. **定期回顾** - 用复盘模板积累经验教训
3. **迭代优化** - 根据实际使用反馈优化模板
4. **团队协作** - 将模板输出作为团队决策会议的输入材料

---

## 🤝 贡献

如果你有新的通用分析场景需求，欢迎提 PR：
- 新增模板文件到 `ryan_common/` 目录
- 运行 `./setup.sh` 自动配置
- 更新本 README.md

---

## 📮 反馈

如有问题或建议，请提交 GitHub Issue。
