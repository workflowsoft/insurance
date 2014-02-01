


-- Создание таблицы additional_coefficients
-- Дамп структуры для таблица ubercalc.additional_coefficients
CREATE TABLE IF NOT EXISTS `additional_coefficients` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `factor_id` int(10) DEFAULT '0',
  `contract_days` int(2) DEFAULT NULL,
  `contract_months` int(2) DEFAULT NULL,
  `contract_years` int(2) DEFAULT NULL,
  `ksp_value` double DEFAULT '0',
  `tariff_program_id` int(10) DEFAULT '0',
  `ldu_quantity` varchar(50) COLLATE utf8_bin DEFAULT '0',
  `driver_age_down` int(10) DEFAULT '0',
  `driver_age_up` int(10) DEFAULT '0',
  `driver_exp_down` int(10) DEFAULT '0',
  `driver_exp_up` int(10) DEFAULT '0',
  `ki_value` double DEFAULT '0',
  `TS_NoDefendFlag` tinyint(1) DEFAULT '0',
  `TS_SatelliteFlag` tinyint(1) DEFAULT '0',
  `TS_HaveElectronicAlarm` tinyint(1) DEFAULT '0',
  `TS_Risks_Id` int(10) DEFAULT '0',
  `ksd_description_id` int(10) DEFAULT '0',
  `kp_description_id` int(10) DEFAULT '0',
  `kp_flag` tinyint(1) DEFAULT '0',
  `ko_is_checked` tinyint(1) DEFAULT '0',
  `regres_limit_factor_id` int(10) DEFAULT '0',
  `tariff_def_damage_type_id` int(10) DEFAULT '0',
  `klv_value` double DEFAULT '0',
  `payments_without_references_id` int(10) DEFAULT '0',
  `ka_value` double DEFAULT '0',
  `Franshiza_Percent_Up` double DEFAULT '0',
  `Franshiza_Percent_Down` double DEFAULT '0',
  `Franshiza_Percent_value` double DEFAULT '0',
  `franchise_type_id` int(10) DEFAULT '0',
  `Franshiza_Flag` tinyint(1) DEFAULT '0',
  `commercial_carting_flag` tinyint(1) DEFAULT '0',
  `commission_percent_value` double DEFAULT '0',
  `value` float DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Сводная таблица со значениями всех коэффициентов';

