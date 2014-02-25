<?php
/**
 * Created by PhpStorm.
 * User: PavelTropin
 * Date: 24.02.14
 * Time: 13:04
 */

namespace Calculation;


class Configuration {

    private static $factorTables = array('additional_coefficients', 'tariff_coefficients');

    private static $factorTableSql = 'SELECT COLUMN_NAME as `column`, \'%s\' AS `table` FROM
	                                    INFORMATION_SCHEMA.COLUMNS
		                                  WHERE TABLE_SCHEMA = \'%s\' AND TABLE_NAME = \'%s\'';

    private static $factorDefinitionSql = 'SELECT F.name, F.`default`, SCH.`column`, SCH.`table`,
                                              FR.`type` AS reference_type, FR.`reference_table`, FR.name as reference_name,
                                              FR.id as reference_id, FR.program_specific
                                                FROM factors F LEFT JOIN factor2references F2R
                                                  ON F2R.factor_id = F.id
	                                            LEFT JOIN factor_references FR
	                                              ON FR.id = F2R.reference_id
	                                            INNER JOIN (%s) SCH
		                                          ON F.name = SCH.`column` OR
		                                             CONCAT(F.name,\'_down\') = SCH.`column` OR
		                                             CONCAT(F.name,\'_up\') = SCH.`column`
		                                          ORDER BY CASE WHEN CONCAT(F.name,\'_up\') = SCH.`column` THEN 1 ELSE 0 END';

    private static $definitions = null;

    public static function getFactorsDefinitions()
    {
        if (is_null(Configuration::$definitions))
        {
            $definitions = array();
            $dbName = \Frapi_Internal::getCachedDbConfig()['db_database'];
            $tableSqls = array();
            foreach (Configuration::$factorTables as $factorTable)
            {
                array_push($tableSqls, sprintf(Configuration::$factorTableSql, $factorTable, $dbName, $factorTable));
            }
            $finalSql = sprintf(Configuration::$factorDefinitionSql, join(' UNION ALL ', $tableSqls));
            $sth = \Frapi_Database::getInstance()->query($finalSql);
            $results = $sth->fetchAll(\PDO::FETCH_ASSOC);
            foreach ($results as $defPart)
            {
                $key = $defPart['name'];
                if (!array_key_exists($key, $definitions))
                {
                    $definitions[$key] = array(
                        'name' => $defPart['reference_name'],
                        'type' => $defPart['reference_type'],
                        'program_specific' => $defPart['program_specific'],
                        'columns' => array($defPart['column']),
                        'tables' => array($defPart['table']),
                    );
                    if (!is_null($defPart['reference_table']))
                        $definitions[$key] = array_merge($definitions[$key], array('reference_table'=> $defPart['reference_table']));
                }
                else
                {
                    $newColumn = $defPart['column'];
                    $newTable = $defPart['table'];
                    if(!in_array($newColumn, $definitions[$key]['columns'], true))
                        array_push($definitions[$key]['columns'],$newColumn);
                    if(!in_array($newTable, $definitions[$key]['tables'], true))
                        array_push($definitions[$key]['tables'],$newTable);
                }
            }
            Configuration::$definitions = $definitions;
        }
        return Configuration::$definitions;
    }
} 