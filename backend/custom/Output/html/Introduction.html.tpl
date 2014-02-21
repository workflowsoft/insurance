<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!-->
<html class="no-js">
<!--<![endif]-->
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>Insurance, bitch!</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,300,600,700' rel='stylesheet' type='text/css'>
<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="stylesheet" href="static/css/main.css">
<link rel="stylesheet" href="static/css/bootstrap.min.css">
<script src="static/js/vendor/modernizr-2.6.2.min.js"></script>
<script src="static/js/vendor/lodash.min.js"></script>
<script src="static/js/jquery/jquery-1.9.1.min.js"></script>
<script src="static/js/vendor/bootstrap.min.js"></script>
</head>
<body class="l-body">
<!--[if lt IE 7]>
			<p class="browsehappy">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a> to improve your experience.</p>
		<![endif]-->
<div class="l-wrapper">
	<div class="b-header">
		<div class="page-header">
			<h1>Insurance</h1>
			<h4><small>Get insured or die trying</small></h4>
		</div>
	</div>
	<div class="l-content">
		<!-- Контейнер шаблона с общей информацией -->
		<div id="mainInfo" class="b-main_info">
		</div>

<script id="calcTemplate" type="ractive">

	<h2><small>Калькулятор тарифов по страхованию средств наземного транспорта</small></h2>
	<form id="calcForm" role="form" class="g-clrfix" on-submit="getTotal" on-change="processFormData">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Сведения о транспортном средстве</h3>
			</div>

			<div class="panel-body">
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<label class=" control-label">Тип транспортного средства</label>
						<select class="form-control" disabled={{!ts_type}} name="ts_type_id" value={{calculate.ts_type_id}}>
							<option disabled selected>Выберите тип ТС</option>
							{{#ts_type}}
								<option value={{id}}>{{name}}</option>
							{{/ts_type}}

						</select>
					</div>
					<div class="col-lg-6">
						<label class=" control-label">Марка транспортного средства</label>
						<select disabled={{!ts_make}} class="form-control" name="ts_make_id" value={{calculate.ts_make_id}}>
							<option disabled selected>Выберите марку ТС</option>
							{{#ts_make}}
								<option value={{id}}>{{name}}</option>
							{{/ts_make}}
						</select>
					</div>
					<div class="col-lg-6">
						<label class=" control-label">Модель транспортного средства</label>
						<select disabled={{!ts_model}} class="form-control" name="ts_model_id" value={{calculate.ts_model_id}}>
							<option disabled selected>Выберите модель ТС</option>
							{{#ts_model}}
								<option value={{id}}>{{name}}</option>
							{{/ts_model}}
						</select>
					</div>
					<div class="col-lg-6">
						<label class=" control-label">Модификация транспортного средства</label>
						<select disabled={{!ts_modification}} class="form-control" name="ts_modification_id" value={{calculate.ts_modification_id}}>
							<option disabled selected>Выберите модификацию ТС</option>
							{{#ts_modification}}
								<option value={{id}}>{{name}}</option>
							{{/ts_modification}}
						</select>
					</div>
					<div class="col-lg-6">
						<label class=" control-label">Программа страхования</label>
						<select disabled={{!tariff_program}} class="form-control" name="tariff_program_id" value={{calculate.tariff_program_id}}>
							{{^tariff_program.hasDefault}}
								<option disabled selected>ыберите программу</option>
							{{/tariff_program.hasDefault}}

							{{#tariff_program}}
								{{#default}}
									<option selected value={{id}}>{{name}}</option>
								{{/default}}

								{{^default}}
									<option value={{id}}>{{name}}</option>
								{{/default}}
							{{/tariff_program}}
						</select>
					</div>
					<div class="col-lg-6">
						<label class=" control-label">Тип возмещения</label>
						<select disabled={{!tariff_def_damage_type}} class="form-control" name="tariff_def_damage_type_id" value={{calculate.tariff_def_damage_type_id}}>
							{{^tariff_def_damage_type.hasDefault}}
								<option disabled selected>Выберите тип возмещения</option>
							{{/tariff_def_damage_type.hasDefault}}

							{{#tariff_def_damage_type}}
								{{#default}}
									<option selected value={{id}}>{{name}}</option>
								{{/default}}

								{{^default}}
									<option value={{id}}>{{name}}</option>
								{{/default}}
							{{/tariff_def_damage_type}}

						</select>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-12">
						<label class=" control-label">Категория ТС</label>
						<select disabled={{!ts_group}} class="form-control" value={{calculate.ts_group_id}}> name="ts_group_id">
							{{^ts_group.hasDefault}}
								<option disabled selected>Выберите категорию</option>
							{{/ts_group.hasDefault}}

							{{#ts_group}}
								{{#default}}
									<option selected value={{id}}>{{name}}</option>
								{{/default}}

								{{^default}}
									<option value={{id}}>{{name}}</option>
								{{/default}}
							{{/ts_group}}
						</select>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<div class="input-group"><span class="input-group-addon">Срок эксплуатации ТС</span><input value={{calculate.ts_age}} type="text" name="ts_age" class="form-control"></div>
					</div>
					<div class="col-lg-6">
						<div class="input-group"><span class="input-group-addon">Стоимость ТС</span><input value={{calculate.ts_sum}} type="text" name="ts_sum" class="form-control"></div>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<label class=" control-label">Набор рисков</label>
						<select disabled={{!risks}} name="risk_id" value={{calculate.risk_id}} class="form-control">
							{{#risks}}
								<option value="{{id}}">{{name}}</option>
							{{/risks}}
						</select>
					</div>
					<div class="col-lg-6">
						<label class=" control-label">Есть доп.оборудование на сумму</label>
						<div class="input-group">
							<span class="input-group-addon">
							<input name="additional_equip" checked={{additional.equip}} type="checkbox">
							</span>
							<input type="text" disabled="{{!additional.equip}}" class="form-control" />
						</div>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<label class=" control-label">Франшиза</label>
						<select disabled={{!franchise_type}} name="franchise_type_id" value={{calculate.franchise_type_id}} class="form-control">
							<option value="1">Не выбрано</option>
							{{#franchise_type}}
								<option value="{{id}}">{{name}}</option>
							{{/franchise_type}}
						</select>
					 </div>
					 <div class="col-lg-6">
						<label for="">Процент от страховой суммы</label>
						<input type="text" value="{{calculate.franchise_percent}}" class="form-control">
					</div>
				</div>

				<div class="form-group g-clrfix">
					<div class="col-lg-3">
						<label class="checkbox-inline">
							<input type="checkbox" id="inlineCheckbox1" checked="{{calculate.ts_satellite_flag}}">Есть спутниковая поисковая система
						</label>
					</div>
					<div class="col-lg-3">
						<label class="checkbox-inline">
							<input type="checkbox" id="inlineCheckbox2" checked="{{calculate.ts_no_defend_flag}}">Нет противоугонной системы (для грузовиков, автобусов…)
						</label>
					</div>
					<div class="col-lg-3">
						<label class="checkbox-inline">
							<input type="checkbox"  id="inlineCheckbox3" checked="{{calculate.ts_electronic_alarm_flag}}">Есть эл. сигнализация с обратной связью
						</label>
					</div>
					<div class="col-lg-3">
						<label class="checkbox-inline">
							<input type="checkbox"  id="inlineCheckbox3" checked="{{calculate.amortisation}}">Учёт амортизации (для тарифа УНИВЕРСАЛ)
						</label>
					</div>
				</div>
			</div>
		</div>
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Сведения для рассчёта тарифа</h3>
			</div>
			<div class="panel-body">
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<label class="checkbox-inline">
							<input type="checkbox" checked={{calculate.commercial_carting_flag}}>ТС сдаётся в прокат
						</label>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-4">
						<label class="control-label">Количество ЛДУ</label>
						<input name="drivers_count" type="text" value="{{calculate.drivers_count}}" class="form-control">
					</div>
					<div class="col-lg-4">
						<label class=" control-label">Выплаты без справок</label>
						<select name="payments_without_references_id" value={{calculate.payments_without_references_id}} class="form-control">
							{{#payments_without_references}}
								<option value={{id}}>{{name}}</option>
							{{/payments_without_references}}
						</select>
					</div>
					<div class="col-lg-4">
					    <label class=" control-label">Тип возмещения</label>
						<select class="form-control" value="{{calculate.regres_limit_factor_id}}" name="regres_limit_factor_id">
							{{#regres_limit}}
							<option value={{id}}>{{name}}</option>
							{{/regres_limit}}
						</select>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-4">
					<label for="contract_day">День</label>
							<input name="contract_day" type="text" value="{{calculate.contract_day}}" class="form-control">
						</div>
						<div class="col-lg-4">
							<label for="contract_month">Месяц</label>
							<input value="{{calculate.contract_month}}" name="contract_month" type="text" class="form-control">
						</div>
						<div class="col-lg-4">
							<label for="contract_year">Год</label>
							<input type="text" name="contract_year" value="{{calculate.contract_year}}" class="form-control">
						</div>

					<div class="col-lg-4">
						<label for="">Возраст водителей(По самому «плохому» показателю)</label>
						<input type="text" value="{{calculate.driver_age}}" class="form-control">
					</div>
					<div class="col-lg-4">
						<label for="">Стаж водителей(По самому «плохому» показателю)</label>
						<input type="text" value="{{calculate.driver_exp}}" class="form-control">
					</div>
					<div class="col-lg-4">
					</div>
				</div>
			</div>
		</div>

		{{#totalSum}}
			<h2 class="b-total_sum">Стоимость полиса составит {{totalSum}} рублей.</h2>
		{{/totalSum}}
		
		{{^additional.submitReady}}
			<button type="submit" disabled  class="btn btn-lg btn-default pull-right">Рассчитать</button>
		{{/additional.submitReady}}
		{{#additional.submitReady}}
			<button type="submit"  class="btn btn-lg btn-info pull-right">Рассчитать</button>
		{{/additional.submitReady}}
	</form>
</script>

<div class="b-calc" id="calc">
	
</div>
		
		<!-- Контейнер шаблона с калькулятором -->
		<div id="calc2" class="b-calc">

		</div>
	</div>
	<div class="b-footer">
	</div>
</div>

<div class="b-loader-backdrop">
	<div class="b-loading"></div>
</div>

<!-- Modal -->
<div class="modal fade" id="datepickerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">Выберите дату</h4>
			</div>
			<div class="modal-body">
			...
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary">OK</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script src="static/js/core/Ractive.js"></script>
<script src="static/js/main.js"></script>
</body>
</html>