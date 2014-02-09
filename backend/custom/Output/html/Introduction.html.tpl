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
		
		<!-- Контейнер шаблона с калькулятором -->
		<div id="calc" class="b-calc">
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