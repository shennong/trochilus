#pragma once
#include "afxwin.h"


// CCmdDlg 对话框

class CCmdDlg : public CDialogEx,public IModule
{
	DECLARE_DYNAMIC(CCmdDlg)

public:
	CCmdDlg(CWnd* pParent = NULL);   // 标准构造函数
	virtual ~CCmdDlg();

// 对话框数据
	enum { IDD = IDD_DIALOG_CMD };
	static void HandleModuleMsg(LPCTSTR clientid,UINT nMsg, LPVOID lpContext, LPVOID lpParameter);
	void HandleModuleMsgProc(UINT nMsg,LPVOID lpContext,LPVOID lpParameter);

	void EnableButton(BOOL isOpen);

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

	DECLARE_MESSAGE_MAP()
public:

	virtual BOOL OnInitDialog();
	afx_msg void OnBnClickedButtonOpen();
	afx_msg void OnBnClickedButtonClose();
	afx_msg void OnClose();

	afx_msg HBRUSH OnCtlColor(CDC* pDC, CWnd* pWnd, UINT nCtlColor);
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	afx_msg void OnEnChangeEditResult();

	BOOL IsDisable(CString strCmd);

	void InitDisable();
public:
	CBrush m_bkBrush;
	UINT m_nCurSel;
	CEdit m_editResult;
	CString m_strResult;

	CStringArray m_arrDis;
};
