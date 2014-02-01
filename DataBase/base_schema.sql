-- Дамп структуры базы данных ubercalc
DROP DATABASE IF EXISTS `ubercalc`;
CREATE DATABASE IF NOT EXISTS `ubercalc` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `ubercalc`;

-- Поправочные коэфициенты с зависимостью от факторов, которые их формируют
DROP TABLE IF EXISTS `additional_coefficients`;
CREATE TABLE IF NOT EXISTS `additional_coefficients` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `factor_id` int(10) DEFAULT '0',
  `tariff_program_id` int(10) DEFAULT '0',
  `ts_risks_id` int(10) DEFAULT '0',
  `regres_limit_factor_id` int(10) DEFAULT '0',
  `tariff_def_damage_type_id` int(10) DEFAULT '0',
  `payments_without_references_id` int(10) DEFAULT '0',  
  `franchise_type_id` int(10) DEFAULT '0',
  `contract_from_day` int(2) DEFAULT NULL,
  `contract_to_day` int(2) DEFAULT NULL,
  `contract_from_month` int(2) DEFAULT NULL,
  `contract_to_month` int(2) DEFAULT NULL,
  `contract_from_year` int(2) DEFAULT NULL,
  `contract_to_year` int(2) DEFAULT NULL,
  `drivers_count` varchar(50) COLLATE utf8_bin DEFAULT '0',
  `driver_age_down` int(10) DEFAULT '0',
  `driver_age_up` int(10) DEFAULT '0',
  `driver_exp_down` int(10) DEFAULT '0',
  `driver_exp_up` int(10) DEFAULT '0',
  `ts_no_defend_flag` tinyint(1) DEFAULT '0',
  `ts_satellite_flag` tinyint(1) DEFAULT '0',
  `ts_have_electronic_alarm` tinyint(1) DEFAULT '0',
  `is_onetime_payment` tinyint(1) DEFAULT '0',
  `car_quantity_down` int(10) DEFAULT '0',
  `car_quantity_up` int(10) DEFAULT '0',
  `franchise_percent_up` double DEFAULT '0',
  `franchise_percent_down` double DEFAULT '0',
  `commercial_carting_flag` tinyint(1) DEFAULT '0',
  `commission_percent_value` double DEFAULT '0',
  `is_legal_entity` tinyint(1) DEFAULT '0',
  `value` float DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Поправочные коэфициенты с зависимостью от факторов, которые их формируют';

-- Таблица списка используемых в формуле РАССЧЕТНЫХ операндов, их обязательность и значение по-умолчанию
DROP TABLE IF EXISTS `all_factors`;
CREATE TABLE IF NOT EXISTS `all_factors` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `description` varchar(50) COLLATE utf8_bin NOT NULL,
  `code` varchar(50) COLLATE utf8_bin NOT NULL,
  `is_mandatory` tinyint(1) DEFAULT '0',
  `default_value` int(10) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица списка используемых в формуле РАССЧЕТНЫХ операндов, их обязательность и значение по-умолчанию';



-- Таблица фронтового справочника, длительности договора страховки
DROP TABLE IF EXISTS `front_contract_duration`;
CREATE TABLE IF NOT EXISTS `front_contract_duration` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `contract_to_days` int(11) DEFAULT NULL,
  `contract_to_months` int(11) DEFAULT NULL,
  `contract_to_years` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица фронтового справочника, длительности договора страховки';

-- Тип франшизы
DROP TABLE IF EXISTS `franchise_type`;
CREATE TABLE IF NOT EXISTS `franchise_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Тип франшизы';

-- Варианты выплаты без справок
DROP TABLE IF EXISTS `payments_without_references`;
CREATE TABLE IF NOT EXISTS `payments_without_references` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Варианты выплаты без справок';

-- Лимит регресного возмещения страховой суммы
DROP TABLE IF EXISTS `regres_limit`;
CREATE TABLE IF NOT EXISTS `regres_limit` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Лимит регресного возмещения страховой суммы';

-- Пакеты рисков или конкретные риски
DROP TABLE IF EXISTS `risks`;
CREATE TABLE IF NOT EXISTS `risks` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Пакеты рисков или конкретные риски';

-- Варианты тарифных планов
DROP TABLE IF EXISTS `tariff_program`;
CREATE TABLE IF NOT EXISTS `tariff_program` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Варианты тарифных планов';

-- Таблица зависимостей базового тарифа от различных факторов
DROP TABLE IF EXISTS `tariff_coefficients`;
CREATE TABLE IF NOT EXISTS `tariff_coefficients` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `TS_Group_Id` int(10) DEFAULT NULL,
  `TS_Producer_Id` int(10) DEFAULT NULL,
  `TS_Model_Id` int(10) DEFAULT NULL,
  `TS_Modification_Id` int(10) DEFAULT NULL,
  `Tariff_Program_Id` int(10) NOT NULL,
  `Risk_Id` int(10) NOT NULL,
  `Damage_Det_Type_Id` int(10) DEFAULT NULL,
  `TS_Age` int(10) NOT NULL,
  `TS_Sum_Up` int(10) DEFAULT NULL,
  `TS_Sum_Down` int(10) DEFAULT NULL,
  `Amortisation` bit(1) DEFAULT NULL,
  `Value` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1802 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица зависимостей базового тарифа от различных факторов';

-- Определение размера страхового возмещения
DROP TABLE IF EXISTS `tariff_def_damage_type`;
CREATE TABLE IF NOT EXISTS `tariff_def_damage_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Определение размера страхового возмещения';

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
  `TS_Group_Id` int(10) NOT NULL,
  `TS_Modification_Id` int(10) NOT NULL,
  `TS_Type_Id` int(10) NOT NULL,
  `TS_Model_Id` int(10) NOT NULL,
  `TS_Producer_ID` int(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Group2TS_Group` (`TS_Group_Id`),
  CONSTRAINT `FK_Group2TS_Group` FOREIGN KEY (`TS_Group_Id`) REFERENCES `ts_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Составление групп транспортных средств и конкретных моделей и марок';

-- Тип ТС
DROP TABLE IF EXISTS `ts_type`;
CREATE TABLE IF NOT EXISTS `ts_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Тип ТС';

-- Производители ТС
DROP TABLE IF EXISTS `ts_make`;
CREATE TABLE IF NOT EXISTS `ts_make` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Производители ТС';

-- Модель TC
DROP TABLE IF EXISTS `ts_model`;
CREATE TABLE IF NOT EXISTS `ts_model` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `TS_Producer_Id` int(10) NOT NULL,
  `TS_Type_Id` int(10) DEFAULT '0',
  `Name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Model2TS_Producer` (`TS_Producer_Id`),
  KEY `FK_Model2TS_Type` (`TS_Type_Id`),
  CONSTRAINT `FK_Model2TS_Producer` FOREIGN KEY (`TS_Producer_Id`) REFERENCES `ts_make` (`id`),
  CONSTRAINT `FK_Model2TS_Type` FOREIGN KEY (`TS_Type_Id`) REFERENCES `ts_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Модель TC';

-- Модификация ТС
DROP TABLE IF EXISTS `ts_modification`;
CREATE TABLE IF NOT EXISTS `ts_modification` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `TS_Model_Id` int(10) NOT NULL DEFAULT '0',
  `TS_Type_Id` int(10) DEFAULT '0',
  `Name` varchar(50) COLLATE utf8_bin DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_Modif2TS_Type` (`TS_Type_Id`),
  KEY `FK_Modif2TS_Model` (`TS_Model_Id`),
  CONSTRAINT `FK_Modif2TS_Model` FOREIGN KEY (`TS_Model_Id`) REFERENCES `ts_model` (`id`),
  CONSTRAINT `FK_Modif2TS_Type` FOREIGN KEY (`TS_Type_Id`) REFERENCES `ts_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Модификация ТС';



-- Дамп структуры для таблица ubercalc.front_ldu_quantity
DROP TABLE IF EXISTS `front_ldu_quantity`;
CREATE TABLE IF NOT EXISTS `front_ldu_quantity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `value` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Количество ЛДУ (лиц допущенных к управлению)';
