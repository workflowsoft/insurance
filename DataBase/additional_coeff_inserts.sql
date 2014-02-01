



-- вставка для kps

SET @ksp_id = (SELECT id FROM all_factors WHERE code='ksp');
SET @ksp_program_id = (SELECT id FROM front_tariff_program WHERE name='Эконом 50/50');
INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `value`) VALUES
	(@ksp_id, @ksp_program_id, 1);




-- вставка для kvs

SET @kvs_id = (SELECT id FROM all_factors WHERE code='kvs');
SET @NoLimit = (SELECT value FROM front_ldu_quantity WHERE name='Без ограничений');
SET @AnyMore33 = (SELECT value FROM front_ldu_quantity WHERE name='Любые лица от 33 лет');

INSERT INTO `additional_coefficients` (`factor_id`, `ldu_quantity`, `driver_age_down`, `driver_age_up`, `driver_exp_down`, `driver_exp_up`, `value`) VALUES
	(@kvs_id, @NoLimit, NULL, NULL, NULL, NULL, 1),
	(@kvs_id, @AnyMore33, NULL, NULL, NULL, NULL, 1),
	(@kvs_id, NULL, 18, 23, 0, 2, 1.4),
	(@kvs_id, NULL, 18, 23, 3, 5, 1.3),
	(@kvs_id, NULL, 24, 27, 0, 2, 1.3),
	(@kvs_id, NULL, 24, 27, 3, 5, 1.1),
	(@kvs_id, NULL, 24, 27, 6, 9, 0.95),
	(@kvs_id, NULL, 28, 32, 0, 2, 1.2),
	(@kvs_id, NULL, 28, 32, 3, 5, 1.05),
	(@kvs_id, NULL, 28, 32, 6, 9, 0.9),
	(@kvs_id, NULL, 28, 32, 10, NULL, 0.85),
	(@kvs_id, NULL, 33, 40, 0, 2, 1.1),
	(@kvs_id, NULL, 33, 40, 3, 5, 1),
	(@kvs_id, NULL, 33, 40, 6, 9, 0.85),
	(@kvs_id, NULL, 33, 40, 10, NULL, 0.8),
	(@kvs_id, NULL, 41, NULL, 0, 2, 1.15),
	(@kvs_id, NULL, 41, NULL, 3, 5, 1),
	(@kvs_id, NULL, 41, NULL, 6, 9, 0.85),
	(@kvs_id, NULL, 41, NULL, 10, NULL, 0.8);

	
-- вставка для kl 	
	
SET @kl_id = (SELECT id FROM all_factors WHERE code='kl');
SET @less3drivers = (SELECT id FROM front_ldu_quantity WHERE name='Не более 3-х водителей');
SET @fourdrivers = (SELECT id FROM front_ldu_quantity WHERE name='4 водителя');
SET @fivedrivers = (SELECT id FROM front_ldu_quantity WHERE name='5 водителей');

INSERT INTO `additional_coefficients` (`factor_id`, `ldu_quantity`, `value`) VALUES
	(@kl_id, @AnyMore33, 1.25),
	(@kl_id, @NoLimit, 1.4),
	(@kl_id, @less3drivers, 1),
	(@kl_id, @fourdrivers, 1.1),
	(@kl_id, @fivedrivers, 1.2);
	
	
	
	
-- вставка для kps
	
SET @kps_id = (SELECT id FROM all_factors WHERE code='kps');

INSERT INTO `additional_coefficients` (`factor_id`, `TS_NoDefendFlag`, `TS_SatelliteFlag`, `TS_HaveElectronicAlarm`, `value`) VALUES
	(@kps_id, 1, NULL, NULL, 1.3),
	(@kps_id, NULL, 1, NULL, 0.87),	
	(@kps_id, NULL, NULL, 1, 0.95);

 
-- вставка для kuts
	
SET @kuts_id = (SELECT id FROM all_factors WHERE code='kuts');
SET @kuts_1 = (SELECT id FROM front_risks WHERE name='ХИЩЕНИЕ + УЩЕРБ + УТС');
SET @kuts_2 = (SELECT id FROM front_risks WHERE name='УЩЕРБ + УТС');

INSERT INTO `additional_coefficients` (`factor_id`, `ts_risks_id`, `value`) VALUES
	(@kuts_id, @kuts_1, 1.3),
	(@kuts_id, @kuts_2, 1.3);
	
	
	
-- вставка для ksd
	
SET @ksd_id = (SELECT id FROM all_factors WHERE code='ksd');

INSERT INTO `additional_coefficients` (`factor_id`, `contract_days`, `contract_months`, `contract_years`, `value`) VALUES
	(@ksd_id, 5, NULL, NULL, 0.05),
	(@ksd_id, 15, NULL, NULL, 0.1),
	(@ksd_id, NULL, 1, NULL, 0.2),
	(@ksd_id, NULL, 2, NULL, 0.3),
	(@ksd_id, NULL, 3, NULL, 0.4),
	(@ksd_id, NULL, 4, NULL, 0.5),
	(@ksd_id, NULL, 5, NULL, 0.6),
	(@ksd_id, NULL, 6, NULL, 0.7),
	(@ksd_id, NULL, 7, NULL, 0.75),
	(@ksd_id, NULL, 8, NULL, 0.8),
	(@ksd_id, NULL, 9, NULL, 0.85),
	(@ksd_id, NULL, 10, NULL, 0.9),
	(@ksd_id, NULL, 11, NULL, 0.95),
	(@ksd_id, NULL, 12, NULL, 1),
	(@ksd_id, NULL, NULL, 2, 2);
	
	
-- вставка для kp - коэф. парковости (по умолчанию = 1)
	
SET @kp_id = (SELECT id FROM all_factors WHERE code='kp');
SET @kp2to5 = (SELECT id FROM front_kp_description WHERE name='2-5 ТС');
SET @kp6to9 = (SELECT id FROM front_kp_description WHERE name='6-9 ТС');
SET @kp10more = (SELECT id FROM front_kp_description WHERE name='10 и выше');

INSERT INTO `additional_coefficients` (`factor_id`, `kp_description_id`, `value`) VALUES
	(@kp_id, @kp2to5, 0.98),
	(@kp_id, @kp6to9, 0.95),
	(@kp_id, @kp10more, 0.9);
	

	
-- вставка	для ko - единовременная оплата страх. премии
	
SET @ko_id = (SELECT id FROM all_factors WHERE code='ko');

INSERT INTO `additional_coefficients` (`factor_id`, `ko_is_checked`, `value`) VALUES
	(@ko_id, 1, 0.97),
	(@ko_id, 0, 1);
	
	
-- вставка для klv - Коэффициент лимита возмещения

SET @klv_id = (SELECT id FROM all_factors WHERE code='klv');
SET @NonAggregateLimit = (SELECT id FROM front_regres_limit_factor WHERE name='Неагрегатный лимит');
SET @AggregateLimit = (SELECT id FROM front_regres_limit_factor WHERE name='Агрегатный лимит');
SET @ToFirstInsEvent = (SELECT id FROM front_regres_limit_factor WHERE name='До 1 страхового случая');
SET @UniversalInsProgram = (SELECT id FROM tariff_program WHERE name='Универсал');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `regres_limit_factor_id`, `value`) VALUES
	(@klv_id, @UniversalInsProgram, @NonAggregateLimit, 1),
	(@klv_id, @UniversalInsProgram, @AggregateLimit, 0.95),
	(@klv_id, @UniversalInsProgram, @ToFirstInsEvent, 0.6);	
	
	
-- вставка для kctoa - Коэффициент возмещения

SET @kctoa_id = (SELECT id FROM all_factors WHERE code='kctoa');
SET @1C = (SELECT id FROM tariff_def_damage_type WHERE code='1C');
SET @2C = (SELECT id FROM tariff_def_damage_type WHERE code='2C');
SET @3C = (SELECT id FROM tariff_def_damage_type WHERE code='3C');
SET @UniversalInsProgram = (SELECT id FROM tariff_program WHERE name='Универсал');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `tariff_def_damage_type_id`, `klv_value`, `value`) VALUES
	(@kctoa_id, NULL, @1C, 1, 1),
	(@kctoa_id, NULL, @1C, 0.95, 1),
	(@kctoa_id, NULL, @2C, 1, 1.05),
	(@kctoa_id, NULL, @2C, 0.95, 1.05),
	(@kctoa_id, NULL, @3C, 1, 1.2),
	(@kctoa_id, NULL, @3C, 0.95, 1.2),
	(@kctoa_id, @UniversalInsProgram, NULL, 0.6, 1);	

	
	
-- вставка для vbs - Выплаты без справок (по умолчанию = 1)

SET @vbs_id = (SELECT id FROM all_factors WHERE code='vbs');
SET @pay1time = (SELECT id FROM front_payments_without_references WHERE name='1 раз за период страхования');
SET @pay2times = (SELECT id FROM front_payments_without_references WHERE name='2 раза за период страхования');
SET @nopay_1 = (SELECT id FROM front_payments_without_references WHERE name='Не осуществляются (1 вариант)');
SET @nopay_2 = (SELECT id FROM front_payments_without_references WHERE name='Не осуществляются (2 вариант)');
SET @Buisness = (SELECT id FROM tariff_program WHERE name='Бизнес');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `payments_without_references_id`, `value`) VALUES
	(@vbs_id, @Buisness, @pay1time, 1),
	(@vbs_id, @Buisness, @pay2times, 1),
	(@vbs_id, @Buisness, @nopay_1, 0.95),
	(@vbs_id, @Buisness, @nopay_2, 0.9),
	
	(@vbs_id, NULL, @pay1time, 1),
	(@vbs_id, NULL, @pay2times, 1.1),
	(@vbs_id, NULL, @nopay_1, 0.95),
	(@vbs_id, NULL, @nopay_2, 0.9);		

	
	
-- вставка для kf - коэф. франшизы

SET @kf_id = (SELECT id FROM all_factors WHERE code='kf');

SET @UnconditionalFranshiza = (SELECT id FROM front_franchise WHERE name='Безусловная');
SET @ConditionalFranshiza = (SELECT id FROM front_franchise WHERE name='Условная');
SET @Econom = (SELECT id FROM tariff_program WHERE name='Эконом до 1 страхового случая');
SET @Optimal = (SELECT id FROM tariff_program WHERE name='Оптимал');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `regres_limit_factor_id`, `Franshiza_Percent_Down`, `Franshiza_Percent_Up`, `Franshiza_Percent_value`, `franchise_type_id`, `Franshiza_Flag`, `commercial_carting_flag`, `value`) VALUES
	
	(@kf_id, NULL, NULL, NULL, NULL, 2, NULL, 1, NULL, 1),
	(@kf_id, NULL, NULL, 0.1, 0.5, NULL, @UnconditionalFranshiza, 1, NULL, 0.93),
	(@kf_id, NULL, NULL, 0.6, 1, NULL, @UnconditionalFranshiza, 1, NULL, 0.85),
	(@kf_id, NULL, NULL, 1.1, 2, NULL, @UnconditionalFranshiza, 1, NULL, 0.8),
	(@kf_id, NULL, NULL, 2.1, 3, NULL, @UnconditionalFranshiza, 1, NULL, 0.75),
	(@kf_id, NULL, NULL, 3.1, 4, NULL, @UnconditionalFranshiza, 1, NULL, 0.7),
	(@kf_id, NULL, NULL, 4.1, 5, NULL, @UnconditionalFranshiza, 1, NULL, 0.65),
	(@kf_id, NULL, NULL, 5.1, 6, NULL, @UnconditionalFranshiza, 1, NULL, 0.6),
	(@kf_id, NULL, NULL, 6.1, 7, NULL, @UnconditionalFranshiza, 1, NULL, 0.55),
	(@kf_id, NULL, NULL, 7.1, 8, NULL, @UnconditionalFranshiza, 1, NULL, 0.5),
	(@kf_id, NULL, NULL, NULL, 0.6, 1, @ConditionalFranshiza, 1, NULL, 0.9),
	(@kf_id, NULL, NULL, NULL, 1.1, 2, @ConditionalFranshiza, 1, NULL, 0.85),
	(@kf_id, NULL, NULL, NULL, 2.1, 3, @ConditionalFranshiza, 1, NULL, 0.8),
	(@kf_id, NULL, NULL, NULL, 3.1, 4, @ConditionalFranshiza, 1, NULL, 0.75),
	(@kf_id, NULL, NULL, NULL, 4.1, 5, @ConditionalFranshiza, 1, NULL, 0.7),
	(@kf_id, NULL, NULL, NULL, 5.1, 6, @ConditionalFranshiza, 1, NULL, 0.65),
	(@kf_id, NULL, NULL, NULL, 6.1, 7, @ConditionalFranshiza, 1, NULL, 0.6),
	(@kf_id, NULL, NULL, NULL, 7.1, 8, @ConditionalFranshiza, 1, NULL, 0.55),
	(@kf_id, @UniversalInsProgram, @ToFirstInsEvent, NULL, NULL, NULL, NULL, NULL, NULL, 1),
	(@kf_id, @Econom, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1),
	(@kf_id, @Optimal, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1);
	
	
	
	
-- вставка для kkv - коэф. комиссионного вознаграждения

SET @kkv_id = (SELECT id FROM all_factors WHERE code='kkv');

INSERT INTO `additional_coefficients` (`factor_id`, `commission_percent_value`, `value`) VALUES
	
	(@kkv_id, 0, 0.8),
	(@kkv_id, 1, 0.81),
	(@kkv_id, 2, 0.82),
	(@kkv_id, 3, 0.83),
	(@kkv_id, 4, 0.84),
	(@kkv_id, 5, 0.85),
	(@kkv_id, 6, 0.86),
	(@kkv_id, 7, 0.87),
	(@kkv_id, 8, 0.88),
	(@kkv_id, 9, 0.89),
	(@kkv_id, 10, 0.9),
	(@kkv_id, 11, 0.91),
	(@kkv_id, 12, 0.92),
	(@kkv_id, 13, 0.93),
	(@kkv_id, 14, 0.94),
	(@kkv_id, 15, 0.95),
	(@kkv_id, 16, 0.96),
	(@kkv_id, 17, 0.97),
	(@kkv_id, 18, 0.98),
	(@kkv_id, 19, 0.99),
	(@kkv_id, 20, 1),
	(@kkv_id, 21, 1.02),
	(@kkv_id, 22, 1.04),
	(@kkv_id, 23, 1.06),
	(@kkv_id, 24, 1.07),
	(@kkv_id, 25, 1.08);

		
	
-- EOF