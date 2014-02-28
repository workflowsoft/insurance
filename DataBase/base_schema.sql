-- Дамп структуры базы данных ubercalc
DROP DATABASE IF EXISTS `ubercalc`;
CREATE DATABASE IF NOT EXISTS `ubercalc` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;

USE `ubercalc`;

-- Таблица списка используемых в формуле РАССЧЕТНЫХ операндов, их обязательность и значение по-умолчанию
DROP TABLE IF EXISTS `coefficients`;
CREATE TABLE IF NOT EXISTS `coefficients` (
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
  `icon` varchar(256),
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
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Модификация ТС';

-- Связка Тип ТС -> Производитель ТС
DROP TABLE IF EXISTS `ts_type2ts_make`;
CREATE TABLE IF NOT EXISTS `ts_type2ts_make` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `ts_type_id` int(10) REFERENCES `ts_type`(id),
  `ts_make_id` int(10) REFERENCES `ts_make`(id),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Связка Тип ТС -> Производитель ТС';

-- Группа ТС
DROP TABLE IF EXISTS `ts_group`;
CREATE TABLE IF NOT EXISTS `ts_group` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) COLLATE utf8_bin NOT NULL,
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

DROP TABLE IF EXISTS `ts_antitheft`;
CREATE TABLE IF NOT EXISTS `ts_antitheft` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Поправочные коэфициенты с зависимостью от факторов, которые их формируют
DROP TABLE IF EXISTS `additional_coefficients`;
CREATE TABLE IF NOT EXISTS `additional_coefficients` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `coefficient_id` int(10) NOT NULL REFERENCES coefficients(id),
  `tariff_program_id` int(10) DEFAULT NULL REFERENCES tariff_program(id),
  `risk_id` int(10) DEFAULT NULL REFERENCES  risks(id),
  `ts_group_id` int(10) REFERENCES `ts_group`(id),
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
  `ts_antitheft_id` int(10) DEFAULT NULL REFERENCES ts_antitheft(id),
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
  `ts_group_id` int(10) REFERENCES `ts_group`(id),
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


-- Таблица обязательной зависимости значений одних факторов от значений других факторов
DROP TABLE IF EXISTS `factor_restricions`;
CREATE TABLE IF NOT EXISTS `factor_restricions` (
	`id` int(10) unsigned NOT NULL AUTO_INCREMENT,
	`factor_name` varchar(50) NOT NULL,
	`dependent_factor_name` varchar(50) NOT NULL,
	`factor_value_down` double,
	`factor_value_up` double,
	`factor_value` varchar(50) NULL,
	`dependent_factor_value` varchar(50) NULL,
	`dependent_factor_down` double,
	`dependent_factor_up` double,
	`conditional` bit(1) DEFAULT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Определение значений одних факторов значеним других на праве перезаписи';

-- Таблица факторов

DROP TABLE IF EXISTS `factors`;
CREATE TABLE IF NOT EXISTS `factors` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `title` varchar(128) NOT NULL,
  `default` int(10) unsigned,
  `description` varchar(255),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Факторы, участвующие в расчете коэффициентов';

-- Привязка справочников к факторам
DROP TABLE IF EXISTS `factor_references`;
CREATE TABLE IF NOT EXISTS `factor_references` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `reference_table` varchar(50),
  `type` varchar(50) NOT NULL,
  `program_specific` tinyint(1) NOT NULL,
   PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Справочники в системе и их типы';

-- Привязка справочников к факторам
DROP TABLE IF EXISTS `factor2references`;
CREATE TABLE IF NOT EXISTS `factor2references` (
   `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
   `factor_id` int(10) unsigned NOT NULL REFERENCES `factors`(id),
   `reference_id` int(10) unsigned NOT NULL REFERENCES `factor_references`(id),
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Привязка справочников к факторам';

-- Поправочные коэфициенты с зависимостью от факторов, которые их формируют
DROP TABLE IF EXISTS `calc_history`;
CREATE TABLE IF NOT EXISTS `calc_history` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
# факторы
  `ts_age` int(10) NOT NULL,
  `ts_sum` double DEFAULT NULL,
  `tariff_program_id` int(10) DEFAULT NULL REFERENCES tariff_program(id),
  `risk_id` int(10) DEFAULT NULL REFERENCES  risks(id),
  `ts_type_id` int(10) REFERENCES `ts_type`(id),
  `ts_group_id` int(10) REFERENCES `ts_group`(id),
  `ts_make` VARCHAR (128),
  `ts_model` VARCHAR (128),
  `ts_modification_id` int(10) REFERENCES `ts_modification`(id),
  `regres_limit_factor_id` int(10) DEFAULT NULL REFERENCES regres_limit(id),
  `tariff_def_damage_type_id` int(10) DEFAULT NULL REFERENCES tariff_def_damage_type(id),
  `payments_without_references_id` int(10) DEFAULT NULL REFERENCES payments_without_references(id),
  `franchise_type_id` int(10) DEFAULT NULL REFERENCES franchise_type(id),
  `contract_day` int(2) DEFAULT NULL,
  `contract_month` int(2) DEFAULT NULL,
  `contract_year` int(2) DEFAULT NULL,
  `drivers_count` int(10) DEFAULT NULL,
  `driver_age` int(10) DEFAULT NULL,
  `driver_exp` int(10) DEFAULT NULL,
  `ts_antitheft_id` int(10) DEFAULT NULL REFERENCES ts_antitheft(id),
  `is_onetime_payment` tinyint(1) DEFAULT NULL,
  `car_quantity` int(10) DEFAULT NULL,
  `franchise_percent` double DEFAULT NULL,
  `commercial_carting_flag` tinyint(1) DEFAULT NULL,
  `commission_percent` double DEFAULT NULL,
  `is_legal_entity` tinyint(1) DEFAULT NULL,
  `amortisation` bit(1) DEFAULT NULL,
# значения коэфициентов
  `base` DOUBLE,
  `kuts` DOUBLE,
  `kf` DOUBLE,
  `kvs` DOUBLE,
  `kl` DOUBLE,
  `kp` DOUBLE,
  `ksd` DOUBLE,
  `kps` DOUBLE,
  `kkv` DOUBLE,
  `ko` DOUBLE,
  `klv` DOUBLE,
  `kctoa` DOUBLE,
  `vbs` DOUBLE,
  `ksp` DOUBLE,
  `ki` DOUBLE,
  `kbm` DOUBLE,
  `ka` DOUBLE,
# сумма или ошибка
  `sum` double,
  `sum_additional` double,
  `errors` VARCHAR(512),
# прочие
# add user_id
  `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица истории калькуляций';



