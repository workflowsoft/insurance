SELECT TPS.id, TPS.name,
  CASE WHEN ADTNL.tariff_program_id = -1 THEN 0 ELSE 1 END AS Calculable 
FROM
(SELECT tariff_program_id FROM tariff_coefficients GROUP BY tariff_program_id) TP
  LEFT JOIN 
  (
  SELECT IFNULL(ADC.tariff_program_id, -1) AS tariff_program_id FROM
    (
      SELECT * FROM
        (SELECT C.id, COUNT(C.id) AS coefficient_count,
                      CASE WHEN MIN(IFNULL(AC.id, -1))>0 THEN 1 ELSE 0 END AS Calculable,
                      CASE WHEN MIN(IFNULL(AC.tariff_program_id, -1))>0 THEN 1 ELSE 0 END AS Dependent
        /*Хитрость в том, что если при текущей комбинации WHERE, 
          для коэфициента есть хоть одно значение, где tariff_program_id = NULL, 
          значит коэфициенту все равно на его значение в принципе. 
          Засчет LEFT JOIN значение любого поля из AC = NULL обознвчает, что соотвтетствие в таблице найдено не было,
          что однозначно трактуется как невозможность вычисления данного кожфициента при текущем наборе WHERE
          */
         FROM coefficients C LEFT JOIN
           additional_coefficients AC ON C.id = AC.coefficient_id
         WHERE C.is_mandatory = 1 GROUP BY C.id) DEP
        INNER JOIN
        (SELECT COUNT(C.id) as mandatory_count
         FROM coefficients C
         WHERE C.is_mandatory = 1) CNT ON 1=1
          /* Хитрая таблица, которая к основной таблице обязательных 
          коэфициентов их разрешимости и зависимости добавляет количество самих обязательных коэфициентов */
    ) DEP2
    LEFT JOIN
      (SELECT DISTINCT coefficient_id, tariff_program_id FROM
          additional_coefficients
            WHERE tariff_program_id IS NOT NULL
              GROUP BY coefficient_id, tariff_program_id 
      ) ADC /* Таблица коэфициент-программа без повторений и зависимостей от каких-либо других факторов */
      ON ADC.coefficient_id = DEP2.id
  WHERE DEP2.dependent = 1 OR DEP2.Calculable = 0
  GROUP BY ADC.tariff_program_id
  HAVING COUNT(ADC.coefficient_id) = MAX(DEP2.mandatory_count) OR ADC.tariff_program_id IS NULL /*На случай неразрешимой ситуации*/
  /* В таблицу попдает или тарифная программа с Id = NULL, это значит, что мы получили неразрешимую комбинацию 
  или набор id программ страхования, которые приводят к суммарному разрешению */
  ) ADTNL ON ADTNL.tariff_program_id = TP.tariff_program_id OR ADTNL.tariff_program_id = -1
  INNER JOIN tariff_program TPS ON TPS.id = IFNULL(TP.tariff_program_id, ADTNL.tariff_program_id) OR ADTNL.tariff_program_id = -1
  /*Недостает момента, что IFNULL(TP.tariff_program_id, ADTNL.tariff_program_id) в данном случае некорректный формат JOIN-а
  если в ADTNL.tariff_program_id только NULL то выводится TP.tariff_program_id, есть хоть одно -1, то все теряет смысл, 
  т.к. неразрешимый случай  
  Если заполнено значениями, то надо брать только пересечения, где есть и TP.tariff_program_id и ADTNL.tariff_program_id
  Все отлично решается сбросом всех коэфициентов в одну таблицу и уничтожение всего этого безобразия
  */
