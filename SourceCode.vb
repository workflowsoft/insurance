
'
' ������� ��� ���������� ����� �������� ��
' ��������� �������� �� 0 �� 999999999999
'
' ��������������� ����������
Dim ������, �������� As Boolean
Dim ���������, ������������� As Boolean
' ������ ��������� ������
Dim �����(32) As String
' ���������� ���������
Const ������ As Boolean = True
Const ���� As Boolean = False
'
' ������� ���������� ����� �������� � ������
'
Function �������������(�����)
	' ������� �������
	���������� = (����� - Fix(�����)) * 100
	If (���������� - Fix(����������)) >= 0.5 Then
		If ���������� >= 99.5 Then
			���������� = 0
			����� = ����� + 1
		Else
			���������� = Fix(����������) + 1
		End If
	Else
		���������� = Fix(����������)
	End If
	������� = CStr(����������)
	' ����� ������� ��� ��������� ����� ��������
	����� = CStr(Fix(�����))
	���������� = ������
	������������� = �������������(�����, ����������)
	' ������ � ��������� �����
	������������� = UCase(Mid(�������������, 1, 1)) + _
						   Mid(�������������, 2)
	' ��������� ����� ��������� �����
	����� = Len(�����)
	' ���� ����� ������ �� ����� �����, ��������
	' �� ���� (��� ������������ ���������)
	If ����� = 1 Then
		����� = "0" & �����
		����� = ����� + 1
	End If
	' ���������� ������� ��������� ������
	'
	' ��� �����, �������������� �� 10, 11, 12, 13,
	' 14, 15, 16, 17, 18, 19 ��������� "������"
	If Mid(�����, ����� - 1, 1) = 1 Then
		������������� = ������������� + "������"
		' ��� ���� ��������� �������
	Else
		Select Case Mid(�����, �����)
			' ��� �����, �������������� �� 1 ��������� "�����"
			Case 1
				������������� = ������������� + "�����"
				' ��� �����, �������������� �� 2, 3, 4
				' ��������� "�����"
			Case 2, 3, 4
				������������� = ������������� + "�����"
				' ��� �����, �������������� �� 5, 6, 7, 8,
				' 9, 0 ��������� "������"
			Case Else
				������������� = ������������� + "������"
		End Select
	End If
	' ������������ ��������� ���������, �������� �������
	If Len(�������) = 1 Then
		������� = "0" + �������
	End If
	������������� = ������������� + " " + ������� + " "
	' ��� �����, �������������� �� 10, 11, 12, 13,
	' 14, 15, 16, 17, 18, 19 ��������� "������"
	If Mid(�������, 1, 1) = 1 Then
		������������� = ������������� + "������"
		' ��� ���� ��������� �������
	Else
		Select Case Mid(�������, 2)
			' ��� �����, �������������� �� 1 ��������� "�������"
			Case 1
				������������� = ������������� + "�������"
				' ��� �����, �������������� �� 2, 3, 4
				' ��������� "������"
			Case 2, 3, 4
				������������� = ������������� + "�������"
				' ��� �����, �������������� �� 5, 6, 7, 8,
				' 9, 0 ��������� "������"
			Case Else
				������������� = ������������� + "������"
		End Select
	End If
End Function
'
' ������� ���������� ����� ��������
'
Function �������������(�����, Optional ���������� = ������)
	' ���������� �������� ������� ������
	�����(1) = "���" : �����(2) = "���"
	�����(3) = "���" : �����(4) = "�����"
	�����(5) = "���" : �����(6) = "����"
	�����(7) = "���" : �����(8) = "�����"
	�����(9) = "�����" : �����(10) = "�"
	�����(11) = "�" : �����(12) = "�"
	�����(13) = "�������" : �����(14) = "�����"
	�����(15) = "�����" : �����(16) = "������"
	�����(17) = "���" : �����(18) = "���"
	�����(19) = "���" : �����(20) = "���"
	�����(21) = "����" : �����(22) = "�����"
	�����(23) = "�" : �����(24) = "�"
	�����(25) = "�������" : �����(26) = "��"
	�����(27) = " " : �����(28) = ""
	�����(29) = "�����" : �����(30) = "���"
	�����(31) = "��������" : �����(32) = "���� "
	' ��������� ���������� ������� ������������
	������ = ���� : �������� = ����
	��������� = ���� : ������������� = ����
	' ����������� ������� �����, ���� ��� ����
	����� = Fix(�����)
	' ���������� ����� ��������� �����
	����� = Len(�����)
	' ���� �� ���� ������ �����, ������� � �������
	' ����� �� ������� ������
	For ������� = ����� To 1 Step -1
		' ����������� ��������� �����, �����������
		' ������� �����
		������������� = ������������� + _
						 ������������(Mid(�����, _
						 ����� - ������� + 1, 1), _
						 �������, ����������)
	Next �������
	' �������� ���������� ������ ������ ���
	' ������� ���������. �������� ���
	If ������������� = "" Then
		������������� = �����(32)
	End If
End Function
'
' ����������� ���� �� ������ �� ���������
' ����� ����� � �� ����������� ������
'
' ������� �������� ������ � ������� ������
'
Private Function ������������(�����, �����, ���) As String
	' ���� ����� ��� ������� ����������, ��
	' ��������� �� ���� ��� ��������
	If (����� <> 0) And ((����� = 11) Or _
		 (����� = 12)) Then
		��������� = ������
	End If
	' ���� ����� ��� ������� ���������, ��
	' ��������� �� ���� ��� ��������
	If (����� <> 0) And ((����� = 8) Or _
		 (����� = 9)) Then
		�������� = ������
	End If
	' ���� ����� ��� ������� �����, ��
	' ��������� �� ���� ��� ��������
	If (����� <> 0) And ((����� = 5) Or _
		 (����� = 6)) Then
		������ = ������
	End If
	' ���� ���������� ����� ���� �������
	' � ���� ��������, �� ��������
	If ������������� Then
		Select Case �����
			' ����� "������ "
			Case 0
				������������ = �����(29) + �����(12) + _
							   �����(27)
				' ����� "����������� "
			Case 1
				������������ = �����(1) + �����(10) + _
							   �����(13) + �����(27)
				' ����� "���������� "
			Case 2
				������������ = �����(18) + �����(13) + _
							   �����(27)
				' � ��������� ������� ����� �������� �����
				' ���� "������� "
			Case Else
				������������ = �����(�����) + �����(13) + _
							   �����(27)
		End Select
		' ��������� �������� ��������
		Select Case �����
			Case 4
				' ��������� "����� "
				������������ = ������������ + �����(22) + _
							   �����(27)
				' ��������� "��������� "
			Case 7
				������������ = ������������ + �����(25) + _
							   �����(26) + �����(27)
				' ��������� "���������� "
			Case 10
				������������ = ������������ + �����(31) + _
							   �����(26) + �����(27)
		End Select
		' ���������� ��������, ��� ��� ��������� �
		' ���������� ��������
		������������� = ���� : �������� = ����
		��������� = ���� : ������ = ����
		' �� ���� ��������� �������, �� ����
		' �� ��� �������� ����� ������� �������
	Else
		' ���������� �������� ��������
		If (����� = 2) Or (����� = 5) Or _
			  (����� = 8) Or (����� = 11) Then
			Select Case �����
				' ���������� ��� ������ ������� ���
				' ����������� ��� ��������� �����
				Case 1
					������������� = ������
					' ����� "��������" ��� "��������"
				Case 2, 3
					������������ = �����(�����) + �����(14) + _
								   �����(27)
					' ����� "����� "
				Case 4
					������������ = �����(15) + �����(27)
					' ����� "��������� "
				Case 9
					������������ = �����(16) + �����(17) + _
								   �����(27)
					' � ��������� ������� ����� �������� �����
					' ���� "����� "
				Case 5, 6, 7, 8
					������������ = �����(�����) + �����(12) + _
								   �����(29) + �����(27)
			End Select
		End If
		' ���������� �������� �����
		If (����� = 3) Or (����� = 6) Or _
			  (����� = 9) Or (����� = 12) Then
			Select Case �����
				' ����� "��� "
				Case 1
					������������ = �����(17) + �����(27)
					' ����� "������ "
				Case 2
					������������ = �����(18) + �����(19) + _
								   �����(27)
					' ����� "������ "
				Case 3
					������������ = �����(3) + �����(30) + _
								   �����(27)
					' ����� "��������� "
				Case 4
					������������ = �����(4) + �����(11) + _
								   �����(30) + �����(27)
					' � ��������� ������� ����� �������� �����
					' ���� "��� "
				Case 5, 6, 7, 8, 9
					������������ = �����(�����) + �����(12) + _
								   �����(20) + �����(27)
			End Select
		End If
		' ���������� �������� ������
		If (����� = 1) Or (����� = 4) Or _
			  (����� = 7) Or (����� = 10) Then
			Select Case �����
				' ����� "���� " ��� "���� "
				Case 1
					If (���) Or _
					 (����� = 7) Or (����� = 10) Then
						������������ = �����(1) + �����(10) + _
									�����(27)
					Else
						������������ = �����(21) + �����(27)
					End If
					' ����� "��� " ��� "��� "
				Case 2
					If (���) Or _
					 (����� = 7) Or (����� = 10) Then
						������������ = �����(�����) + �����(27)
					Else
						������������ = �����(18) + �����(27)
					End If
					' ����� "��� "
				Case 3
					������������ = �����(�����) + �����(27)
					' ����� "������ "
				Case 4
					������������ = �����(4) + �����(11) + _
								   �����(27)
					' � ��������� ������� ����� �������� �����
				Case 5, 6, 7, 8, 9
					������������ = �����(�����) + �����(12) + _
								   �����(27)
			End Select
			' ���������� �������� �����
			If ����� = 4 Then
				Select Case �����
					' ����� "����� " ������ � ��� ������, ����
					' ���� �� � ����� ������� ����� ���� �� �������
					' ��������
					Case 0
						If ������ Then
							������������ = �����(22) + �����(27)
						End If
						' ����� "���� ������ "
					Case 1
						������������ = �����(21) + �����(27) + _
							   �����(22) + �����(23) + �����(27)
						' ����� "��� ������ "
					Case 2
						������������ = �����(18) + �����(27) + _
							   �����(22) + �����(24) + �����(27)
						' ��������� "������ "
					Case 3, 4
						������������ = ������������ + �����(22) + _
									   �����(24) + �����(27)
						' � ��������� ������� ��������� "����� "
					Case 5, 6, 7, 8, 9
						������������ = ������������ + �����(22) + _
									   �����(27)
				End Select
				' ���������� �������� �����, ��� ���
				' ��������� � ���������� ��������
				������ = ����
			End If
			' ���������� �������� ���������
			If ����� = 7 Then
				Select Case �����
					' ����� "��������� " ������ � ��� ������,
					' ���� ���� �� � ����� ������� ���������
					' ���� �� ������� ��������
					Case 0
						If �������� Then
							������������ = �����(25) + �����(26) + _
										   �����(27)
						End If
						' ��������� "������� "
					Case 1
						������������ = ������������ + �����(25) + _
									   �����(27)
						' ��������� "�������� "
					Case 2, 3, 4
						������������ = ������������ + �����(25) + _
									   �����(23) + �����(27)
						' ��������� "��������� "
					Case 5, 6, 7, 8, 9
						������������ = ������������ + �����(25) + _
									   �����(26) + �����(27)
				End Select
				' ���������� �������� ���������, ��� ���
				' ��������� � ���������� ��������
				�������� = ����
			End If
			' ���������� �������� ����������
			If ����� = 10 Then
				Select Case �����
					' ����� "���������� " ������ � ��� ������,
					' ���� ���� �� � ����� ������� ����������
					' ���� �� ������� ��������
					Case 0
						If ��������� Then
							������������ = �����(31) + �����(26) + _
										   �����(27)
						End If
						' ��������� "�������� "
					Case 1
						������������ = ������������ + �����(31) + _
									   �����(27)
						' ��������� "��������� "
					Case 2, 3, 4
						������������ = ������������ + �����(31) + _
									   �����(23) + �����(27)
						' ��������� "���������� "
					Case 5, 6, 7, 8, 9
						������������ = ������������ + �����(31) + _
									   �����(26) + �����(27)
				End Select
				' ���������� �������� ����������, ��� ���
				' ��������� � ���������� ��������
				��������� = ����
			End If
		End If
	End If
End Function




Sub CalculateTarif()

	Dim DOSum As Double
	Dim TheCol As String
	Dim TheRow As String
	Dim CategoryTS As String
	Dim Prem As Double

	Tarif = "�������� � ������: "
	TheCol = ""
	DOSum = 0

	CategoryTS = Trim(Mid(TransportForm.TS_Category.Value, 1, 6))
	'MsgBox "'" & CategoryTS & "'"
	TSExp = CInt(TransportForm.TS_age.Value)
	Risk = TransportForm.TS_Risks.Value
	InsurProgram = TransportForm.TS_InsurProgram.Value

	CalcType = TransportForm.CalculationType.Value


	'������� ������� ����� �� �������
	Select Case (CategoryTS)
		Case "1.1."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "5"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "6"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "7"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "8"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "9"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "10"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "11"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "7"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "8"
			End If
		Case "1.2."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "13"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "14"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "15"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "16"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "17"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "18"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "19"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "9"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "10"
			End If
		Case "1.3."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "21"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "22"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "23"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "24"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "25"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "26"
			ElseIf (Risk = "������� + �����") And (InsurProgram = "������ 50/50") Then
				TheCol = "27"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "28"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "11"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "12"
			End If
		Case "2.2.1."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "30"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "31"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "32"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "33"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "34"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "35"
			ElseIf (Risk = "������� + �����") And (InsurProgram = "������ 50/50") Then
				TheCol = "36"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "37"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "13"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "14"
			End If
		Case "2.2.2."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "39"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "40"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "41"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "42"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "43"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "44"
			ElseIf (Risk = "������� + �����") And (InsurProgram = "������ 50/50") Then
				TheCol = "45"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "46"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "15"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "16"
			End If
		Case "2.2.3."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "48"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "49"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "50"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "51"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "52"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "53"
			ElseIf (Risk = "������� + �����") And (InsurProgram = "������ 50/50") Then
				TheCol = "54"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "55"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "17"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "18"
			End If
		Case "2.2.4."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "57"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "58"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "59"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "60"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "61"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "62"
			ElseIf (Risk = "������� + �����") And (InsurProgram = "������ 50/50") Then
				TheCol = "63"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "64"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "19"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "20"
			End If
		Case "2.2.5."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "66"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "67"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "68"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "69"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "70"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "71"
			ElseIf (Risk = "������� + �����") And (InsurProgram = "������ 50/50") Then
				TheCol = "72"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "73"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "21"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "22"
			End If
		Case "3.1."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "75"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "76"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "77"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "78"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "79"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "80"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "81"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "23"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "24"
			End If
		Case "3.2."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "83"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "84"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "85"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "86"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "87"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "88"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "89"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "25"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "26"
			End If
		Case "3.3."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "91"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "92"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "93"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "94"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "95"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "96"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "97"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "27"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "28"
			End If
		Case "3.4."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "99"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "100"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "101"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "102"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "103"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "104"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "105"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "29"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "30"
			End If
		Case "3.5."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "107"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "108"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "109"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "110"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "111"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "112"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "113"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "31"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "32"
			End If
		Case "3.6."
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������") Then
				TheCol = "115"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "������") Then
				TheCol = "116"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "��������") Then
				TheCol = "117"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "��������") Then
				TheCol = "118"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "�������") Then
				TheCol = "119"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "�������") Then
				TheCol = "120"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "������ �� 1 ���������� ������") Then
				TheCol = "121"
			ElseIf ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) And (InsurProgram = "���������") Then
				TheCol = "33"
			ElseIf ((Risk = "����� + ���") Or (Risk = "�����")) And (InsurProgram = "���������") Then
				TheCol = "34"
			End If
	End Select

	If TransportForm.TS_InsurProgram.Value = "���������" Then
		If TransportForm.CheckBox2.Value = True Then
			'������� Universal
			TheRow = 15 + TSExp
		Else
			TheRow = 7 + TSExp
		End If
	Else
		'������� Tarifi
		Select Case (CalcType)
			Case "�� ����������� �����������"
				TheRow = 7 + TSExp
			Case "�� ����������� ����������� / �� ������ ���� �� �������"
				TheRow = 18 + TSExp
			Case "�� ����������� ����������� / �� ������ ���� �� ������� / �� ������ ���� �� ������"
				TheRow = 23 + TSExp
		End Select
	End If




	If TransportForm.TS_InsurProgram.Value = "���������" Then
		WS = ActiveWorkbook.Sheets("Universal")
	Else
		WS = ActiveWorkbook.Sheets("Tarifi")
	End If
	BaseTarif = WS.Cells(CInt(TheCol), CInt(TheRow)).Value
	Worksheets("Data").Cells(14, 2).Value = BaseTarif

	'������� ����������� ����.
	Ksp = 1		  '��� - ����. ���������� ��������
	Kf = 1		  '��  - ����. ��������
	Kvs = 1		  '��� - ����. ��������/�����
	Kl = 1		  '��  - ����. ���������� ���, ���������� � ����������.
	KI = TransportForm.KI.Value			'��  - ����. ������������� ��
	Kbm = TransportForm.DriverKBM.Value	'��� - ����. �����-�����
	Kps = 1		  '��� - ����. ������������� �������������� �������
	KUTS = 0	  '����- ����. ���
	Worksheets("Data").Cells(8, 1).Value = "-"
	Worksheets("Data").Cells(8, 2).Value = "-"
	Worksheets("Data").Cells(8, 3).Value = "-"
	'--------------------------------------------------------------------------------------
	'KUTS
	If (TransportForm.TS_Risks.Value = "������� + ����� + ���") Or (TransportForm.TS_Risks.Value = "����� + ���") Then
		KUTS = 1.3
	End If
	'---------------------------------------------------------------------------------------
	'Kf
	If (TransportForm.FranshizaFlag.Enabled = False) And (TransportForm.FranshizaPercent.Value = 2) And (TransportForm.FranshizaFlag.Value = True) Then
		'���� ������ �� 1 ���������� ������, ���� ��� �� ��������� � ������. � ����� ������ �� = 1
		Kf = 1
		Worksheets("Data").Cells(8, 1).Value = "-"
		Worksheets("Data").Cells(8, 2).Value = "-"
		Worksheets("Data").Cells(8, 3).Value = "-"
	ElseIf (TransportForm.FranshizaFlag.Value = True) Then
		If TransportForm.FranshizaType.Value = "�����������" Then
			Select Case (TransportForm.FranshizaPercent.Value)
				Case 0.1 To 0.5 : Kf = 0.93
				Case 0.6 To 1 : Kf = 0.85
				Case 1.1 To 2 : Kf = 0.8
				Case 2.1 To 3 : Kf = 0.75
				Case 3.1 To 4 : Kf = 0.7
				Case 4.1 To 5 : Kf = 0.65
				Case 5.1 To 6 : Kf = 0.6
				Case 6.1 To 7 : Kf = 0.55
				Case 7.1 To 8 : Kf = 0.5
			End Select
			Worksheets("Data").Cells(8, 1).Value = "�����������"
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) Then
				Worksheets("Data").Cells(8, 2).Value = "������� + �����"
			Else
				Worksheets("Data").Cells(8, 2).Value = "�����"
			End If
			Worksheets("Data").Cells(8, 3).Value = TransportForm.FranshizaPercent.Value
		Else
			Select Case (TransportForm.FranshizaPercent.Value)
				Case 0.1 To 0.5 : Kf = 0.95
				Case 0.6 To 1 : Kf = 0.9
				Case 1.1 To 2 : Kf = 0.85
				Case 2.1 To 3 : Kf = 0.8
				Case 3.1 To 4 : Kf = 0.75
				Case 4.1 To 5 : Kf = 0.7
				Case 5.1 To 6 : Kf = 0.65
				Case 6.1 To 7 : Kf = 0.6
				Case 7.1 To 8 : Kf = 0.55
			End Select
			Worksheets("Data").Cells(8, 1).Value = "��������"
			If ((Risk = "������� + ����� + ���") Or (Risk = "������� + �����")) Then
				Worksheets("Data").Cells(8, 2).Value = "������� + �����"
			Else
				Worksheets("Data").Cells(8, 2).Value = "�����"
			End If
			Worksheets("Data").Cells(8, 3).Value = TransportForm.FranshizaPercent.Value
		End If
	End If
	'--------------------------------------------------------------------------------------

	'Kvs
	If TransportForm.LDUNum.Value = "��� �����������" Then
		Kvs = 1
	ElseIf TransportForm.LDUNum.Value = "����� ���� �� 33 ���" Then
		Kvs = 1
	Else
		If TransportForm.TS_OrganisationFlag.Value = False Then
			If TransportForm.Driver_Age.Value <= 23 Then
				Select Case (TransportForm.DriverExp.Value)
					Case 0 To 2
						Kvs = 1.4
					Case 3 To 5
						Kvs = 1.3
				End Select
			ElseIf TransportForm.Driver_Age.Value <= 27 Then
				Select Case (TransportForm.DriverExp.Value)
					Case 0 To 2
						Kvs = 1.3
					Case 3 To 5
						Kvs = 1.1
					Case 6 To 9
						Kvs = 0.95
				End Select

			ElseIf TransportForm.Driver_Age.Value <= 32 Then
				Select Case (TransportForm.DriverExp.Value)
					Case 0 To 2
						Kvs = 1.2
					Case 3 To 5
						Kvs = 1.05
					Case 6 To 9
						Kvs = 0.9
					Case Is >= 10
						Kvs = 0.85
				End Select
			ElseIf TransportForm.Driver_Age.Value <= 40 Then
				Select Case (TransportForm.DriverExp.Value)
					Case 0 To 2
						Kvs = 1.1
					Case 3 To 5
						Kvs = 1
					Case 6 To 9
						Kvs = 0.85
					Case Is >= 10
						Kvs = 0.8
				End Select
			ElseIf TransportForm.Driver_Age.Value > 40 Then
				Select Case (TransportForm.DriverExp.Value)
					Case 0 To 2
						Kvs = 1.15
					Case 3 To 5
						Kvs = 1
					Case 6 To 9
						Kvs = 0.85
					Case Is >= 10
						Kvs = 0.8
				End Select
			End If
		End If
	End If
	'-------------------------------------------------------------------------

	'Kl
	If TransportForm.TS_OrganisationFlag.Value = True Then
		Kl = 1
	ElseIf TransportForm.LDUNum.Value = "����� ���� �� 33 ���" Then
		Kl = 1.25
	Else
		Select Case (TransportForm.LDUNum.Value)
			Case "��� �����������" : Kl = 1.4
			Case "�� ����� 3-� ���������" : Kl = 1
			Case "4 ��������" : Kl = 1.1
			Case "5 ���������" : Kl = 1.2
		End Select
	End If
	'-------------------------------------------------------------------------
	'����������� ����������
	If TransportForm.CheckBox3.Value = True Then
		If TransportForm.parck.Value = "2-5 ��" Then
			kp = 0.98
		ElseIf TransportForm.parck.Value = "6-9 ��" Then
			kp = 0.95
		ElseIf TransportForm.parck.Value = "10 � ����" Then
			kp = 0.9
		End If
	Else
		kp = 1
	End If
	'-------------------------------------------------------------------------
	'����������� ����� �������� ��������
	If TransportForm.ComboBox1.Value = "�� 5-�� ����" Then
		ksd = 0.05
	ElseIf TransportForm.ComboBox1.Value = "�� 15-�� ����" Then
		ksd = 0.1
	ElseIf TransportForm.ComboBox1.Value = "�� 1-�� ������" Then
		ksd = 0.2
	ElseIf TransportForm.ComboBox1.Value = "�� 2-� �������" Then
		ksd = 0.3
	ElseIf TransportForm.ComboBox1.Value = "�� 3-� �������" Then
		ksd = 0.4
	ElseIf TransportForm.ComboBox1.Value = "�� 4-� �������" Then
		ksd = 0.5
	ElseIf TransportForm.ComboBox1.Value = "�� 5-�� �������" Then
		ksd = 0.6
	ElseIf TransportForm.ComboBox1.Value = "�� 6-�� �������" Then
		ksd = 0.7
	ElseIf TransportForm.ComboBox1.Value = "�� 7-�� �������" Then
		ksd = 0.75
	ElseIf TransportForm.ComboBox1.Value = "�� 8-�� �������" Then
		ksd = 0.8
	ElseIf TransportForm.ComboBox1.Value = "�� 9-�� �������" Then
		ksd = 0.85
	ElseIf TransportForm.ComboBox1.Value = "�� 10-�� �������" Then
		ksd = 0.9
	ElseIf TransportForm.ComboBox1.Value = "�� 11-�� �������" Then
		ksd = 0.95
	ElseIf TransportForm.ComboBox1.Value = "�� 12-�� �������" Then
		ksd = 1
	End If
	'-------------------------------------------------------------------------
	'Kps
	If (TransportForm.TS_NoDefendFlag.Enabled = True) And (TransportForm.TS_NoDefendFlag.Value = True) Then
		Kps = 1.3
	ElseIf (TransportForm.TS_SatelliteFlag.Enabled = True) And (TransportForm.TS_SatelliteFlag.Value = True) Then
		Kps = 0.87
	ElseIf (TransportForm.TS_HaveElectronicAlarm.Enabled = True) And (TransportForm.TS_HaveElectronicAlarm.Value = True) Then
		Kps = 0.95
	End If
	'--------------------------------------------------------------------------

	'���
	kkv = 1
	Select Case TransportForm.ComisPercent.Value
		Case Is = 0 : kkv = 0.8
		Case Is = 1 : kkv = 0.81
		Case Is = 2 : kkv = 0.82
		Case Is = 3 : kkv = 0.83
		Case Is = 4 : kkv = 0.84
		Case Is = 5 : kkv = 0.85
		Case Is = 6 : kkv = 0.86
		Case Is = 7 : kkv = 0.87
		Case Is = 8 : kkv = 0.88
		Case Is = 9 : kkv = 0.89
		Case Is = 10 : kkv = 0.9
		Case Is = 11 : kkv = 0.91
		Case Is = 12 : kkv = 0.92
		Case Is = 13 : kkv = 0.93
		Case Is = 14 : kkv = 0.94
		Case Is = 15 : kkv = 0.95
		Case Is = 16 : kkv = 0.96
		Case Is = 17 : kkv = 0.97
		Case Is = 18 : kkv = 0.98
		Case Is = 19 : kkv = 0.99
		Case Is = 20 : kkv = 1
		Case Is = 21 : kkv = 1.02
		Case Is = 22 : kkv = 1.04
		Case Is = 23 : kkv = 1.06
		Case Is = 24 : kkv = 1.07
		Case Is = 25 : kkv = 1.08
	End Select

	'�������������� ������ ��������� ������
	If TransportForm.CheckBox1.Value = True Then
		ko = 0.97
	Else
		ko = 1
	End If




	If TransportForm.TS_InsurProgram.Value = "���������" Then
		'����������� ������ ����������
		If TransportForm.RegresLimit.Value = "������������ �����" Then
			klv = 1
		ElseIf TransportForm.RegresLimit.Value = "���������� �����" Then
			klv = 0.95
		ElseIf TransportForm.RegresLimit.Value = "�� 1 ���������� ������" Then
			klv = 0.6
		End If
	End If




	'����������� ����������
	If (klv = 1) Or (klv = 0.95) Then
		If TransportForm.CalculationType.Value = "�� ����������� �����������" Then
			kctoa = 1
		ElseIf TransportForm.CalculationType.Value = "�� ����������� ����������� / �� ������ ���� �� �������" Then
			kctoa = 1.05
		ElseIf TransportForm.CalculationType.Value = "�� ����������� ����������� / �� ������ ���� �� ������� / �� ������ ���� �� ������" Then
			kctoa = 1.2
		End If
	End If




	If TransportForm.TS_InsurProgram.Value = "���������" Then
		If (klv = 0.6) Then
			kctoa = 1
		End If
	End If




	'�������� ��� �������
	vbc = 1
	If InsurProgram = "������" Then
		Select Case (TransportForm.Viplat.Value)
			Case "1 ��� �� ������ �����������" : vbc = 1
			Case "2 ���� �� ������ �����������" : vbc = 1
			Case "�� �������������� (1 �������)" : vbc = 0.95
			Case "�� �������������� (2 �������)" : vbc = 0.9
		End Select
	Else
		Select Case (TransportForm.Viplat.Value)
			Case "1 ��� �� ������ �����������" : vbc = 1
			Case "2 ���� �� ������ �����������" : vbc = 1.1
			Case "�� �������������� (1 �������)" : vbc = 0.95
			Case "�� �������������� (2 �������)" : vbc = 0.9
		End Select
	End If




	If InsurProgram = "���������" Then
		'ksd = 1
		If TransportForm.RegresLimit.Value = "�� 1 ���������� ������" Then
			Kf = 1
		End If




	End If
	If InsurProgram = "������ �� 1 ���������� ������" Then
		Kf = 1
	End If




	If (InsurProgram = "�������") And (TransportForm.CheckBox4.Value = True) Then
		Kf = 1
	End If




	'����������� ����������
	ka = TransportForm.TextBox2.Value




	'����. ���������� ��������
	Ksp = TransportForm.TextBox1.Value
	If TransportForm.TS_InsurProgram.Value = "������ 50/50" Then
		ksd = 1
	End If




	'������� ����� �� ���. ������������
	If TransportForm.TS_DopFlag = True Then
		DOTarif = 10 * ksd * ka * kkv
		DopSalary = TransportForm.TS_DopSalary.Value
		DOSum = Round(CDbl(DopSalary) * DOTarif / 100, 2)
		Tarif = Tarif + Chr(13) + "����� �� ���. ������������ = 10%. ��� =" & ksd & ". ��=" & ka & ". ���=" & kkv & ". ������ �� ���. ������������ = " & DOSum
		TransportForm.T_Tarif.Caption = Tarif
	End If





	'������� ����� � ������ ���� �����������
	If TransportForm.TS_InsurProgram.Value = "������ 50/50" Then
		Tarif = Tarif + Chr(13) + "������� �����=" & BaseTarif & ". ���=" & Kbm & ". ��=" & Kf & ". ��=" & kp & ". ���=" & Kvs
		BaseTarif = Round(BaseTarif * Kbm * Kf * kp * Kvs, 2)
		Prem = Round(TransportForm.TS_salary.Value * BaseTarif / 100, 2)
		Worksheets("Data").Cells(15, 2).Value = 1
		'Tarif = Tarif + Chr(13) + "������� �����=" & BaseTarif & ". ���=" & Kps & ". ���=" & Kbm & ". ��=" & Ki & ". ��=" & Kl & ". ���=" & Kvs & ". ��=" & Kf & ". ���=" & Ksp & ". ���=" & kkv
	ElseIf TransportForm.TS_InsurProgram.Value = "���������" Then
		Worksheets("Data").Cells(15, 2).Value = Kps
		If Kl = 1.4 Then
			Tarif = Tarif + Chr(13) + "������� �����=" & BaseTarif & ". ���=" & Kps & ".  �����=" & kctoa & ". ���=" & klv & ". ���=" & Kbm & ". ��=" & KI & ". ��=" & Kl & ". ��=" & Kf & ". ��=" & ko & ". ���=" & Ksp & ". ���=" & kkv & ". �� = " & kp & ". ��� =" & ksd & ". �� =" & vbc & ". �� =" & ka
			BaseTarif = Round(BaseTarif * klv * kctoa * Kps * Kbm * KI * Kl * Kf * Ksp * ko * kkv * kp * ksd * vbc * ka, 2)
		Else
			Tarif = Tarif + Chr(13) + "������� �����=" & BaseTarif & ". ���=" & Kps & ".�����=" & kctoa & ". ���=" & klv & ". ���=" & Kbm & ". ��=" & KI & ". ��=" & Kl & ". ���=" & Kvs & ". ��=" & Kf & ". ��=" & ko & ". ���=" & Ksp & ". ���=" & kkv & ". �� = " & kp & ". ��� =" & ksd & ". �� =" & vbc & ". �� =" & ka
			BaseTarif = Round(BaseTarif * klv * kctoa * Kps * Kbm * KI * Kl * Kvs * Kf * Ksp * ko * kkv * kp * ksd * vbc * ka, 2)
		End If
	Else
		Worksheets("Data").Cells(15, 2).Value = Kps
		If Kl = 1.4 Then
			Tarif = Tarif + Chr(13) + "������� �����=" & BaseTarif & ". ���=" & Kps & ". ���=" & Kbm & ". ��=" & KI & ". ��=" & Kl & ". ��=" & Kf & ". ��=" & ko & ". ���=" & Ksp & ". ���=" & kkv & ". �� = " & kp & ". ��� =" & ksd & ". �� =" & vbc & ". �� =" & ka
			BaseTarif = Round(BaseTarif * Kps * Kbm * KI * Kl * Kf * Ksp * ko * kkv * kp * ksd * vbc * ka, 2)
		Else
			Tarif = Tarif + Chr(13) + "������� �����=" & BaseTarif & ". ���=" & Kps & ". ���=" & Kbm & ". ��=" & KI & ". ��=" & Kl & ". ���=" & Kvs & ". ��=" & Kf & ". ��=" & ko & ". ���=" & Ksp & ". ���=" & kkv & ". �� = " & kp & ". ��� =" & ksd & ". �� =" & vbc & ". �� =" & ka
			BaseTarif = Round(BaseTarif * Kps * Kbm * KI * Kl * Kvs * Kf * Ksp * ko * kkv * kp * ksd * vbc * ka, 2)
		End If
	End If




	If (TransportForm.TS_Risks.Value = "������� + ����� + ���") Or (TransportForm.TS_Risks.Value = "����� + ���") Then
		BaseTarif = BaseTarif + KUTS
		Tarif = Tarif + Chr(13) + "������� ����� �� ��� = " & KUTS
	End If
	Prem = Round(TransportForm.TS_salary.Value * BaseTarif / 100, 2)
	Tarif = Tarif + Chr(13) + "����� �� �� = " & BaseTarif & ". ��������� ������ �� �� = " & Prem
	Tarif = Tarif + Chr(13) + "����� ��������� ������: " & Prem + DOSum
	TransportForm.T_Tarif.Caption = Tarif

	Worksheets("Data").Cells(3, 1).Value = Prem
	Worksheets("Data").Cells(4, 1).Value = DOSum
	'
	Worksheets("Data").Cells(16, 2).Value = Kvs
	Worksheets("Data").Cells(17, 2).Value = Kl
	Worksheets("Data").Cells(18, 2).Value = Kf
	Worksheets("Data").Cells(19, 2).Value = KI
	Worksheets("Data").Cells(20, 2).Value = Kbm
	Worksheets("Data").Cells(21, 2).Value = kkv
	Worksheets("Data").Cells(22, 2).Value = kp
	Worksheets("Data").Cells(23, 2).Value = ko
	Worksheets("Data").Cells(24, 2).Value = vbc
	Worksheets("Data").Cells(25, 2).Value = ksd
	Worksheets("Data").Cells(26, 2).Value = Ksp
	Worksheets("Data").Cells(27, 2).Value = ka
	'




End Sub




Private Sub CalculateButton_Click()

	ErrStr = "���������� ��������� ������:"
	ErrSum = 0

	'�������� �������� �� ������������ ���� ������
	If TransportForm.TS_salary.Value <= 0 Then
		ErrStr = ErrStr + Chr(13) + "�� ������� ��������� ��!"
		ErrSum = ErrSum + 1
	End If

	'������ �����������
	If TransportForm.CalculationType.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "�� ������ ������ �����������!"
		ErrSum = ErrSum + 1
	End If
	If TransportForm.TS_InsurProgram.Value = "���������" Then
		If TransportForm.RegresLimit.Value = "�� 1 ���������� ������" Then
			If (TransportForm.CalculationType.Value = "�� ����������� ����������� / �� ������ ���� �� �������") Or (TransportForm.CalculationType.Value = "�� ����������� ����������� / �� ������ ���� �� ������� / �� ������ ���� �� ������") Then
				ErrStr = ErrStr + Chr(13) + "�������� ������ ������ �����������!"
				ErrSum = ErrSum + 1
			End If
		End If
	End If

	'����� ������
	If TransportForm.TS_Risks.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "�� ������ ����� ������!"
		ErrSum = ErrSum + 1
	End If

	'����������� ������������� ��������������
	If TransportForm.ComisPercent.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "�� ������ ����������� ������������� ��������������!"
		ErrSum = ErrSum + 1
	End If

	'����������� �������� ��� �������

	If TransportForm.TS_InsurProgram.Value <> "������ 50/50" Then
		If TransportForm.Viplat.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "�� ������ �������� ��� �������!"
			ErrSum = ErrSum + 1
		End If
	End If

	'����������� ����� �������� ��������
	If TransportForm.TS_InsurProgram.Value <> "������ 50/50" Then
		If TransportForm.ComboBox1.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "�� ������ ���� �������� ��������!"
			ErrSum = ErrSum + 1
		End If
	End If

	'���. ������������
	If (TransportForm.TS_DopFlag.Value = True) And (TransportForm.TS_DopSalary.Value = 0) Then
		ErrStr = ErrStr + Chr(13) + "�� ������� ��������� ���. ������������!"
		ErrSum = ErrSum + 1
	End If

	'��������� �����������
	If TransportForm.TS_InsurProgram.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "�� ������� ��������� �����������"
		ErrSum = ErrSum + 1
	End If

	'��������
	If TransportForm.FranshizaFlag.Value = True Then
		If TransportForm.FranshizaType.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "�� ������ ��� ��������"
			ErrSum = ErrSum + 1
		End If

		If TransportForm.FranshizaPercent.Value = 0 Then
			ErrStr = ErrStr + Chr(13) + "�� ������ ������� ��������"
			ErrSum = ErrSum + 1
		End If
	End If

	'����� ����������
	If TransportForm.TS_InsurProgram.Value = "���������" Then
		If TransportForm.RegresLimit.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "�� ������ ����� ����������!"
			ErrSum = ErrSum + 1
		End If
	End If

	'���-�� ���
	If TransportForm.TS_InsurProgram.Value <> "������ 50/50" Then
		If (TransportForm.TS_OrganisationFlag.Value = False) And (TransportForm.LDUNum.Value = "") Then
			ErrStr = ErrStr + Chr(13) + "�� ������� ���������� ���!"
			ErrSum = ErrSum + 1
		End If
	End If

	If TransportForm.TS_InsurProgram.Value = "���������" Then
		'���-�� ���
		If TransportForm.Viplat.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "�� ������� �������� ��� ������� !"
			ErrSum = ErrSum + 1
		End If
	End If

	'��������� ��
	If TransportForm.TS_Category.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "�� ������� ��������� ��!"
		ErrSum = ErrSum + 1
	End If

	If TransportForm.CheckBox3.Value = True Then
		If TransportForm.parck.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "�� ������ ����������� ����������!"
			ErrSum = ErrSum + 1
		End If
	End If


	'��������� ��������� �������, � ����������� �� ��������� �����������
	IsAgeErr = 0

	Select Case TransportForm.TS_InsurProgram.Value
		Case "������"
			If (TransportForm.TS_Category.Value = "1.1.   �������� (��� 2104, 05, 06, 07, 08, 09 � �����������) � ������ �������� �� �������������� ������������, �� �������� � ������ 1-3") Or (TransportForm.TS_Category.Value = "1.2.   ��� 11114 (���), �� 2126, 2717 � �����������, �������� ���") Or (TransportForm.TS_Category.Value = "1.3.   ��� ������, ������, 2110, 2111, 2112, 2113, 2114, 2115 � �����������, ������� ����, ������� ����, ���, ���") Then
				If (TransportForm.TS_age > 3) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			Else
				If (TransportForm.TS_age > 4) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			End If

		Case "��������"
			If (TransportForm.TS_Category.Value = "1.1.   �������� (��� 2104, 05, 06, 07, 08, 09 � �����������) � ������ �������� �� �������������� ������������, �� �������� � ������ 1-3") Or (TransportForm.TS_Category.Value = "1.2.   ��� 11114 (���), �� 2126, 2717 � �����������, �������� ���") Or (TransportForm.TS_Category.Value = "1.3.   ��� ������, ������, 2110, 2111, 2112, 2113, 2114, 2115 � �����������, ������� ����, ������� ����, ���, ���") Then
				If (TransportForm.TS_age > 3) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			Else
				If (TransportForm.TS_age > 4) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			End If


		Case "������ 50/50"
			If (TransportForm.TS_Category.Value = "1.3.   ��� ������, ������, 2110, 2111, 2112, 2113, 2114, 2115 � �����������, ������� ����, ������� ����, ���, ���") Then
				If (TransportForm.TS_age > 3) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			Else
				If (TransportForm.TS_age > 4) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			End If

		Case "������ �� 1 ���������� ������"
			If (TransportForm.TS_age > 10) Or (TransportForm.TS_age < 0) Then
				IsAgeErr = 1
			End If

		Case "���������"
			If (TransportForm.TS_age > 7) Or (TransportForm.TS_age < 0) Then
				IsAgeErr = 1
			End If




		Case "�������"
			If (TransportForm.CheckBox4.Value = True) Then
				If (TransportForm.TS_age < 0) Or (TransportForm.TS_age > 10) Then
					IsAgeErr = 1
				End If
			Else
				If (TransportForm.TS_age > 10) Or (TransportForm.TS_age < 4) Then
					IsAgeErr = 1
				End If
			End If

	End Select

	If IsAgeErr = 1 Then
		ErrStr = ErrStr + Chr(13) + "��� ��������� ��������� ����������� ������ ���������� �� � ��������� ������ ������������!"
		ErrSum = ErrSum + 1
	End If

	If ErrSum > 0 Then
		MsgBox(ErrStr, vbInformation, "��������")
		'Return
	Else
		Call CalculateTarif()
	End If

End Sub





Private Sub CheckBox3_Click()
	TransportForm.parck.Enabled = (TransportForm.CheckBox3.Value)
End Sub





Private Sub CheckBox4_Click()
	If TransportForm.CheckBox4.Value = True Then
		TransportForm.FranshizaFlag.Value = True
		TransportForm.FranshizaPercent.Value = 2
		TransportForm.FranshizaType.Value = "�����������"
		TransportForm.FranshizaFlag.Enabled = False
		TransportForm.FranshizaPercent.Enabled = False
		TransportForm.FranshizaType.Enabled = False
		TransportForm.KI.Enabled = False
		TransportForm.KI.Value = 2
	Else
		TransportForm.FranshizaFlag.Value = False
		TransportForm.FranshizaPercent.Value = ""
		TransportForm.FranshizaFlag.Enabled = True
		TransportForm.FranshizaPercent.Enabled = True
		TransportForm.FranshizaType.Enabled = True
		TransportForm.KI.Enabled = True
		TransportForm.KI.Value = 1
	End If

End Sub




Private Sub CommandButton1_Click()
	TransportForm.PrintForm()
End Sub




Private Sub CommandButton2_Click()
	Worksheets("Data").Cells(2, 1).Value = Worksheets("Data").Cells(3, 1).Value + Worksheets("Data").Cells(4, 1).Value
	WS1 = ActiveSheet
	WS2 = ActiveWorkbook.Sheets("�����")
	WS3 = ActiveWorkbook.Sheets("���������")
	WS3.Activate()




	WS2.Cells(48, 5).Value = Worksheets("Data").Cells(2, 1).Value & "  (" & �������������(Worksheets("Data").Cells(2, 1).Value) & ")"




	If TransportForm.CalculationType.Value = "�� ����������� �����������" Then
		opredelenie = "1�"
	ElseIf TransportForm.CalculationType.Value = "�� ����������� ����������� / �� ������ ���� �� �������" Then
		opredelenie = "2�"
	ElseIf TransportForm.CalculationType.Value = "�� ����������� ����������� / �� ������ ���� �� ������� / �� ������ ���� �� ������" Then
		opredelenie = "3�"
	End If




	Select Case TransportForm.TS_InsurProgram.Value
		Case "������"
			WS2.Cells(7, 3).Value = "��" & opredelenie
		Case "��������"
			WS2.Cells(7, 3).Value = "��" & opredelenie
		Case "�������"
			WS2.Cells(7, 3).Value = "��1�"
		Case "������ �� 1 ���������� ������"
			WS2.Cells(7, 3).Value = "��" & opredelenie
		Case "������ 50/50"
			WS2.Cells(7, 3).Value = "���" & opredelenie
		Case "���������"
			If TransportForm.RegresLimit.Value = "������������ �����" Then
				If TransportForm.CheckBox2.Value = True Then
					WS2.Cells(7, 3).Value = "���" & opredelenie
				Else
					WS2.Cells(7, 3).Value = "���" & opredelenie
				End If
			ElseIf TransportForm.RegresLimit.Value = "���������� �����" Then
				If TransportForm.CheckBox2.Value = True Then
					WS2.Cells(7, 3).Value = "���" & opredelenie
				Else
					WS2.Cells(7, 3).Value = "���" & opredelenie
				End If
			ElseIf TransportForm.RegresLimit.Value = "�� 1 ���������� ������" Then
				If TransportForm.CheckBox2.Value = True Then
					WS2.Cells(7, 3).Value = "���" & opredelenie
				Else
					WS2.Cells(7, 3).Value = "���" & opredelenie
				End If
			End If
	End Select




	If TransportForm.TS_InsurProgram.Value = "���������" Then
		'����������� ������ ����������
		If TransportForm.RegresLimit.Value = "������������ �����" Then
			Worksheets("Data").Cells(1, 12).Value = 0
			Worksheets("Data").Cells(2, 12).Value = 1
			Worksheets("Data").Cells(3, 12).Value = 0
		ElseIf TransportForm.RegresLimit.Value = "���������� �����" Then
			Worksheets("Data").Cells(1, 12).Value = 1
			Worksheets("Data").Cells(2, 12).Value = 0
			Worksheets("Data").Cells(3, 12).Value = 0
		ElseIf TransportForm.RegresLimit.Value = "�� 1 ���������� ������" Then
			Worksheets("Data").Cells(1, 12).Value = 0
			Worksheets("Data").Cells(2, 12).Value = 0
			Worksheets("Data").Cells(3, 12).Value = 1
		End If
	Else
		Select Case TransportForm.TS_InsurProgram.Value
			Case "������"
				Worksheets("Data").Cells(1, 12).Value = 0
				Worksheets("Data").Cells(2, 12).Value = 1
				Worksheets("Data").Cells(3, 12).Value = 0
			Case "��������"
				Worksheets("Data").Cells(1, 12).Value = 1
				Worksheets("Data").Cells(2, 12).Value = 0
				Worksheets("Data").Cells(3, 12).Value = 0
			Case "�������"
				Worksheets("Data").Cells(1, 12).Value = 0
				Worksheets("Data").Cells(2, 12).Value = 1
				Worksheets("Data").Cells(3, 12).Value = 0
			Case "������ �� 1 ���������� ������"
				Worksheets("Data").Cells(1, 12).Value = 0
				Worksheets("Data").Cells(2, 12).Value = 0
				Worksheets("Data").Cells(3, 12).Value = 1
			Case "������ 50/50"
				Worksheets("Data").Cells(1, 12).Value = 0
				Worksheets("Data").Cells(2, 12).Value = 1
				Worksheets("Data").Cells(3, 12).Value = 0
		End Select
	End If




	WS2.Cells(76, 13).Value = DateValue(Now) & "�."
	WS3.Cells(3, 10).Value = "��������� �� " & DateValue(Now) & "�."




	'����, ���������� � ���������� ��
	If TransportForm.TS_OrganisationFlag = True Then
		If TransportForm.LDUNum.Value = "��� �����������" Then
			Worksheets("Data").Cells(13, 4).Value = 1
			Worksheets("Data").Cells(13, 5).Value = 0
		Else
			Worksheets("Data").Cells(13, 4).Value = 0
			Worksheets("Data").Cells(13, 5).Value = 1
		End If
	Else
		Worksheets("Data").Cells(13, 4).Value = 0
		Worksheets("Data").Cells(13, 5).Value = 0
	End If
	'�����
	If (TransportForm.TS_Risks = "������� + ����� + ���") Then
		Worksheets("Data").Cells(1, 8).Value = 1
		Worksheets("Data").Cells(2, 8).Value = 1
		Worksheets("Data").Cells(3, 8).Value = 1
		Worksheets("Data").Cells(3, 9).Value = 0
	ElseIf (TransportForm.TS_Risks = "������� + �����") Then
		Worksheets("Data").Cells(1, 8).Value = 1
		Worksheets("Data").Cells(2, 8).Value = 1
		Worksheets("Data").Cells(3, 8).Value = 0
		Worksheets("Data").Cells(3, 9).Value = 1
	ElseIf (TransportForm.TS_Risks = "����� + ���") Then
		Worksheets("Data").Cells(1, 8).Value = 0
		Worksheets("Data").Cells(2, 8).Value = 1
		Worksheets("Data").Cells(3, 8).Value = 1
		Worksheets("Data").Cells(3, 9).Value = 0
	ElseIf (TransportForm.TS_Risks = "�����") Then
		Worksheets("Data").Cells(1, 8).Value = 0
		Worksheets("Data").Cells(2, 8).Value = 1
		Worksheets("Data").Cells(3, 8).Value = 0
		Worksheets("Data").Cells(3, 9).Value = 1
	End If

	'�����
	Select Case TransportForm.TS_InsurProgram.Value
		Case "������"
			Worksheets("Data").Cells(8, 5).Value = 0
			Worksheets("Data").Cells(8, 6).Value = 1
		Case "��������"
			Worksheets("Data").Cells(8, 5).Value = 0
			Worksheets("Data").Cells(8, 6).Value = 1
		Case "�������"
			Worksheets("Data").Cells(8, 5).Value = 1
			Worksheets("Data").Cells(8, 6).Value = 0
		Case "���������"
			Worksheets("Data").Cells(8, 5).Value = 0
			Worksheets("Data").Cells(8, 6).Value = 1
		Case "������ �� 1 ���������� ������"
			If TransportForm.TS_age.Value < 5 Then
				Worksheets("Data").Cells(8, 5).Value = 1
				Worksheets("Data").Cells(8, 6).Value = 0
			Else
				Worksheets("Data").Cells(8, 5).Value = 0
				Worksheets("Data").Cells(8, 6).Value = 2
			End If
		Case "������ 50/50"
			Worksheets("Data").Cells(8, 5).Value = 0
			Worksheets("Data").Cells(8, 6).Value = 1
	End Select




	WS3.Cells(55, 6).Value = Worksheets("Data").Cells(2, 3).Value - TransportForm.TS_age.Value




	If TransportForm.CalculationType.Value = "�� ����������� �����������" Then
		Worksheets("Data").Cells(1, 16).Value = 1
		Worksheets("Data").Cells(2, 16).Value = 0
		Worksheets("Data").Cells(3, 16).Value = 0
	ElseIf TransportForm.CalculationType.Value = "�� ����������� ����������� / �� ������ ���� �� �������" Then
		Worksheets("Data").Cells(1, 16).Value = 1
		Worksheets("Data").Cells(2, 16).Value = 1
		Worksheets("Data").Cells(3, 16).Value = 0
	ElseIf TransportForm.CalculationType.Value = "�� ����������� ����������� / �� ������ ���� �� ������� / �� ������ ���� �� ������" Then
		Worksheets("Data").Cells(1, 16).Value = 1
		Worksheets("Data").Cells(2, 16).Value = 1
		Worksheets("Data").Cells(3, 16).Value = 1
	End If




	WS2.Cells(41, 3).Value = TransportForm.TS_salary.Value
	WS2.Cells(41, 5).Value = TransportForm.TS_salary.Value
	WS2.Cells(41, 13).Value = Worksheets("Data").Cells(3, 1).Value




	If TransportForm.TS_DopFlag = True Then
		WS2.Cells(42, 3).Value = TransportForm.TS_DopSalary.Value
		WS2.Cells(42, 5).Value = TransportForm.TS_DopSalary.Value
		WS2.Cells(42, 13).Value = Worksheets("Data").Cells(4, 1).Value
		'��������
		WS2.Cells(42, 7).Value = Worksheets("Data").Cells(8, 1).Value
		WS2.Cells(42, 9).Value = Worksheets("Data").Cells(8, 2).Value
		WS2.Cells(42, 11).Value = Worksheets("Data").Cells(8, 3).Value
	Else
		WS2.Cells(42, 3).Value = "-"
		WS2.Cells(42, 5).Value = "-"
		WS2.Cells(42, 13).Value = "-"
		'��������
		WS2.Cells(42, 7).Value = "-"
		WS2.Cells(42, 9).Value = "-"
		WS2.Cells(42, 11).Value = "-"
	End If




	If TransportForm.CheckBox1.Value = True Then
		Worksheets("Data").Cells(1, 20).Value = 1
		Worksheets("Data").Cells(2, 20).Value = 0
	Else
		Worksheets("Data").Cells(1, 20).Value = 0
		Worksheets("Data").Cells(2, 20).Value = 1
	End If




	If TransportForm.Viplat.Value = "1 ��� �� ������ �����������" Then
		Worksheets("Data").Cells(8, 8).Value = 1
		Worksheets("Data").Cells(8, 9).Value = 0
		Worksheets("Data").Cells(8, 10).Value = 0
		Worksheets("Data").Cells(8, 11).Value = 1
	ElseIf TransportForm.Viplat.Value = "2 ���� �� ������ �����������" Then
		Worksheets("Data").Cells(8, 8).Value = 1
		Worksheets("Data").Cells(8, 9).Value = 0
		Worksheets("Data").Cells(8, 10).Value = 1
		Worksheets("Data").Cells(8, 11).Value = 0
	ElseIf TransportForm.Viplat.Value = "�� �������������� (1 �������)" Then
		Worksheets("Data").Cells(8, 8).Value = 0
		Worksheets("Data").Cells(8, 9).Value = 1
		Worksheets("Data").Cells(8, 10).Value = 0
		Worksheets("Data").Cells(8, 11).Value = 0
	End If




	'��������
	WS2.Cells(41, 7).Value = Worksheets("Data").Cells(8, 1).Value
	WS2.Cells(41, 9).Value = Worksheets("Data").Cells(8, 2).Value
	WS2.Cells(41, 11).Value = Worksheets("Data").Cells(8, 3).Value
	WS3.Cells(122, 6).Value = Worksheets("Data").Cells(8, 1).Value
	WS3.Cells(122, 8).Value = Worksheets("Data").Cells(8, 2).Value
	WS3.Cells(122, 10).Value = Worksheets("Data").Cells(8, 3).Value
	'
	Unload TransportForm
End Sub




Private Sub Driver_Age_AfterUpdate()




	age = TransportForm.Driver_Age.Value

	If (age < 18) Or (IsNumeric(age) = False) Then
		MsgBox("������� �������� �� ����� ���� ������ 18 ���.", vbInformation, "��������")
		TransportForm.Driver_Age.Value = 18
	End If

End Sub





Private Sub DriverExp_AfterUpdate()
	Err = 0

	If IsNumeric(TransportForm.Driver_Age.Value) = False Then
		MsgBox("������� ������� ������� ��������!", vbInformation, "������!")
	Else
		DriverExp = TransportForm.DriverExp.Value
		Select Case (TransportForm.Driver_Age.Value)
			Case 18 To 23
				If (DriverExp < 0) Or (DriverExp > 5) Then
					Err = 1
				End If
			Case Is > 23
				If (DriverExp < 0) Then
					Err = 1
				End If
		End Select
	End If

	If Err = 1 Then
		MsgBox("�� ����� ������ ���� ��������!", vbInformation, "��������")
		TransportForm.DriverExp.Value = 0
	End If
End Sub





Private Sub FranshizaFlag_Change()

	TransportForm.FranshizaPercent.Visible = TransportForm.FranshizaFlag.Value
	TransportForm.FranshizaType.Visible = TransportForm.FranshizaFlag.Value
	TransportForm.T_FranshizaPercent.Visible = TransportForm.FranshizaFlag.Value

	If TransportForm.FranshizaFlag.Value = True Then
		'��� ��������
		TransportForm.FranshizaType.AddItem "�����������"
		TransportForm.FranshizaType.AddItem "��������"
	Else
		TransportForm.FranshizaType.Clear()
	End If




End Sub




Private Sub Ki_AfterUpdate()
	If (TransportForm.KI.Value = 2) Or (TransportForm.KI.Value = 1.7) Then
		TransportForm.FranshizaFlag.Value = True
		TransportForm.FranshizaPercent.Value = 2
		TransportForm.FranshizaType.Value = "�����������"
		TransportForm.FranshizaFlag.Enabled = False
		TransportForm.FranshizaPercent.Enabled = False
		TransportForm.FranshizaType.Enabled = False
		TransportForm.T_KI.Visible = True

	Else
		TransportForm.FranshizaFlag.Value = False
		TransportForm.FranshizaFlag.Enabled = True
		TransportForm.FranshizaPercent.Enabled = True
		TransportForm.FranshizaType.Enabled = True
		TransportForm.T_KI.Visible = False
	End If

End Sub




Private Sub LDUNum_Change()
	If TransportForm.LDUNum.Value = "����� ���� �� 33 ���" Then
		TransportForm.Driver_Age.Enabled = False
		TransportForm.DriverExp.Enabled = False
	Else
		TransportForm.Driver_Age.Enabled = True
		TransportForm.DriverExp.Enabled = True
	End If
End Sub




Private Sub RegresLimit_Change()
	If TransportForm.RegresLimit.Value = "�� 1 ���������� ������" Then
		TransportForm.FranshizaFlag.Value = True
		TransportForm.FranshizaPercent.Value = 2
		TransportForm.FranshizaType.Value = "�����������"
		TransportForm.FranshizaFlag.Enabled = False
		TransportForm.FranshizaPercent.Enabled = False
		TransportForm.FranshizaType.Enabled = False
	Else
		TransportForm.FranshizaFlag.Value = False
		TransportForm.FranshizaPercent.Value = ""
		TransportForm.FranshizaFlag.Enabled = True
		TransportForm.FranshizaPercent.Enabled = True
		TransportForm.FranshizaType.Enabled = True
		TransportForm.KI.Enabled = True
	End If

End Sub




Private Sub TS_age_Change()

	age = TransportForm.TS_age.Value
	If (TransportForm.TS_InsurProgram.Value = "������ 50/50") Then
		If (TransportForm.TS_Category.Value = "1.3.   ��� ������, ������, 2110, 2111, 2112, 2113, 2114, 2115 � �����������, ������� ����, ������� ����, ���, ���") Then
			If (age > 3) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("���� ������������ �� �� ����� 3 ���.", vbInformation, "��������")
			End If
		Else
			If (age > 4) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("���� ������������ �� �� ����� 4 ���.", vbInformation, "��������")
			End If
		End If
	End If

	If (TransportForm.TS_InsurProgram.Value = "������ �� 1 ���������� ������") Then
		If (age > 10) Or (age < 0) Or (IsNumeric(age) = False) Then
			MsgBox("���� ������������ �� �� ����� 10 ���.", vbInformation, "��������")
		End If
	End If

	If (TransportForm.TS_InsurProgram.Value = "���������") Then
		If (age > 7) Or (age < 0) Or (IsNumeric(age) = False) Then
			MsgBox("���� ������������ �� �� ����� 7 ���.", vbInformation, "��������")
		End If
	End If

	If (TransportForm.TS_InsurProgram.Value = "������") Or (TransportForm.TS_InsurProgram.Value = "��������") Then
		If (TransportForm.TS_Category.Value = "1.1.   �������� (��� 2104, 05, 06, 07, 08, 09 � �����������) � ������ �������� �� �������������� ������������, �� �������� � ������ 1-3") Or (TransportForm.TS_Category.Value = "1.2.   ��� 11114 (���), �� 2126, 2717 � �����������, �������� ���") Or (TransportForm.TS_Category.Value = "1.3.   ��� ������, ������, 2110, 2111, 2112, 2113, 2114, 2115 � �����������, ������� ����, ������� ����, ���, ���") Then
			If (age > 3) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("���� ������������ �� �� ����� 3 ���.", vbInformation, "��������")
			End If
		Else
			If (age > 4) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("���� ������������ �� �� ����� 4 ���.", vbInformation, "��������")
			End If
		End If
	End If

	If (TransportForm.TS_InsurProgram.Value = "�������") Then
		If (TransportForm.CheckBox4.Value = True) Then
			If (age > 10) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("���� ������������ �� �� 0 �� 10 ���.", vbInformation, "��������")
			End If
		Else
			If (age > 10) Or (age < 4) Or (IsNumeric(age) = False) Then
				If (age <> 1) Then
					MsgBox("���� ������������ �� ����� 3-� ���, �� �� ����� 10-�� ���.", vbInformation, "��������")
				End If
			End If
		End If
	End If




	'If (age > 10) Or (age < 0) Or (IsNumeric(age) = False) Then
	'        MsgBox "���� ������������ �� �� ������ ��������� 10 ���.", vbInformation, "��������"
	'    End If

End Sub




Private Sub TS_Category_Change()

	TransportForm.TS_Risks.Clear()

	If (TransportForm.TS_InsurProgram.Value = "������") Or (TransportForm.TS_InsurProgram.Value = "��������") Or (TransportForm.TS_InsurProgram.Value = "�������") Then
		TransportForm.TS_Risks.AddItem "������� + �����"
		TransportForm.TS_Risks.AddItem "������� + ����� + ���"
		TransportForm.TS_Risks.AddItem "�����"
		TransportForm.TS_Risks.AddItem "����� + ���"
	ElseIf TransportForm.TS_InsurProgram.Value = "���������" Then
		TransportForm.TS_Risks.AddItem "������� + �����"
		TransportForm.TS_Risks.AddItem "�����"
	ElseIf (TransportForm.TS_InsurProgram.Value = "������ �� 1 ���������� ������") Then
		TransportForm.TS_Risks.AddItem "������� + �����"
		TransportForm.TS_Risks.AddItem "������� + ����� + ���"
	ElseIf (TransportForm.TS_InsurProgram.Value = "������ 50/50") Then
		TransportForm.TS_Risks.AddItem "������� + �����"
	End If

End Sub




Private Sub TS_DopFlag_Change()
	If TransportForm.TS_DopFlag.Value = True Then
		'TransportForm.TS_DopSalary.Value = 0
		TransportForm.TS_DopSalary.SetFocus()
	End If




End Sub




Private Sub TS_DopSalary_AfterUpdate()

	If TransportForm.TS_DopFlag.Value = True Then

		If (IsNumeric(TransportForm.TS_DopSalary.Value) = False) Or (TransportForm.TS_DopSalary.Value <= 0) Then
			MsgBox("�� ������ ����� ���. ������������!", vbInformation, "��������")
			TransportForm.TS_DopSalary.Value = 0
		End If

	End If

End Sub




Private Sub TS_HaveElectronicAlarm_Click()
	If TransportForm.TS_HaveElectronicAlarm.Value = True Then
		TransportForm.TS_NoDefendFlag.Value = False
		TransportForm.TS_SatelliteFlag.Value = False
	End If
End Sub




Private Sub TS_InsurProgram_Change()




	TransportForm.TS_Category.Clear()
	TransportForm.CalculationType.Clear()

	InsurProgram = TransportForm.TS_InsurProgram.Value
	If InsurProgram = "���������" Then
		TransportForm.RegresLimit.Visible = True
		TransportForm.CheckBox2.Visible = True
		TransportForm.Label18.Visible = True

	Else
		TransportForm.RegresLimit.Visible = False
		TransportForm.CheckBox2.Visible = False
		TransportForm.Label18.Visible = False

	End If




	If InsurProgram = "������ �� 1 ���������� ������" Then
		TransportForm.FranshizaFlag.Value = True
		TransportForm.FranshizaPercent.Value = 4
		TransportForm.FranshizaType.Value = "��������"
		TransportForm.FranshizaFlag.Enabled = False
		TransportForm.FranshizaPercent.Enabled = False
		TransportForm.FranshizaType.Enabled = False
		TransportForm.CheckBox4.Visible = False
	ElseIf InsurProgram = "������ 50/50" Then
		TransportForm.ComisPercent.Enabled = False
		TransportForm.Label17.Visible = False
		TransportForm.Viplat.Visible = False
		TransportForm.CheckBox3.Visible = True
		TransportForm.parck.Visible = True
		TransportForm.CheckBox1.Visible = False
		'
		TransportForm.TS_OrganisationFlag.Visible = False
		TransportForm.LDUNum.Visible = False
		TransportForm.Label15.Visible = False
		TransportForm.Label10.Visible = True
		TransportForm.Driver_Age.Visible = True
		TransportForm.Label11.Visible = True
		TransportForm.DriverExp.Visible = True
		'
		TransportForm.CheckBox1.Visible = False
		TransportForm.Label19.Visible = False
		TransportForm.ComboBox1.Visible = False
		TransportForm.TS_SatelliteFlag.Visible = False
		TransportForm.TS_NoDefendFlag.Visible = False
		TransportForm.TS_HaveElectronicAlarm.Visible = False
		TransportForm.TextBox1.Visible = False
		TransportForm.TextBox2.Visible = False
		TransportForm.Label20.Visible = False
		TransportForm.Label21.Visible = False
		TransportForm.FranshizaFlag.Value = True
		TransportForm.FranshizaPercent.Value = 8
		TransportForm.FranshizaType.Value = "�����������"
		TransportForm.FranshizaFlag.Enabled = False
		TransportForm.FranshizaPercent.Enabled = False
		TransportForm.FranshizaType.Enabled = False
		TransportForm.CheckBox4.Visible = False
	Else
		If InsurProgram = "�������" Then
			TransportForm.CheckBox4.Visible = True
		Else
			TransportForm.CheckBox4.Visible = False
		End If
		TransportForm.ComisPercent.Enabled = True
		TransportForm.Label17.Visible = True
		TransportForm.Viplat.Visible = True
		TransportForm.CheckBox3.Visible = True
		TransportForm.parck.Visible = True
		TransportForm.CheckBox1.Visible = True
		TransportForm.TS_OrganisationFlag.Visible = True
		TransportForm.LDUNum.Visible = True
		TransportForm.Label15.Visible = True
		TransportForm.Label10.Visible = True
		TransportForm.Driver_Age.Visible = True
		TransportForm.Label11.Visible = True
		TransportForm.DriverExp.Visible = True
		TransportForm.CheckBox1.Visible = True
		TransportForm.Label19.Visible = True
		TransportForm.ComboBox1.Visible = True
		TransportForm.TS_SatelliteFlag.Visible = True
		TransportForm.TS_NoDefendFlag.Visible = True
		TransportForm.TS_HaveElectronicAlarm.Visible = True
		TransportForm.TextBox1.Visible = True
		TransportForm.TextBox2.Visible = True
		TransportForm.Label20.Visible = True
		TransportForm.Label21.Visible = True
		TransportForm.FranshizaFlag.Value = False
		TransportForm.FranshizaFlag.Enabled = True
		TransportForm.FranshizaPercent.Enabled = True
		TransportForm.FranshizaType.Enabled = True
		TransportForm.KI.Enabled = True
	End If

	TransportForm.KI.Value = 1
	TransportForm.KI.Enabled = False





	Select Case (InsurProgram)
		Case "������ 50/50"
			TransportForm.TS_Category.AddItem "1.3.   ��� ������, ������, 2110, 2111, 2112, 2113, 2114, 2115 � �����������, ������� ����, ������� ����, ���, ���"
			TransportForm.TS_Category.AddItem "2.2.1. ��������� �������� ���������� �� ��������� ������: �� 400 000 ���"
			TransportForm.TS_Category.AddItem "2.2.2. ��������� �������� ���������� �� ��������� ������: �� 400 001 �� 800 000 ���"
			TransportForm.TS_Category.AddItem "2.2.3. ��������� �������� ���������� �� ��������� ������: �� 800 001 �� 1 200 000 ���"
			TransportForm.TS_Category.AddItem "2.2.4. ��������� �������� ���������� �� ��������� ������: �� 1 200 001 �� 2 000 000 ���"
			TransportForm.TS_Category.AddItem "2.2.5. ��������� �������� ���������� �� ��������� ������: �� 2 000 001 ���"
		Case Else
			TransportForm.TS_Category.AddItem "1.1.   �������� (��� 2104, 05, 06, 07, 08, 09 � �����������) � ������ �������� �� �������������� ������������, �� �������� � ������ 1-3"
			TransportForm.TS_Category.AddItem "1.2.   ��� 11114 (���), �� 2126, 2717 � �����������, �������� ���"
			TransportForm.TS_Category.AddItem "1.3.   ��� ������, ������, 2110, 2111, 2112, 2113, 2114, 2115 � �����������, ������� ����, ������� ����, ���, ���"
			TransportForm.TS_Category.AddItem "2.2.1. ��������� �������� ���������� �� ��������� ������: �� 400 000 ���"
			TransportForm.TS_Category.AddItem "2.2.2. ��������� �������� ���������� �� ��������� ������: �� 400 001 �� 800 000 ���"
			TransportForm.TS_Category.AddItem "2.2.3. ��������� �������� ���������� �� ��������� ������: �� 800 001 �� 1 200 000 ���"
			TransportForm.TS_Category.AddItem "2.2.4. ��������� �������� ���������� �� ��������� ������: �� 1 200 001 �� 2 000 000 ���"
			TransportForm.TS_Category.AddItem "2.2.5. ��������� �������� ���������� �� ��������� ������: �� 2 000 001 ���"
			TransportForm.TS_Category.AddItem "3.1.   �������������, ������� � ����-��������� �� �� ���� �� 3,5�, � �.�. ""������"" - ��� 3302, 3221, 2217, 2751"
			TransportForm.TS_Category.AddItem "3.2.   ���� - ���������"
			TransportForm.TS_Category.AddItem "3.3.   ��������"
			TransportForm.TS_Category.AddItem "3.4.   ���������"
			TransportForm.TS_Category.AddItem "3.5.   ����������� (��������������, �������������, �����������, ��������, ����� � �.�.)"
			TransportForm.TS_Category.AddItem "3.6.   ������ �� �������, �����������"
	End Select

	Select Case InsurProgram
		Case "������", "��������", "������ 50/50", "���������"
			'����������� ������� ���������� ����������
			TransportForm.CalculationType.AddItem "�� ����������� �����������"
			TransportForm.CalculationType.AddItem "�� ����������� ����������� / �� ������ ���� �� �������"
			TransportForm.CalculationType.AddItem "�� ����������� ����������� / �� ������ ���� �� ������� / �� ������ ���� �� ������"
		Case Else
			TransportForm.CalculationType.AddItem "�� ����������� �����������"
	End Select

End Sub





Private Sub TS_NoDefendFlag_Click()
	If TransportForm.TS_NoDefendFlag.Value = True Then
		TransportForm.TS_SatelliteFlag.Value = False
		TransportForm.TS_HaveElectronicAlarm.Value = False
	End If
End Sub




Private Sub TS_OrganisationFlag_Change()




	TransportForm.Driver_Age.Enabled = Not (TransportForm.TS_OrganisationFlag.Value)
	TransportForm.DriverExp.Enabled = Not (TransportForm.TS_OrganisationFlag.Value)
	TransportForm.LDUNum.Enabled = Not (TransportForm.TS_OrganisationFlag.Value)

End Sub




Private Sub TS_salary_AfterUpdate()




	Salary = TransportForm.TS_salary.Value
	If (IsNumeric(Salary) = False) Or (Salary <= 0) Then
		MsgBox("�� ��������� ������� ��������� ������������� ��������", vbInformation, "��������")
	End If

	If (TransportForm.TS_InsurProgram.Value = "�������") Then
		If (TransportForm.CheckBox4.Value = True) Then
			If (TransportForm.TS_age.Value > 10) Or (TransportForm.TS_age.Value < 0) Then
				MsgBox("���� ������������ �� �� 0 �� 10 ���.", vbInformation, "��������")
			End If
		Else
			If (TransportForm.TS_age.Value > 10) Or (TransportForm.TS_age.Value < 4) Then
				MsgBox("���� ������������ �� ����� 3-� ���, �� �� ����� 10-�� ���.", vbInformation, "��������")
			End If
		End If
	End If




End Sub





Private Sub TS_SatelliteFlag_Click()
	If TransportForm.TS_SatelliteFlag.Value = True Then
		TransportForm.TS_NoDefendFlag.Value = False
		TransportForm.TS_HaveElectronicAlarm.Value = False
	End If
End Sub




Private Sub UserForm_Initialize()









	'TransportForm.TS_Category.Value = "1.1. �������� (��� 2104, 05, 06, 07, 08, 09 � �����������) � ������ �������� �� �������������� ������������, �� �������� � ������ 1-3"

	TransportForm.TS_age.Value = 0

	TransportForm.TS_InsurProgram.AddItem "������"
	TransportForm.TS_InsurProgram.AddItem "��������"
	TransportForm.TS_InsurProgram.AddItem "�������"
	TransportForm.TS_InsurProgram.AddItem "������ 50/50"
	TransportForm.TS_InsurProgram.AddItem "������ �� 1 ���������� ������"
	TransportForm.TS_InsurProgram.AddItem "���������"

	TransportForm.DriverKBM.Value = 1
	TransportForm.KI.Value = 1
	TransportForm.TextBox1.Value = 1
	TransportForm.TextBox2.Value = 1
	TransportForm.FranshizaFlag.Value = False
	TransportForm.FranshizaPercent.Visible = TransportForm.FranshizaFlag.Value
	TransportForm.FranshizaType.Visible = TransportForm.FranshizaFlag.Value
	TransportForm.T_FranshizaPercent.Visible = TransportForm.FranshizaFlag.Value


	'����� ���������� (���� �� ���������, ����������)
	TransportForm.RegresLimit.Visible = False
	TransportForm.CheckBox2.Visible = False
	TransportForm.Label18.Visible = False
	TransportForm.parck.Enabled = False

	'���������� ���
	TransportForm.LDUNum.AddItem "��� �����������"
	TransportForm.LDUNum.AddItem "�� ����� 3-� ���������"
	TransportForm.LDUNum.AddItem "4 ��������"
	TransportForm.LDUNum.AddItem "5 ���������"
	TransportForm.LDUNum.AddItem "����� ���� �� 33 ���"

	'������������� �������� �� ���������
	TransportForm.Driver_Age.Value = 18
	TransportForm.DriverExp.Value = 0
	TransportForm.TS_salary.Value = 0
	TransportForm.T_KI.Visible = False
	TransportForm.CheckBox4.Visible = False

	TransportForm.ComisPercent.Value = 20

	'TransportForm.PrintButton.Visible = False

	TransportForm.Viplat.AddItem "1 ��� �� ������ �����������"
	TransportForm.Viplat.AddItem "2 ���� �� ������ �����������"
	TransportForm.Viplat.AddItem "�� �������������� (1 �������)"
	TransportForm.Viplat.AddItem "�� �������������� (2 �������)"

	TransportForm.RegresLimit.AddItem "������������ �����"
	TransportForm.RegresLimit.AddItem "���������� �����"
	TransportForm.RegresLimit.AddItem "�� 1 ���������� ������"




	TransportForm.parck.AddItem "2-5 ��"
	TransportForm.parck.AddItem "6-9 ��"
	TransportForm.parck.AddItem "10 � ����"




	TransportForm.ComboBox1.AddItem "�� 5-�� ����"
	TransportForm.ComboBox1.AddItem "�� 15-�� ����"
	TransportForm.ComboBox1.AddItem "�� 1-�� ������"
	TransportForm.ComboBox1.AddItem "�� 2-� �������"
	TransportForm.ComboBox1.AddItem "�� 3-� �������"
	TransportForm.ComboBox1.AddItem "�� 4-� �������"
	TransportForm.ComboBox1.AddItem "�� 5-�� �������"
	TransportForm.ComboBox1.AddItem "�� 6-�� �������"
	TransportForm.ComboBox1.AddItem "�� 7-�� �������"
	TransportForm.ComboBox1.AddItem "�� 8-�� �������"
	TransportForm.ComboBox1.AddItem "�� 9-�� �������"
	TransportForm.ComboBox1.AddItem "�� 10-�� �������"
	TransportForm.ComboBox1.AddItem "�� 11-�� �������"
	TransportForm.ComboBox1.AddItem "�� 12-�� �������"





End Sub








