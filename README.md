# Claude Prompts — Structured AI Workflow for Developers

🚀 **Production-ready prompt workflows for Claude Code**
Standardize how developers **PLAN → EXECUTE → REVIEW → AUDIT** code with AI — safely, step by step.

> Designed for **real-world software engineering**, not chat-style prompting.

---

## 为什么要用这个？

当你在用 Claude / AI 写代码时，最常见的问题是：

* ❌ 一次性改太多代码，**不可控**
* ❌ 没有审查与回滚思路，**风险极高**
* ❌ AI 输出无法沉淀为长期可复用的知识

**这个仓库解决的是：如何让 AI 像一个“受控的高级工程师”一样工作。**

---

## What You Get

✅ **Structured Workflow**
A strict 4-stage process: **Plan → Execute → Review → Audit**

✅ **Anti-Chaos Design**
Step-by-step execution, every change is verifiable & rollback-safe

✅ **AI Output = Documentation**
Prompts are designed so AI outputs are directly reusable as tech docs

✅ **Multi-Stack Support**
iOS / Flutter / React / TypeScript (each stack is fully self-contained)

✅ **Universal Analysis Templates**
Project handover, SDK takeover, and idea feasibility analysis tools

---

## 项目结构

```
claude-prompts/
├── ryan_common/           # 通用分析模板
│   ├── Idea-Feasibility-Analysis.md      # 创意可行性分析
│   ├── Project-Handover-Guide.md         # GitHub 项目接手指南
│   └── SDK-Handover-Guide.md             # 公司 SDK 接手指南
├── ryan_ios/              # iOS 开发模板 (Objective-C/Swift)
├── ryan_flutter/          # Flutter 开发模板
├── ryan_react/            # React 开发模板
├── ryan_ts/               # TypeScript 开发模板
├── setup.sh               # 自动配置软链接脚本
└── README.md
```

每个目录通过软链接机制在任意项目中都可以通过 `@ryan_common/xxx.md` 等方式全局引用。

---

## 适合谁？

* Senior / Mid-level Developers
* 在生产项目中使用 Claude Code 的工程师
* 对 **安全、性能、稳定性、可回滚性** 有要求的人
* 不想让 AI “一顿乱改代码”的人

---

## 项目一句话定位

> **This is not a prompt collection.
> It is a disciplined AI-assisted development workflow.**

---

📦 Repository: [https://github.com/devSkills1/claude-prompts](https://github.com/devSkills1/claude-prompts)
