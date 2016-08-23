!include MUI.nsh
!include LogicLib.nsh
!include nsDialogs.nsh
!include WinMessages.nsh
!include FileFunc.nsh
!include WinVer.nsh

Name "Practice"
OutFile ".\build\Practice_${version}_${from}.exe"
SetCompressor /SOLID lzma

Icon ".\app\icons\icon-32.ico"
UninstallIcon ".\app\icons\icon-32.ico"

!define MUI_ICON ".\app\icons\icon-32.ico"
!define MUI_UNICON ".\app\icons\icon-32.ico"
# !define MUI_FINISHPAGE_RUN "$INSTDIR\Practice.exe"

InstallDir "$PROGRAMFILES\Practice"

Page custom welcome
Page instfiles
Page custom finish
# !define MUI_PAGE_INSTFILES install

UninstPage uninstConfirm
UninstPage instfiles

RequestExecutionLevel admin

XPStyle on

!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_LANGUAGE SimpChinese

VIProductVersion "0.0.2.0"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "ProductName" "Practice"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "Comments" "Comments"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "CompanyName" "CompanyName"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "LegalTrademarks" "LegalTrademarks"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "LegalCopyright" "LegalCopyright"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileDescription" "Practice"
VIAddVersionKey /LANG=${LANG_SIMPCHINESE} "FileVersion" "0.0.2.0"

Var HEADLINE_FONT

Function .onInit

	InitPluginsDir
	File /oname=$PLUGINSDIR\page1.bmp ".\app\icons\page1.bmp"
	File /oname=$PLUGINSDIR\page2.bmp ".\app\icons\page2.bmp"

FunctionEnd

Function HideControls

	LockWindow on
	GetDlgItem $0 $HWNDPARENT 1
	ShowWindow $0 ${SW_HIDE}

	GetDlgItem $0 $HWNDPARENT 2
	ShowWindow $0 ${SW_HIDE}

	GetDlgItem $0 $HWNDPARENT 3
	ShowWindow $0 ${SW_HIDE}

	GetDlgItem $0 $HWNDPARENT 1028
	ShowWindow $0 ${SW_HIDE}

	GetDlgItem $0 $HWNDPARENT 1256
	ShowWindow $0 ${SW_HIDE}

	GetDlgItem $0 $HWNDPARENT 1035
	ShowWindow $0 ${SW_HIDE}

	GetDlgItem $0 $HWNDPARENT 1037
	ShowWindow $0 ${SW_HIDE}

	GetDlgItem $0 $HWNDPARENT 1038
	ShowWindow $0 ${SW_HIDE}

	GetDlgItem $0 $HWNDPARENT 1039
	ShowWindow $0 ${SW_HIDE}

	GetDlgItem $0 $HWNDPARENT 1045
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 1034
   	ShowWindow $0 ${SW_HIDE}

   	GetDlgItem $0 $HWNDPARENT 1035
   	ShowWindow $0 ${SW_HIDE}

   	GetDlgItem $0 $HWNDPARENT 1036
   	ShowWindow $0 ${SW_HIDE}

   	GetDlgItem $0 $HWNDPARENT 1037
   	ShowWindow $0 ${SW_HIDE}

   	GetDlgItem $0 $HWNDPARENT 1038
   	ShowWindow $0 ${SW_HIDE}

   	GetDlgItem $0 $HWNDPARENT 1039
   	ShowWindow $0 ${SW_HIDE}

   	GetDlgItem $0 $HWNDPARENT 1256
   	ShowWindow $0 ${SW_HIDE}

   	GetDlgItem $0 $HWNDPARENT 1028
   	ShowWindow $0 ${SW_HIDE}

	LockWindow off

FunctionEnd

Function ShowControls

	LockWindow on
	GetDlgItem $0 $HWNDPARENT 1
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 2
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 3
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 1028
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 1256
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 1035
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 1037
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 1038
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 1039
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 1045
	ShowWindow $0 ${SW_NORMAL}

	GetDlgItem $0 $HWNDPARENT 1034
   	ShowWindow $0 ${SW_NORMAL}

   	GetDlgItem $0 $HWNDPARENT 1035
   	ShowWindow $0 ${SW_NORMAL}

   	GetDlgItem $0 $HWNDPARENT 1036
   	ShowWindow $0 ${SW_NORMAL}

   	GetDlgItem $0 $HWNDPARENT 1037
   	ShowWindow $0 ${SW_NORMAL}

   	GetDlgItem $0 $HWNDPARENT 1038
   	ShowWindow $0 ${SW_NORMAL}

   	GetDlgItem $0 $HWNDPARENT 1039
   	ShowWindow $0 ${SW_NORMAL}

   	GetDlgItem $0 $HWNDPARENT 1256
   	ShowWindow $0 ${SW_NORMAL}

   	GetDlgItem $0 $HWNDPARENT 1028
   	ShowWindow $0 ${SW_NORMAL}

	LockWindow off

FunctionEnd

Var Dialog
Var Image
Var ImageHandle
Var InstallBtn
Var DirBtn
Var DirLabel

Function welcome

	# System::Call 'user32::SetWindowPos(i$hwndparent,i,i,i,i 590,i 415,i 0x16)' ; Resize outer dialog
	nsDialogs::Create 1044
	Pop $Dialog
	System::Call 'user32::MoveWindow(i$Dialog,i0,i0,i 500,i 336,i0)'

	SetCtlColors $Dialog "" 0xffffff

	${NSD_CreateLabel} 20 -30 270 12 ""
	Pop $DirLabel
	SetCtlColors $DirLabel "" 0xffffff
	ShowWindow $DirLabel ${SW_HIDE}

	${NSD_CreateButton} -100 -30 80 20 "Next"
	Pop $InstallBtn
	${NSD_OnClick} $InstallBtn onClickNext

	${NSD_CreateButton} -200 -30 80 20 "Custom Dir"
	Pop $DirBtn
	${NSD_OnClick} $DirBtn showDirDialog

	${NSD_CreateBitmap} 0 0 100% 100% ""
	Pop $IMAGE
	${NSD_SetImage} $Image $PLUGINSDIR\page1.bmp $ImageHandle
	SetCtlColors $Image "" 0xffffff

	Call HideControls

	nsDialogs::Show

	Call ShowControls
FunctionEnd

Function showDirDialog
	nsDialogs::SelectFolderDialog "Custom Dir" ""

	Pop $0

	${IF} $0 == error
	${ELSE}
		StrCpy $INSTDIR $0

		${NSD_SetText} $DirLabel $INSTDIR
		ShowWindow $DirLabel ${SW_NORMAL}

		SetOutPath $INSTDIR
	${EndIf}
FunctionEnd

Function RelGotoPage
  	IntCmp $R9 0 0 Move Move
    	StrCmp $R9 "X" 0 Move
      	StrCpy $R9 "120"
  	Move:
  	SendMessage $HWNDPARENT "0x408" "$R9" ""
FunctionEnd

Function onClickNext
  	StrCpy $R9 1
  	Call RelGotoPage
  	Abort
FunctionEnd

Var CompleteBtn
Var Progress

Function finish
	# System::Call 'user32::SetWindowPos(i$hwndparent,i,i,i,i 590,i 415,i 0x16)' ; Resize outer dialog
	nsDialogs::Create 1044
	Pop $Dialog
	# System::Call 'user32::MoveWindow(i$Dialog,i0,i0,i 590,i 415,i0)'
	System::Call 'user32::MoveWindow(i$Dialog,i0,i0,i 500,i 336,i0)'
	SetCtlColors $Dialog "" 0xffffff

	${NSD_CreateButton} -100 -30 80 20 "Complete"
	Pop $CompleteBtn
	# ${NSD_OnClick} $CompleteBtn startInstall
	${NSD_OnClick} $CompleteBtn onClickComplete

	# ${NSD_CreateProgressBar} 20 355 400 20 ""
	# Pop $Progress
	# ${NSD_CreateTimer} OnTimer 200

	${NSD_CreateBitmap} 0 0 100% 100% ""
	Pop $IMAGE
	${NSD_SetImage} $Image $PLUGINSDIR\page2.bmp $ImageHandle
	SetCtlColors $Image "" 0xffffff

	Call HideControls

	nsDialogs::Show
FunctionEnd

Function OnTimer

	SendMessage $Progress ${PBM_GETPOS} 0 0 $1
	${If} $1 >= 100
		${NSD_KillTimer} OnTimer
		MessageBox MB_OK "Timer 3 killed"
	${Else}
		SendMessage $Progress ${PBM_DELTAPOS} 2 0
	${EndIf}

FunctionEnd

Function onClickComplete
	# StrCpy $R9 1
 #  	Call RelGotoPage
 #  	Abort
 # 	Quit
	# MessageBox MB_OK "Open exe"

	Exec '"$INSTDIR\Practice.exe"'

	SendMessage $HwndParent ${WM_CLOSE} 0 0

	Abort
FunctionEnd

Section
	DetailPrint "开始安装。。。"
	DetailPrint $INSTDIR

	SetOutPath $INSTDIR

	# File "README.md"
	File /r "E:\Workspace\MeMe-RIA\build\MeMeLive\win32\*.*"
	# File /r "E:\Workspace\MeMe-RIA\build\MeMeLive\win32\Practice.exe"

	; Write the installation path into the registry
 	WriteRegStr HKLM SOFTWARE\Practice "Install_Dir" "$INSTDIR"

 	; Write the uninstall keys for Windows
 	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Practice" "DisplayName" "Practice"
 	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Practice" "UninstallString" '"$INSTDIR\uninstall.exe"'
 	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Practice" "NoModify" 1
 	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Practice" "NoRepair" 1

	CreateShortCut "$DESKTOP\Practice.lnk" "$INSTDIR\Practice.exe"
	WriteUninstaller "$INSTDIR\UninstallMeMeLive.exe"

	CreateDirectory "$STARTMENU\Practice"
    CreateShortcut "$STARTMENU\Practice\UninstallPractice.lnk" "$INSTDIR\UninstallMeMeLive.exe"
    CreateShortcut "$STARTMENU\Practice\Practice.lnk" "$INSTDIR\Practice.exe"

	# CreateDirectory "$STARTMENU\User Pinned\TaskBar"
	# CreateShortcut "$QUICKLAUNCH\Practice.lnk" "$INSTDIR\Practice.exe"
    # CreateShortcut "$QUICKLAUNCH\User Pinned\TaskBar\Practice.lnk" "$INSTDIR\Practice.exe"

	# pin the icon to taskbar
	${IF} ${IsWin10}
	${ELSE}
		ExecShell "taskbarpin" "$STARTMENU\Practice\Practice.lnk"
	${EndIf}

	# goto next pagte
	StrCpy $R9 1
  	Call RelGotoPage
  	Abort
SectionEnd

Section "Uninstall"
	DetailPrint "Start Uninstall"
	DetailPrint "$INSTDIR"
  	; Remove registry keys
  	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Practice"
  	DeleteRegKey HKLM SOFTWARE\Practice

	# unpin stskbar link
	ExecShell "taskbarunpin" "$STARTMENU\Practice\Practice.lnk"

	; Remove shortcuts, if any
	Delete "$DESKTOP\Practice.lnk"

	Delete "$STARTMENU\Practice\*.*"
	RMDir "$STARTMENU\Practice"

  	; Remove files and uninstaller
  	Delete "$INSTDIR\*.*"

  	; Remove directories used
  	RMDir /r "$INSTDIR\locales"
  	RMDir /r "$INSTDIR\PepperFlash"
  	RMDir /r "$INSTDIR\pnacl"
  	RMDir "$INSTDIR"

SectionEnd
