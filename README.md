# Claude Prompts 模板集

> 结构化 Prompt 模板库，适配 Claude Code，用于规范化软件开发工作流

---

## 📚 项目简介

这是一个 **Claude Code Prompt 模板集合**，包含针对不同技术栈的结构化提示词模板，帮助你和 AI 更高效地协作完成开发任务。

**核心价值：**
- ✅ **标准化工作流** - Plan → Execute → Review → Audit 四阶段流程
- ✅ **防失控机制** - 逐步执行，每步可验证、可回滚
- ✅ **知识沉淀** - AI 输出即文档，可复用可分享
- ✅ **多技术栈** - 支持 iOS、Flutter、React、TypeScript 等

---

## 🗂️ 目录结构

```
claude-prompts/
├── ryan_ios/               # iOS 开发模板（Objective-C / Swift）
│   ├── README.md          # iOS 模板说明
│   ├── USAGE.md           # 详细使用指南
│   ├── plan_security.md   # 安全加固规划
│   ├── plan_performance.md # 性能优化规划
│   ├── checklist.md       # 审计检查清单
│   └── ...
│
├── ryan_flutter/           # Flutter 开发模板
├── ryan_react/             # React 开发模板
├── ryan_ts/                # TypeScript 开发模板
│
├── setup.sh                # 自动配置脚本
├── SYMLINK_SETUP.md        # 软链接配置指南
└── README.md               # 本文档
```

---

## 🚀 快速开始

### 1️⃣ 一键配置（推荐）

将所有模板链接到 Claude Code 全局配置，在任何项目中都能直接引用：

```bash
# 克隆或进入项目目录
cd /Users/ryan/Desktop/claude-prompts/

# 运行自动配置脚本
./setup.sh
```

**脚本会自动：**
- ✅ 创建 `~/.claude/` 目录
- ✅ 扫描所有模板目录（ryan_ios、ryan_flutter、ryan_react 等）
- ✅ 批量创建软链接
- ✅ 显示配置结果

---

### 2️⃣ 使用模板

配置完成后，在任何项目中都可以直接引用：

```bash
# 在任意项目目录
cd ~/your-project/

# 在 Claude Code 中使用
@ryan_ios/plan_security.md
@ryan_ios/checklist.md
@ryan_flutter/xxx.md
@ryan_react/xxx.md
```

**示例对话：**
```
你: @ryan_ios/plan_security.md
    帮我规划越狱检测方案

    背景：金融 App，已上线，目前只有 ptrace 反调试

AI: [输出完整的安全分析和执行方案...]
```

---

## 📖 模板分类

### iOS 开发模板

| 模板 | 用途 | 使用场景 |
|------|------|---------|
| `plan_architecture.md` | 架构规划 | 大型架构改动前的分析和方案设计 |
| `plan_security.md` | 安全检测 | 反调试/反Hook/反注入/反重签名 |
| `plan_performance.md` | 性能优化 | 主线程卡顿/崩溃/OOM 问题分析 |
| `plan_refactor_legacy.md` | 老代码重构 | Objective-C 遗留代码优化 |
| `plan_logging.md` | 日志系统 | 异步日志/崩溃保护设计 |
| `code_execute_step.md` | 执行控制 | 逐步执行修改，防止失控（最重要） |
| `review_and_rollback.md` | 审查回滚 | 代码审查和回滚策略 |
| `checklist.md` | 审计清单 | 安全/性能/稳定性/审核风险检查 |

**详细说明：** 查看 [`ryan_ios/README.md`](ryan_ios/README.md) 和 [`ryan_ios/USAGE.md`](ryan_ios/USAGE.md)

---

### Flutter 开发模板

| 模板 | 用途 | 使用场景 |
|------|------|---------|
| `plan_state_management.md` | 状态管理 | Provider/Riverpod/Bloc 方案设计 |
| `plan_performance.md` | 性能优化 | Flutter 渲染优化/内存优化 |
| `code_execute_step.md` | 执行控制 | 逐步执行修改，防止失控 |
| `review_and_rollback.md` | 审查回滚 | 代码审查和回滚策略 |
| `checklist.md` | 审计清单 | 发布前检查清单 |

**详细说明：** 查看 [`ryan_flutter/README.md`](ryan_flutter/README.md)

---

### React 开发模板

| 模板 | 用途 | 使用场景 |
|------|------|---------|
| `plan_performance.md` | 性能优化 | 渲染优化/虚拟列表/懒加载 |
| `code_execute_step.md` | 执行控制 | 逐步执行修改，防止失控 |
| `review_and_rollback.md` | 审查回滚 | 代码审查和回滚策略 |
| `checklist.md` | 审计清单 | 性能/无障碍/SEO/安全检查 |

**详细说明：** 查看 [`ryan_react/README.md`](ryan_react/README.md)

---

### TypeScript 开发模板

| 模板 | 用途 | 使用场景 |
|------|------|---------|
| `plan_types.md` | 类型系统设计 | 类型定义/泛型设计/类型推导 |
| `code_execute_step.md` | 执行控制 | 逐步执行修改，防止失控 |
| `review_and_rollback.md` | 审查回滚 | 代码审查和回滚策略 |
| `checklist.md` | 审计清单 | 类型安全/性能/可维护性检查 |

**详细说明：** 查看 [`ryan_ts/README.md`](ryan_ts/README.md)

---

## 🔧 配置说明

### 软链接工作原理

```
源文件位置（Git 管理）:
/Users/ryan/Desktop/claude-prompts/ryan_ios/

        ↓ 软链接

全局访问位置:
~/.claude/ryan_ios/
```

**优点：**
- ✅ 任何项目都能直接 `@ryan_ios/xxx.md` 引用
- ✅ 修改会同步到源文件（Git 可追踪）
- ✅ 统一管理，不会有重复副本
- ✅ 方便团队分享和协作

**详细配置说明：** 查看 [`SYMLINK_SETUP.md`](SYMLINK_SETUP.md)

---

## 💡 使用流程

### 标准四阶段工作流

```
1️⃣ Plan（规划）
   ↓ 使用 plan_*.md
   ↓ 获取分析和执行计划

2️⃣ Execute（执行）
   ↓ 使用 code_execute_step.md
   ↓ 逐步实施改动

3️⃣ Review（审查）
   ↓ 使用 review_and_rollback.md
   ↓ 验证改动是否符合要求

4️⃣ Audit（审计）
   ↓ 使用 checklist.md
   ↓ 最终质量门禁检查
```

### 典型使用案例

**案例 1：实现越狱检测**
```
@ryan_ios/plan_security.md        → 规划方案
@ryan_ios/code_execute_step.md    → 逐步实施
@ryan_ios/review_and_rollback.md  → 审查改动
@ryan_ios/checklist.md            → 最终审计
```

**案例 2：性能优化**
```
@ryan_ios/plan_performance.md     → 分析瓶颈
@ryan_ios/code_execute_step.md    → 优化实施
@ryan_ios/review_and_rollback.md  → 验证效果
```

---

## 🎯 设计原则

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

## 📝 添加新模板

### 1. 创建新的技术栈目录

```bash
# 创建 Flutter 模板目录
mkdir -p flutter
cd flutter

# 创建模板文件
touch README.md
touch plan_state_management.md
touch plan_performance.md
touch checklist.md
```

### 2. 重新运行配置脚本

```bash
cd /Users/ryan/Desktop/claude-prompts/
./setup.sh
```

脚本会自动扫描并创建新模板的软链接。

### 3. 使用新模板

```bash
@ryan_flutter/plan_state_management.md
```

---

## 🤝 团队协作

### 团队成员配置

1. **克隆仓库**
   ```bash
   git clone <your-repo-url> ~/claude-prompts
   ```

2. **运行配置脚本**
   ```bash
   cd ~/claude-prompts
   ./setup.sh
   ```

3. **开始使用**
   ```bash
   @ryan_ios/xxx.md
   ```

### 更新模板

```bash
# 拉取最新模板
git pull

# 所有人的 @ryan_ios/xxx.md 自动使用最新版本
# （因为软链接指向源文件）
```

---

## 🗑️ 卸载

```bash
# 删除所有软链接（源文件不受影响）
rm ~/.claude/ryan_ios
rm ~/.claude/ryan_flutter
rm ~/.claude/ryan_react
rm ~/.claude/ryan_ts

# 或者删除整个 .claude 目录
rm -rf ~/.claude/
```

---

## 📚 相关文档

- **[SYMLINK_SETUP.md](SYMLINK_SETUP.md)** - 软链接配置详细指南
- **[ryan_ios/README.md](ryan_ios/README.md)** - iOS 模板说明
- **[ryan_ios/USAGE.md](ryan_ios/USAGE.md)** - iOS 模板使用指南和案例
- **[Claude Code 官方文档](https://claude.com/claude-code)** - Claude Code 使用文档

---

## 🏗️ 架构设计说明

### 为什么每个技术栈都有相似的模板？

虽然文件名相同（如 `code_execute_step.md`、`review_and_rollback.md`），但内容针对不同技术栈和用户画像优化：

| 技术栈 | 模板风格 | 用户画像 | 示例差异 |
|--------|---------|---------|---------|
| **iOS** | 简洁版（123行） | 资深 iOS 开发者 | Objective-C/Swift 示例、App Store 审核检查 |
| **Flutter** | 详细版（322行） | 跨平台新手较多 | Dart 示例、Widget 测试、平台兼容性 |
| **React** | 组件化风格（309行） | Web 开发为主 | JSX/Hooks 示例、Web Vitals、无障碍 |
| **TypeScript** | 类型系统重点 | 类型安全追求者 | 泛型设计、类型推导、strict 模式 |

### 设计原则：完整独立 > DRY 原则

**为什么不创建 `common/` 目录？**

经过专业 agents 审查（Code Reviewer、Architect、DX Optimizer），我们选择保持技术栈完整独立：

1. **用户体验优先**
   ```bash
   # 一个前缀搞定所有
   @ryan_ios/plan_security.md
   @ryan_ios/code_execute_step.md
   @ryan_ios/checklist.md

   # 而非混合引用
   @common/code_execute_step.md
   @ryan_ios/plan_security.md
   ```

2. **内容本就不同**
   - 文本相似 ≠ 知识重复
   - iOS 的"执行控制"检查项 vs Flutter 的"执行控制"检查项本质不同
   - 强行合并会丢失技术栈特定的上下文

3. **自动补全完美**
   ```bash
   输入: @ryan_ios/<Tab>
   显示: 所有 iOS 可用模板（包括 code_execute_step.md）

   # common/ 方案会导致：
   输入: @ryan_ios/<Tab>
   显示: 只有 plan_*.md，看不到 code_execute_step.md
   ```

4. **架构清晰**
   - 每个技术栈是完整独立的模块（Self-Contained Module Pattern）
   - 可以独立删除、移动、分享
   - 零耦合，互不影响

5. **磁盘占用可忽略**
   - 4 个技术栈 × 2 个通用模板 × 平均 8KB ≈ 64KB
   - 2024 年这点空间完全不是问题

### 如何在多个技术栈间同步改进？

虽然保持独立，但通用改进可以轻松同步：

```bash
# 方式 1：批量替换
sed -i '' 's/旧内容/新内容/g' */code_execute_step.md

# 方式 2：diff 对比后手动合并
diff ryan_ios/code_execute_step.md ryan_flutter/code_execute_step.md

# 方式 3：使用脚本（scripts/sync-improvements.sh）
```

### 业界参考

类似的文档/模板项目也采用独立架构：

- **Yeoman Generators** - 每个生成器完整独立，即使有大量重复
- **VSCode 文档** - 每个语言文档完整独立，不抽象共享
- **Awesome-* 系列** - 每个分类独立，没有 common/ 目录

**共同点：** 文档项目优先考虑**完整性和用户体验**，而非代码复用。

---

## 🎓 最佳实践

1. **分步执行** - 一次只做一小步，不要让 AI 一次改太多代码
2. **每步审查** - Plan → Execute → Review → Audit，不跳过
3. **保守优先** - 最小改动，不过度工程化
4. **可回滚** - 每步都要能快速回滚
5. **知识沉淀** - 将 AI 输出保存为技术文档

---

## 🆘 常见问题

### Q1: 必须使用软链接吗？

不是必须的，你也可以直接在项目中使用：
```bash
@/path/to/claude-prompts/ryan_ios/plan_security.md
```

但软链接更方便，任何项目都能用 `@ryan_ios/xxx.md`。

---

### Q2: 如何添加自定义模板？

在对应的技术栈目录下添加 `.md` 文件即可：
```bash
# 添加自定义 iOS 模板
cd ryan_ios/
touch plan_custom.md

# 使用
@ryan_ios/plan_custom.md
```

---

### Q3: 团队成员路径不一致怎么办？

使用软链接方式，每个人的路径可以不同：
```bash
# 成员 A
git clone ... ~/claude-prompts
cd ~/claude-prompts && ./setup.sh

# 成员 B
git clone ... ~/Desktop/my-prompts
cd ~/Desktop/my-prompts && ./setup.sh

# 都能使用 @ryan_ios/xxx.md（软链接统一指向 ~/.claude/ryan_ios）
```

---

### Q4: 如何验证配置是否成功？

```bash
# 查看软链接
ls -la ~/.claude/

# 应该看到类似输出：
# ryan_ios -> /Users/ryan/Desktop/claude-prompts/ryan_ios
# ryan_flutter -> /Users/ryan/Desktop/claude-prompts/ryan_flutter

# 测试引用
cd ~/any-project/
# 在 Claude Code 中输入 @ryan_ios/ 按 Tab，应该能看到自动补全
```

---

## 📊 项目状态

- ✅ **iOS 模板** - 已完成，包含 10 个核心模板
- ✅ **Flutter 模板** - 已完成，包含 6 个核心模板
- ✅ **React 模板** - 已完成，包含 5 个核心模板
- ✅ **TypeScript 模板** - 已完成，包含 5 个核心模板

---

## 🔗 相关链接

- **Claude Code** - https://claude.com/claude-code
- **Claude API** - https://docs.anthropic.com/
- **GitHub** - (如有公开仓库，在此添加链接)

---

## 📄 许可证

MIT License（或根据实际情况修改）

---

## 🙏 贡献

欢迎提交 Issue 和 Pull Request！

如果你创建了新的技术栈模板，欢迎分享！

---

**开始使用：**

```bash
# 1. 配置
./setup.sh

# 2. 使用
@ryan_ios/plan_security.md

# 3. 享受高效的 AI 协作开发！
```

🚀 **Happy Coding with Claude!**
