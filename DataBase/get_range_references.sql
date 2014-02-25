SELECT VAL.`name`, 
	CASE WHEN F.id IS NULL THEN VAL.`value` ELSE F.`default` END AS `value`, 
	CASE WHEN VAL.franchise_percent_down IS NULL AND VAL.franchise_percent_up IS NULL THEN 1 ELSE 0 END AS is_any, 
	CASE WHEN F.id IS NULL THEN 0 ELSE 1 END AS is_default
	FROM
(SELECT 
	CASE WHEN AC.franchise_percent_down IS NULL AND franchise_percent_up IS NULL THEN 'Отсутствует'
		ELSE
			CONCAT('от ',IFNULL(AC.franchise_percent_down, 0),CASE WHEN franchise_percent_up IS NULL THEN ' и более' ELSE CONCAT(' до ',franchise_percent_up) END)
	END AS `name`,
	IFNULL(AC.franchise_percent_down, 0) AS `value`,
	franchise_percent_down,
	franchise_percent_up
FROM additional_coefficients AC 
GROUP BY franchise_percent_down, franchise_percent_up ORDER BY franchise_percent_down) VAL
LEFT JOIN factors F 
	ON F.name = 'franchise_percent' 
	AND F.`default` IS NOT NULL 
	AND (
			(
				NOT (VAL.franchise_percent_down IS NULL AND VAL.franchise_percent_up IS NULL) AND
				(VAL.franchise_percent_down IS NULL OR VAL.franchise_percent_down<=F.`default`) 
				AND (VAL.franchise_percent_up IS NULL OR F.`default`<=VAL.franchise_percent_up)
			) OR
			(VAL.franchise_percent_down IS NULL AND VAL.franchise_percent_up IS NULL AND F.`default` = 0)
		)

SELECT VAL.*, CASE WHEN F.id IS NULL THEN 0 ELSE 1 END AS is_default FROM
(
SELECT
   CASE WHEN AC.contract_day_down IS NULL AND
            AC.contract_day_up IS NULL AND
            AC.contract_month_down IS NULL AND
            AC.contract_month_up IS NULL AND
            AC.contract_year_down IS NULL AND
            AC.contract_year_up IS NULL THEN 1
   ELSE 0 END AS is_any,
  CASE WHEN AC.contract_day_down IS NULL AND
            AC.contract_day_up IS NULL AND
            AC.contract_month_down IS NULL AND
            AC.contract_month_up IS NULL AND
            AC.contract_year_down IS NULL AND
            AC.contract_year_up IS NULL THEN 'Отсутствует'
  ELSE
    CONCAT(
        CASE WHEN
          AC.contract_day_down IS NULL THEN
          CASE WHEN AC.contract_month_down IS NULL THEN
            CASE WHEN AC.contract_year_down IS NULL THEN
              ''
            ELSE
              CASE WHEN AC.contract_year_down = AC.contract_year_up THEN
                CONCAT(AC.contract_year_down, ' лет')
              ELSE
                CONCAT('от ', AC.contract_year_down, ' лет')
              END
            END
          ELSE
            CASE WHEN AC.contract_month_down = AC.contract_month_up THEN
              CONCAT(AC.contract_month_down, ' мес.')
            ELSE
              CONCAT('от ', AC.contract_month_down, ' мес.')
            END
          END
        ELSE
          CASE WHEN AC.contract_day_down = AC.contract_day_up THEN
            CONCAT(AC.contract_day_down, ' дн.')
          ELSE
            CONCAT('от ', AC.contract_day_down, ' дн.')
          END
        END,
        CASE WHEN
          AC.contract_day_up IS NULL THEN
          CASE WHEN AC.contract_month_up IS NULL THEN
            CASE WHEN AC.contract_year_up IS NULL THEN
              ' и более'
            WHEN IFNULL(AC.contract_year_down,-1) <> IFNULL(AC.contract_year_up, -1) THEN
              CONCAT(' до ', AC.contract_year_up, ' лет')
            ELSE ''
            END
          WHEN IFNULL(AC.contract_month_down,-1) <> IFNULL(AC.contract_month_up, -1) THEN
            CONCAT(' до ', AC.contract_month_up, ' мес.')
          ELSE ''
          END
        WHEN IFNULL(AC.contract_day_down,-1)  <> IFNULL(AC.contract_day_up,-1) THEN
          CONCAT(' до ', AC.contract_day_up, ' дн.')
        ELSE ''
        END)
  END AS `name`,
  CASE WHEN AC.contract_day_down IS NULL AND
            AC.contract_day_up IS NULL AND
            AC.contract_month_down IS NULL AND
            AC.contract_month_up IS NULL AND
            AC.contract_year_down IS NULL AND
            AC.contract_year_up IS NULL THEN 0
  ELSE
    CASE WHEN
      AC.contract_day_up IS NULL THEN
      CASE WHEN AC.contract_month_up IS NULL THEN
        CASE WHEN AC.contract_year_up IS NULL THEN
          0
        ELSE
          AC.contract_year_up
        END
      ELSE
        AC.contract_month_up
      END
    ELSE
      AC.contract_day_up
    END
  END AS `value`,
  CASE WHEN AC.contract_day_down IS NULL AND
            AC.contract_day_up IS NULL AND
            AC.contract_month_down IS NULL AND
            AC.contract_month_up IS NULL AND
            AC.contract_year_down IS NULL AND
            AC.contract_year_up IS NULL THEN 'contract_day'
  ELSE
    CASE WHEN
      AC.contract_day_up IS NULL THEN
      CASE WHEN AC.contract_month_up IS NULL THEN
        CASE WHEN AC.contract_year_up IS NULL THEN
          0
        ELSE
          'contract_year'
        END
      ELSE
        'contract_month'
      END
    ELSE
      'contract_day'
    END
  END AS `request_parameter`
FROM additional_coefficients AC
GROUP BY
  AC.contract_day_down, AC.contract_day_up,
  AC.contract_month_down, contract_month_up,
  AC.contract_year_down, AC.contract_year_up
ORDER BY AC.contract_year_down, AC.contract_year_up,
  AC.contract_month_down, AC.contract_month_up,
  AC.contract_day_down, AC.contract_day_up
  ) VAL
  LEFT JOIN factors F ON F.name = VAL.request_parameter AND F.`default` = VAL.value
  /*
  	Надо иметь ввиду, что в данной конфигурации default значение крепится по крайнему значению сверху
  	А должно быть по диапазону и хитро
  */