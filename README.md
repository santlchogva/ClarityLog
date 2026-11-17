# 清志 ClarityLog

> 专为脑雾人群设计的健康追踪 App

[![Build iOS IPA](https://github.com/santlchogva/ClarityLog/actions/workflows/build-ios.yml/badge.svg)](https://github.com/santlchogva/ClarityLog/actions/workflows/build-ios.yml)

---

## 简介

**清志**是一款帮助慢性疲劳、脑雾人群记录日常状态、发现个人规律的健康日志 App。

每天花 1 分钟记录感受、饮食和活动，帮你与医生更有效地沟通，找到属于自己的健康规律。

---

## 核心功能

| 功能 | 说明 |
|---|---|
| 🧠 **清晰度评分** | 0-10 分自评，每天一次，追踪脑雾变化趋势 |
| 🍚 **饮食记录** | 记录三餐与加餐，观察饮食与感受的关联 |
| 🚶 **活动追踪** | 记录运动类型与时长，PEM 风险智能提醒 |
| 📊 **数据洞察** | 7 天趋势图表，睡眠与清晰度相关性分析 |
| 💡 **科学建议** | 每条建议附有医学引用依据，可查阅原文 |
| 🌸 **月经周期** | 可选开启，追踪经期与症状关联（数据仅存本地） |

---

## 截图

*（待补充）*

---

## 技术栈

- **框架**：Flutter 3.50 (iOS + Android 单代码库)
- **状态管理**：flutter_riverpod
- **导航**：go_router
- **本地数据库**：sqflite (SQLite)
- **图表**：fl_chart

---

## 安装

### Android

从 [Releases](https://github.com/santlchogva/ClarityLog/releases) 下载最新 APK，开启「允许未知来源」后安装。

### iOS

1. 从 [Actions](https://github.com/santlchogva/ClarityLog/actions) 下载最新构建产物中的 `.ipa` 文件
2. 使用 [Sideloadly](https://sideloadly.io)（Windows/Mac）配合 Apple ID 安装到设备

---

## 本地开发

```bash
# 克隆仓库
git clone https://github.com/santlchogva/ClarityLog.git
cd ClarityLog/app

# 安装依赖
flutter pub get

# 运行（需已连接设备或启动模拟器）
flutter run
```

**环境要求**：Flutter 3.50+，Dart 3.3+

---

## 隐私说明

- 所有数据**仅存储在用户设备本地**，不上传至任何服务器
- 月经数据独立存储，导出时默认不包含
- 本 App 不收集任何个人信息

---

## 免责声明

本 App 仅供个人健康记录参考，不构成医疗建议。如有健康问题，请咨询专业医生。

---

## License

MIT
