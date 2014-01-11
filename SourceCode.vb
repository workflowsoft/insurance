
'
' Функции для вычисления суммы прописью по
' числовому значению от 0 до 999999999999
'
' Вспомогательные переменные
Dim Тысячи, Миллионы As Boolean
Dim Миллиарды, ВторойДесяток As Boolean
' Массмв составных частей
Dim Часть(32) As String
' Логические константы
Const Истина As Boolean = True
Const Ложь As Boolean = False
'
' Функция возвращает сумму прописью в рублях
'
Function СуммаПрописью(Рубли)
	' Считаем копейки
	Переменная = (Рубли - Fix(Рубли)) * 100
	If (Переменная - Fix(Переменная)) >= 0.5 Then
		If Переменная >= 99.5 Then
			Переменная = 0
			Рубли = Рубли + 1
		Else
			Переменная = Fix(Переменная) + 1
		End If
	Else
		Переменная = Fix(Переменная)
	End If
	Копейки = CStr(Переменная)
	' Вызов функции для получения числа прописью
	Число = CStr(Fix(Рубли))
	МужскойРод = Истина
	СуммаПрописью = ЧислоПрописью(Число, МужскойРод)
	' Строку с заглавной буквы
	СуммаПрописью = UCase(Mid(СуммаПрописью, 1, 1)) + _
						   Mid(СуммаПрописью, 2)
	' Вычислить длину исходного числа
	Длина = Len(Число)
	' Если число только из одной цифры, добавить
	' до двух (для единообразия алгоритма)
	If Длина = 1 Then
		Число = "0" & Число
		Длина = Длина + 1
	End If
	' Добавление нужного окончания строки
	'
	' Для чисел, оканчивающихся на 10, 11, 12, 13,
	' 14, 15, 16, 17, 18, 19 добавляем "рублей"
	If Mid(Число, Длина - 1, 1) = 1 Then
		СуммаПрописью = СуммаПрописью + "рублей"
		' Для всех остальных случаев
	Else
		Select Case Mid(Число, Длина)
			' Для чисел, оканчивающихся на 1 добавляем "рубль"
			Case 1
				СуммаПрописью = СуммаПрописью + "рубль"
				' Для чисел, оканчивающихся на 2, 3, 4
				' добавляем "рубля"
			Case 2, 3, 4
				СуммаПрописью = СуммаПрописью + "рубля"
				' Для чисел, оканчивающихся на 5, 6, 7, 8,
				' 9, 0 добавляем "рублей"
			Case Else
				СуммаПрописью = СуммаПрописью + "рублей"
		End Select
	End If
	' Окончательно формируем результат, добавляя копейки
	If Len(Копейки) = 1 Then
		Копейки = "0" + Копейки
	End If
	СуммаПрописью = СуммаПрописью + " " + Копейки + " "
	' Для чисел, оканчивающихся на 10, 11, 12, 13,
	' 14, 15, 16, 17, 18, 19 добавляем "копеек"
	If Mid(Копейки, 1, 1) = 1 Then
		СуммаПрописью = СуммаПрописью + "копеек"
		' Для всех остальных случаев
	Else
		Select Case Mid(Копейки, 2)
			' Для чисел, оканчивающихся на 1 добавляем "копейка"
			Case 1
				СуммаПрописью = СуммаПрописью + "копейка"
				' Для чисел, оканчивающихся на 2, 3, 4
				' добавляем "копеек"
			Case 2, 3, 4
				СуммаПрописью = СуммаПрописью + "копейки"
				' Для чисел, оканчивающихся на 5, 6, 7, 8,
				' 9, 0 добавляем "копеек"
			Case Else
				СуммаПрописью = СуммаПрописью + "копеек"
		End Select
	End If
End Function
'
' функция возвращает число прописью
'
Function ЧислоПрописью(Число, Optional МужскойРод = Истина)
	' Присвоение значений массиву частей
	Часть(1) = "оди" : Часть(2) = "два"
	Часть(3) = "три" : Часть(4) = "четыр"
	Часть(5) = "пят" : Часть(6) = "шест"
	Часть(7) = "сем" : Часть(8) = "восем"
	Часть(9) = "девят" : Часть(10) = "н"
	Часть(11) = "е" : Часть(12) = "ь"
	Часть(13) = "надцать" : Часть(14) = "дцать"
	Часть(15) = "сорок" : Часть(16) = "девяно"
	Часть(17) = "сто" : Часть(18) = "две"
	Часть(19) = "сти" : Часть(20) = "сот"
	Часть(21) = "одна" : Часть(22) = "тысяч"
	Часть(23) = "а" : Часть(24) = "и"
	Часть(25) = "миллион" : Часть(26) = "ов"
	Часть(27) = " " : Часть(28) = ""
	Часть(29) = "десят" : Часть(30) = "ста"
	Часть(31) = "миллиард" : Часть(32) = "ноль "
	' Временные переменные вначале сбрасываются
	Тысячи = Ложь : Миллионы = Ложь
	Миллиарды = Ложь : ВторойДесяток = Ложь
	' Отбрасываем дробную часть, если она есть
	Число = Fix(Число)
	' Определяем длину исходного числа
	Длина = Len(Число)
	' Цикл по всем цифрам числа, начиная с крайней
	' левой до крайней правой
	For Позиция = Длина To 1 Step -1
		' Добавляются очередные слова, описывающие
		' текущую цифру
		ЧислоПрописью = ЧислоПрописью + _
						 ЦифраСтрокой(Mid(Число, _
						 Длина - Позиция + 1, 1), _
						 Позиция, МужскойРод)
	Next Позиция
	' Алгоритм возвращает пустую строку при
	' нулевом аргументе. Исправим это
	If ЧислоПрописью = "" Then
		ЧислоПрописью = Часть(32)
	End If
End Function
'
' Составление слов из частей по очередной
' цифре числа и по предистории работы
'
' Функция доступна только в текущем модуле
'
Private Function ЦифраСтрокой(Цифра, Место, Род) As String
	' Если сотни или десятки миллиардов, то
	' запомнить об этом для будущего
	If (Цифра <> 0) And ((Место = 11) Or _
		 (Место = 12)) Then
		Миллиарды = Истина
	End If
	' Если сотни или десятки миллионов, то
	' запомнить об этом для будущего
	If (Цифра <> 0) And ((Место = 8) Or _
		 (Место = 9)) Then
		Миллионы = Истина
	End If
	' Если сотни или десятки тысяч, то
	' запомнить об этом для будущего
	If (Цифра <> 0) And ((Место = 5) Or _
		 (Место = 6)) Then
		Тысячи = Истина
	End If
	' Если предыдущая цифра была единица
	' в пеле десятков, то выбираем
	If ВторойДесяток Then
		Select Case Цифра
			' пишем "десять "
			Case 0
				ЦифраСтрокой = Часть(29) + Часть(12) + _
							   Часть(27)
				' пишем "одиннадцать "
			Case 1
				ЦифраСтрокой = Часть(1) + Часть(10) + _
							   Часть(13) + Часть(27)
				' пишем "двенадцать "
			Case 2
				ЦифраСтрокой = Часть(18) + Часть(13) + _
							   Часть(27)
				' в остальных случаях пишем название цифры
				' плюс "надцать "
			Case Else
				ЦифраСтрокой = Часть(Цифра) + Часть(13) + _
							   Часть(27)
		End Select
		' Добавляем название разрядов
		Select Case Место
			Case 4
				' добавляем "тысяч "
				ЦифраСтрокой = ЦифраСтрокой + Часть(22) + _
							   Часть(27)
				' добавляем "миллионов "
			Case 7
				ЦифраСтрокой = ЦифраСтрокой + Часть(25) + _
							   Часть(26) + Часть(27)
				' добавляем "миллиардов "
			Case 10
				ЦифраСтрокой = ЦифраСтрокой + Часть(31) + _
							   Часть(26) + Часть(27)
		End Select
		' Сбрасываем значения, так как переходим к
		' предыдущим разрядам
		ВторойДесяток = Ложь : Миллионы = Ложь
		Миллиарды = Ложь : Тысячи = Ложь
		' Во всех остальных случаях, то есть
		' не для описания чисел второго десятка
	Else
		' Определяем название десятков
		If (Место = 2) Or (Место = 5) Or _
			  (Место = 8) Or (Место = 11) Then
			Select Case Цифра
				' Запоминаем про второй десяток для
				' подстановки при следующем входе
				Case 1
					ВторойДесяток = Истина
					' пишем "двадцать" или "тридцать"
				Case 2, 3
					ЦифраСтрокой = Часть(Цифра) + Часть(14) + _
								   Часть(27)
					' пишем "сорок "
				Case 4
					ЦифраСтрокой = Часть(15) + Часть(27)
					' пишем "девяносто "
				Case 9
					ЦифраСтрокой = Часть(16) + Часть(17) + _
								   Часть(27)
					' в остальных случаях пишем название цифры
					' плюс "десят "
				Case 5, 6, 7, 8
					ЦифраСтрокой = Часть(Цифра) + Часть(12) + _
								   Часть(29) + Часть(27)
			End Select
		End If
		' Определяем названия сотен
		If (Место = 3) Or (Место = 6) Or _
			  (Место = 9) Or (Место = 12) Then
			Select Case Цифра
				' пишем "сто "
				Case 1
					ЦифраСтрокой = Часть(17) + Часть(27)
					' пишем "двести "
				Case 2
					ЦифраСтрокой = Часть(18) + Часть(19) + _
								   Часть(27)
					' пишем "триста "
				Case 3
					ЦифраСтрокой = Часть(3) + Часть(30) + _
								   Часть(27)
					' пишем "четыреста "
				Case 4
					ЦифраСтрокой = Часть(4) + Часть(11) + _
								   Часть(30) + Часть(27)
					' в остальных случаях пишем название цифры
					' плюс "сот "
				Case 5, 6, 7, 8, 9
					ЦифраСтрокой = Часть(Цифра) + Часть(12) + _
								   Часть(20) + Часть(27)
			End Select
		End If
		' Определяем названия единиц
		If (Место = 1) Or (Место = 4) Or _
			  (Место = 7) Or (Место = 10) Then
			Select Case Цифра
				' пишем "один " или "одна "
				Case 1
					If (Род) Or _
					 (Место = 7) Or (Место = 10) Then
						ЦифраСтрокой = Часть(1) + Часть(10) + _
									Часть(27)
					Else
						ЦифраСтрокой = Часть(21) + Часть(27)
					End If
					' пишем "два " или "две "
				Case 2
					If (Род) Or _
					 (Место = 7) Or (Место = 10) Then
						ЦифраСтрокой = Часть(Цифра) + Часть(27)
					Else
						ЦифраСтрокой = Часть(18) + Часть(27)
					End If
					' пишем "три "
				Case 3
					ЦифраСтрокой = Часть(Цифра) + Часть(27)
					' пишем "четыре "
				Case 4
					ЦифраСтрокой = Часть(4) + Часть(11) + _
								   Часть(27)
					' в остальных случаях пишем название цифры
				Case 5, 6, 7, 8, 9
					ЦифраСтрокой = Часть(Цифра) + Часть(12) + _
								   Часть(27)
			End Select
			' Определяем названия тысяч
			If Место = 4 Then
				Select Case Цифра
					' пишем "тысяч " только в том случае, если
					' хотя бы в одном разряде тысяч есть не нулевое
					' значение
					Case 0
						If Тысячи Then
							ЦифраСтрокой = Часть(22) + Часть(27)
						End If
						' пишем "одна тысяча "
					Case 1
						ЦифраСтрокой = Часть(21) + Часть(27) + _
							   Часть(22) + Часть(23) + Часть(27)
						' пишем "две тысячи "
					Case 2
						ЦифраСтрокой = Часть(18) + Часть(27) + _
							   Часть(22) + Часть(24) + Часть(27)
						' добавляем "тысячи "
					Case 3, 4
						ЦифраСтрокой = ЦифраСтрокой + Часть(22) + _
									   Часть(24) + Часть(27)
						' в остальных случаях добавляем "тысяч "
					Case 5, 6, 7, 8, 9
						ЦифраСтрокой = ЦифраСтрокой + Часть(22) + _
									   Часть(27)
				End Select
				' Сбрасываем значения тысяч, так как
				' переходим к предыдущим разрядам
				Тысячи = Ложь
			End If
			' Определяем названия миллионов
			If Место = 7 Then
				Select Case Цифра
					' пишем "миллионов " только в том случае,
					' если хотя бы в одном разряде миллионов
					' есть не нулевое значение
					Case 0
						If Миллионы Then
							ЦифраСтрокой = Часть(25) + Часть(26) + _
										   Часть(27)
						End If
						' добавляем "миллион "
					Case 1
						ЦифраСтрокой = ЦифраСтрокой + Часть(25) + _
									   Часть(27)
						' добавляем "миллиона "
					Case 2, 3, 4
						ЦифраСтрокой = ЦифраСтрокой + Часть(25) + _
									   Часть(23) + Часть(27)
						' добавляем "миллионов "
					Case 5, 6, 7, 8, 9
						ЦифраСтрокой = ЦифраСтрокой + Часть(25) + _
									   Часть(26) + Часть(27)
				End Select
				' Сбрасываем значения миллионов, так как
				' переходим к предыдущим разрядам
				Миллионы = Ложь
			End If
			' Определяем названия миллиардов
			If Место = 10 Then
				Select Case Цифра
					' пишем "миллиардов " только в том случае,
					' если хотя бы в одном разряде миллиардов
					' есть не нулевое значение
					Case 0
						If Миллиарды Then
							ЦифраСтрокой = Часть(31) + Часть(26) + _
										   Часть(27)
						End If
						' добавляем "миллиард "
					Case 1
						ЦифраСтрокой = ЦифраСтрокой + Часть(31) + _
									   Часть(27)
						' добавляем "миллиарда "
					Case 2, 3, 4
						ЦифраСтрокой = ЦифраСтрокой + Часть(31) + _
									   Часть(23) + Часть(27)
						' добавляем "миллиардов "
					Case 5, 6, 7, 8, 9
						ЦифраСтрокой = ЦифраСтрокой + Часть(31) + _
									   Часть(26) + Часть(27)
				End Select
				' Сбрасываем значения миллиардов, так как
				' переходим к предыдущим разрядам
				Миллиарды = Ложь
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

	Tarif = "Сведения о тарифе: "
	TheCol = ""
	DOSum = 0

	CategoryTS = Trim(Mid(TransportForm.TS_Category.Value, 1, 6))
	'MsgBox "'" & CategoryTS & "'"
	TSExp = CInt(TransportForm.TS_age.Value)
	Risk = TransportForm.TS_Risks.Value
	InsurProgram = TransportForm.TS_InsurProgram.Value

	CalcType = TransportForm.CalculationType.Value


	'Считаем базовый тариф по объекту
	Select Case (CategoryTS)
		Case "1.1."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "5"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "6"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "7"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "8"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "9"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "10"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "11"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "7"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "8"
			End If
		Case "1.2."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "13"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "14"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "15"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "16"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "17"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "18"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "19"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "9"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "10"
			End If
		Case "1.3."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "21"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "22"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "23"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "24"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "25"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "26"
			ElseIf (Risk = "ХИЩЕНИЕ + УЩЕРБ") And (InsurProgram = "Эконом 50/50") Then
				TheCol = "27"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "28"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "11"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "12"
			End If
		Case "2.2.1."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "30"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "31"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "32"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "33"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "34"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "35"
			ElseIf (Risk = "ХИЩЕНИЕ + УЩЕРБ") And (InsurProgram = "Эконом 50/50") Then
				TheCol = "36"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "37"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "13"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "14"
			End If
		Case "2.2.2."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "39"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "40"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "41"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "42"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "43"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "44"
			ElseIf (Risk = "ХИЩЕНИЕ + УЩЕРБ") And (InsurProgram = "Эконом 50/50") Then
				TheCol = "45"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "46"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "15"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "16"
			End If
		Case "2.2.3."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "48"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "49"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "50"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "51"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "52"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "53"
			ElseIf (Risk = "ХИЩЕНИЕ + УЩЕРБ") And (InsurProgram = "Эконом 50/50") Then
				TheCol = "54"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "55"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "17"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "18"
			End If
		Case "2.2.4."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "57"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "58"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "59"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "60"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "61"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "62"
			ElseIf (Risk = "ХИЩЕНИЕ + УЩЕРБ") And (InsurProgram = "Эконом 50/50") Then
				TheCol = "63"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "64"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "19"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "20"
			End If
		Case "2.2.5."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "66"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "67"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "68"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "69"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "70"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "71"
			ElseIf (Risk = "ХИЩЕНИЕ + УЩЕРБ") And (InsurProgram = "Эконом 50/50") Then
				TheCol = "72"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "73"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "21"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "22"
			End If
		Case "3.1."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "75"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "76"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "77"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "78"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "79"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "80"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "81"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "23"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "24"
			End If
		Case "3.2."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "83"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "84"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "85"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "86"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "87"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "88"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "89"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "25"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "26"
			End If
		Case "3.3."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "91"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "92"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "93"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "94"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "95"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "96"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "97"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "27"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "28"
			End If
		Case "3.4."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "99"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "100"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "101"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "102"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "103"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "104"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "105"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "29"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "30"
			End If
		Case "3.5."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "107"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "108"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "109"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "110"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "111"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "112"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "113"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "31"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "32"
			End If
		Case "3.6."
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "115"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Бизнес") Then
				TheCol = "116"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "117"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Стандарт") Then
				TheCol = "118"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "119"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Оптимал") Then
				TheCol = "120"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Эконом до 1 страхового случая") Then
				TheCol = "121"
			ElseIf ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "33"
			ElseIf ((Risk = "УЩЕРБ + УТС") Or (Risk = "УЩЕРБ")) And (InsurProgram = "Универсал") Then
				TheCol = "34"
			End If
	End Select

	If TransportForm.TS_InsurProgram.Value = "Универсал" Then
		If TransportForm.CheckBox2.Value = True Then
			'Таблица Universal
			TheRow = 15 + TSExp
		Else
			TheRow = 7 + TSExp
		End If
	Else
		'Таблица Tarifi
		Select Case (CalcType)
			Case "По калькуляции страховщика"
				TheRow = 7 + TSExp
			Case "По калькуляции страховщика / По счетам СТОА из перечня"
				TheRow = 18 + TSExp
			Case "По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору"
				TheRow = 23 + TSExp
		End Select
	End If




	If TransportForm.TS_InsurProgram.Value = "Универсал" Then
		WS = ActiveWorkbook.Sheets("Universal")
	Else
		WS = ActiveWorkbook.Sheets("Tarifi")
	End If
	BaseTarif = WS.Cells(CInt(TheCol), CInt(TheRow)).Value
	Worksheets("Data").Cells(14, 2).Value = BaseTarif

	'Считаем Поправочные коэф.
	Ksp = 1		  'Ксп - коэф. страхового продукта
	Kf = 1		  'Кф  - коэф. франшизы
	Kvs = 1		  'Квс - коэф. возраста/стажа
	Kl = 1		  'Кл  - коэф. количества лиц, допущенных к управлению.
	KI = TransportForm.KI.Value			'Ки  - коэф. использования ТС
	Kbm = TransportForm.DriverKBM.Value	'Кбм - коэф. Бонус-Малус
	Kps = 1		  'Кпс - коэф. использования противоугонной системы
	KUTS = 0	  'КУТС- коэф. УТС
	Worksheets("Data").Cells(8, 1).Value = "-"
	Worksheets("Data").Cells(8, 2).Value = "-"
	Worksheets("Data").Cells(8, 3).Value = "-"
	'--------------------------------------------------------------------------------------
	'KUTS
	If (TransportForm.TS_Risks.Value = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (TransportForm.TS_Risks.Value = "УЩЕРБ + УТС") Then
		KUTS = 1.3
	End If
	'---------------------------------------------------------------------------------------
	'Kf
	If (TransportForm.FranshizaFlag.Enabled = False) And (TransportForm.FranshizaPercent.Value = 2) And (TransportForm.FranshizaFlag.Value = True) Then
		'Либо Эконом до 1 страхового случая, либо для ТС сдающихся в прокат. В таком случае Кф = 1
		Kf = 1
		Worksheets("Data").Cells(8, 1).Value = "-"
		Worksheets("Data").Cells(8, 2).Value = "-"
		Worksheets("Data").Cells(8, 3).Value = "-"
	ElseIf (TransportForm.FranshizaFlag.Value = True) Then
		If TransportForm.FranshizaType.Value = "Безусловная" Then
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
			Worksheets("Data").Cells(8, 1).Value = "Безусловная"
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) Then
				Worksheets("Data").Cells(8, 2).Value = "ХИЩЕНИЕ + УЩЕРБ"
			Else
				Worksheets("Data").Cells(8, 2).Value = "УЩЕРБ"
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
			Worksheets("Data").Cells(8, 1).Value = "Условная"
			If ((Risk = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (Risk = "ХИЩЕНИЕ + УЩЕРБ")) Then
				Worksheets("Data").Cells(8, 2).Value = "ХИЩЕНИЕ + УЩЕРБ"
			Else
				Worksheets("Data").Cells(8, 2).Value = "УЩЕРБ"
			End If
			Worksheets("Data").Cells(8, 3).Value = TransportForm.FranshizaPercent.Value
		End If
	End If
	'--------------------------------------------------------------------------------------

	'Kvs
	If TransportForm.LDUNum.Value = "Без ограничений" Then
		Kvs = 1
	ElseIf TransportForm.LDUNum.Value = "Любые лица от 33 лет" Then
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
	ElseIf TransportForm.LDUNum.Value = "Любые лица от 33 лет" Then
		Kl = 1.25
	Else
		Select Case (TransportForm.LDUNum.Value)
			Case "Без ограничений" : Kl = 1.4
			Case "Не более 3-х водителей" : Kl = 1
			Case "4 водителя" : Kl = 1.1
			Case "5 водителей" : Kl = 1.2
		End Select
	End If
	'-------------------------------------------------------------------------
	'Коэффициент парковости
	If TransportForm.CheckBox3.Value = True Then
		If TransportForm.parck.Value = "2-5 ТС" Then
			kp = 0.98
		ElseIf TransportForm.parck.Value = "6-9 ТС" Then
			kp = 0.95
		ElseIf TransportForm.parck.Value = "10 и выше" Then
			kp = 0.9
		End If
	Else
		kp = 1
	End If
	'-------------------------------------------------------------------------
	'Коэффициент срока действия договора
	If TransportForm.ComboBox1.Value = "до 5-ти дней" Then
		ksd = 0.05
	ElseIf TransportForm.ComboBox1.Value = "до 15-ти дней" Then
		ksd = 0.1
	ElseIf TransportForm.ComboBox1.Value = "до 1-го месяца" Then
		ksd = 0.2
	ElseIf TransportForm.ComboBox1.Value = "до 2-х месяцев" Then
		ksd = 0.3
	ElseIf TransportForm.ComboBox1.Value = "до 3-х месяцев" Then
		ksd = 0.4
	ElseIf TransportForm.ComboBox1.Value = "до 4-х месяцев" Then
		ksd = 0.5
	ElseIf TransportForm.ComboBox1.Value = "до 5-ти месяцев" Then
		ksd = 0.6
	ElseIf TransportForm.ComboBox1.Value = "до 6-ти месяцев" Then
		ksd = 0.7
	ElseIf TransportForm.ComboBox1.Value = "до 7-ми месяцев" Then
		ksd = 0.75
	ElseIf TransportForm.ComboBox1.Value = "до 8-ми месяцев" Then
		ksd = 0.8
	ElseIf TransportForm.ComboBox1.Value = "до 9-ти месяцев" Then
		ksd = 0.85
	ElseIf TransportForm.ComboBox1.Value = "до 10-ти месяцев" Then
		ksd = 0.9
	ElseIf TransportForm.ComboBox1.Value = "до 11-ти месяцев" Then
		ksd = 0.95
	ElseIf TransportForm.ComboBox1.Value = "до 12-ти месяцев" Then
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

	'Ккв
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

	'Единовременная оплата страховой премии
	If TransportForm.CheckBox1.Value = True Then
		ko = 0.97
	Else
		ko = 1
	End If




	If TransportForm.TS_InsurProgram.Value = "Универсал" Then
		'Коэффициент лимита возмещения
		If TransportForm.RegresLimit.Value = "Неагрегатный лимит" Then
			klv = 1
		ElseIf TransportForm.RegresLimit.Value = "Агрегатный лимит" Then
			klv = 0.95
		ElseIf TransportForm.RegresLimit.Value = "До 1 страхового случая" Then
			klv = 0.6
		End If
	End If




	'Коэффициент возмещения
	If (klv = 1) Or (klv = 0.95) Then
		If TransportForm.CalculationType.Value = "По калькуляции страховщика" Then
			kctoa = 1
		ElseIf TransportForm.CalculationType.Value = "По калькуляции страховщика / По счетам СТОА из перечня" Then
			kctoa = 1.05
		ElseIf TransportForm.CalculationType.Value = "По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору" Then
			kctoa = 1.2
		End If
	End If




	If TransportForm.TS_InsurProgram.Value = "Универсал" Then
		If (klv = 0.6) Then
			kctoa = 1
		End If
	End If




	'«Выплаты без справок»
	vbc = 1
	If InsurProgram = "Бизнес" Then
		Select Case (TransportForm.Viplat.Value)
			Case "1 раз за период страхования" : vbc = 1
			Case "2 раза за период страхования" : vbc = 1
			Case "Не осуществляются (1 вариант)" : vbc = 0.95
			Case "Не осуществляются (2 вариант)" : vbc = 0.9
		End Select
	Else
		Select Case (TransportForm.Viplat.Value)
			Case "1 раз за период страхования" : vbc = 1
			Case "2 раза за период страхования" : vbc = 1.1
			Case "Не осуществляются (1 вариант)" : vbc = 0.95
			Case "Не осуществляются (2 вариант)" : vbc = 0.9
		End Select
	End If




	If InsurProgram = "Универсал" Then
		'ksd = 1
		If TransportForm.RegresLimit.Value = "До 1 страхового случая" Then
			Kf = 1
		End If




	End If
	If InsurProgram = "Эконом до 1 страхового случая" Then
		Kf = 1
	End If




	If (InsurProgram = "Оптимал") And (TransportForm.CheckBox4.Value = True) Then
		Kf = 1
	End If




	'Коэффициент андрайтера
	ka = TransportForm.TextBox2.Value




	'Коэф. страхового продукта
	Ksp = TransportForm.TextBox1.Value
	If TransportForm.TS_InsurProgram.Value = "Эконом 50/50" Then
		ksd = 1
	End If




	'Считаем тариф по доп. оборудованию
	If TransportForm.TS_DopFlag = True Then
		DOTarif = 10 * ksd * ka * kkv
		DopSalary = TransportForm.TS_DopSalary.Value
		DOSum = Round(CDbl(DopSalary) * DOTarif / 100, 2)
		Tarif = Tarif + Chr(13) + "Тариф по доп. оборудованию = 10%. Ксд =" & ksd & ". Ка=" & ka & ". Ккв=" & kkv & ". Премия по доп. оборудованию = " & DOSum
		TransportForm.T_Tarif.Caption = Tarif
	End If





	'Считаем тариф с учетом всех поправочных
	If TransportForm.TS_InsurProgram.Value = "Эконом 50/50" Then
		Tarif = Tarif + Chr(13) + "Базовый тариф=" & BaseTarif & ". КБМ=" & Kbm & ". Кф=" & Kf & ". Кп=" & kp & ". Квс=" & Kvs
		BaseTarif = Round(BaseTarif * Kbm * Kf * kp * Kvs, 2)
		Prem = Round(TransportForm.TS_salary.Value * BaseTarif / 100, 2)
		Worksheets("Data").Cells(15, 2).Value = 1
		'Tarif = Tarif + Chr(13) + "Базовый тариф=" & BaseTarif & ". Кпс=" & Kps & ". КБМ=" & Kbm & ". Ки=" & Ki & ". Кл=" & Kl & ". Квс=" & Kvs & ". Кф=" & Kf & ". Ксп=" & Ksp & ". Ккв=" & kkv
	ElseIf TransportForm.TS_InsurProgram.Value = "Универсал" Then
		Worksheets("Data").Cells(15, 2).Value = Kps
		If Kl = 1.4 Then
			Tarif = Tarif + Chr(13) + "Базовый тариф=" & BaseTarif & ". Кпс=" & Kps & ".  Кстоа=" & kctoa & ". Клв=" & klv & ". КБМ=" & Kbm & ". Ки=" & KI & ". Кл=" & Kl & ". Кф=" & Kf & ". Ко=" & ko & ". Ксп=" & Ksp & ". Ккв=" & kkv & ". Кп = " & kp & ". Ксд =" & ksd & ". Кв =" & vbc & ". Ка =" & ka
			BaseTarif = Round(BaseTarif * klv * kctoa * Kps * Kbm * KI * Kl * Kf * Ksp * ko * kkv * kp * ksd * vbc * ka, 2)
		Else
			Tarif = Tarif + Chr(13) + "Базовый тариф=" & BaseTarif & ". Кпс=" & Kps & ".Кстоа=" & kctoa & ". Клв=" & klv & ". КБМ=" & Kbm & ". Ки=" & KI & ". Кл=" & Kl & ". Квс=" & Kvs & ". Кф=" & Kf & ". Ко=" & ko & ". Ксп=" & Ksp & ". Ккв=" & kkv & ". Кп = " & kp & ". Ксд =" & ksd & ". Кв =" & vbc & ". Ка =" & ka
			BaseTarif = Round(BaseTarif * klv * kctoa * Kps * Kbm * KI * Kl * Kvs * Kf * Ksp * ko * kkv * kp * ksd * vbc * ka, 2)
		End If
	Else
		Worksheets("Data").Cells(15, 2).Value = Kps
		If Kl = 1.4 Then
			Tarif = Tarif + Chr(13) + "Базовый тариф=" & BaseTarif & ". Кпс=" & Kps & ". КБМ=" & Kbm & ". Ки=" & KI & ". Кл=" & Kl & ". Кф=" & Kf & ". Ко=" & ko & ". Ксп=" & Ksp & ". Ккв=" & kkv & ". Кп = " & kp & ". Ксд =" & ksd & ". Кв =" & vbc & ". Ка =" & ka
			BaseTarif = Round(BaseTarif * Kps * Kbm * KI * Kl * Kf * Ksp * ko * kkv * kp * ksd * vbc * ka, 2)
		Else
			Tarif = Tarif + Chr(13) + "Базовый тариф=" & BaseTarif & ". Кпс=" & Kps & ". КБМ=" & Kbm & ". Ки=" & KI & ". Кл=" & Kl & ". Квс=" & Kvs & ". Кф=" & Kf & ". Ко=" & ko & ". Ксп=" & Ksp & ". Ккв=" & kkv & ". Кп = " & kp & ". Ксд =" & ksd & ". Кв =" & vbc & ". Ка =" & ka
			BaseTarif = Round(BaseTarif * Kps * Kbm * KI * Kl * Kvs * Kf * Ksp * ko * kkv * kp * ksd * vbc * ka, 2)
		End If
	End If




	If (TransportForm.TS_Risks.Value = "ХИЩЕНИЕ + УЩЕРБ + УТС") Or (TransportForm.TS_Risks.Value = "УЩЕРБ + УТС") Then
		BaseTarif = BaseTarif + KUTS
		Tarif = Tarif + Chr(13) + "Базовый тариф по УТС = " & KUTS
	End If
	Prem = Round(TransportForm.TS_salary.Value * BaseTarif / 100, 2)
	Tarif = Tarif + Chr(13) + "Тариф по ТС = " & BaseTarif & ". Страховая премия по ТС = " & Prem
	Tarif = Tarif + Chr(13) + "ИТОГО страховая премия: " & Prem + DOSum
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

	ErrStr = "Обнаружены следующие ошибки:"
	ErrSum = 0

	'Начинаем проверку на корректность всех данных
	If TransportForm.TS_salary.Value <= 0 Then
		ErrStr = ErrStr + Chr(13) + "Не указана стоимость ТС!"
		ErrSum = ErrSum + 1
	End If

	'Способ калькуляции
	If TransportForm.CalculationType.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "Не указан способ калькуляции!"
		ErrSum = ErrSum + 1
	End If
	If TransportForm.TS_InsurProgram.Value = "Универсал" Then
		If TransportForm.RegresLimit.Value = "До 1 страхового случая" Then
			If (TransportForm.CalculationType.Value = "По калькуляции страховщика / По счетам СТОА из перечня") Or (TransportForm.CalculationType.Value = "По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору") Then
				ErrStr = ErrStr + Chr(13) + "Выберите другой способ калькуляции!"
				ErrSum = ErrSum + 1
			End If
		End If
	End If

	'Набор рисков
	If TransportForm.TS_Risks.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "Не указан набор рисков!"
		ErrSum = ErrSum + 1
	End If

	'Коэффициент комиссионного вознаграждения
	If TransportForm.ComisPercent.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "Не указан коэффициент комиссионного вознаграждения!"
		ErrSum = ErrSum + 1
	End If

	'Коэффициент «Выплаты без справок»

	If TransportForm.TS_InsurProgram.Value <> "Эконом 50/50" Then
		If TransportForm.Viplat.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "Не указан «Выплаты без справок»!"
			ErrSum = ErrSum + 1
		End If
	End If

	'Коэффициент срока действия договора
	If TransportForm.TS_InsurProgram.Value <> "Эконом 50/50" Then
		If TransportForm.ComboBox1.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "Не указан срок действия договора!"
			ErrSum = ErrSum + 1
		End If
	End If

	'Доп. оборудование
	If (TransportForm.TS_DopFlag.Value = True) And (TransportForm.TS_DopSalary.Value = 0) Then
		ErrStr = ErrStr + Chr(13) + "Не указана стоимость доп. оборудования!"
		ErrSum = ErrSum + 1
	End If

	'Программа страхования
	If TransportForm.TS_InsurProgram.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "Не указана программа страхования"
		ErrSum = ErrSum + 1
	End If

	'Франшиза
	If TransportForm.FranshizaFlag.Value = True Then
		If TransportForm.FranshizaType.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "Не указан тип франшизы"
			ErrSum = ErrSum + 1
		End If

		If TransportForm.FranshizaPercent.Value = 0 Then
			ErrStr = ErrStr + Chr(13) + "Не указан процент франшизы"
			ErrSum = ErrSum + 1
		End If
	End If

	'Лимит возмещения
	If TransportForm.TS_InsurProgram.Value = "Универсал" Then
		If TransportForm.RegresLimit.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "Не указан лимит возмещения!"
			ErrSum = ErrSum + 1
		End If
	End If

	'Кол-во ЛДУ
	If TransportForm.TS_InsurProgram.Value <> "Эконом 50/50" Then
		If (TransportForm.TS_OrganisationFlag.Value = False) And (TransportForm.LDUNum.Value = "") Then
			ErrStr = ErrStr + Chr(13) + "Не указано количество ЛДУ!"
			ErrSum = ErrSum + 1
		End If
	End If

	If TransportForm.TS_InsurProgram.Value = "Универсал" Then
		'Кол-во ЛДУ
		If TransportForm.Viplat.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "Не указано «Выплаты без справок» !"
			ErrSum = ErrSum + 1
		End If
	End If

	'Категория ТС
	If TransportForm.TS_Category.Value = "" Then
		ErrStr = ErrStr + Chr(13) + "Не указана категория ТС!"
		ErrSum = ErrSum + 1
	End If

	If TransportForm.CheckBox3.Value = True Then
		If TransportForm.parck.Value = "" Then
			ErrStr = ErrStr + Chr(13) + "Не указан Коэффициент парковости!"
			ErrSum = ErrSum + 1
		End If
	End If


	'Проверяем различные условия, в зависимости от программы страхования
	IsAgeErr = 0

	Select Case TransportForm.TS_InsurProgram.Value
		Case "Бизнес"
			If (TransportForm.TS_Category.Value = "1.1.   Классика (ВАЗ 2104, 05, 06, 07, 08, 09 и модификации) и прочие легковые ТС отечественного производства, не вошедшие в группы 1-3") Or (TransportForm.TS_Category.Value = "1.2.   ВАЗ 11114 (ОКА), ИЖ 2126, 2717 и модификации, легковые ГАЗ") Or (TransportForm.TS_Category.Value = "1.3.   ВАЗ Приора, Калина, 2110, 2111, 2112, 2113, 2114, 2115 и модификации, Шевроле Нива, Шевроле Вива, УАЗ, ЗАЗ") Then
				If (TransportForm.TS_age > 3) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			Else
				If (TransportForm.TS_age > 4) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			End If

		Case "Стандарт"
			If (TransportForm.TS_Category.Value = "1.1.   Классика (ВАЗ 2104, 05, 06, 07, 08, 09 и модификации) и прочие легковые ТС отечественного производства, не вошедшие в группы 1-3") Or (TransportForm.TS_Category.Value = "1.2.   ВАЗ 11114 (ОКА), ИЖ 2126, 2717 и модификации, легковые ГАЗ") Or (TransportForm.TS_Category.Value = "1.3.   ВАЗ Приора, Калина, 2110, 2111, 2112, 2113, 2114, 2115 и модификации, Шевроле Нива, Шевроле Вива, УАЗ, ЗАЗ") Then
				If (TransportForm.TS_age > 3) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			Else
				If (TransportForm.TS_age > 4) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			End If


		Case "Эконом 50/50"
			If (TransportForm.TS_Category.Value = "1.3.   ВАЗ Приора, Калина, 2110, 2111, 2112, 2113, 2114, 2115 и модификации, Шевроле Нива, Шевроле Вива, УАЗ, ЗАЗ") Then
				If (TransportForm.TS_age > 3) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			Else
				If (TransportForm.TS_age > 4) Or (TransportForm.TS_age < 0) Then
					IsAgeErr = 1
				End If
			End If

		Case "Эконом до 1 страхового случая"
			If (TransportForm.TS_age > 10) Or (TransportForm.TS_age < 0) Then
				IsAgeErr = 1
			End If

		Case "Универсал"
			If (TransportForm.TS_age > 7) Or (TransportForm.TS_age < 0) Then
				IsAgeErr = 1
			End If




		Case "Оптимал"
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
		ErrStr = ErrStr + Chr(13) + "При выбранной программе страхования нельзя страховать ТС с выбранным сроком эксплуатации!"
		ErrSum = ErrSum + 1
	End If

	If ErrSum > 0 Then
		MsgBox(ErrStr, vbInformation, "Внимание")
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
		TransportForm.FranshizaType.Value = "Безусловная"
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
	WS2 = ActiveWorkbook.Sheets("Полис")
	WS3 = ActiveWorkbook.Sheets("Заявление")
	WS3.Activate()




	WS2.Cells(48, 5).Value = Worksheets("Data").Cells(2, 1).Value & "  (" & СуммаПрописью(Worksheets("Data").Cells(2, 1).Value) & ")"




	If TransportForm.CalculationType.Value = "По калькуляции страховщика" Then
		opredelenie = "1С"
	ElseIf TransportForm.CalculationType.Value = "По калькуляции страховщика / По счетам СТОА из перечня" Then
		opredelenie = "2С"
	ElseIf TransportForm.CalculationType.Value = "По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору" Then
		opredelenie = "3С"
	End If




	Select Case TransportForm.TS_InsurProgram.Value
		Case "Бизнес"
			WS2.Cells(7, 3).Value = "НБ" & opredelenie
		Case "Стандарт"
			WS2.Cells(7, 3).Value = "АБ" & opredelenie
		Case "Оптимал"
			WS2.Cells(7, 3).Value = "АИ1С"
		Case "Эконом до 1 страхового случая"
			WS2.Cells(7, 3).Value = "СБ" & opredelenie
		Case "Эконом 50/50"
			WS2.Cells(7, 3).Value = "АЭБ" & opredelenie
		Case "Универсал"
			If TransportForm.RegresLimit.Value = "Неагрегатный лимит" Then
				If TransportForm.CheckBox2.Value = True Then
					WS2.Cells(7, 3).Value = "УНИ" & opredelenie
				Else
					WS2.Cells(7, 3).Value = "УНБ" & opredelenie
				End If
			ElseIf TransportForm.RegresLimit.Value = "Агрегатный лимит" Then
				If TransportForm.CheckBox2.Value = True Then
					WS2.Cells(7, 3).Value = "УАИ" & opredelenie
				Else
					WS2.Cells(7, 3).Value = "УАБ" & opredelenie
				End If
			ElseIf TransportForm.RegresLimit.Value = "До 1 страхового случая" Then
				If TransportForm.CheckBox2.Value = True Then
					WS2.Cells(7, 3).Value = "УСИ" & opredelenie
				Else
					WS2.Cells(7, 3).Value = "УСБ" & opredelenie
				End If
			End If
	End Select




	If TransportForm.TS_InsurProgram.Value = "Универсал" Then
		'Коэффициент лимита возмещения
		If TransportForm.RegresLimit.Value = "Неагрегатный лимит" Then
			Worksheets("Data").Cells(1, 12).Value = 0
			Worksheets("Data").Cells(2, 12).Value = 1
			Worksheets("Data").Cells(3, 12).Value = 0
		ElseIf TransportForm.RegresLimit.Value = "Агрегатный лимит" Then
			Worksheets("Data").Cells(1, 12).Value = 1
			Worksheets("Data").Cells(2, 12).Value = 0
			Worksheets("Data").Cells(3, 12).Value = 0
		ElseIf TransportForm.RegresLimit.Value = "До 1 страхового случая" Then
			Worksheets("Data").Cells(1, 12).Value = 0
			Worksheets("Data").Cells(2, 12).Value = 0
			Worksheets("Data").Cells(3, 12).Value = 1
		End If
	Else
		Select Case TransportForm.TS_InsurProgram.Value
			Case "Бизнес"
				Worksheets("Data").Cells(1, 12).Value = 0
				Worksheets("Data").Cells(2, 12).Value = 1
				Worksheets("Data").Cells(3, 12).Value = 0
			Case "Стандарт"
				Worksheets("Data").Cells(1, 12).Value = 1
				Worksheets("Data").Cells(2, 12).Value = 0
				Worksheets("Data").Cells(3, 12).Value = 0
			Case "Оптимал"
				Worksheets("Data").Cells(1, 12).Value = 0
				Worksheets("Data").Cells(2, 12).Value = 1
				Worksheets("Data").Cells(3, 12).Value = 0
			Case "Эконом до 1 страхового случая"
				Worksheets("Data").Cells(1, 12).Value = 0
				Worksheets("Data").Cells(2, 12).Value = 0
				Worksheets("Data").Cells(3, 12).Value = 1
			Case "Эконом 50/50"
				Worksheets("Data").Cells(1, 12).Value = 0
				Worksheets("Data").Cells(2, 12).Value = 1
				Worksheets("Data").Cells(3, 12).Value = 0
		End Select
	End If




	WS2.Cells(76, 13).Value = DateValue(Now) & "г."
	WS3.Cells(3, 10).Value = "ЗАЯВЛЕНИЕ от " & DateValue(Now) & "г."




	'Лица, допущенных к управлению ТС
	If TransportForm.TS_OrganisationFlag = True Then
		If TransportForm.LDUNum.Value = "Без ограничений" Then
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
	'РИСКИ
	If (TransportForm.TS_Risks = "ХИЩЕНИЕ + УЩЕРБ + УТС") Then
		Worksheets("Data").Cells(1, 8).Value = 1
		Worksheets("Data").Cells(2, 8).Value = 1
		Worksheets("Data").Cells(3, 8).Value = 1
		Worksheets("Data").Cells(3, 9).Value = 0
	ElseIf (TransportForm.TS_Risks = "ХИЩЕНИЕ + УЩЕРБ") Then
		Worksheets("Data").Cells(1, 8).Value = 1
		Worksheets("Data").Cells(2, 8).Value = 1
		Worksheets("Data").Cells(3, 8).Value = 0
		Worksheets("Data").Cells(3, 9).Value = 1
	ElseIf (TransportForm.TS_Risks = "УЩЕРБ + УТС") Then
		Worksheets("Data").Cells(1, 8).Value = 0
		Worksheets("Data").Cells(2, 8).Value = 1
		Worksheets("Data").Cells(3, 8).Value = 1
		Worksheets("Data").Cells(3, 9).Value = 0
	ElseIf (TransportForm.TS_Risks = "УЩЕРБ") Then
		Worksheets("Data").Cells(1, 8).Value = 0
		Worksheets("Data").Cells(2, 8).Value = 1
		Worksheets("Data").Cells(3, 8).Value = 0
		Worksheets("Data").Cells(3, 9).Value = 1
	End If

	'Износ
	Select Case TransportForm.TS_InsurProgram.Value
		Case "Бизнес"
			Worksheets("Data").Cells(8, 5).Value = 0
			Worksheets("Data").Cells(8, 6).Value = 1
		Case "Стандарт"
			Worksheets("Data").Cells(8, 5).Value = 0
			Worksheets("Data").Cells(8, 6).Value = 1
		Case "Оптимал"
			Worksheets("Data").Cells(8, 5).Value = 1
			Worksheets("Data").Cells(8, 6).Value = 0
		Case "Универсал"
			Worksheets("Data").Cells(8, 5).Value = 0
			Worksheets("Data").Cells(8, 6).Value = 1
		Case "Эконом до 1 страхового случая"
			If TransportForm.TS_age.Value < 5 Then
				Worksheets("Data").Cells(8, 5).Value = 1
				Worksheets("Data").Cells(8, 6).Value = 0
			Else
				Worksheets("Data").Cells(8, 5).Value = 0
				Worksheets("Data").Cells(8, 6).Value = 2
			End If
		Case "Эконом 50/50"
			Worksheets("Data").Cells(8, 5).Value = 0
			Worksheets("Data").Cells(8, 6).Value = 1
	End Select




	WS3.Cells(55, 6).Value = Worksheets("Data").Cells(2, 3).Value - TransportForm.TS_age.Value




	If TransportForm.CalculationType.Value = "По калькуляции страховщика" Then
		Worksheets("Data").Cells(1, 16).Value = 1
		Worksheets("Data").Cells(2, 16).Value = 0
		Worksheets("Data").Cells(3, 16).Value = 0
	ElseIf TransportForm.CalculationType.Value = "По калькуляции страховщика / По счетам СТОА из перечня" Then
		Worksheets("Data").Cells(1, 16).Value = 1
		Worksheets("Data").Cells(2, 16).Value = 1
		Worksheets("Data").Cells(3, 16).Value = 0
	ElseIf TransportForm.CalculationType.Value = "По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору" Then
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
		'Франшиза
		WS2.Cells(42, 7).Value = Worksheets("Data").Cells(8, 1).Value
		WS2.Cells(42, 9).Value = Worksheets("Data").Cells(8, 2).Value
		WS2.Cells(42, 11).Value = Worksheets("Data").Cells(8, 3).Value
	Else
		WS2.Cells(42, 3).Value = "-"
		WS2.Cells(42, 5).Value = "-"
		WS2.Cells(42, 13).Value = "-"
		'Франшиза
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




	If TransportForm.Viplat.Value = "1 раз за период страхования" Then
		Worksheets("Data").Cells(8, 8).Value = 1
		Worksheets("Data").Cells(8, 9).Value = 0
		Worksheets("Data").Cells(8, 10).Value = 0
		Worksheets("Data").Cells(8, 11).Value = 1
	ElseIf TransportForm.Viplat.Value = "2 раза за период страхования" Then
		Worksheets("Data").Cells(8, 8).Value = 1
		Worksheets("Data").Cells(8, 9).Value = 0
		Worksheets("Data").Cells(8, 10).Value = 1
		Worksheets("Data").Cells(8, 11).Value = 0
	ElseIf TransportForm.Viplat.Value = "Не осуществляются (1 вариант)" Then
		Worksheets("Data").Cells(8, 8).Value = 0
		Worksheets("Data").Cells(8, 9).Value = 1
		Worksheets("Data").Cells(8, 10).Value = 0
		Worksheets("Data").Cells(8, 11).Value = 0
	End If




	'Франшиза
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
		MsgBox("Возраст водителя не может быть меньше 18 лет.", vbInformation, "Внимание")
		TransportForm.Driver_Age.Value = 18
	End If

End Sub





Private Sub DriverExp_AfterUpdate()
	Err = 0

	If IsNumeric(TransportForm.Driver_Age.Value) = False Then
		MsgBox("Сначала укажите возраст водителя!", vbInformation, "Ахтунг!")
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
		MsgBox("Не верно указан стаж водителя!", vbInformation, "Внимание")
		TransportForm.DriverExp.Value = 0
	End If
End Sub





Private Sub FranshizaFlag_Change()

	TransportForm.FranshizaPercent.Visible = TransportForm.FranshizaFlag.Value
	TransportForm.FranshizaType.Visible = TransportForm.FranshizaFlag.Value
	TransportForm.T_FranshizaPercent.Visible = TransportForm.FranshizaFlag.Value

	If TransportForm.FranshizaFlag.Value = True Then
		'Тип франшизы
		TransportForm.FranshizaType.AddItem "Безусловная"
		TransportForm.FranshizaType.AddItem "Условная"
	Else
		TransportForm.FranshizaType.Clear()
	End If




End Sub




Private Sub Ki_AfterUpdate()
	If (TransportForm.KI.Value = 2) Or (TransportForm.KI.Value = 1.7) Then
		TransportForm.FranshizaFlag.Value = True
		TransportForm.FranshizaPercent.Value = 2
		TransportForm.FranshizaType.Value = "Безусловная"
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
	If TransportForm.LDUNum.Value = "Любые лица от 33 лет" Then
		TransportForm.Driver_Age.Enabled = False
		TransportForm.DriverExp.Enabled = False
	Else
		TransportForm.Driver_Age.Enabled = True
		TransportForm.DriverExp.Enabled = True
	End If
End Sub




Private Sub RegresLimit_Change()
	If TransportForm.RegresLimit.Value = "До 1 страхового случая" Then
		TransportForm.FranshizaFlag.Value = True
		TransportForm.FranshizaPercent.Value = 2
		TransportForm.FranshizaType.Value = "Безусловная"
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
	If (TransportForm.TS_InsurProgram.Value = "Эконом 50/50") Then
		If (TransportForm.TS_Category.Value = "1.3.   ВАЗ Приора, Калина, 2110, 2111, 2112, 2113, 2114, 2115 и модификации, Шевроле Нива, Шевроле Вива, УАЗ, ЗАЗ") Then
			If (age > 3) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("Срок эксплуатации ТС не более 3 лет.", vbInformation, "Внимание")
			End If
		Else
			If (age > 4) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("Срок эксплуатации ТС не более 4 лет.", vbInformation, "Внимание")
			End If
		End If
	End If

	If (TransportForm.TS_InsurProgram.Value = "Эконом до 1 страхового случая") Then
		If (age > 10) Or (age < 0) Or (IsNumeric(age) = False) Then
			MsgBox("Срок эксплуатации ТС не более 10 лет.", vbInformation, "Внимание")
		End If
	End If

	If (TransportForm.TS_InsurProgram.Value = "Универсал") Then
		If (age > 7) Or (age < 0) Or (IsNumeric(age) = False) Then
			MsgBox("Срок эксплуатации ТС не более 7 лет.", vbInformation, "Внимание")
		End If
	End If

	If (TransportForm.TS_InsurProgram.Value = "Бизнес") Or (TransportForm.TS_InsurProgram.Value = "Стандарт") Then
		If (TransportForm.TS_Category.Value = "1.1.   Классика (ВАЗ 2104, 05, 06, 07, 08, 09 и модификации) и прочие легковые ТС отечественного производства, не вошедшие в группы 1-3") Or (TransportForm.TS_Category.Value = "1.2.   ВАЗ 11114 (ОКА), ИЖ 2126, 2717 и модификации, легковые ГАЗ") Or (TransportForm.TS_Category.Value = "1.3.   ВАЗ Приора, Калина, 2110, 2111, 2112, 2113, 2114, 2115 и модификации, Шевроле Нива, Шевроле Вива, УАЗ, ЗАЗ") Then
			If (age > 3) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("Срок эксплуатации ТС не более 3 лет.", vbInformation, "Внимание")
			End If
		Else
			If (age > 4) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("Срок эксплуатации ТС не более 4 лет.", vbInformation, "Внимание")
			End If
		End If
	End If

	If (TransportForm.TS_InsurProgram.Value = "Оптимал") Then
		If (TransportForm.CheckBox4.Value = True) Then
			If (age > 10) Or (age < 0) Or (IsNumeric(age) = False) Then
				MsgBox("Срок эксплуатации ТС от 0 до 10 лет.", vbInformation, "Внимание")
			End If
		Else
			If (age > 10) Or (age < 4) Or (IsNumeric(age) = False) Then
				If (age <> 1) Then
					MsgBox("Срок эксплуатации ТС свыше 3-х лет, но не более 10-ти лет.", vbInformation, "Внимание")
				End If
			End If
		End If
	End If




	'If (age > 10) Or (age < 0) Or (IsNumeric(age) = False) Then
	'        MsgBox "Срок эксплуатации ТС не должен превышать 10 лет.", vbInformation, "Внимание"
	'    End If

End Sub




Private Sub TS_Category_Change()

	TransportForm.TS_Risks.Clear()

	If (TransportForm.TS_InsurProgram.Value = "Бизнес") Or (TransportForm.TS_InsurProgram.Value = "Стандарт") Or (TransportForm.TS_InsurProgram.Value = "Оптимал") Then
		TransportForm.TS_Risks.AddItem "ХИЩЕНИЕ + УЩЕРБ"
		TransportForm.TS_Risks.AddItem "ХИЩЕНИЕ + УЩЕРБ + УТС"
		TransportForm.TS_Risks.AddItem "УЩЕРБ"
		TransportForm.TS_Risks.AddItem "УЩЕРБ + УТС"
	ElseIf TransportForm.TS_InsurProgram.Value = "Универсал" Then
		TransportForm.TS_Risks.AddItem "ХИЩЕНИЕ + УЩЕРБ"
		TransportForm.TS_Risks.AddItem "УЩЕРБ"
	ElseIf (TransportForm.TS_InsurProgram.Value = "Эконом до 1 страхового случая") Then
		TransportForm.TS_Risks.AddItem "ХИЩЕНИЕ + УЩЕРБ"
		TransportForm.TS_Risks.AddItem "ХИЩЕНИЕ + УЩЕРБ + УТС"
	ElseIf (TransportForm.TS_InsurProgram.Value = "Эконом 50/50") Then
		TransportForm.TS_Risks.AddItem "ХИЩЕНИЕ + УЩЕРБ"
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
			MsgBox("Не верная сумма доп. оборудования!", vbInformation, "Внимание")
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
	If InsurProgram = "Универсал" Then
		TransportForm.RegresLimit.Visible = True
		TransportForm.CheckBox2.Visible = True
		TransportForm.Label18.Visible = True

	Else
		TransportForm.RegresLimit.Visible = False
		TransportForm.CheckBox2.Visible = False
		TransportForm.Label18.Visible = False

	End If




	If InsurProgram = "Эконом до 1 страхового случая" Then
		TransportForm.FranshizaFlag.Value = True
		TransportForm.FranshizaPercent.Value = 4
		TransportForm.FranshizaType.Value = "Условная"
		TransportForm.FranshizaFlag.Enabled = False
		TransportForm.FranshizaPercent.Enabled = False
		TransportForm.FranshizaType.Enabled = False
		TransportForm.CheckBox4.Visible = False
	ElseIf InsurProgram = "Эконом 50/50" Then
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
		TransportForm.FranshizaType.Value = "Безусловная"
		TransportForm.FranshizaFlag.Enabled = False
		TransportForm.FranshizaPercent.Enabled = False
		TransportForm.FranshizaType.Enabled = False
		TransportForm.CheckBox4.Visible = False
	Else
		If InsurProgram = "Оптимал" Then
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
		Case "Эконом 50/50"
			TransportForm.TS_Category.AddItem "1.3.   ВАЗ Приора, Калина, 2110, 2111, 2112, 2113, 2114, 2115 и модификации, Шевроле Нива, Шевроле Вива, УАЗ, ЗАЗ"
			TransportForm.TS_Category.AddItem "2.2.1. Импортные легковые автомобили со страховой суммой: до 400 000 руб"
			TransportForm.TS_Category.AddItem "2.2.2. Импортные легковые автомобили со страховой суммой: от 400 001 до 800 000 руб"
			TransportForm.TS_Category.AddItem "2.2.3. Импортные легковые автомобили со страховой суммой: от 800 001 до 1 200 000 руб"
			TransportForm.TS_Category.AddItem "2.2.4. Импортные легковые автомобили со страховой суммой: от 1 200 001 до 2 000 000 руб"
			TransportForm.TS_Category.AddItem "2.2.5. Импортные легковые автомобили со страховой суммой: от 2 000 001 руб"
		Case Else
			TransportForm.TS_Category.AddItem "1.1.   Классика (ВАЗ 2104, 05, 06, 07, 08, 09 и модификации) и прочие легковые ТС отечественного производства, не вошедшие в группы 1-3"
			TransportForm.TS_Category.AddItem "1.2.   ВАЗ 11114 (ОКА), ИЖ 2126, 2717 и модификации, легковые ГАЗ"
			TransportForm.TS_Category.AddItem "1.3.   ВАЗ Приора, Калина, 2110, 2111, 2112, 2113, 2114, 2115 и модификации, Шевроле Нива, Шевроле Вива, УАЗ, ЗАЗ"
			TransportForm.TS_Category.AddItem "2.2.1. Импортные легковые автомобили со страховой суммой: до 400 000 руб"
			TransportForm.TS_Category.AddItem "2.2.2. Импортные легковые автомобили со страховой суммой: от 400 001 до 800 000 руб"
			TransportForm.TS_Category.AddItem "2.2.3. Импортные легковые автомобили со страховой суммой: от 800 001 до 1 200 000 руб"
			TransportForm.TS_Category.AddItem "2.2.4. Импортные легковые автомобили со страховой суммой: от 1 200 001 до 2 000 000 руб"
			TransportForm.TS_Category.AddItem "2.2.5. Импортные легковые автомобили со страховой суммой: от 2 000 001 руб"
			TransportForm.TS_Category.AddItem "3.1.   Микроавтобусы, фургоны и мини-грузовики на их базе до 3,5т, в т.ч. ""Газели"" - ГАЗ 3302, 3221, 2217, 2751"
			TransportForm.TS_Category.AddItem "3.2.   Мото - транспорт"
			TransportForm.TS_Category.AddItem "3.3.   Автобусы"
			TransportForm.TS_Category.AddItem "3.4.   Грузовики"
			TransportForm.TS_Category.AddItem "3.5.   Спецтехника (сельхозтехника, бетономешалки, экскаваторы, тракторы, краны и т.п.)"
			TransportForm.TS_Category.AddItem "3.6.   Прочие ТС прицепы, полуприцепы"
	End Select

	Select Case InsurProgram
		Case "Бизнес", "Стандарт", "Эконом 50/50", "Универсал"
			'Определение размера страхового возмещения
			TransportForm.CalculationType.AddItem "По калькуляции страховщика"
			TransportForm.CalculationType.AddItem "По калькуляции страховщика / По счетам СТОА из перечня"
			TransportForm.CalculationType.AddItem "По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору"
		Case Else
			TransportForm.CalculationType.AddItem "По калькуляции страховщика"
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
		MsgBox("Не правильно указана стоимость транспортного средства", vbInformation, "Внимание")
	End If

	If (TransportForm.TS_InsurProgram.Value = "Оптимал") Then
		If (TransportForm.CheckBox4.Value = True) Then
			If (TransportForm.TS_age.Value > 10) Or (TransportForm.TS_age.Value < 0) Then
				MsgBox("Срок эксплуатации ТС от 0 до 10 лет.", vbInformation, "Внимание")
			End If
		Else
			If (TransportForm.TS_age.Value > 10) Or (TransportForm.TS_age.Value < 4) Then
				MsgBox("Срок эксплуатации ТС свыше 3-х лет, но не более 10-ти лет.", vbInformation, "Внимание")
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









	'TransportForm.TS_Category.Value = "1.1. Классика (ВАЗ 2104, 05, 06, 07, 08, 09 и модификации) и прочие легковые ТС отечественного производства, не вошедшие в группы 1-3"

	TransportForm.TS_age.Value = 0

	TransportForm.TS_InsurProgram.AddItem "Бизнес"
	TransportForm.TS_InsurProgram.AddItem "Стандарт"
	TransportForm.TS_InsurProgram.AddItem "Оптимал"
	TransportForm.TS_InsurProgram.AddItem "Эконом 50/50"
	TransportForm.TS_InsurProgram.AddItem "Эконом до 1 страхового случая"
	TransportForm.TS_InsurProgram.AddItem "Универсал"

	TransportForm.DriverKBM.Value = 1
	TransportForm.KI.Value = 1
	TransportForm.TextBox1.Value = 1
	TransportForm.TextBox2.Value = 1
	TransportForm.FranshizaFlag.Value = False
	TransportForm.FranshizaPercent.Visible = TransportForm.FranshizaFlag.Value
	TransportForm.FranshizaType.Visible = TransportForm.FranshizaFlag.Value
	TransportForm.T_FranshizaPercent.Visible = TransportForm.FranshizaFlag.Value


	'Лимит возмещения (если не Универсал, недоступно)
	TransportForm.RegresLimit.Visible = False
	TransportForm.CheckBox2.Visible = False
	TransportForm.Label18.Visible = False
	TransportForm.parck.Enabled = False

	'Количество ЛДУ
	TransportForm.LDUNum.AddItem "Без ограничений"
	TransportForm.LDUNum.AddItem "Не более 3-х водителей"
	TransportForm.LDUNum.AddItem "4 водителя"
	TransportForm.LDUNum.AddItem "5 водителей"
	TransportForm.LDUNum.AddItem "Любые лица от 33 лет"

	'Устанавливаем значения по умолчанию
	TransportForm.Driver_Age.Value = 18
	TransportForm.DriverExp.Value = 0
	TransportForm.TS_salary.Value = 0
	TransportForm.T_KI.Visible = False
	TransportForm.CheckBox4.Visible = False

	TransportForm.ComisPercent.Value = 20

	'TransportForm.PrintButton.Visible = False

	TransportForm.Viplat.AddItem "1 раз за период страхования"
	TransportForm.Viplat.AddItem "2 раза за период страхования"
	TransportForm.Viplat.AddItem "Не осуществляются (1 вариант)"
	TransportForm.Viplat.AddItem "Не осуществляются (2 вариант)"

	TransportForm.RegresLimit.AddItem "Неагрегатный лимит"
	TransportForm.RegresLimit.AddItem "Агрегатный лимит"
	TransportForm.RegresLimit.AddItem "До 1 страхового случая"




	TransportForm.parck.AddItem "2-5 ТС"
	TransportForm.parck.AddItem "6-9 ТС"
	TransportForm.parck.AddItem "10 и выше"




	TransportForm.ComboBox1.AddItem "до 5-ти дней"
	TransportForm.ComboBox1.AddItem "до 15-ти дней"
	TransportForm.ComboBox1.AddItem "до 1-го месяца"
	TransportForm.ComboBox1.AddItem "до 2-х месяцев"
	TransportForm.ComboBox1.AddItem "до 3-х месяцев"
	TransportForm.ComboBox1.AddItem "до 4-х месяцев"
	TransportForm.ComboBox1.AddItem "до 5-ти месяцев"
	TransportForm.ComboBox1.AddItem "до 6-ти месяцев"
	TransportForm.ComboBox1.AddItem "до 7-ми месяцев"
	TransportForm.ComboBox1.AddItem "до 8-ми месяцев"
	TransportForm.ComboBox1.AddItem "до 9-ти месяцев"
	TransportForm.ComboBox1.AddItem "до 10-ти месяцев"
	TransportForm.ComboBox1.AddItem "до 11-ти месяцев"
	TransportForm.ComboBox1.AddItem "до 12-ти месяцев"





End Sub








