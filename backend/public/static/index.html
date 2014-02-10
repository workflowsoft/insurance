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
	<form role="form" class="g-clrfix" on-submit="processFormData">
		<div class="panel panel-info">
			<div class="panel-heading">
				<h3 class="panel-title">Сведения о транспортном средстве</h3>
			</div>

			<div class="panel-body">
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<label class=" control-label">Программа страхования</label>
						<select class="form-control" name="tariff_program">
							<option disabled selected>Выберите программу</option>
							{{#tariff_program}}
								<option value={{id}}>{{name}}</option>
							{{/tariff_program}}

						</select>
					</div>
					<div class="col-lg-6">
						<label class=" control-label">Коэффициент срока действия договора</label>
						<div class="">
							<select class="form-control" name="front_contract_duration">
								<option disabled selected>Выберите коэффициент</option>
								{{#front_contract_duration}}
								<option value={{id}}>{{name}}</option>
								{{/front_contract_duration}}
							</select>
						</div>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-12">
						<label class=" control-label">Категория ТС</label>
						<select class="form-control" name="ts_group">
							<option disabled selected>Выберите категорию</option>
							{{#ts_group}}
								<option value={{id}}>{{Name}}</option>
							{{/ts_group}}
						</select>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<div class="input-group"><span class="input-group-addon">Срок эксплуатации ТС</span><input type="text" name="expluatation_time" class="form-control"></div>
					</div>
					<div class="col-lg-6">
						<div class="input-group"><span class="input-group-addon">Стоимость ТС</span><input type="text" name="ts_cost" class="form-control"></div>
					</div>
				</div>
				<div class="form-group g-clrfix">
					<div class="col-lg-6">
						<label class=" control-label">Набор рисков</label>
						<select name="risks" class="form-control">
							{{#risks}}
								<option value="{{id}}">{{name}}</option>
							{{/risks}}
						</select>
					</div>
					<div class="col-lg-6">
						<label class=" control-label">Франшиза</label>
						<select name="franchise_type" class="form-control">
							<option value="1">Не выбрано</option>
							{{#franchise_type}}
								<option value="{{id}}">{{name}}</option>
							{{/franchise_type}}
						</select>
					</div>
					<div class="form-group g-clrfix">
						<div class="col-lg-6">
							<label class=" control-label">Есть доп.оборудование на сумму</label>
							<div class="input-group">
								<span class="input-group-addon">
								<input name="additional_equip" type="checkbox">
								</span>
								<input type="text" disabled class="form-control">
							</div>
						 </div>
					</div>
					<div class="form-group g-clrfix">
						<div class="col-lg-4">
							<label class="checkbox-inline">
								<input type="checkbox" id="inlineCheckbox1" value="option1">Есть спутниковая поисковая система
							</label>
						</div>
						<div class="col-lg-4">
							<label class="checkbox-inline">
								<input type="checkbox" id="inlineCheckbox2" value="option2">Нет противоугонной системы (для грузовиков, автобусов…)
							</label>
						</div>
						<div class="col-lg-4">
							<label class="checkbox-inline">
								<input type="checkbox" id="inlineCheckbox3" value="option3">Есть эл. сигнализация с обратной связью
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
								<input type="checkbox" id="inlineCheckbox3" value="option1">Страхователь — юр.лицо
							</label>
						</div>
					</div>
					<div class="form-group g-clrfix">
						<div class="col-lg-6">
							<label class=" control-label">Количество ЛДУ</label>
							<select name="lduCount" class="form-control">
								<option value="1">Без ограничений</option>
								<option value="2">Не более 3-х водителей</option>
							</select>
						</div><!-- /.col-lg-6 -->
						<div class="col-lg-6">
							<label class=" control-label">Выплаты без справок</label>
							<select name="payments_without_references" class="form-control">
								{{#payments_without_references}}
									<option value={{id}}>{{name}}</option>
								{{/payments_without_references}}
							</select>
						</div>
					</div>
					<div class="form-group g-clrfix">
						<div class="col-lg-4"><label for="">Возраст водителей(По самому «плохому» показателю)</label><input type="text" class="form-control"></div>
						<div class="col-lg-4"><label for="">Стаж водителей(По самому «плохому» показателю)</label><input type="text" class="form-control"></div>
						<div class="col-lg-4"><label for="">Коэффициент исопльзования ТС <br />&nbsp;</label><input type="text" class="form-control"></div>
						<div class="col-lg-4"><label for="">Коэффициент бонус-малус</label><input type="text" class="form-control"></div>
						<div class="col-lg-4"><label for="">Дополнительный коэффициент</label><input type="text" class="form-control"></div>
						<div class="col-lg-4"><label for="">Коэф. страхового продукта</label><input type="text" class="form-control"></div>
					</div>
					<div class="form-group g-clrfix">
						<div class="col-lg-12">
							<label class=" control-label">Определение размера ущерба</label>
							<select class="form-control" name="tariff_def_damage_type">
								{{#tariff_def_damage_type}}
								<option value={{id}}>{{name}}</option>
								{{/tariff_def_damage_type}}
							</select>
						</div>
					</div>
				</div>
			</div>
		</div>
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