-- Дамп структуры базы данных ubercalc
DROP DATABASE IF EXISTS `ubercalc`;
CREATE DATABASE IF NOT EXISTS `ubercalc`
  DEFAULT CHARACTER SET utf8
  COLLATE utf8_bin;

USE `ubercalc`;

-- Таблица списка используемых в формуле РАССЧЕТНЫХ операндов, их обязательность и значение по-умолчанию
DROP TABLE IF EXISTS `all_factors`;
CREATE TABLE IF NOT EXISTS `all_factors` (
  `id`            INT(10)          NOT NULL AUTO_INCREMENT,
  `name`          VARCHAR(50)
                  COLLATE utf8_bin NOT NULL,
  `description`   VARCHAR(50)
                  COLLATE utf8_bin NOT NULL,
  `code`          VARCHAR(50)
                  COLLATE utf8_bin NOT NULL,
  `is_mandatory`  TINYINT(1) DEFAULT '0',
  `default_value` DOUBLE DEFAULT '1',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Таблица списка используемых в формуле РАССЧЕТНЫХ операндов, их обязательность и значение по-умолчанию';

-- Тип франшизы
DROP TABLE IF EXISTS `franchise_type`;
CREATE TABLE IF NOT EXISTS `franchise_type` (
  `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50)
         COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Тип франшизы';

-- Варианты выплаты без справок
DROP TABLE IF EXISTS `payments_without_references`;
CREATE TABLE IF NOT EXISTS `payments_without_references` (
  `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50)
         COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Варианты выплаты без справок';

-- Лимит регресного возмещения страховой суммы
DROP TABLE IF EXISTS `regres_limit`;
CREATE TABLE IF NOT EXISTS `regres_limit` (
  `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50)
         COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Лимит регресного возмещения страховой суммы';

-- Пакеты рисков или конкретные риски
DROP TABLE IF EXISTS `risks`;
CREATE TABLE IF NOT EXISTS `risks` (
  `id`   INT(10)          NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50)
         COLLATE utf8_bin NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Пакеты рисков или конкретные риски';

-- Варианты тарифных планов
DROP TABLE IF EXISTS `tariff_program`;
CREATE TABLE IF NOT EXISTS `tariff_program` (
  `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50)
         COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Варианты тарифных планов';

-- Определение размера страхового возмещения
DROP TABLE IF EXISTS `tariff_def_damage_type`;
CREATE TABLE IF NOT EXISTS `tariff_def_damage_type` (
  `id`   INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128)
         COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Определение размера страхового возмещения';

-- Тип ТС
DROP TABLE IF EXISTS `ts_type`;
CREATE TABLE IF NOT EXISTS `ts_type` (
  `id`   INT(10)          NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50)
         COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Тип ТС';

-- Производители ТС
DROP TABLE IF EXISTS `ts_make`;
CREATE TABLE IF NOT EXISTS `ts_make` (
  `id`   INT(10)          NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50)
         COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Производители ТС';

-- Модель TC
DROP TABLE IF EXISTS `ts_model`;
CREATE TABLE IF NOT EXISTS `ts_model` (
  `id`         INT(10)          NOT NULL AUTO_INCREMENT,
  `ts_type_id` INT(10)          NOT NULL REFERENCES ts_type (id),
  `ts_make_id` INT(10)          NOT NULL REFERENCES `ts_make` (id),
  `name`       VARCHAR(50)
               COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Модель TC';

-- Модификация ТС
DROP TABLE IF EXISTS `ts_modification`;
CREATE TABLE IF NOT EXISTS `ts_modification` (
  `id`          INT(10)          NOT NULL AUTO_INCREMENT,
  `ts_model_id` INT(10)          NOT NULL REFERENCES `ts_model` (id),
  `ts_type_id`  INT(10) REFERENCES `ts_type` (id), /*Модификация модели может поменять тип ТС, но обчыно такого не случается*/
  `Name`        VARCHAR(50)
                COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Модификация ТС';

-- Группа ТС
DROP TABLE IF EXISTS `ts_group`;
CREATE TABLE IF NOT EXISTS `ts_group` (
  `id`   INT(10)          NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(512)
         COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Группа ТС';

-- Составление групп транспортных средств и конкретных моделей и марок
DROP TABLE IF EXISTS `ts_group_match`;
CREATE TABLE IF NOT EXISTS `ts_group_match` (
  `id`                 INT(10) NOT NULL AUTO_INCREMENT,
  `ts_group_id`        INT(10) NOT NULL REFERENCES `ts_group` (id),
  `ts_modification_id` INT(10) REFERENCES `ts_modification` (id),
  `ts_type_id`         INT(10) REFERENCES `ts_type` (id),
  `ts_model_id`        INT(10) REFERENCES `ts_model` (id),
  `ts_make_id`         INT(10) REFERENCES `ts_make` (id),
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Составление групп транспортных средств и конкретных моделей и марок';


DROP TABLE IF EXISTS `contract_day`;
CREATE TABLE IF NOT EXISTS `contract_day` (
  `id`   INT(10) NOT NULL AUTO_INCREMENT,
  `down` TINYINT UNSIGNED DEFAULT NULL,
  `up`   TINYINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `contract_month`;
CREATE TABLE IF NOT EXISTS `contract_month` (
  `id`   INT(10) NOT NULL AUTO_INCREMENT,
  `down` TINYINT UNSIGNED DEFAULT NULL,
  `up`   TINYINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `contract_year`;
CREATE TABLE IF NOT EXISTS `contract_year` (
  `id`   INT(10) NOT NULL AUTO_INCREMENT,
  `down` INT(2) DEFAULT NULL,
  `up`   INT(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `drivers_count`;
CREATE TABLE IF NOT EXISTS `drivers_count` (
  `id`   INT(10) NOT NULL AUTO_INCREMENT,
  `down` TINYINT UNSIGNED DEFAULT NULL,
  `up`   TINYINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `driver_age`;
CREATE TABLE IF NOT EXISTS `driver_age` (
  `id`   INT(10) NOT NULL AUTO_INCREMENT,
  `down` TINYINT UNSIGNED DEFAULT NULL,
  `up`   TINYINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `driver_exp`;
CREATE TABLE IF NOT EXISTS `driver_exp` (
  `id`   INT(10) NOT NULL AUTO_INCREMENT,
  `down` TINYINT UNSIGNED DEFAULT NULL,
  `up`   TINYINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;


DROP TABLE IF EXISTS `car_quantity`;
CREATE TABLE IF NOT EXISTS `car_quantity` (
  `id`   INT(10) NOT NULL AUTO_INCREMENT,
  `down` TINYINT UNSIGNED DEFAULT NULL,
  `up`   TINYINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;


DROP TABLE IF EXISTS `franchise_percent`;
CREATE TABLE IF NOT EXISTS `franchise_percent` (
  `id`   INT(10) NOT NULL AUTO_INCREMENT,
  `down` TINYINT UNSIGNED DEFAULT NULL,
  `up`   TINYINT UNSIGNED DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

DROP TABLE IF EXISTS `commission_percent`;
CREATE TABLE IF NOT EXISTS `commission_percent` (
  `id`   INT(10) NOT NULL AUTO_INCREMENT,
  `down` DOUBLE DEFAULT NULL,
  `up`   DOUBLE DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin;

-- Поправочные коэфициенты с зависимостью от факторов, которые их формируют
DROP TABLE IF EXISTS `additional_coefficients`;
CREATE TABLE IF NOT EXISTS `additional_coefficients` (
  `id`                             INT(10) NOT NULL AUTO_INCREMENT,
  `factor_id`                      INT(10) NOT NULL REFERENCES all_factors (id),
  `tariff_program_id`              INT(10) DEFAULT NULL REFERENCES tariff_program (id),
  `risk_id`                        INT(10) DEFAULT NULL REFERENCES risks (id),
  `ts_type_id`                     INT(10) REFERENCES `ts_type` (id),
  `ts_group_id`                    INT(10) REFERENCES `ts_group` (id),
  `ts_make_id`                     INT(10) REFERENCES `ts_make` (id),
  `ts_model_id`                    INT(10) REFERENCES `ts_model` (id),
  `ts_modification_id`             INT(10) REFERENCES `ts_modification` (id),
  `ts_age`                         INT(10) NULL,
  `regres_limit_factor_id`         INT(10) DEFAULT NULL REFERENCES regres_limit (id),
  `tariff_def_damage_type_id`      INT(10) DEFAULT NULL REFERENCES tariff_def_damage_type (id),
  `payments_without_references_id` INT(10) DEFAULT NULL REFERENCES payments_without_references (id),
  `franchise_type_id`              INT(10) DEFAULT NULL REFERENCES franchise_type (id),
  `contract_day_id`                INT(10) DEFAULT NULL REFERENCES contract_day (id),
  `contract_month_id`              INT(10) DEFAULT NULL REFERENCES contract_month (id),
  `contract_year_id`               INT(10) DEFAULT NULL REFERENCES contract_year (id),
  `drivers_count_id`               INT(10) DEFAULT NULL REFERENCES drivers_count (id),
  `driver_age_id`                  INT(10) DEFAULT NULL REFERENCES driver_age (id),
  `driver_exp_id`                  INT(10) DEFAULT NULL REFERENCES driver_exp (id),
  `ts_no_defend_flag`              TINYINT(1) DEFAULT NULL,
  `ts_satellite_flag`              TINYINT(1) DEFAULT NULL,
  `ts_have_electronic_alarm`       TINYINT(1) DEFAULT NULL,
  `is_onetime_payment`             TINYINT(1) DEFAULT NULL,
  `car_quantity_id`                INT(10) DEFAULT NULL REFERENCES car_quantity (id),
  `franchise_percent_id`           INT(10) DEFAULT NULL REFERENCES franchise_percent (id),
  `commercial_carting_flag`        TINYINT(1) DEFAULT NULL,
  `commission_percent_id`          INT(10) DEFAULT NULL REFERENCES commission_percent (id),
  `is_legal_entity`                TINYINT(1) DEFAULT NULL,
  `amortisation`                   BIT(1) DEFAULT NULL,
  `priority`                       INT(10) DEFAULT 0,
  `value`                          FLOAT   NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Поправочные коэфициенты с зависимостью от факторов, которые их формируют';

-- Таблица зависимостей базового тарифа от различных факторов
DROP TABLE IF EXISTS `tariff_coefficients`;
CREATE TABLE IF NOT EXISTS `tariff_coefficients` (
  `id`                        INT(10) NOT NULL AUTO_INCREMENT,
  `ts_type_id`                INT(10) REFERENCES `ts_type` (id),
  `ts_group_id`               INT(10) REFERENCES `ts_group` (id),
  `ts_make_id`                INT(10) REFERENCES `ts_make` (id),
  `ts_model_id`               INT(10) REFERENCES `ts_model` (id),
  `ts_modification_id`        INT(10) REFERENCES `ts_modification` (id),
  `tariff_program_id`         INT(10) NOT NULL REFERENCES `tariff_program` (id),
  `risk_id`                   INT(10) NOT NULL REFERENCES `risks` (id),
  `tariff_def_damage_type_id` INT(10) NULL  REFERENCES `tariff_def_damage_type` (id),
  `ts_age`                    INT(10) NOT NULL,
  `ts_sum_up`                 INT(10) DEFAULT NULL,
  `ts_sum_down`               INT(10) DEFAULT NULL,
  `amortisation`              BIT(1) DEFAULT NULL,
  `value`                     DOUBLE  NOT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Таблица зависимостей базового тарифа от различных факторов';

-- Таблица фронтового справочника, длительности договора страховки
DROP TABLE IF EXISTS `front_contract_duration`;
CREATE TABLE IF NOT EXISTS `front_contract_duration` (
  `id`                 INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`               VARCHAR(50)
                       COLLATE utf8_bin DEFAULT NULL,
  `contract_to_days`   INT(11) DEFAULT NULL,
  `contract_to_months` INT(11) DEFAULT NULL,
  `contract_to_years`  INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Таблица фронтового справочника, длительности договора страховки';

-- Дамп структуры для таблица ubercalc.front_ldu_quantity
DROP TABLE IF EXISTS `front_ldu_quantity`;
CREATE TABLE IF NOT EXISTS `front_ldu_quantity` (
  `id`    INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`  VARCHAR(50)
          COLLATE utf8_bin DEFAULT NULL,
  `value` INT(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Количество ЛДУ (лиц допущенных к управлению)';

-- Таблица обязательной зависимости значений одних факторов от значений других факторов
DROP TABLE IF EXISTS `factor_restricions`;
CREATE TABLE IF NOT EXISTS `factor_restricions` (
  `id`                     INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `factor_name`            VARCHAR(50)      NOT NULL COLLATE utf8_bin,
  `dependent_factor_name`  VARCHAR(50)      NOT NULL COLLATE utf8_bin,
  `factor_value_down`      DOUBLE,
  `factor_value_up`        DOUBLE,
  `factor_value`           VARCHAR(50)      NULL COLLATE utf8_bin,
  `dependent_factor_value` VARCHAR(50)      NULL COLLATE utf8_bin,
  `dependent_factor_down`  DOUBLE,
  `dependent_factor_up`    DOUBLE,
  `conditional`            BIT(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
)
  ENGINE =InnoDB
  DEFAULT CHARSET =utf8
  COLLATE =utf8_bin
  COMMENT ='Определение значений одних факторов значеним других на праве перезаписи';

