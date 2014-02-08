use `ubercalc`;

-- вставка для kuts (утрата товарной стоимости))
SET @kuts_id = (SELECT id FROM all_factors WHERE code='kuts');

INSERT INTO `additional_coefficients` (`factor_id`, `amortisation`, `value`) VALUES
  (@kuts_id, 0, 1.3);

-- Вставка для kf - коэф. франшизы
SET @kf_id = (SELECT id FROM all_factors WHERE code='kf');
-- Коэфициент при безусловной франшизе (минимальный шаг, 10-ые процента)
SET @UnconditionalFranshiza = (SELECT id FROM franchise_type WHERE name='Безусловная');
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_down`,
  `franchise_percent_up`, `franchise_type_id`, `value`) VALUES
  (@kf_id, 0.1, 0.5, @UnconditionalFranshiza, 0.93),
  (@kf_id, 0.6, 1, @UnconditionalFranshiza, 0.85),
  (@kf_id, 1.1, 2, @UnconditionalFranshiza, 0.8),
  (@kf_id, 2.1, 3, @UnconditionalFranshiza, 0.75),
  (@kf_id, 3.1, 4, @UnconditionalFranshiza, 0.7),
  (@kf_id, 4.1, 5, @UnconditionalFranshiza, 0.65),
  (@kf_id, 5.1, 6, @UnconditionalFranshiza, 0.6),
  (@kf_id, 6.1, 7, @UnconditionalFranshiza, 0.55),
  (@kf_id, 7.1, 8, @UnconditionalFranshiza, 0.5);
-- Коэфициент при условной франшизе (минимальный шаг, 10-ые процента)
SET @ConditionalFranshiza = (SELECT id FROM franchise_type WHERE name='Условная');

INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_down`,
                                       `franchise_percent_up`, `franchise_type_id`, `value`) VALUES
  (@kf_id, 0.1, 0.5, @ConditionalFranshiza, 0.95),
  (@kf_id, 0.6, 1, @ConditionalFranshiza, 0.9),
  (@kf_id, 1.1, 2, @ConditionalFranshiza, 0.85),
  (@kf_id, 2.1, 3, @ConditionalFranshiza, 0.8),
  (@kf_id, 3.1, 4, @ConditionalFranshiza, 0.75),
  (@kf_id, 4.1, 5, @ConditionalFranshiza, 0.7),
  (@kf_id, 5.1, 6, @ConditionalFranshiza, 0.65),
  (@kf_id, 6.1, 7, @ConditionalFranshiza, 0.6),
  (@kf_id, 7.1, 8, @ConditionalFranshiza, 0.55);

SET @TPEconom = (SELECT id FROM tariff_program WHERE name='Эконом до 1 страхового случая');
SET @UniversalInsProgram = (SELECT id FROM tariff_program WHERE name='Универсал');
SET @TPOptimal = (SELECT id FROM tariff_program WHERE name='Оптимал');
SET @TPEconon50 = (SELECT id FROM tariff_program WHERE name='Эконом 50/50');
SET @Reges1CC = (SELECT id FROM regres_limit WHERE name='До 1 страхового случая');

-- Коэфициент франшизы = 1 (т.е. не действует),
-- При прокате ТС
-- ТП Эконом 1СС,
-- Универсал с лимитом возмещения до 1СС
-- Оптимал
INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `commercial_carting_flag` , `regres_limit_factor_id`, `value`, `priority`) VALUES
  (@kf_id, NULL, 1, NULL, 1, 2),
  (@kf_id, @TPEconom, NULL, NULL, 1, 1),
  (@kf_id, @UniversalInsProgram, NULL, @Reges1CC, 1, 1),
  (@kf_id, @TPOptimal, NULL, NULL, 1, 1);


-- вставка для kvs коэф. возраста-стажа (иметь ввиду, что у нас по-умолчанию не юрлицо.) шаг, один год
SET @kvs_id = (SELECT id FROM all_factors WHERE code='kvs');

-- Рассчитывает только при укзании количества водителей, если количество не указано, отрабатывает значение по-умолчанию

INSERT INTO `additional_coefficients` (`factor_id`, `drivers_count_down`, `drivers_count_up`, `driver_age_down`, `driver_age_up`, `driver_exp_down`, `driver_exp_up`, `value`, `is_legal_entity`) VALUES
  (@kvs_id, 1, NULL, 0, 23, 0, 2, 1.4, 0),
  (@kvs_id, 1, NULL, 0, 23, 3, 5, 1.3, 0),
  (@kvs_id, 1, NULL, 24, 27, 0, 2, 1.3, 0),
  (@kvs_id, 1, NULL, 24, 27, 3, 5, 1.1, 0),
  (@kvs_id, 1, NULL, 24, 27, 6, 9, 0.95, 0),
  (@kvs_id, 1, NULL, 28, 32, 0, 2, 1.2, 0),
  (@kvs_id, 1, NULL, 28, 32, 3, 5, 1.05, 0),
  (@kvs_id, 1, NULL, 28, 32, 6, 9, 0.9, 0),
  (@kvs_id, 1, NULL, 28, 32, 10, NULL, 0.85, 0),
  (@kvs_id, 1, NULL, 33, 40, 0, 2, 1.1, 0),
  (@kvs_id, 1, NULL, 33, 40, 3, 5, 1, 0),
  (@kvs_id, 1, NULL, 33, 40, 6, 9, 0.85, 0),
  (@kvs_id, 1, NULL, 33, 40, 10, NULL, 0.8, 0),
  (@kvs_id, 1, NULL, 41, NULL, 0, 2, 1.15, 0),
  (@kvs_id, 1, NULL, 41, NULL, 3, 5, 1, 0),
  (@kvs_id, 1, NULL, 41, NULL, 6, 9, 0.85, 0),
  (@kvs_id, 1, NULL, 41, NULL, 10, NULL, 0.8, 0);

-- вставка для kl (лиц, допущенных к управлению)
SET @kl_id = (SELECT id FROM all_factors WHERE code='kl');

INSERT INTO `additional_coefficients` (`factor_id`, `drivers_count_down`,
                                       `drivers_count_up`, `driver_age_down`,
                                       `is_legal_entity` , `value`, `priority`) VALUES
  (@kl_id, NULL, NULL, 33, 0, 1.25, 0),
  (@kl_id, 1, 3, NULL, 0, 1, 1),
  (@kl_id, 4, 4, NULL, 0, 1.1, 1),
  (@kl_id, 5, 5, NULL, 0, 1.2, 1),
  (@kl_id, NULL, NULL, NULL, 1, 1, 2);

-- вставка для kp - коэф. парковости (по умолчанию = 1)
SET @kp_id = (SELECT id FROM all_factors WHERE code='kp');

INSERT INTO `additional_coefficients` (`factor_id`, `car_quantity_down`, `car_quantity_up`, `value`) VALUES
  (@kp_id, 2, 5, 0.98),
  (@kp_id, 6, 9, 0.95),
  (@kp_id, 10, NULL, 0.9);

-- Вставка для ksd (коэфициент срока действия договора))
SET @ksd_id = (SELECT id FROM all_factors WHERE code='ksd');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `contract_from_day`, `contract_to_day`, `contract_from_month`,
                                       `contract_to_month`, `contract_from_year`, `contract_to_year`, `value`, `priority`) VALUES
  (@ksd_id, NULL, 5, 5, NULL, NULL, NULL, NULL, 0.05, 0),
  (@ksd_id, NULL,6, 15, NULL, NULL, NULL, NULL, 0.1, 0),
  (@ksd_id, NULL,16, NULL, NULL, 1, NULL, NULL, 0.2, 0),
  (@ksd_id, NULL,NULL, NULL, 2, 2, NULL, NULL, 0.3, 0),
  (@ksd_id, NULL,NULL, NULL, 3, 3, NULL, NULL, 0.4, 0),
  (@ksd_id, NULL,NULL, NULL, 4, 4, NULL, NULL, 0.5, 0),
  (@ksd_id, NULL,NULL, NULL, 5, 5, NULL, NULL, 0.6, 0),
  (@ksd_id, NULL,NULL, NULL, 6, 6, NULL, NULL, 0.7, 0),
  (@ksd_id, NULL,NULL, NULL, 7, 7, NULL, NULL, 0.75, 0),
  (@ksd_id, NULL,NULL, NULL, 8, 8, NULL, NULL, 0.8, 0),
  (@ksd_id, NULL,NULL, NULL, 9, 9, NULL, NULL, 0.85, 0),
  (@ksd_id, NULL,NULL, NULL, 10, 10, NULL, NULL, 0.9, 0),
  (@ksd_id, NULL,NULL, NULL, 11, 11, NULL, NULL, 0.95, 0),
  (@ksd_id, NULL,NULL, NULL, 12, 12, NULL, NULL, 1, 0),
  (@ksd_id, @TPEconon50, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1);


-- вставка для kps (Коэфициент противоугонных средств)
SET @kps_id = (SELECT id FROM all_factors WHERE code='kps');

INSERT INTO `additional_coefficients` (`factor_id`, `ts_no_defend_flag`, `ts_satellite_flag`, `ts_have_electronic_alarm`, `value`, `priority`) VALUES
  (@kps_id, 1, NULL, NULL, 1.3, 0),
  (@kps_id, NULL, 1, NULL, 0.87, 2),
  (@kps_id, NULL, NULL, 1, 0.95, 1);

-- вставка для kkv - коэф. комиссионного вознаграждения (шаг, один процент)
SET @kkv_id = (SELECT id FROM all_factors WHERE code='kkv');

INSERT INTO `additional_coefficients` (`factor_id`, `commission_percent_down`, `commission_percent_up`, `value`) VALUES
  (@kkv_id, 1, 1, 0.81),
  (@kkv_id, 2, 2, 0.82),
  (@kkv_id, 3, 3, 0.83),
  (@kkv_id, 4, 4, 0.84),
  (@kkv_id, 5, 5, 0.85),
  (@kkv_id, 6, 6, 0.86),
  (@kkv_id, 7, 7, 0.87),
  (@kkv_id, 8, 8, 0.88),
  (@kkv_id, 9, 9, 0.89),
  (@kkv_id, 10, 10, 0.9),
  (@kkv_id, 11, 11, 0.91),
  (@kkv_id, 12, 12, 0.92),
  (@kkv_id, 13, 13, 0.93),
  (@kkv_id, 14, 14, 0.94),
  (@kkv_id, 15, 15, 0.95),
  (@kkv_id, 16, 16, 0.96),
  (@kkv_id, 17, 17, 0.97),
  (@kkv_id, 18, 18, 0.98),
  (@kkv_id, 19, 19, 0.99),
  (@kkv_id, 20, 20, 1),
  (@kkv_id, 21, 21, 1.02),
  (@kkv_id, 22, 22, 1.04),
  (@kkv_id, 23, 23, 1.06),
  (@kkv_id, 24, 24, 1.07),
  (@kkv_id, 25, 25, 1.08);

-- вставка	для ko - единовременная оплата страх. премии
SET @ko_id = (SELECT id FROM all_factors WHERE code='ko');

INSERT INTO `additional_coefficients` (`factor_id`, `is_onetime_payment`, `value`) VALUES
  (@ko_id, 1, 0.97);

-- вставка для klv - Коэффициент лимита возмещения
SET @klv_id = (SELECT id FROM all_factors WHERE code='klv');
SET @AggregateLimit = (SELECT id FROM regres_limit WHERE name='Агрегатный лимит');
SET @ToFirstInsEvent = (SELECT id FROM regres_limit WHERE name='До 1 страхового случая');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `regres_limit_factor_id`, `value`) VALUES
  (@klv_id, @UniversalInsProgram, @AggregateLimit, 0.95),
  (@klv_id, @UniversalInsProgram, @ToFirstInsEvent, 0.6);


-- вставка для kctoa - Коэффициент возмещения
SET @kctoa_id = (SELECT id FROM all_factors WHERE code='kctoa');
SET @1C = (SELECT id FROM tariff_def_damage_type WHERE name='По калькуляции страховщика');
SET @2C = (SELECT id FROM tariff_def_damage_type WHERE name='По калькуляции страховщика / По счетам СТОА из перечня');
SET @3C = (SELECT id FROM tariff_def_damage_type WHERE name='По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `tariff_def_damage_type_id`, `regres_limit_factor_id`, `value`) VALUES
  (@kctoa_id, @UniversalInsProgram, @1C, @NonAggregateLimit, 1),
  (@kctoa_id, @UniversalInsProgram, @1C, @AggregateLimit, 1),
  (@kctoa_id, @UniversalInsProgram, @2C, @NonAggregateLimit, 1.05),
  (@kctoa_id, @UniversalInsProgram, @2C, @AggregateLimit, 1.05),
  (@kctoa_id, @UniversalInsProgram, @3C, @NonAggregateLimit, 1.2),
  (@kctoa_id, @UniversalInsProgram, @3C, @AggregateLimit, 1.2),
  (@kctoa_id, @UniversalInsProgram, NULL, @ToFirstInsEvent, 1);

-- вставка для vbs - Выплаты без справок (по умолчанию = 1)
SET @vbs_id = (SELECT id FROM all_factors WHERE code='vbs');
SET @pay1time = (SELECT id FROM payments_without_references WHERE name='1 раз за период страхования');
SET @pay2times = (SELECT id FROM payments_without_references WHERE name='2 раза за период страхования');
SET @nopay_1 = (SELECT id FROM payments_without_references WHERE name='Не осуществляются (1 вариант)');
SET @nopay_2 = (SELECT id FROM payments_without_references WHERE name='Не осуществляются (2 вариант)');
SET @Buisness = (SELECT id FROM tariff_program WHERE name='Бизнес');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `payments_without_references_id`, `value`, `priority`) VALUES
  (@vbs_id, @Buisness, @pay1time, 1, 1),
  (@vbs_id, @Buisness, @pay2times, 1, 1),
  (@vbs_id, @Buisness, @nopay_1, 0.95, 1),
  (@vbs_id, @Buisness, @nopay_2, 0.9, 1),
  (@vbs_id, NULL, @pay1time, 1, 0),
  (@vbs_id, NULL, @pay2times, 1.1, 0),
  (@vbs_id, NULL, @nopay_1, 0.95, 0),
  (@vbs_id, NULL, @nopay_2, 0.9, 0);

SET @uncond_fran = (SELECT id FROM franchise_type WHERE `name`='Безусловная');
SET @cond_fran = (SELECT id FROM franchise_type WHERE `name`='Условная');

-- Принудительно франшиза 2% при комерческом извозе. (безусловная) + Коэфициент использования ТС = 2 (Ки), еще возможен вариант Ки = 1.7)
INSERT INTO `factor_restricions` (`factor_name`, `dependent_factor_name`, `factor_value`, `dependent_factor_value`)
VALUES
  ('commercial_carting_flag', 'franchise_percent', 1, 2),
  ('commercial_carting_flag', 'ki_ts', 1, 2),
  ('commercial_carting_flag', 'franchise_type_id', 1, @uncond_fran);

-- Принудительно франшиза 4% при тарифном плане эконом до 1СС (условная))
INSERT INTO `factor_restricions` (`factor_name`, `dependent_factor_name`, `factor_value`, `dependent_factor_value`)
VALUES
  ('tariff_program_id', 'franchise_percent', @TPEconom, 4),
  ('tariff_program_id', 'franchise_type_id', @TPEconom, @cond_fran);

-- Принудительно франшиза 8% при тарифном плане эконом 50/50 (безусловная)
INSERT INTO `factor_restricions` (`factor_name`, `dependent_factor_name`, `factor_value`, `dependent_factor_value`)
VALUES
  ('tariff_program_id', 'franchise_percent', @TPEconon50, 8),
  ('tariff_program_id', 'franchise_type_id', @TPEconon50, @uncond_fran);

-- При коэфициенте использования ТС больше 1,7 обязательна франшиза >=2%
INSERT INTO `factor_restricions` (`factor_name`, `dependent_factor_name`, `factor_value_down`, `dependent_factor_down`, `conditional`, `dependent_factor_value`)
VALUES ('ki_ts', 'franchise_percent', 1.7, 2, 1, 2);
-- EOF