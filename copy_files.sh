#!/bin/bash

echo "=========================================="
echo "  复制 VoiceNoteApp 源文件"
echo "=========================================="
echo ""

# 等待用户输入新项目的路径
echo "请按以下步骤操作："
echo ""
echo "1. 在 Xcode 中创建新项目（保存到临时文件夹）"
echo "2. 新项目创建完成后，关闭 Xcode"
echo "3. 将新项目的文件夹拖拽到终端窗口，"
echo "   然后按回车继续"
echo ""
echo "=========================================="

read NEW_PROJECT_PATH

# 去除可能的引号和空格
NEW_PROJECT_PATH=$(echo "$NEW_PROJECT_PATH" | xargs)

echo ""
echo "检测到项目路径: $NEW_PROJECT_PATH"
echo ""

# 获取项目文件夹内的 VoiceNoteApp 文件夹
PROJECT_FOLDER=$(ls -d "$NEW_PROJECT_PATH"/VoiceNoteApp 2>/dev/null | head -1)

if [ -z "$PROJECT_FOLDER" ]; then
    echo "错误: 找不到 VoiceNoteApp 文件夹"
    echo "请确认路径正确"
    exit 1
fi

echo "源文件文件夹: $PROJECT_FOLDER"
echo ""

# 备份并替换文件
BACKUP_DIR="$PROJECT_FOLDER.backup"
mkdir -p "$BACKUP_DIR"

echo "正在备份原文件..."
cp -r "$PROJECT_FOLDER"/* "$BACKUP_DIR/" 2>/dev/null

echo ""
echo "正在复制源文件..."

# 删除默认文件（保留项目配置）
rm -f "$PROJECT_FOLDER"/VoiceNoteApp.swift
rm -f "$PROJECT_FOLDER"/ContentView.swift
rm -rf "$PROJECT_FOLDER"/Preview Content

# 复制我们的源文件
cp -r VoiceNoteApp/*.swift "$PROJECT_FOLDER"/
cp -r VoiceNoteApp/Models "$PROJECT_FOLDER"/
cp -r VoiceNoteApp/ViewModels "$PROJECT_FOLDER"/
cp -r VoiceNoteApp/Views "$PROJECT_FOLDER"/
cp -r VoiceNoteApp/Services "$PROJECT_FOLDER"/
cp -r VoiceNoteApp/Persistence "$PROJECT_FOLDER"/
cp -r VoiceNoteApp/Resources "$PROJECT_FOLDER"/
cp VoiceNoteApp/Info.plist "$PROJECT_FOLDER"/

echo ""
echo "✅ 源文件复制完成！"
echo ""
echo "备份位置: $BACKUP_DIR"
echo ""
echo "现在可以在 Xcode 中打开项目了"
echo ""
echo "下一步:"
echo "  1. 在 Xcode 中打开新项目"
echo "  2. 确认所有 Swift 文件都已添加到 Target"
echo "  3. 按 Cmd + R 运行"

