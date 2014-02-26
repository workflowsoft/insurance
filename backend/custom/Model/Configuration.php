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

    private static $dependentSql = 'SELECT AC.`coefficient_id`, %s FROM `additional_coefficients` AC GROUP BY AC.`coefficient_id`';
    private static $dependentColumn = 'CASE WHEN MAX(IFNULL(AC.%s, -1)) = -1 THEN 0 ELSE 1 END AS %s';

    private static $definitions = null;

    private static $dependencies = null;

    public static function getCoefficientDependencies()
    {
        if (is_null(Configuration::$dependencies))
        {
            $factors = Configuration::getFactorsDefinitions();
            $columnCheckParts = array();
            foreach($factors as $factorDef)
            {
                if (in_array('additional_coefficients', $factorDef['tables']))
                {
                    foreach($factorDef['columns'] as $factorColumn)
                    {
                        array_push($columnCheckParts, sprintf(Configuration::$dependentColumn, $factorColumn, $factorColumn));
                    }
                }
            }
            $checkSql = sprintf(Configuration::$dependentSql, join(' , ', $columnCheckParts));
            $sth = \Frapi_Database::getInstance()->query($checkSql);
            $results = $sth->fetchAll(\PDO::FETCH_ASSOC);

            $deps = array();

            foreach($results as $result)
            {
                foreach($factors as $factor=>$factorDef)
                {
                    foreach($factorDef['columns'] as $factorColumn)
                    {
                        if (array_key_exists($factorColumn, $result))
                        {
                            if ($result[$factorColumn] == 1)
                            {
                                //Есть зависимость, фискируем
                                if (!array_key_exists($factor, $deps))
                                {
                                    $deps[$factor] = array();
                                }
                                $new_coef =  $result['coefficient_id'];
                                if (!in_array($new_coef, $deps[$factor]))
                                {
                                    array_push($deps[$factor], $new_coef);
                                }
                            }
                        }
                    }
                }
            }
            Configuration::$dependencies = $deps;
        }
        return Configuration::$dependencies;
    }

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