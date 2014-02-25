SELECT F.name, F.`default`, SCH.`column`, SCH.`table`, FR.`type` AS reference_type, FR.`reference_table`, FR.name as reference_name, FR.id as reference_id, FR.program_specific FROM factors F LEFT JOIN
	factor2references F2R ON F2R.factor_id = F.id
	LEFT JOIN factor_references FR ON FR.id = F2R.reference_id 
	INNER JOIN
(SELECT COLUMN_NAME as `column`, 'additional_coefficients' AS `table` FROM 
	INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'ubercalc' AND TABLE_NAME = 'additional_coefficients'
UNION ALL
SELECT COLUMN_NAME, 'tariff_coefficients' AS `table` FROM 
	INFORMATION_SCHEMA.COLUMNS 
		WHERE TABLE_SCHEMA = 'ubercalc' AND TABLE_NAME = 'tariff_coefficients') SCH
		ON F.name = SCH.`column` OR CONCAT(F.name,'_down') = SCH.`column` OR CONCAT(F.name,'_up') = SCH.`column`
		ORDER BY CASE WHEN CONCAT(F.name,'_up') = SCH.`column` THEN 1 ELSE 0 END