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
<title>Insurance</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,400,300,600,700' rel='stylesheet' type='text/css'>
<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
<link rel="stylesheet" href="static/css/main.css">
<link rel="stylesheet" href="static/css/bootstrap.min.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.4/themes/cupertino/jquery-ui.css">

<script src="static/js/vendor/lodash.min.js"></script>
<script src="static/js/jquery/jquery-1.9.1.min.js"></script>
<script src="static/js/jquery/jquery-ui.min.js"></script>
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
			<h4><small>Калькулятор тарифов по страхованию средств наземного транспорта</small></h4>
		</div>
	</div>
	<div class="l-content">
		<!-- Контейнер шаблона с общей информацией -->
		<div id="mainInfo" class="b-main_info">
		</div>

<script id="calcTemplate" type="ractive">
	<form id="calcForm" role="form" class="g-clrfix" on-submit="getTotal" on-change="processFormData">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Сведения о транспортном средстве</h3>
			</div>

			<div class="panel-body">
				<div class="form-group g-clrfix">
					<div class="col-lg-3">
						<label class=" control-label">Тип транспортного средства</label>
						<select class="form-control" disabled={{!ts_type.values}} name="ts_type_id" value={{calculate.ts_type_id}}>
							{{#ts_type.values}}
								{{^is_default}}
									<option value={{value}}>{{name}}</option>
								{{/is_default}}

								{{#is_default}}
									<option selected value={{value}}>{{name}}</option>
								{{/is_default}}
							{{/ts_type.values}}
						</select>
					</div>
					<div class="col-lg-3">
						<label class=" control-label">Марка транспортного средства</label>
						<input type="text" name="ts_make" class="form-control">
					</div>
					<div class="col-lg-3">
						<label class=" control-label">Модель транспортного средства</label>
						<input name="ts_model" type="text" class="form-control">
					</div>
					<div class="col-lg-3">
						<label class=" control-label">Модификация транспортного средства</label>
						<select disabled={{!ts_modification.values}} class="form-control" name="ts_modification_id" value={{calculate.ts_modification_id}}>
							<option disabled>Выберите модификацию ТС</option>
							{{#ts_modification.values}}
								{{#is_default}}
									<option selected="selected" value={{value}}>{{name}}</option>
								{{/is_default}}

								{{^is_default}}
									<option value={{value}}>{{name}}</option>
								{{/is_default}}
							{{/ts_modification.values}}
						</select>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-12">
						<label class=" control-label">Категория ТС</label>
						<select id="category_select" disabled={{!ts_group}} class="form-control" value={{calculate.ts_group_id}} name="ts_group_id">
								<option disabled selected>Выберите категорию</option>
							{{#ts_group.values}}
								{{#is_default}}
									<option selected="selected" value={{value}}>{{name}}</option>
								{{/is_default}}

								{{^is_default}}
									<option value={{value}}>{{name}}</option>
								{{/is_default}}
							{{/ts_group.values}}
						</select>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<label class="control-label">Срок эксплуатации ТС ({{visible_ts_age}})</label>
						<div id="ts_age" class="js-slider"></div>
					</div>
					<div class="col-lg-6">
						<div class="input-group"><span class="input-group-addon">Стоимость ТС</span><input value={{calculate.ts_sum}} placeholder="Введите число" type="text" name="ts_sum" class="form-control"></div>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<label class=" control-label">Есть доп.оборудование на сумму</label>
						<div class="input-group">
							<span class="input-group-addon">
							<input name="additional_equip" checked={{additional.equip}} type="checkbox">
							</span>
							<input type="text" name="additional_sum" value="{{calculate.additional_sum}}" disabled="{{!additional.equip}}" class="form-control" />
						</div>
					</div>
				</div>

				<div class="form-group g-clrfix">

					{{#ts_antitheft.values}}
						<div class="col-lg-3">
							<div class="radio">
								<label>
									{{#is_default}}
										<input type="radio" name="ts_antitheft_id" checked="checked" value={{value}}>{{name}}
									{{/is_default}}

									{{^is_default}}
										<input type="radio" name="ts_antitheft_id" value={{value}}>{{name}}
									{{/is_default}}
								</label>
							</div>
						</div>
					{{/ts_antitheft.values}}

					<div class="col-lg-3">
					<br />
						<label class="checkbox-inline">
							<input name="commercial_carting_flag" type="checkbox" checked={{calculate.commercial_carting_flag}}>ТС сдаётся в прокат
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
					<div class="col-lg-4">
						<label class="control-label">Количество водителей<br>({{visible_drivers_count}})</label>
						<div id="drivers_count" class="js-slider"></div>
					</div>
					<div class="col-lg-4">
						<label for="">Возраст самого юного водителя<br>({{visible_driver_age}})</label>
						<div id="driver_age" class="js-slider"></div>
					</div>
					<div class="col-lg-4">
						<label for="">Стаж самого неопытного водителя<br>({{visible_driver_exp}})</label>
						<div id="driver_exp" class="js-slider"></div>
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
			<button type="submit" disabled  class="btn btn-lg btn-default pull-right">Далее</button>
		{{/additional.submitReady}}
		{{#additional.submitReady}}
			<button type="submit"  class="btn btn-lg btn-info pull-right">Далее</button>
		{{/additional.submitReady}}
	</form>
</script>

<script id="programsTemplate" type="ractive">
{{#programsLoaded}}
	<h2><small>Подходящие страховые программы</small></h2>
{{/programsLoaded}}
{{#programs:num}}
	<form id="programsForm" role="form" class="g-clrfix" on-submit="re" on-change="recalc" on-reset="reset">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">{{name}}</h3>
			</div>

				<form class="form-group g-clrfix" data-program-key={{num}} on-change="recalc" data-id="{{id}}">
					<div class="col-lg-3">
						<button type="button" class="btn js-popover btn-default" data-container="body" data-toggle="popover" data-placement="right" data-content="{{description}}">
 							<span class="glyphicon glyphicon-info-sign"></span> О программе
						</button>
						
					</div>
					<div class="col-lg-6">

					<input type="hidden" name="tariff_program_id" value="{{id}}">

					{{#references:key}}
						<div class="col-lg-6">	
							<label for="">{{title}}</label>
							<select class="form-control" name={{requestName}} >
								{{#references[key].values:index}}
									{{#references[key].values[index]}}
										{{#(is_default === 1)}}
											<option data-request-name={{request_parameter}} selected value={{value}}>{{name}}</option>
										{{/is_default}}

										{{#(is_default === 0)}}
											<option data-request-name={{request_parameter}} value={{value}}>{{name}}</option>
										{{/is_default}}
									{{/references[key].values[index]}}
								{{/references[key].values}}
							</select>
						</div>
					{{/references}}
						<div class="col-lg-6">
							<br />
							<label class="checkbox-inline">
								<input name="amortisation" type="checkbox">Утрата товарной стоимости
							</label>
						</div>
					</div>
					<div class="col-lg-3">
						<h4><small>Стоимость полиса</small><h4>
						<p>Сумма: {{cost.Result.Contract.Sum}}</p>
						{{#cost.Result.Additional}}
						<h4><small>Стоимость доп.оборудования</small><h4>
						<p>Сумма: {{cost.Result.Additional.Sum}}</p>
						{{/cost.Result.Additional}}
					</div>
				</form>
				<div class="b-programs-buttons g-clrfix">
					<button disabled="disabled" class="btn btn-md btn-default pull-left js-reset" on-click="resetProgram">Сбросить</button>
					<button disabled="disabled" class="btn btn-md btn-info pull-right js-recalc" on-click="recalcProgram">Пересчитать</button>
				</div>
				<div class="panel panel-default">
					<div class="panel-heading">Коэффициенты</div>
					<div class="panel-body">
						<table class="table table-bordered table-condensed">
							<tr>
								{{#cost.Result.Coefficients:key}}
									<td>{{key}}</td>
								{{/cost.Result.Coefficients}}
							</tr>
							<tr>
								{{#cost.Result.Coefficients:key}}
									<td>{{cost.Result.Coefficients[key]}}</td>
								{{/cost.Result.Coefficients}}
							</tr>
						</table>
					</div>
				</div>
			
			
		</div>
	</form>
{{/programs}}
</script>
		<!-- Контейнер шаблона с калькулятором -->
		<div class="b-calc" id="calc"></div>
		<div class="b-programs" id="programs"></div>
	</div>
	<div class="b-footer">
		© twistedmotions | 2014
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

<script src="static/js/jquery/jquery.noty.packaged.min.js"></script>
<script src="static/js/core/Ractive.js"></script>
<script src="static/js/main.js"></script>
<script src="static/js/plugins.js"></script>
<script src="static/js/jquery/jquery.overrides.js"></script>
</body>
</html>