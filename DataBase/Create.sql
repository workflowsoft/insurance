-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               5.5.34 - MySQL Community Server (GPL)
-- ОС Сервера:                   Win32
-- HeidiSQL Версия:              8.2.0.4675
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Дамп структуры базы данных ubercalc
DROP DATABASE IF EXISTS `ubercalc`;
CREATE DATABASE IF NOT EXISTS `ubercalc` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `ubercalc`;


-- Дамп структуры для таблица ubercalc.all_factors
DROP TABLE IF EXISTS `all_factors`;
CREATE TABLE IF NOT EXISTS `all_factors` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  `description` varchar(50) COLLATE utf8_bin NOT NULL,
  `code` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Таблица со всеми коэффициентами и что они означают и их кодами';

-- Дамп данных таблицы ubercalc.all_factors: ~15 rows (приблизительно)
/*!40000 ALTER TABLE `all_factors` DISABLE KEYS */;
INSERT INTO `all_factors` (`id`, `name`, `description`, `code`) VALUES
	(1, 'Ксп', 'коэф. страхового продукта', 'ksp'),
	(2, 'Квс', 'коэф. возраста/стажа', 'kvs'),
	(3, 'Кл', 'коэф. количества лиц, допущенных к управлению', 'kl'),
	(4, 'Ки', 'коэф. использования ТС', 'ki'),
	(5, 'Кпс', 'коэф. использования противоугонной системы', 'kps'),
	(6, 'КУТС', 'коэф. УТС (Утраты товарной стоимости)', 'kuts'),
	(7, 'Ксд', 'коэф. срока действия договора', 'ksd'),
	(8, 'Кп', 'коэф. парковости', 'kp'),
	(9, 'Ко', 'коэф. единовременной оплаты страховой премии', 'ko'),
	(10, 'Клв', 'коэф. лимита возмещения', 'klv'),
	(11, 'Кстоа', 'коэф. возмещения (Размера страхового возмещения)', 'kctoa'),
	(12, 'Вбс', 'коэф. «выплаты без справок»', 'vbs'),
	(13, 'Ка', 'коэф. андрайтера', 'ka'),
	(14, 'Кф', 'коэф. франшизы', 'kf'),
	(15, 'Ккв', 'коэф. комиссионного вознаграждения', 'kkv');
/*!40000 ALTER TABLE `all_factors` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.factor_kuts
DROP TABLE IF EXISTS `factor_kuts`;
CREATE TABLE IF NOT EXISTS `factor_kuts` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `Risk` varchar(50) COLLATE utf8_bin NOT NULL DEFAULT '0',
  `Value` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Зависимости коэф КУТС\r\nУТС - Утрата Товарной Стоимости';

-- Дамп данных таблицы ubercalc.factor_kuts: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `factor_kuts` DISABLE KEYS */;
/*!40000 ALTER TABLE `factor_kuts` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.fatality_factor_table
DROP TABLE IF EXISTS `fatality_factor_table`;
CREATE TABLE IF NOT EXISTS `fatality_factor_table` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `factor_id` int(10) DEFAULT '0',
  `tariff_program_id` int(10) DEFAULT '0',
  `ldu_quantity` int(10) DEFAULT '0',
  `driver_age_up` int(10) DEFAULT '0',
  `driver_age_down` int(10) DEFAULT '0',
  `driver_exp_up` int(10) DEFAULT '0',
  `driver_exp_down` int(10) DEFAULT '0',
  `TS_NoDefendFlag` tinyint(1) DEFAULT '0',
  `TS_SatelliteFlag` tinyint(1) DEFAULT '0',
  `TS_HaveElectronicAlarm` tinyint(1) DEFAULT '0',
  `TS_Risks_Id` int(10) DEFAULT '0',
  `ksd_description_id` int(10) DEFAULT '0',
  `kp_description_id` int(10) DEFAULT '0',
  `ko_is_checked` tinyint(1) DEFAULT '0',
  `regres_limit_factor_id` int(10) DEFAULT '0',
  `value` float DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Сводная таблица со значениями всех коэффициентов';

-- Дамп данных таблицы ubercalc.fatality_factor_table: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `fatality_factor_table` DISABLE KEYS */;
/*!40000 ALTER TABLE `fatality_factor_table` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.franchise
DROP TABLE IF EXISTS `franchise`;
CREATE TABLE IF NOT EXISTS `franchise` (
  `fr_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fr_value` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`fr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Франшиза';

-- Дамп данных таблицы ubercalc.franchise: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `franchise` DISABLE KEYS */;
INSERT INTO `franchise` (`fr_id`, `fr_value`) VALUES
	(1, 'Условная'),
	(2, 'Безусловная');
/*!40000 ALTER TABLE `franchise` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.kp_description
DROP TABLE IF EXISTS `kp_description`;
CREATE TABLE IF NOT EXISTS `kp_description` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Коэффициент парковости';

-- Дамп данных таблицы ubercalc.kp_description: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `kp_description` DISABLE KEYS */;
INSERT INTO `kp_description` (`id`, `name`) VALUES
	(1, '2-5 ТС'),
	(2, '6-9 ТС'),
	(3, '10 и выше');
/*!40000 ALTER TABLE `kp_description` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ksd_description
DROP TABLE IF EXISTS `ksd_description`;
CREATE TABLE IF NOT EXISTS `ksd_description` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `value_days` int(11) DEFAULT NULL,
  `value_months` int(11) DEFAULT NULL,
  `value_years` int(11) DEFAULT NULL,
  `ksd` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Описание коэффициента срока действия договора (ksd)';

-- Дамп данных таблицы ubercalc.ksd_description: ~15 rows (приблизительно)
/*!40000 ALTER TABLE `ksd_description` DISABLE KEYS */;
INSERT INTO `ksd_description` (`id`, `name`, `value_days`, `value_months`, `value_years`, `ksd`) VALUES
	(1, 'до 5-ти дней', 5, NULL, NULL, 0.05),
	(2, 'до 15-ти дней', 15, NULL, NULL, 0.1),
	(3, 'до 1-го месяца', NULL, 1, NULL, 0.2),
	(4, 'до 2-х месяцев', NULL, 2, NULL, 0.3),
	(5, 'до 3-х месяцев', NULL, 3, NULL, 0.4),
	(6, 'до 4-х месяцев', NULL, 4, NULL, 0.5),
	(7, 'до 5-ти месяцев', NULL, 5, NULL, 0.6),
	(8, 'до 6-ти месяцев', NULL, 6, NULL, 0.7),
	(9, 'до 7-ми месяцев', NULL, 7, NULL, 0.75),
	(10, 'до 8-ми месяцев', NULL, 8, NULL, 0.8),
	(11, 'до 9-ти месяцев', NULL, 9, NULL, 0.85),
	(12, 'до 10-ти месяцев', NULL, 10, NULL, 0.9),
	(13, 'до 11-ти месяцев', NULL, 11, NULL, 0.95),
	(17, 'до 12-ти месяцев', NULL, 12, NULL, 1),
	(18, 'до 2-х лет', NULL, NULL, 2, 2);
/*!40000 ALTER TABLE `ksd_description` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ksp_description
DROP TABLE IF EXISTS `ksp_description`;
CREATE TABLE IF NOT EXISTS `ksp_description` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Описание коэф. страховых продуктов';

-- Дамп данных таблицы ubercalc.ksp_description: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ksp_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `ksp_description` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.kvs_description
DROP TABLE IF EXISTS `kvs_description`;
CREATE TABLE IF NOT EXISTS `kvs_description` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Описание коэффициента и';

-- Дамп данных таблицы ubercalc.kvs_description: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `kvs_description` DISABLE KEYS */;
/*!40000 ALTER TABLE `kvs_description` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ldu_quantity
DROP TABLE IF EXISTS `ldu_quantity`;
CREATE TABLE IF NOT EXISTS `ldu_quantity` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Количество ЛДУ (лиц допущенных к управлению)';

-- Дамп данных таблицы ubercalc.ldu_quantity: ~5 rows (приблизительно)
/*!40000 ALTER TABLE `ldu_quantity` DISABLE KEYS */;
INSERT INTO `ldu_quantity` (`id`, `name`) VALUES
	(1, 'Без ограничений'),
	(2, 'Не более 3-х водителей'),
	(3, '4 водителя'),
	(4, '5 водителей'),
	(5, 'Любые лица от 33 лет');
/*!40000 ALTER TABLE `ldu_quantity` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.payments_without_references
DROP TABLE IF EXISTS `payments_without_references`;
CREATE TABLE IF NOT EXISTS `payments_without_references` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Выплаты без справок';

-- Дамп данных таблицы ubercalc.payments_without_references: ~4 rows (приблизительно)
/*!40000 ALTER TABLE `payments_without_references` DISABLE KEYS */;
INSERT INTO `payments_without_references` (`id`, `name`) VALUES
	(1, '1 раз за период страхования'),
	(2, '2 раза за период страхования'),
	(3, 'Не осуществляются (1 вариант)'),
	(4, 'Не осуществляются (2 вариант)');
/*!40000 ALTER TABLE `payments_without_references` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.regres_limit_factor
DROP TABLE IF EXISTS `regres_limit_factor`;
CREATE TABLE IF NOT EXISTS `regres_limit_factor` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Коэффициент лимита возмещения, значения для дропдауна';

-- Дамп данных таблицы ubercalc.regres_limit_factor: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `regres_limit_factor` DISABLE KEYS */;
INSERT INTO `regres_limit_factor` (`id`, `name`) VALUES
	(1, 'Неагрегатный лимит'),
	(2, 'Агрегатный лимит'),
	(3, 'До 1 страхового случая');
/*!40000 ALTER TABLE `regres_limit_factor` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.tariff_coefficients
DROP TABLE IF EXISTS `tariff_coefficients`;
CREATE TABLE IF NOT EXISTS `tariff_coefficients` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `TS_Group_Id` int(10) DEFAULT NULL,
  `TS_Producer_Id` int(10) DEFAULT NULL,
  `TS_Model_Id` int(10) DEFAULT NULL,
  `TS_Modification_Id` int(10) DEFAULT NULL,
  `Tariff_Program_Id` int(10) NOT NULL,
  `TS_Age` int(10) NOT NULL,
  `TS_Sum_Up` int(10) NOT NULL,
  `TS_Sum_Down` int(10) NOT NULL,
  `Risk_Id` int(10) NOT NULL,
  `Damage_Det_Type_Id` int(10) NOT NULL,
  `Amortisation` bit(1) DEFAULT NULL,
  `Value` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Коэффициенты базового тарифа';

-- Дамп данных таблицы ubercalc.tariff_coefficients: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `tariff_coefficients` DISABLE KEYS */;
/*!40000 ALTER TABLE `tariff_coefficients` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.tariff_def_damage_type
DROP TABLE IF EXISTS `tariff_def_damage_type`;
CREATE TABLE IF NOT EXISTS `tariff_def_damage_type` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Определение размера страхового возмещения';

-- Дамп данных таблицы ubercalc.tariff_def_damage_type: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `tariff_def_damage_type` DISABLE KEYS */;
INSERT INTO `tariff_def_damage_type` (`id`, `name`) VALUES
	(1, 'По калькуляции страховщика'),
	(2, 'По калькуляции страховщика / По счетам СТОА из перечня'),
	(3, 'По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору');
/*!40000 ALTER TABLE `tariff_def_damage_type` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.tariff_program
DROP TABLE IF EXISTS `tariff_program`;
CREATE TABLE IF NOT EXISTS `tariff_program` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Значения для выбора программы страхования';

-- Дамп данных таблицы ubercalc.tariff_program: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `tariff_program` DISABLE KEYS */;
INSERT INTO `tariff_program` (`id`, `name`) VALUES
	(1, 'Бизнес'),
	(2, 'Стандарт'),
	(3, 'Оптимал'),
	(4, 'Эконом 50/50'),
	(5, 'Эконом до 1 страхового случая'),
	(6, 'Универсал');
/*!40000 ALTER TABLE `tariff_program` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.tariff_risks
DROP TABLE IF EXISTS `tariff_risks`;
CREATE TABLE IF NOT EXISTS `tariff_risks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Список рисков';

-- Дамп данных таблицы ubercalc.tariff_risks: ~2 rows (приблизительно)
/*!40000 ALTER TABLE `tariff_risks` DISABLE KEYS */;
INSERT INTO `tariff_risks` (`id`, `name`) VALUES
	(1, 'ХИЩЕНИЕ + УЩЕРБ'),
	(3, 'УЩЕРБ');
/*!40000 ALTER TABLE `tariff_risks` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ts_group
DROP TABLE IF EXISTS `ts_group`;
CREATE TABLE IF NOT EXISTS `ts_group` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Группа ТС';

-- Дамп данных таблицы ubercalc.ts_group: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ts_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `ts_group` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ts_group_match
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Составление групп';

-- Дамп данных таблицы ubercalc.ts_group_match: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ts_group_match` DISABLE KEYS */;
/*!40000 ALTER TABLE `ts_group_match` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ts_model
DROP TABLE IF EXISTS `ts_model`;
CREATE TABLE IF NOT EXISTS `ts_model` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `TS_Producer_Id` int(10) NOT NULL,
  `TS_Type_Id` int(10) DEFAULT '0',
  `Name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_Model2TS_Producer` (`TS_Producer_Id`),
  KEY `FK_Model2TS_Type` (`TS_Type_Id`),
  CONSTRAINT `FK_Model2TS_Type` FOREIGN KEY (`TS_Type_Id`) REFERENCES `ts_type` (`id`),
  CONSTRAINT `FK_Model2TS_Producer` FOREIGN KEY (`TS_Producer_Id`) REFERENCES `ts_producer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Модель TC';

-- Дамп данных таблицы ubercalc.ts_model: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ts_model` DISABLE KEYS */;
/*!40000 ALTER TABLE `ts_model` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ts_modification
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

-- Дамп данных таблицы ubercalc.ts_modification: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ts_modification` DISABLE KEYS */;
/*!40000 ALTER TABLE `ts_modification` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ts_producer
DROP TABLE IF EXISTS `ts_producer`;
CREATE TABLE IF NOT EXISTS `ts_producer` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Производители ТС';

-- Дамп данных таблицы ubercalc.ts_producer: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ts_producer` DISABLE KEYS */;
/*!40000 ALTER TABLE `ts_producer` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ts_type
DROP TABLE IF EXISTS `ts_type`;
CREATE TABLE IF NOT EXISTS `ts_type` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Тип ТС';

-- Дамп данных таблицы ubercalc.ts_type: ~0 rows (приблизительно)
/*!40000 ALTER TABLE `ts_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `ts_type` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.vehicle_category
DROP TABLE IF EXISTS `vehicle_category`;
CREATE TABLE IF NOT EXISTS `vehicle_category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Cat_title_n` text COLLATE utf8_bin,
  `Cat_title` text COLLATE utf8_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Категории транспортных средств';

-- Дамп данных таблицы ubercalc.vehicle_category: ~14 rows (приблизительно)
/*!40000 ALTER TABLE `vehicle_category` DISABLE KEYS */;
INSERT INTO `vehicle_category` (`id`, `Cat_title_n`, `Cat_title`) VALUES
	(1, '1.1.', 'Классика (ВАЗ 2104, 05, 06, 07, 08, 09 и модификации) и прочие легковые ТС отечественного производства, не вошедшие в группы 1-3'),
	(2, '1.2.', 'ВАЗ 11114 (ОКА), ИЖ 2126, 2717 и модификации, легковые ГАЗ'),
	(3, '1.3.', 'ВАЗ Приора, Калина, 2110, 2111, 2112, 2113, 2114, 2115 и модификации, Шевроле Нива, Шевроле Вива, УАЗ, ЗАЗ'),
	(4, '2.2.1.', 'Импортные легковые автомобили со страховой суммой: до 400 000 руб'),
	(5, '2.2.2.', 'Импортные легковые автомобили со страховой суммой: от 400 001 до 800 000 руб'),
	(6, '2.2.3.', 'Импортные легковые автомобили со страховой суммой: от 800 001 до 1 200 000 руб'),
	(7, '2.2.4.', 'Импортные легковые автомобили со страховой суммой: от 1 200 001 до 2 000 000 руб'),
	(8, '2.2.5.', 'Импортные легковые автомобили со страховой суммой: от 2 000 001 руб'),
	(9, '3.1.', 'Микроавтобусы, фургоны и мини-грузовики на их базе до 3,5т, в т.ч. ""Газели"" - ГАЗ 3302, 3221, 2217, 2751'),
	(10, '3.2.', 'Мото транспорт'),
	(11, '3.3.', 'Автобусы'),
	(12, '3.4.', 'Грузовики'),
	(13, '3.5.', 'Спецтехника (сельхозтехника, бетономешалки, экскаваторы, тракторы, краны и т.п.)'),
	(14, '3.6.', 'Прочие ТС прицепы, полуприцепы');
/*!40000 ALTER TABLE `vehicle_category` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
