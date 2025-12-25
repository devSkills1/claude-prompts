# 软链接配置指南

> 如何将 Prompt 模板链接到 Claude Code 全局配置目录

---

## 📖 什么是软链接？

软链接（Symbolic Link）就像"快捷方式"，让你在一个位置访问另一个位置的文件。

**好处：**
- ✅ 任何项目都能直接 `@ryan_ios/xxx.md` 引用模板
- ✅ 修改会同步到源文件（Git 可追踪）
- ✅ 统一管理，不会有重复副本
- ✅ 方便团队分享和协作

---

## 🚀 快速配置

### 方法 1: 自动配置（推荐⭐）

**一键配置所有模板目录（ryan_ios、ryan_flutter、ryan_react、ryan_ts 等）**

```bash
# 进入项目目录
cd ~/xxx/claude-prompts/

# 运行自动配置脚本
./setup.sh
```

**脚本会自动:**
- ✅ 创建 `~/.claude/` 目录（如果不存在）
- ✅ 扫描所有模板目录（ryan_ios、ryan_flutter、ryan_react 等）
- ✅ 批量创建软链接
- ✅ 跳过已存在的链接
- ✅ 显示配置结果

---

### 方法 2: 手动配置单个模板

**适合只配置特定模板（如 iOS）**

#### 步骤 1: 检查 Claude 配置目录

```bash
# 检查 ~/.claude/ 目录是否存在
ls ~/.claude/

# 如果不存在，创建它
mkdir -p ~/.claude/
```

#### 步骤 2: 创建软链接

```bash
# 进入这个项目目录
cd ~/xxx/claude-prompts/

# 创建 ryan_ios 模板的软链接
ln -s "$(pwd)/ryan_ios" ~/.claude/ryan_ios
```

**解释：**
- `ln -s` - 创建软链接命令
- `$(pwd)/ryan_ios` - 当前目录下的 ryan_ios 文件夹的绝对路径
- `~/.claude/ryan_ios` - 目标位置（Claude 全局配置）

#### 步骤 3: 验证配置

```bash
# 查看软链接是否创建成功
ls -la ~/.claude/ryan_ios

# 应该看到类似输出：
# lrwxr-xr-x  1 xxx  staff  40 Dec 24 10:00 /Users/xxx/.claude/ryan_ios -> ~/xxx/claude-prompts/ryan_ios

# 测试能否访问文件
cat ~/.claude/ryan_ios/README.md
```

---

## ✅ 使用验证

### 在任意项目中测试

```bash
# 进入任意其他项目目录
cd ~/any-project/

# 在 Claude Code 中使用
@ryan_ios/plan_security.md

# 应该能成功引用模板
```

---

## 📁 目录结构示意

```
~/xxx/claude-prompts/
├── ryan_ios/               ← 源文件（Git 管理）
├── ryan_flutter/           ← 源文件（Git 管理）
├── ryan_react/             ← 源文件（Git 管理）
├── ryan_ts/                ← 源文件（Git 管理）
└── setup.sh                ← 自动配置脚本

        软链接 ↓

~/.claude/
├── ryan_ios/        → ~/xxx/claude-prompts/ryan_ios/
├── ryan_flutter/    → ~/xxx/claude-prompts/ryan_flutter/
├── ryan_react/      → ~/xxx/claude-prompts/ryan_react/
└── ryan_ts/         → ~/xxx/claude-prompts/ryan_ts/
```

**工作原理：**
1. 你在项目文件夹中编辑 `claude-prompts/ryan_ios/xxx.md`
2. Git 可以追踪这些修改
3. 任何项目都通过 `@ryan_ios/xxx.md` 访问
4. 实际读取的是源文件，修改会同步
5. 所有模板目录全局可用

---

## 🔧 添加新的模板目录

### 方法 1: 重新运行配置脚本（推荐）

当你创建新的模板目录后，只需重新运行脚本即可：

```bash
# 1. 创建新模板目录
mkdir -p ~/xxx/claude-prompts/ryan_flutter
mkdir -p ~/xxx/claude-prompts/ryan_react
mkdir -p ~/xxx/claude-prompts/ryan_ts

# 2. 重新运行配置脚本
cd ~/xxx/claude-prompts/
./setup.sh

# 脚本会自动：
# - 扫描所有新目录
# - 创建对应的软链接
# - 跳过已存在的链接
```

---

### 方法 2: 手动添加单个模板

```bash
# 假设你创建了 flutter 模板目录
cd ~/xxx/claude-prompts/

# 创建软链接
ln -s "$(pwd)/ryan_flutter" ~/.claude/ryan_flutter

# 使用
@ryan_flutter/plan_xxx.md
```

---

## ❓ 常见问题

### Q1: 软链接和复制文件有什么区别？

| 方式 | 占用空间 | 修改同步 | Git 追踪 |
|------|---------|---------|---------|
| 软链接 | 几乎为 0 | ✅ 自动同步 | ✅ 追踪源文件 |
| 复制文件 | 双倍空间 | ❌ 需手动同步 | ❌ 两份独立文件 |

---

### Q2: 删除软链接会影响源文件吗？

**不会！** 删除软链接只是删除"快捷方式"，源文件完全不受影响。

```bash
# 删除软链接（源文件不受影响）
rm ~/.claude/ryan_ios

# 重新创建
ln -s ~/xxx/claude-prompts/ryan_ios ~/.claude/ryan_ios
```

---

### Q3: 移动源文件夹后软链接会失效吗？

**会！** 软链接指向的是绝对路径，移动源文件夹后需要重新创建：

```bash
# 删除旧链接
rm ~/.claude/ryan_ios

# 进入新位置
cd /path/to/new/location/claude-prompts/

# 重新创建链接
ln -s "$(pwd)/ryan_ios" ~/.claude/ryan_ios
```

---

### Q4: 如何查看软链接指向哪里？

```bash
# 方法 1: 使用 ls -la
ls -la ~/.claude/ryan_ios

# 方法 2: 使用 readlink
readlink ~/.claude/ryan_ios

# 输出: ~/xxx/claude-prompts/ryan_ios
```

---

### Q5: 团队其他成员如何配置？

**方式 1: 克隆仓库后创建软链接**
```bash
# 克隆仓库
git clone <your-repo-url> ~/claude-prompts

# 创建软链接
cd ~/claude-prompts
ln -s "$(pwd)/ryan_ios" ~/.claude/ryan_ios
```

**方式 2: 提供配置脚本**
```bash
# 在项目根目录创建 setup.sh
#!/bin/bash
ln -s "$(pwd)/ryan_ios" ~/.claude/ryan_ios
echo "✅ 软链接创建成功"

# 使用
chmod +x setup.sh
./setup.sh
```

---

## 🗑️ 卸载软链接

如果不再需要：

```bash
# 仅删除软链接（源文件不受影响）
rm ~/.claude/ryan_ios

# 验证删除成功
ls ~/.claude/ryan_ios
# 输出: No such file or directory
```

---

## 📌 推荐工作流

```
1. 在源文件夹中编辑模板
   ~/xxx/claude-prompts/ryan_ios/

2. Git 提交和推送
   git add ryan_ios/
   git commit -m "更新安全检测模板"
   git push

3. 团队其他成员拉取
   git pull

4. 所有人的 @ryan_ios/xxx.md 自动使用最新版本
   （因为软链接指向源文件）
```

---

## 🎯 完整配置命令（复制即用）

```bash
# 一键配置脚本
cd ~/xxx/claude-prompts/ && \
mkdir -p ~/.claude/ && \
ln -sf "$(pwd)/ryan_ios" ~/.claude/ryan_ios && \
echo "✅ 配置完成！现在可以在任何项目中使用 @ryan_ios/xxx.md"
```

**说明：**
- `-sf` 参数：如果链接已存在则强制覆盖
- 运行后立即生效，无需重启

---

## 📚 相关资源

- **ryan_ios/README.md** - iOS 模板使用说明
- **ryan_ios/USAGE.md** - 详细使用指南和案例
- **Claude Code 文档** - https://claude.com/claude-code

---

## ✨ 配置成功标志

当你看到以下现象，说明配置成功：

```bash
# ✅ 在任意目录执行
cd ~/Desktop/

# ✅ 能看到软链接
ls -la ~/.claude/ryan_ios

# ✅ 能读取文件
cat ~/.claude/ryan_ios/README.md

# ✅ 在 Claude Code 中能引用
@ryan_ios/plan_security.md
```

---

## 🎓 小贴士

1. **备份建议** - 源文件夹定期 Git 提交，防止意外丢失
2. **命名规范** - 软链接名称与源文件夹名称保持一致
3. **多人协作** - 统一使用软链接方式，避免路径差异
4. **定期更新** - 拉取最新模板后，软链接会自动生效

---

**现在就开始配置吧！** 🚀
