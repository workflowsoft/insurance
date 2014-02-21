esurance
========

#Групповое страхование

##Для развертывания проекта нужно.
* Развернуть API
Для этого нужен сервер Apache. Его нужно настроить слушать 2 дополнительных порта, которые будут привязаны к администраторской части API и самому API. 
Для этого нужно в файлах конфигурации Apache (папка conf, порты могут быть другими, если эти у вас заняты)
- httpd.conf, добавить
```
	Listen 91
	Listen 92
```
- conf/extra/httpd-vhosts.conf добавить

```xml
<VirtualHost *:91>
    ##ServerAdmin webmaster@dummy-host.example.com
    DocumentRoot "E:\Projects\esurance\backend\public" #ваш путь до админки
    ServerName localhost
    ServerAlias www.dummy-host.example.com
    ErrorLog "logs/esurance-error.log" #ваш путь до логов
    CustomLog "logs/esurance-access.log" common #ваш путь до логов
	<Directory />
        Options Indexes FollowSymLinks
        AllowOverride all
		Require all granted
	</Directory>
</VirtualHost>
```

```xml
<VirtualHost *:92>
    ##ServerAdmin webmaster@dummy-host.example.com
    DocumentRoot "E:\Projects\esurance\backend\admin\public" #ваш путь до админки
    ServerName localhost
    ServerAlias www.dummy-host.example.com
    ErrorLog "logs/esurance-apiadmin-error.log" #ваш путь до логов
    CustomLog "logs/esurance-apiadmin-access.log" common #ваш путь до логов
	<Directory />
        Options Indexes FollowSymLinks
        AllowOverride all
		Require all granted
	</Directory>
</VirtualHost>
```

* Настроить соединение с БД FRAPI
- В файле backend\custom\Config\configurations.xml найти соответсвтующие теги и поменять их значения на свои
```xml
  <key>db_username</key>
   <value>root</value>
  </configuration>
  <configuration>
   <key>db_password</key>
   <value>mysql12345</value>
  </configuration>
  <configuration>
   <key>db_database</key>
   <value>ubercalc</value>
  </configuration>
 ```
 
 * Развернуть БД на своем локальном сервере БД MySql
 Для этого надо последовательно выполнить скрипты:
 - base_schema.sql
 - base_tariff_data.sql
 - references_data.sql
 - additional_coeff_inserts.sql
 
 #Пример полного ответа API
 
 Запрос
 ```
 http://localhost:91/calculate/v1?risk_id=1&franchise_type_id=1&payments_without_references_id=1&regres_limit_factor_id=1&ts_group_id=10&tariff_program_id=2&tariff_def_damage_type_id=3&ts_age=1&ts_sum=600000&ts_no_defend_flag=false&drivers_count=1&contract_month=12&driver_age=28&driver_exp=4&ts_electronic_alarm_flag=true&amortisation=true&additional_sum=100000
 ```
 
 ```json
 {"Result":
	{"Coefficients":
		{ "base_tariff":"7.6",
		  "kuts":"1",
		  "kf":"1",
		  "kvs":"1.05",
		  "kl":"1",
		  "kp":"0.9",
		  "ksd":"1",
		  "kps":"0.95",
		  "kkv":"0.8",
		  "ko":"0.97",
		  "klv":"1",
		  "kctoa":"1",
		  "vbs":"1",
		  "ksp":"1",
		  "ki":"1",
		  "kbm":"1",
		  "ka":"1"
		},
	 "Additional":
		{"Sum":8000,
		 "Dbg":"8: \u0422\u0430\u0440\u0438\u0444 \u043f\u043e \u0434\u043e\u043f. \u043e\u0431\u043e\u0440\u0443\u0434\u043e\u0432\u0430\u043d\u0438\u044e = 10%. \u041a\u0441\u0434 =1. \u041a\u0430=1. \u041a\u043a\u0432=0.8. \u041f\u0440\u0435\u043c\u0438\u044f \u043f\u043e \u0434\u043e\u043f. \u043e\u0431\u043e\u0440\u0443\u0434\u043e\u0432\u0430\u043d\u0438\u044e = 8000"
		},
	  "Contract":
		{"Tariff":5.2945704,
		 "Sum":31767.42
		}
	 },
	 "inputParams":
	   {"ts_make_id":null,
	    "ts_model_id":null,
		"ts_type_id":null,
		"ts_modification_id":null,
		"ts_group_id":"10",
		"tariff_program_id":"2",
		"risk_id":"1",
		"tariff_def_damage_type_id":"3",
		"ts_age":"1",
		"ts_sum":"600000",
		"amortisation":"true",
		"payments_without_references_id":"1",
		"franchise_type_id":"1",
		"regres_limit_factor_id":"1",
		"contract_day":null,
		"contract_month":"12",
		"contract_year":null,
		"drivers_count":"1",
		"driver_age":"28",
		"driver_exp":"4",
		"ts_no_defend_flag":"false",
		"ts_satellite_flag":null,
		"ts_electronic_alarm_flag":"true",
		"franchise_percent":null,
		"commercial_carting_flag":null,
		"additional_sum":"100000"
		}
 }
 ```

 Запрос
 ```
 /references
 ```
 Ответ приходит в виде
 ```
 {
    ts_type: {
    request_parameter: "ts_type_id"
    values: [6]
        0:  {
            name: "Легковые автомобили"
            value: "1"
            is_default: 1
        }
        1:  {
            name: "Грузовые автомобили"
            value: "2"
            is_default: 0
        }
    }
}
 ```

 где
 ts_type - id справочника
 request_parameter - имя параметра, который необходимо вернуть на бэк
 values - массив возможных значений справочника, в котором
    name - пояснительная информация для отображения
    value - значение, которое уходит на бэк
    is_default - флаг значения по умолчанию