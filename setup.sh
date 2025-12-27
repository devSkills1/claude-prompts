#!/bin/bash

# Claude Prompts 模板自动配置脚本
# 自动将所有模板目录链接到 ~/.claude/

set -e  # 遇到错误立即退出

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo -e "${BLUE}  Claude Prompts 模板配置工具${NC}"
echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo ""

# 获取脚本所在目录（即项目根目录）
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo -e "${YELLOW}📂 项目目录:${NC} $SCRIPT_DIR"
echo -e "${YELLOW}🎯 目标目录:${NC} $CLAUDE_DIR"
echo ""

# 创建 ~/.claude/ 目录（如果不存在）
if [ ! -d "$CLAUDE_DIR" ]; then
    echo -e "${YELLOW}📁 创建 Claude 配置目录...${NC}"
    mkdir -p "$CLAUDE_DIR"
    echo -e "${GREEN}✅ 目录创建成功${NC}"
    echo ""
fi

# 查找所有模板目录（排除 .git 等隐藏目录）
echo -e "${YELLOW}🔍 扫描模板目录...${NC}"
echo ""

TEMPLATE_DIRS=()
LINKED_COUNT=0
SKIPPED_COUNT=0

# 遍历所有子目录
for dir in "$SCRIPT_DIR"/*/ ; do
    # 获取目录名（不含路径）
    dirname=$(basename "$dir")

    # 跳过隐藏目录和特殊目录
    if [[ "$dirname" == .* ]] || [[ "$dirname" == "node_modules" ]]; then
        continue
    fi

    TEMPLATE_DIRS+=("$dirname")

    # 目标链接路径
    link_path="$CLAUDE_DIR/$dirname"

    # 检查链接是否已存在
    if [ -L "$link_path" ]; then
        # 检查链接是否指向正确的位置
        current_target=$(readlink "$link_path")
        expected_target="$SCRIPT_DIR/$dirname"

        if [ "$current_target" == "$expected_target" ]; then
            echo -e "  ${BLUE}⏭️  $dirname${NC} - 已存在且正确，跳过"
            ((SKIPPED_COUNT++))
        else
            echo -e "  ${YELLOW}🔄 $dirname${NC} - 更新链接"
            rm "$link_path"
            ln -s "$SCRIPT_DIR/$dirname" "$link_path"
            echo -e "     ${GREEN}✅ 链接已更新${NC}"
            ((LINKED_COUNT++))
        fi
    elif [ -e "$link_path" ]; then
        # 存在同名文件/目录但不是软链接
        echo -e "  ${YELLOW}⚠️  $dirname${NC} - 目标位置已存在同名文件/目录，请手动处理"
        echo -e "     路径: $link_path"
    else
        # 创建新链接
        echo -e "  ${GREEN}🔗 $dirname${NC} - 创建软链接"
        ln -s "$SCRIPT_DIR/$dirname" "$link_path"
        echo -e "     ${GREEN}✅ 链接创建成功${NC}"
        ((LINKED_COUNT++))
    fi
done

echo ""
echo -e "${BLUE}═══════════════════════════════════════${NC}"
echo -e "${GREEN}🎉 配置完成！${NC}"
echo ""
echo -e "📊 统计信息:"
echo -e "   - 扫描到模板目录: ${#TEMPLATE_DIRS[@]} 个"
echo -e "   - 新建/更新链接: $LINKED_COUNT 个"
echo -e "   - 跳过（已存在）: $SKIPPED_COUNT 个"
echo ""

# 显示所有已配置的模板
if [ ${#TEMPLATE_DIRS[@]} -gt 0 ]; then
    echo -e "${YELLOW}📚 可用的模板:${NC}"
    for template in "${TEMPLATE_DIRS[@]}"; do
        echo -e "   ${GREEN}✓${NC} @$template/"
    done
    echo ""
fi

# 使用说明
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}💡 使用方法:${NC}"
echo ""
echo -e "   在任意项目中，都可以使用以下方式引用模板："
echo ""
for template in "${TEMPLATE_DIRS[@]}"; do
    echo -e "   ${BLUE}@$template/xxx.md${NC}"
done
echo ""
echo -e "   示例："
echo -e "   ${GREEN}@ryan_common/Idea-Feasibility-Analysis.md${NC}    - 创意可行性分析"
echo -e "   ${GREEN}@ryan_common/Project-Handover-Guide.md${NC}       - GitHub 项目接手指南"
echo -e "   ${GREEN}@ryan_common/SDK-Handover-Guide.md${NC}           - 公司 SDK 接手指南"
echo -e "   ${GREEN}@ryan_ios/plan_security.md${NC}                   - iOS 安全规划模板"
echo -e "   ${GREEN}@ryan_flutter/xxx.md${NC}                         - Flutter 模板"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${YELLOW}🔧 验证配置:${NC}"
echo ""
echo -e "   运行以下命令验证:"
echo -e "   ${BLUE}ls -la ~/.claude/${NC}"
echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✨ 配置成功！现在可以在任何项目中使用这些模板了${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
