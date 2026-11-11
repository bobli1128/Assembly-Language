# Assembly-Language

一个学期 16 位汇编语言（DOS / MASM，参照王爽《汇编语言》第 3 版）的完整学习记录：
实验报告、实验代码、课件、课程论文，以及用 Visual Studio 2017 + Irvine 库编写 32 位汇编的资料。

## 目录结构

```
Assembly-Language/
├── README.md                 # 本文件
├── .gitignore                # 忽略 MASM 编译产物（*.obj / *.exe）
│
├── 代码/                     # 实验汇编源码（见下方清单）
├── 实验报告/                 # 实验报告 01~12、exp10 调试截图草稿、翻转课堂互评表
├── 实验/                     # 实验课 PPT（实验 01~12）
│   └── 截图/                 # 实验过程截图，按实验编号归档（实验03 / 实验07）
├── 课件/                     # 理论课课件（汇编语言_00 ~ _17）
├── 论文/                     # 课程论文（docx / pdf）与论文模板
│   ├── 参考文献/             # 写作参考的三篇论文
│   └── 翻转课堂资料/         # 递归与阶乘：VS 汇编实现 PPT 及配套文档
├── 参考资料/                 # 王爽《汇编语言》第3版、Intel 汇编、VC++ 使用指南
└── 软件/
    ├── AsmTools/             # 16 位实验环境：DOSBox 0.74 + MASM + LINK + debug
    └── Irvine.zip            # VS2017 32 位汇编用的 Irvine 库
```

## 源码清单

| 文件 | 内容 |
| --- | --- |
| `exp7.asm` / `sy7.asm` | 实验7：将 21 年的公司收入、雇员等数据整理进表格段（寻址方式在结构化数据访问中的应用，同一题的两份实现） |
| `exp8.asm` | 实验8：转移指令——把 `jmp short s1` 机器码复制到 s 处实现指令替换 |
| `exp9.asm` | `letterc` 子程序：把字符串中的小写字母转为大写（and 11011111B） |
| `exp10.asm` / `test9.asm` | 3×3 矩阵乘法，用子程序嵌套 + 多重循环实现（同一题的两份实现） |
| `test.asm` | 3×4 与 4×5 矩阵相乘，并把结果按十进制打印输出（较完整的版本） |
| `code.asm` | 把代码段前 23 字节程序复制到内存 0020:0000 处 |
| `codesg.asm` | 用栈把 a 段的 8 个字型数据逆序存入 b 段 |

## 16 位实验环境（DOSBox + MASM）

工具都在 `软件/AsmTools/`（另附 `AsmTools.rar` 原始压缩包）：

```text
mount c D:\AsmTools          ; 挂载工具目录
c:
masm exp7;                   ; 汇编，生成 .obj
link exp7;                   ; 连接，生成 .exe
exp7                         ; 运行
debug exp7.exe               ; 调试（-u 反汇编 / -t 单步 / -d 看内存 / -r 看寄存器）
```

## Visual Studio 2017 32 位汇编

- 环境配置见 `参考资料/VC++使用.pdf`，库文件为 `软件/Irvine.zip`；
- 推荐教材：《基于 x86 处理机：汇编语言》（对应 `参考资料/Intel Assembly Language.pdf`）。
