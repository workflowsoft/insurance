esurance
========

#Групповое страхование

##Для развертывания проекта нужно.
* Развернуть API
Для этого нужен сервер Apache. Его нужно настроить слушать 2 дополнительных порта, которые будут привязаны к администраторской части API и самому API. 
Для этого нужно в файлах конфигурации Apache (папка conf, порты могут быть другими, если эти у вас заняты)
** httpd.conf, добавить
```
	Listen 91
	Listen 92
```
** conf/extra/httpd-vhosts.conf добавить

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
** В файле backend\custom\Config\configurations.xml найти соответсвтующие теги и поменять их значения на свои
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
 
 *Развернуть БД на своем локальном сервере БД MySql
 Для этого надо последовательно выполнить скрипты:
 ** base_schema.sql
 ** base_tariff_data.sql
 ** references_data.sql
 ** additional_coeff_inserts.sql