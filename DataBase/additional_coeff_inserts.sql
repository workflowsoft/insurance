USE `ubercalc`;

-- вставка для kuts (утрата товарной стоимости))
SET @kuts_id = (SELECT
                  id
                FROM all_factors
                WHERE code = 'kuts');

INSERT INTO `additional_coefficients` (`factor_id`, `amortisation`, `value`) VALUES
  (@kuts_id, 0, 1.3);

-- Вставка для kf - коэф. франшизы
SET @kf_id = (SELECT
                id
              FROM all_factors
              WHERE code = 'kf');
-- Коэфициент при безусловной франшизе (минимальный шаг, 10-ые процента)
SET @UnconditionalFranshiza = (SELECT
                                 id
                               FROM franchise_type
                               WHERE name = 'Безусловная');
INSERT INTO `franchise_percent` (`down`, `up`) VALUES (0.1, 0.5);
INSERT INTO `franchise_percent` (`down`, `up`) VALUES (0.6, 1);
INSERT INTO `franchise_percent` (`down`, `up`) VALUES (1.1, 2);
INSERT INTO `franchise_percent` (`down`, `up`) VALUES (2.1, 3);
INSERT INTO `franchise_percent` (`down`, `up`) VALUES (3.1, 4);
INSERT INTO `franchise_percent` (`down`, `up`) VALUES (4.1, 5);
INSERT INTO `franchise_percent` (`down`, `up`) VALUES (5.1, 6);
INSERT INTO `franchise_percent` (`down`, `up`) VALUES (6.1, 7);
INSERT INTO `franchise_percent` (`down`, `up`) VALUES (7.1, 8);

INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`)
VALUES (@kf_id, (SELECT
                   `id`
                 FROM `franchise_percent`
                 WHERE `down` = 0.1 AND `up` = 0.5), @UnconditionalFranshiza, 0.93);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`)
VALUES (@kf_id, (SELECT
                   `id`
                 FROM `franchise_percent`
                 WHERE `down` = 0.6 AND `up` = 1), @UnconditionalFranshiza, 0.85);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`)
VALUES (@kf_id, (SELECT
                   `id`
                 FROM `franchise_percent`
                 WHERE `down` = 1.1 AND `up` = 2), @UnconditionalFranshiza, 0.8);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`)
VALUES (@kf_id, (SELECT
                   `id`
                 FROM `franchise_percent`
                 WHERE `down` = 2.1 AND `up` = 3), @UnconditionalFranshiza, 0.75);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`)
VALUES (@kf_id, (SELECT
                   `id`
                 FROM `franchise_percent`
                 WHERE `down` = 3.1 AND `up` = 4), @UnconditionalFranshiza, 0.7);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`)
VALUES (@kf_id, (SELECT
                   `id`
                 FROM `franchise_percent`
                 WHERE `down` = 4.1 AND `up` = 5), @UnconditionalFranshiza, 0.65);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`)
VALUES (@kf_id, (SELECT
                   `id`
                 FROM `franchise_percent`
                 WHERE `down` = 5.1 AND `up` = 6), @UnconditionalFranshiza, 0.6);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`)
VALUES (@kf_id, (SELECT
                   `id`
                 FROM `franchise_percent`
                 WHERE `down` = 6.1 AND `up` = 7), @UnconditionalFranshiza, 0.55);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`)
VALUES (@kf_id, (SELECT
                   `id`
                 FROM `franchise_percent`
                 WHERE `down` = 7.1 AND `up` = 8), @UnconditionalFranshiza, 0.5);
-- Коэфициент при условной франшизе (минимальный шаг, 10-ые процента)
SET @ConditionalFranshiza = (SELECT
                               id
                             FROM franchise_type
                             WHERE name = 'Условная');

INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`) VALUES
  (@kf_id, (SELECT
              `id`
            FROM `franchise_percent`
            WHERE `down` = 0.1 AND `up` = 0.5), @ConditionalFranshiza, 0.95);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`) VALUES
  (@kf_id, (SELECT
              `id`
            FROM `franchise_percent`
            WHERE `down` = 0.6 AND `up` = 1), @ConditionalFranshiza, 0.9);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`) VALUES
  (@kf_id, (SELECT
              `id`
            FROM `franchise_percent`
            WHERE `down` = 1.1 AND `up` = 2), @ConditionalFranshiza, 0.85);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`) VALUES
  (@kf_id, (SELECT
              `id`
            FROM `franchise_percent`
            WHERE `down` = 2.1 AND `up` = 3), @ConditionalFranshiza, 0.8);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`) VALUES
  (@kf_id, (SELECT
              `id`
            FROM `franchise_percent`
            WHERE `down` = 3.1 AND `up` = 4), @ConditionalFranshiza, 0.75);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`) VALUES
  (@kf_id, (SELECT
              `id`
            FROM `franchise_percent`
            WHERE `down` = 4.1 AND `up` = 5), @ConditionalFranshiza, 0.7);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`) VALUES
  (@kf_id, (SELECT
              `id`
            FROM `franchise_percent`
            WHERE `down` = 5.1 AND `up` = 6), @ConditionalFranshiza, 0.65);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`) VALUES
  (@kf_id, (SELECT
              `id`
            FROM `franchise_percent`
            WHERE `down` = 6.1 AND `up` = 7), @ConditionalFranshiza, 0.6);
INSERT INTO `additional_coefficients` (`factor_id`, `franchise_percent_id`, `franchise_type_id`, `value`) VALUES
  (@kf_id, (SELECT
              `id`
            FROM `franchise_percent`
            WHERE `down` = 7.1 AND `up` = 8), @ConditionalFranshiza, 0.55);

SET @TPEconom = (SELECT
                   id
                 FROM tariff_program
                 WHERE name = 'Эконом до 1 страхового случая');
SET @UniversalInsProgram = (SELECT
                              id
                            FROM tariff_program
                            WHERE name = 'Универсал');
SET @TPOptimal = (SELECT
                    id
                  FROM tariff_program
                  WHERE name = 'Оптимал');
SET @TPEconon50 = (SELECT
                     id
                   FROM tariff_program
                   WHERE name = 'Эконом 50/50');
SET @Reges1CC = (SELECT
                   id
                 FROM regres_limit
                 WHERE name = 'До 1 страхового случая');

-- Коэфициент франшизы = 1 (т.е. не действует),
-- При прокате ТС
-- ТП Эконом 1СС,
-- Универсал с лимитом возмещения до 1СС
-- Оптимал
INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `commercial_carting_flag`, `regres_limit_factor_id`, `value`, `priority`)
VALUES
  (@kf_id, NULL, 1, NULL, 1, 2),
  (@kf_id, @TPEconom, NULL, NULL, 1, 1),
  (@kf_id, @UniversalInsProgram, NULL, @Reges1CC, 1, 1),
  (@kf_id, @TPOptimal, NULL, NULL, 1, 1);


-- вставка для kvs коэф. возраста-стажа (иметь ввиду, что у нас по-умолчанию не юрлицо.) шаг, один год
SET @kvs_id = (SELECT
                 id
               FROM all_factors
               WHERE code = 'kvs');

-- Рассчитывает только при укзании количества водителей, если количество не указано, отрабатывает значение по-умолчанию

INSERT INTO `drivers_count` (`down`, `up`) VALUES (1, NULL);
SET @drivers_count = LAST_INSERT_ID();
INSERT INTO `drivers_count` (`down`, `up`) VALUES (1, 3);
SET @drivers_count_1_3 = LAST_INSERT_ID();
INSERT INTO `drivers_count` (`down`, `up`) VALUES (4, 4);
SET @drivers_count_4 = LAST_INSERT_ID();
INSERT INTO `drivers_count` (`down`, `up`) VALUES (5, 5);
SET @drivers_count_5 = LAST_INSERT_ID();


INSERT INTO `driver_age` (`down`, `up`) VALUES (0, 23);
SET @drivers_age_0_23 = LAST_INSERT_ID();
INSERT INTO `driver_age` (`down`, `up`) VALUES (24, 27);
SET @drivers_age_24_27 = LAST_INSERT_ID();
INSERT INTO `driver_age` (`down`, `up`) VALUES (28, 32);
SET @drivers_age_28_32 = LAST_INSERT_ID();
INSERT INTO `driver_age` (`down`, `up`) VALUES (33, 40);
SET @drivers_age_33_40 = LAST_INSERT_ID();
INSERT INTO `driver_age` (`down`, `up`) VALUES (41, NULL);
SET @drivers_age_41 = LAST_INSERT_ID();


INSERT INTO `driver_exp` (`down`, `up`) VALUES (0, 2);
SET @driver_exp_0_2 = LAST_INSERT_ID();
INSERT INTO `driver_exp` (`down`, `up`) VALUES (3, 5);
SET @driver_exp_3_5 = LAST_INSERT_ID();
INSERT INTO `driver_exp` (`down`, `up`) VALUES (6, 9);
SET @driver_exp_6_9 = LAST_INSERT_ID();
INSERT INTO `driver_exp` (`down`, `up`) VALUES (10, NULL);
SET @driver_exp_10 = LAST_INSERT_ID();


INSERT INTO `additional_coefficients` (`factor_id`, `drivers_count_id`, `driver_age_id`, `driver_exp_id`, `value`, `is_legal_entity`)
VALUES
  (@kvs_id, @drivers_count, @drivers_age_0_23, @driver_exp_0_2, 1.4, 0),
(@kvs_id, @drivers_count, @drivers_age_0_23, @driver_exp_3_5, 1.3, 0),
(@kvs_id, @drivers_count, @drivers_age_24_27, @driver_exp_0_2, 1.3, 0),
(@kvs_id, @drivers_count, @drivers_age_24_27, @driver_exp_3_5, 1.1, 0),
(@kvs_id, @drivers_count, @drivers_age_24_27, @driver_exp_6_9, 0.95, 0),
(@kvs_id, @drivers_count, @drivers_age_28_32, @driver_exp_0_2, 1.2, 0),
(@kvs_id, @drivers_count, @drivers_age_28_32, @driver_exp_3_5, 1.05, 0),
(@kvs_id, @drivers_count, @drivers_age_28_32, @driver_exp_6_9, 0.9, 0),
(@kvs_id, @drivers_count, @drivers_age_28_32, @driver_exp_10, 0.85, 0),
(@kvs_id, @drivers_count, @drivers_age_33_40, @driver_exp_0_2, 1.1, 0),
(@kvs_id, @drivers_count, @drivers_age_33_40, @driver_exp_3_5, 1, 0),
  (@kvs_id, @drivers_count, @drivers_age_33_40, @driver_exp_6_9, 0.85, 0),
  (@kvs_id, @drivers_count, @drivers_age_33_40, @driver_exp_10, 0.8, 0),
  (@kvs_id, @drivers_count, @drivers_age_41, @driver_exp_0_2, 1.15, 0),
  (@kvs_id, @drivers_count, @drivers_age_41, @driver_exp_3_5, 1, 0),
  (@kvs_id, @drivers_count, @drivers_age_41, @driver_exp_6_9, 0.85, 0),
  (@kvs_id, @drivers_count, @drivers_age_41, @driver_exp_10, 0.8, 0);

-- вставка для kl (лиц, допущенных к управлению)
SET @kl_id = (SELECT
                id
              FROM all_factors
              WHERE code = 'kl');

INSERT INTO `additional_coefficients` (`factor_id`, `drivers_count_id`, `driver_age_id`,
                                       `is_legal_entity`, `value`, `priority`) VALUES
  (@kl_id, NULL, @drivers_age_33_40, 0, 1.25, 0),
  (@kl_id, NULL, @drivers_age_41, 0, 1.25, 0),
  (@kl_id, @drivers_count_1_3, NULL, 0, 1, 1),
  (@kl_id, @drivers_count_4, NULL, 0, 1.1, 1),
  (@kl_id, @drivers_count_5, NULL, 0, 1.2, 1),
  (@kl_id, NULL, NULL, 1, 1, 2);

-- вставка для kp - коэф. парковости (по умолчанию = 1)
SET @kp_id = (SELECT
                id
              FROM all_factors
              WHERE code = 'kp');

INSERT INTO `car_quantity` (`down`, `up`) VALUES (2, 5);
SET @car_quantity_2_5 = LAST_INSERT_ID();
INSERT INTO `car_quantity` (`down`, `up`) VALUES (6, 9);
SET @car_quantity_6_9 = LAST_INSERT_ID();
INSERT INTO `car_quantity` (`down`, `up`) VALUES (10, NULL);
SET @car_quantity_10 = LAST_INSERT_ID();


INSERT INTO `additional_coefficients` (`factor_id`, `car_quantity_id`, `value`) VALUES
  (@kp_id, @car_quantity_2_5, 0.98),
  (@kp_id, @car_quantity_6_9, 0.95),
  (@kp_id, @car_quantity_10, 0.9);


INSERT INTO `contract_day` (`down`, `up`) VALUES (5, 5);
SET @contract_day_5 = LAST_INSERT_ID();
INSERT INTO `contract_day` (`down`, `up`) VALUES (6, 15);
SET @contract_day_6_15 = LAST_INSERT_ID();
INSERT INTO `contract_day` (`down`, `up`) VALUES (16, NULL);
SET @contract_day_16 = LAST_INSERT_ID();

INSERT INTO `contract_month` (`down`, `up`) VALUES (NULL, 1);
SET @contract_month_1 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (2, 2);
SET @contract_month_2 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (3, 3);
SET @contract_month_3 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (4, 4);
SET @contract_month_4 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (5, 5);
SET @contract_month_5 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (6, 6);
SET @contract_month_6 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (7, 7);
SET @contract_month_7 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (8, 8);
SET @contract_month_8 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (9, 9);
SET @contract_month_9 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (10, 10);
SET @contract_month_10 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (11, 11);
SET @contract_month_11 = LAST_INSERT_ID();
INSERT INTO `contract_month` (`down`, `up`) VALUES (12, 12);
SET @contract_month_12 = LAST_INSERT_ID();


-- Вставка для ksd (коэфициент срока действия договора))
SET @ksd_id = (SELECT
                 id
               FROM all_factors
               WHERE code = 'ksd');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `contract_day_id`, `contract_month_id`, `contract_year_id`, `value`, `priority`)
VALUES
  (@ksd_id, NULL, @contract_day_5, NULL,  NULL, 0.05, 0),
  (@ksd_id, NULL, @contract_day_6_15, NULL, NULL, 0.1, 0),
  (@ksd_id, NULL, @contract_day_16, @contract_month_1, NULL, 0.2, 0),
  (@ksd_id, NULL, NULL, @contract_month_2, NULL, 0.3, 0),
  (@ksd_id, NULL, NULL, @contract_month_3, NULL, 0.4, 0),
  (@ksd_id, NULL, NULL, @contract_month_4, NULL, 0.5, 0),
  (@ksd_id, NULL, NULL, @contract_month_5, NULL, 0.6, 0),
  (@ksd_id, NULL, NULL, @contract_month_6, NULL, 0.7, 0),
  (@ksd_id, NULL, NULL, @contract_month_7, NULL, 0.75, 0),
  (@ksd_id, NULL, NULL, @contract_month_8, NULL, 0.8, 0),
  (@ksd_id, NULL, NULL, @contract_month_9, NULL, 0.85, 0),
  (@ksd_id, NULL, NULL, @contract_month_10, NULL, 0.9, 0),
  (@ksd_id, NULL, NULL, @contract_month_11, NULL, 0.95, 0),
  (@ksd_id, NULL, NULL, @contract_month_12, NULL, 1, 0),
  (@ksd_id, @TPEconon50, NULL, NULL, NULL, 1, 1);


-- вставка для kps (Коэфициент противоугонных средств)
SET @kps_id = (SELECT
                 id
               FROM all_factors
               WHERE code = 'kps');

INSERT INTO `additional_coefficients` (`factor_id`, `ts_no_defend_flag`, `ts_satellite_flag`, `ts_have_electronic_alarm`, `value`, `priority`)
VALUES
  (@kps_id, 1, NULL, NULL, 1.3, 0),
  (@kps_id, NULL, 1, NULL, 0.87, 2),
  (@kps_id, NULL, NULL, 1, 0.95, 1);

-- вставка для kkv - коэф. комиссионного вознаграждения (шаг, один процент)
SET @kkv_id = (SELECT
                 id
               FROM all_factors
               WHERE code = 'kkv');

INSERT INTO `commission_percent` (`down`, `up`) VALUES (1,1);
SET @commission_percent_1 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (2,2);
SET @commission_percent_2 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (3,3);
SET @commission_percent_3 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (4,4);
SET @commission_percent_4 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (5,5);
SET @commission_percent_5 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (6,6);
SET @commission_percent_6 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (7,7);
SET @commission_percent_7 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (8,8);
SET @commission_percent_8 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (9,9);
SET @commission_percent_9 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (10,10);
SET @commission_percent_10 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (11,11);
SET @commission_percent_11 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (12,12);
SET @commission_percent_12 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (13,13);
SET @commission_percent_13 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (14,14);
SET @commission_percent_14 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (15,15);
SET @commission_percent_15 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (16,16);
SET @commission_percent_16 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (17,17);
SET @commission_percent_17 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (18,18);
SET @commission_percent_18 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (19,19);
SET @commission_percent_19 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (20,20);
SET @commission_percent_20 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (21,21);
SET @commission_percent_21 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (22,22);
SET @commission_percent_22 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (23,23);
SET @commission_percent_23 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (24,24);
SET @commission_percent_24 = LAST_INSERT_ID();
INSERT INTO `commission_percent` (`down`, `up`) VALUES (25,25);
SET @commission_percent_25 = LAST_INSERT_ID();


INSERT INTO `additional_coefficients` (`factor_id`, `commission_percent_id`, `value`) VALUES
  (@kkv_id, @commission_percent_1, 0.81),
  (@kkv_id, @commission_percent_2, 0.82),
  (@kkv_id, @commission_percent_3, 0.83),
  (@kkv_id, @commission_percent_4, 0.84),
  (@kkv_id, @commission_percent_5, 0.85),
  (@kkv_id, @commission_percent_6, 0.86),
  (@kkv_id, @commission_percent_7, 0.87),
  (@kkv_id, @commission_percent_8, 0.88),
  (@kkv_id, @commission_percent_9, 0.89),
  (@kkv_id, @commission_percent_10, 0.9),
  (@kkv_id, @commission_percent_11, 0.91),
  (@kkv_id, @commission_percent_12, 0.92),
  (@kkv_id, @commission_percent_13, 0.93),
  (@kkv_id, @commission_percent_14, 0.94),
  (@kkv_id, @commission_percent_15, 0.95),
  (@kkv_id, @commission_percent_16, 0.96),
  (@kkv_id, @commission_percent_17, 0.97),
  (@kkv_id, @commission_percent_18, 0.98),
  (@kkv_id, @commission_percent_19, 0.99),
  (@kkv_id, @commission_percent_0, 1),
  (@kkv_id, @commission_percent_21, 1.02),
  (@kkv_id, @commission_percent_22, 1.04),
  (@kkv_id, @commission_percent_23, 1.06),
  (@kkv_id, @commission_percent_24, 1.07),
  (@kkv_id, @commission_percent_25, 1.08);

-- вставка	для ko - единовременная оплата страх. премии
SET @ko_id = (SELECT
                id
              FROM all_factors
              WHERE code = 'ko');

INSERT INTO `additional_coefficients` (`factor_id`, `is_onetime_payment`, `value`) VALUES
  (@ko_id, 1, 0.97);

-- вставка для klv - Коэффициент лимита возмещения
SET @klv_id = (SELECT
                 id
               FROM all_factors
               WHERE code = 'klv');
SET @AggregateLimit = (SELECT
                         id
                       FROM regres_limit
                       WHERE name = 'Агрегатный лимит');
SET @ToFirstInsEvent = (SELECT
                          id
                        FROM regres_limit
                        WHERE name = 'До 1 страхового случая');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `regres_limit_factor_id`, `value`) VALUES
  (@klv_id, @UniversalInsProgram, @AggregateLimit, 0.95),
  (@klv_id, @UniversalInsProgram, @ToFirstInsEvent, 0.6);


-- вставка для kctoa - Коэффициент возмещения
SET @kctoa_id = (SELECT
                   id
                 FROM all_factors
                 WHERE code = 'kctoa');
SET @1C = (SELECT
             id
           FROM tariff_def_damage_type
           WHERE name = 'По калькуляции страховщика');
SET @2C = (SELECT
             id
           FROM tariff_def_damage_type
           WHERE name = 'По калькуляции страховщика / По счетам СТОА из перечня');
SET @3C = (SELECT
             id
           FROM tariff_def_damage_type
           WHERE name = 'По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `tariff_def_damage_type_id`, `regres_limit_factor_id`, `value`)
VALUES
  (@kctoa_id, @UniversalInsProgram, @1C, @NonAggregateLimit, 1),
  (@kctoa_id, @UniversalInsProgram, @1C, @AggregateLimit, 1),
  (@kctoa_id, @UniversalInsProgram, @2C, @NonAggregateLimit, 1.05),
  (@kctoa_id, @UniversalInsProgram, @2C, @AggregateLimit, 1.05),
  (@kctoa_id, @UniversalInsProgram, @3C, @NonAggregateLimit, 1.2),
  (@kctoa_id, @UniversalInsProgram, @3C, @AggregateLimit, 1.2),
  (@kctoa_id, @UniversalInsProgram, NULL, @ToFirstInsEvent, 1);

-- вставка для vbs - Выплаты без справок (по умолчанию = 1)
SET @vbs_id = (SELECT
                 id
               FROM all_factors
               WHERE code = 'vbs');
SET @pay1time = (SELECT
                   id
                 FROM payments_without_references
                 WHERE name = '1 раз за период страхования');
SET @pay2times = (SELECT
                    id
                  FROM payments_without_references
                  WHERE name = '2 раза за период страхования');
SET @nopay_1 = (SELECT
                  id
                FROM payments_without_references
                WHERE name = 'Не осуществляются (1 вариант)');
SET @nopay_2 = (SELECT
                  id
                FROM payments_without_references
                WHERE name = 'Не осуществляются (2 вариант)');
SET @Buisness = (SELECT
                   id
                 FROM tariff_program
                 WHERE name = 'Бизнес');

INSERT INTO `additional_coefficients` (`factor_id`, `tariff_program_id`, `payments_without_references_id`, `value`, `priority`)
VALUES
  (@vbs_id, @Buisness, @pay1time, 1, 1),
  (@vbs_id, @Buisness, @pay2times, 1, 1),
  (@vbs_id, @Buisness, @nopay_1, 0.95, 1),
  (@vbs_id, @Buisness, @nopay_2, 0.9, 1),
  (@vbs_id, NULL, @pay1time, 1, 0),
  (@vbs_id, NULL, @pay2times, 1.1, 0),
  (@vbs_id, NULL, @nopay_1, 0.95, 0),
  (@vbs_id, NULL, @nopay_2, 0.9, 0);

SET @uncond_fran = (SELECT
                      id
                    FROM franchise_type
                    WHERE `name` = 'Безусловная');
SET @cond_fran = (SELECT
                    id
                  FROM franchise_type
                  WHERE `name` = 'Условная');

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