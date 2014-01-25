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


-- Дамп структуры для таблица ubercalc.contract_factor
DROP TABLE IF EXISTS `contract_factor`;
CREATE TABLE IF NOT EXISTS `contract_factor` (
  `contract_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `contract_value` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  `ksd` float DEFAULT NULL,
  PRIMARY KEY (`contract_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Коэффициент срока действия договора (ksd)';

-- Дамп данных таблицы ubercalc.contract_factor: ~14 rows (приблизительно)
/*!40000 ALTER TABLE `contract_factor` DISABLE KEYS */;
INSERT INTO `contract_factor` (`contract_id`, `contract_value`, `ksd`) VALUES
	(1, 'до 5-ти дней', 0.05),
	(2, 'до 15-ти дней', 0.1),
	(3, 'до 1-го месяца', 0.2),
	(4, 'до 2-х месяцев', 0.3),
	(5, 'до 3-х месяцев', 0.4),
	(6, 'до 4-х месяцев', 0.5),
	(7, 'до 5-ти месяцев', 0.6),
	(8, 'до 6-ти месяцев', 0.7),
	(9, 'до 7-ми месяцев', 0.75),
	(10, 'до 8-ми месяцев', 0.8),
	(11, 'до 9-ти месяцев', 0.85),
	(12, 'до 10-ти месяцев', 0.9),
	(13, 'до 11-ти месяцев', 0.95),
	(14, 'до 12-ти месяцев', 1);
/*!40000 ALTER TABLE `contract_factor` ENABLE KEYS */;


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


-- Дамп структуры для таблица ubercalc.insurance_program
DROP TABLE IF EXISTS `insurance_program`;
CREATE TABLE IF NOT EXISTS `insurance_program` (
  `InsurId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Insur_Cases` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`InsurId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Значения для выбора программы страхования';

-- Дамп данных таблицы ubercalc.insurance_program: ~6 rows (приблизительно)
/*!40000 ALTER TABLE `insurance_program` DISABLE KEYS */;
INSERT INTO `insurance_program` (`InsurId`, `Insur_Cases`) VALUES
	(1, 'Бизнес'),
	(2, 'Стандарт'),
	(3, 'Оптимал'),
	(4, 'Эконом 50/50'),
	(5, 'Эконом до 1 страхового случая'),
	(6, 'Универсал');
/*!40000 ALTER TABLE `insurance_program` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.insurance_return_value
DROP TABLE IF EXISTS `insurance_return_value`;
CREATE TABLE IF NOT EXISTS `insurance_return_value` (
  `ins_ret_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ins_ret_value` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`ins_ret_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Определение размера страхового возмещения';

-- Дамп данных таблицы ubercalc.insurance_return_value: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `insurance_return_value` DISABLE KEYS */;
INSERT INTO `insurance_return_value` (`ins_ret_id`, `ins_ret_value`) VALUES
	(1, 'По калькуляции страховщика'),
	(2, 'По калькуляции страховщика / По счетам СТОА из перечня'),
	(3, 'По калькуляции страховщика / По счетам СТОА из перечня / По счетам СТОА по выбору');
/*!40000 ALTER TABLE `insurance_return_value` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.ldu_quantity
DROP TABLE IF EXISTS `ldu_quantity`;
CREATE TABLE IF NOT EXISTS `ldu_quantity` (
  `LDU_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `LDU_cases` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`LDU_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Количество ЛДУ (лиц допущенных к управлению)';

-- Дамп данных таблицы ubercalc.ldu_quantity: ~5 rows (приблизительно)
/*!40000 ALTER TABLE `ldu_quantity` DISABLE KEYS */;
INSERT INTO `ldu_quantity` (`LDU_id`, `LDU_cases`) VALUES
	(1, 'Без ограничений'),
	(2, 'Не более 3-х водителей'),
	(3, '4 водителя'),
	(4, '5 водителей'),
	(5, 'Любые лица от 33 лет');
/*!40000 ALTER TABLE `ldu_quantity` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.parking_factor
DROP TABLE IF EXISTS `parking_factor`;
CREATE TABLE IF NOT EXISTS `parking_factor` (
  `par_k_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `par_k_value` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`par_k_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Коэффициент парковости';

-- Дамп данных таблицы ubercalc.parking_factor: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `parking_factor` DISABLE KEYS */;
INSERT INTO `parking_factor` (`par_k_id`, `par_k_value`) VALUES
	(1, '2-5 ТС'),
	(2, '6-9 ТС'),
	(3, '10 и выше');
/*!40000 ALTER TABLE `parking_factor` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.payments_without_references
DROP TABLE IF EXISTS `payments_without_references`;
CREATE TABLE IF NOT EXISTS `payments_without_references` (
  `pay_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `enq_case` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`pay_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Выплаты без справок';

-- Дамп данных таблицы ubercalc.payments_without_references: ~4 rows (приблизительно)
/*!40000 ALTER TABLE `payments_without_references` DISABLE KEYS */;
INSERT INTO `payments_without_references` (`pay_id`, `enq_case`) VALUES
	(1, '1 раз за период страхования'),
	(2, '2 раза за период страхования'),
	(3, 'Не осуществляются (1 вариант)'),
	(4, 'Не осуществляются (2 вариант)');
/*!40000 ALTER TABLE `payments_without_references` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.return_limit_factor
DROP TABLE IF EXISTS `return_limit_factor`;
CREATE TABLE IF NOT EXISTS `return_limit_factor` (
  `lim_k_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `lim_k_values` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`lim_k_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Коэффициент лимита возмещения';

-- Дамп данных таблицы ubercalc.return_limit_factor: ~3 rows (приблизительно)
/*!40000 ALTER TABLE `return_limit_factor` DISABLE KEYS */;
INSERT INTO `return_limit_factor` (`lim_k_id`, `lim_k_values`) VALUES
	(1, 'Неагрегатный лимит'),
	(2, 'Агрегатный лимит'),
	(3, 'До 1 страхового случая');
/*!40000 ALTER TABLE `return_limit_factor` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.risks
DROP TABLE IF EXISTS `risks`;
CREATE TABLE IF NOT EXISTS `risks` (
  `risk_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `risk_value` varchar(50) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`risk_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Список рисков';

-- Дамп данных таблицы ubercalc.risks: ~4 rows (приблизительно)
/*!40000 ALTER TABLE `risks` DISABLE KEYS */;
INSERT INTO `risks` (`risk_id`, `risk_value`) VALUES
	(1, 'ХИЩЕНИЕ + УЩЕРБ'),
	(2, 'ХИЩЕНИЕ + УЩЕРБ + УТС'),
	(3, 'УЩЕРБ'),
	(4, 'УЩЕРБ + УТС');
/*!40000 ALTER TABLE `risks` ENABLE KEYS */;


-- Дамп структуры для таблица ubercalc.vehicle_category
DROP TABLE IF EXISTS `vehicle_category`;
CREATE TABLE IF NOT EXISTS `vehicle_category` (
  `CatId` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Cat_title_n` text COLLATE utf8_bin,
  `Cat_title` text COLLATE utf8_bin,
  PRIMARY KEY (`CatId`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='Категории транспортных средств';

-- Дамп данных таблицы ubercalc.vehicle_category: ~14 rows (приблизительно)
/*!40000 ALTER TABLE `vehicle_category` DISABLE KEYS */;
INSERT INTO `vehicle_category` (`CatId`, `Cat_title_n`, `Cat_title`) VALUES
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
