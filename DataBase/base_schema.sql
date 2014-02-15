-- Дамп структуры базы данных ubercalc
DROP DATABASE IF EXISTS `ubercalc`;
CREATE DATABASE IF NOT EXISTS `ubercalc` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

USE `ubercalc`;

-- Таблица списка используемых в формуле РАССЧЕТНЫХ операндов, их обязательность и значение по-умолчанию
DROP TABLE IF EXISTS `all_factors`;
CREATE TABLE IF NOT EXISTS `all_factors` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `description` varchar(50) COLLATE utf8_bin NOT NULL,
  `code` varchar(50) COLLATE utf8_bin NOT NULL,
  `is_mandatory` tinyint(1) DEFAULT '0',
  `default_value` double DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица списка используемых в формуле РАССЧЕТНЫХ операндов, их обязательность и значение по-умолчанию';

-- Тип франшизы
DROP TABLE IF EXISTS `franchise_type`;
CREATE TABLE IF NOT EXISTS `franchise_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Тип франшизы';

-- Варианты выплаты без справок
DROP TABLE IF EXISTS `payments_without_references`;
CREATE TABLE IF NOT EXISTS `payments_without_references` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Варианты выплаты без справок';

-- Лимит регресного возмещения страховой суммы
DROP TABLE IF EXISTS `regres_limit`;
CREATE TABLE IF NOT EXISTS `regres_limit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Лимит регресного возмещения страховой суммы';

-- Пакеты рисков или конкретные риски
DROP TABLE IF EXISTS `risks`;
CREATE TABLE IF NOT EXISTS `risks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Пакеты рисков или конкретные риски';

-- Варианты тарифных планов
DROP TABLE IF EXISTS `tariff_program`;
CREATE TABLE IF NOT EXISTS `tariff_program` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Варианты тарифных планов';

-- Определение размера страхового возмещения
DROP TABLE IF EXISTS `tariff_def_damage_type`;
CREATE TABLE IF NOT EXISTS `tariff_def_damage_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Определение размера страхового возмещения';

-- Тип ТС
DROP TABLE IF EXISTS `ts_type`;
CREATE TABLE IF NOT EXISTS `ts_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Тип ТС';

-- Производители ТС
DROP TABLE IF EXISTS `ts_make`;
CREATE TABLE IF NOT EXISTS `ts_make` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Производители ТС';

-- Модель TC
DROP TABLE IF EXISTS `ts_model`;
CREATE TABLE IF NOT EXISTS `ts_model` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ts_type_id` int(10) NOT NULL REFERENCES  ts_type(id),
  `ts_make_id` int(10) NOT NULL REFERENCES `ts_make`(id),
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Модель TC';

-- Модификация ТС
DROP TABLE IF EXISTS `ts_modification`;
CREATE TABLE IF NOT EXISTS `ts_modification` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ts_model_id` int(10) REFERENCES  `ts_model`(id),
  `ts_type_id` int(10) REFERENCES `ts_type`(id), /*Модификация модели может поменять тип ТС, но обчыно такого не случается*/
  `Name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Модификация ТС';

-- Группа ТС
DROP TABLE IF EXISTS `ts_group`;
CREATE TABLE IF NOT EXISTS `ts_group` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(512) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Группа ТС';

-- Составление групп транспортных средств и конкретных моделей и марок
DROP TABLE IF EXISTS `ts_group_match`;
CREATE TABLE IF NOT EXISTS `ts_group_match` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ts_group_id` int(10) NOT NULL REFERENCES `ts_group`(id),
  `ts_modification_id` int(10) REFERENCES `ts_modification`(id),
  `ts_type_id` int(10) REFERENCES `ts_type`(id),
  `ts_model_id` int(10) REFERENCES `ts_model`(id),
  `ts_make_id` int(10) REFERENCES `ts_make`(id),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Составление групп транспортных средств и конкретных моделей и марок';


-- Поправочные коэфициенты с зависимостью от факторов, которые их формируют
DROP TABLE IF EXISTS `additional_coefficients`;
CREATE TABLE IF NOT EXISTS `additional_coefficients` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `factor_id` int(10) NOT NULL REFERENCES all_factors(id),
  `tariff_program_id` int(10) DEFAULT NULL REFERENCES tariff_program(id),
  `risk_id` int(10) DEFAULT NULL REFERENCES  risks(id),
  `ts_type_id` int(10) REFERENCES `ts_type`(id),
  `ts_group_id` int(10) REFERENCES `ts_group`(id),
  `ts_make_id` int(10) REFERENCES `ts_make`(id),
  `ts_model_id` int(10) REFERENCES `ts_model`(id),
  `ts_modification_id` int(10) REFERENCES `ts_modification`(id),
  `ts_age` int(10) NULL,
  `regres_limit_factor_id` int(10) DEFAULT NULL REFERENCES regres_limit(id),
  `tariff_def_damage_type_id` int(10) DEFAULT NULL REFERENCES tariff_def_damage_type(id),
  `payments_without_references_id` int(10) DEFAULT NULL REFERENCES payments_without_references(id),
  `franchise_type_id` int(10) DEFAULT NULL REFERENCES franchise_type(id),
  `contract_day_down` int(2) DEFAULT NULL,
  `contract_day_up` int(2) DEFAULT NULL,
  `contract_month_down` int(2) DEFAULT NULL,
  `contract_month_up` int(2) DEFAULT NULL,
  `contract_year_down` int(2) DEFAULT NULL,
  `contract_year_up` int(2) DEFAULT NULL,
  `drivers_count_up` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `drivers_count_down` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `driver_age_down` int(10) DEFAULT NULL,
  `driver_age_up` int(10) DEFAULT NULL,
  `driver_exp_down` int(10) DEFAULT NULL,
  `driver_exp_up` int(10) DEFAULT NULL,
  `ts_no_defend_flag` tinyint(1) DEFAULT NULL,
  `ts_satellite_flag` tinyint(1) DEFAULT NULL,
  `ts_have_electronic_alarm` tinyint(1) DEFAULT NULL,
  `is_onetime_payment` tinyint(1) DEFAULT NULL,
  `car_quantity_down` int(10) DEFAULT NULL,
  `car_quantity_up` int(10) DEFAULT NULL,
  `franchise_percent_up` double DEFAULT NULL,
  `franchise_percent_down` double DEFAULT NULL,
  `commercial_carting_flag` tinyint(1) DEFAULT NULL,
  `commission_percent_up` double DEFAULT NULL,
  `commission_percent_down` double DEFAULT NULL,
  `is_legal_entity` tinyint(1) DEFAULT NULL,
  `amortisation` bit(1) DEFAULT NULL,
  `priority` int(10) DEFAULT 0,
  `value` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Поправочные коэфициенты с зависимостью от факторов, которые их формируют';

-- Таблица зависимостей базового тарифа от различных факторов
DROP TABLE IF EXISTS `tariff_coefficients`;
CREATE TABLE IF NOT EXISTS `tariff_coefficients` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ts_type_id` int(10) REFERENCES `ts_type`(id),
  `ts_group_id` int(10) REFERENCES `ts_group`(id),
  `ts_make_id` int(10) REFERENCES `ts_make`(id),
  `ts_model_id` int(10) REFERENCES `ts_model`(id),
  `ts_modification_id` int(10) REFERENCES `ts_modification`(id),
  `tariff_program_id` int(10) NOT NULL REFERENCES `tariff_program`(id),
  `risk_id` int(10) NOT NULL REFERENCES `risks`(id),
  `tariff_def_damage_type_id` int(10) NULL  REFERENCES `tariff_def_damage_type`(id),
  `ts_age` int(10) NOT NULL,
  `ts_sum_up` int(10) DEFAULT NULL,
  `ts_sum_down` int(10) DEFAULT NULL,
  `amortisation` bit(1) DEFAULT NULL,
  `value` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица зависимостей базового тарифа от различных факторов';

-- Таблица фронтового справочника, длительности договора страховки
DROP TABLE IF EXISTS `front_contract_duration`;
CREATE TABLE IF NOT EXISTS `front_contract_duration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `contract_days_up` int(11) DEFAULT NULL,
  `contract_months_up` int(11) DEFAULT NULL,
  `contract_years_up` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица фронтового справочника, длительности договора страховки';

-- Дамп структуры для таблица ubercalc.front_ldu_quantity
DROP TABLE IF EXISTS `front_ldu_quantity`;
CREATE TABLE IF NOT EXISTS `front_ldu_quantity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Количество ЛДУ (лиц допущенных к управлению)';

-- Таблица обязательной зависимости значений одних факторов от значений других факторов
DROP TABLE IF EXISTS `factor_restricions`;
CREATE TABLE IF NOT EXISTS `factor_restricions` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`factor_name` varchar(50) NOT NULL COLLATE utf8_bin,
	`dependent_factor_name` varchar(50) NOT NULL COLLATE utf8_bin,
	`factor_value_down` double,
	`factor_value_up` double,
	`factor_value` varchar(50) NULL COLLATE utf8_bin,
	`dependent_factor_value` varchar(50) NULL COLLATE utf8_bin,
	`dependent_factor_down` double,
	`dependent_factor_up` double,
	`conditional` bit(1) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Определение значений одних факторов значеним других на праве перезаписи';

