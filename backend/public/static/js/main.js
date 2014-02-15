$(function () {
	// Собственно, наша приложуха
	insurance = {
		init: function() {
			this.processTemplates();
		},

		// сюда складываем объекты Ractivejs темплейт
		templates: {},

		initialData: {},

		toggleLoader: function (toggle) {
			toggle = toggle || false;

			var loader = $('.b-loader-backdrop');

			loader.toggle(toggle);
		},

		// Заводим инстансы Ractive.js
		processTemplates: function () {
			// Фабрика, создающая вьюшки. В options необходимо передать el и template
			var templateFactory = function(templateName, options) {
				// Необходимо повыёбываться
				templateName = templateName || ('defaultTemplate_' + (Math.random()*1e4).toFixed());
				options = options || {}

				this.templates[templateName] = new Ractive({
					el: options.el,
					template: options.template,
					data: options.data
				});

			}.bind(this);

			$.get('/references')
				.then(function(response) {
					response = this.preprocessResponseData(response);

					templateFactory('CalcTemplate', {
						el: 'calc',
						template: '#calcTemplate',
						data: response
					})

				}.bind(this))
				.then(function() {
					this.afterLoad();
				}.bind(this));
		},

		afterLoad: function() {
			this.toggleLoader(false);

			this.initBindings();
		},

		validate: function(data) {
			this.toggleLoader(true);

			$.get('/validate',
				data
			).then(function(response) {

				this.toggleLoader(false);
			}.bind(this))
			.fail(function(message){
				console.error(message.statusText);
				this.toggleLoader(false);
			}.bind(this));
		},

		preprocessResponseData: function(data) {
			// Если справочник — пустой массив, превращаем его в false
			_.each(data, function(item, key) {
				_.isArray(item) && !item.length && (data[key] = false);
			});

			_.isEmpty(this.initialData) && (this.initialData = data);
			return data;
		},

		// Дата биндинг, обработка событий, вот это вот всё
		initBindings: function() {
			// Описываем события Ractivejs вьюшек
			// this.templates.MainInfoTemplate.on({
			// 	showDatepickerModal: function(event) {
					
			// }});

			this.templates.CalcTemplate.on({
				// Обработчик, срабатывающий при изменении любого контрола в калькуляторе
				processFormData: function(event) {
					var excludes = ['additional_equip'],
						requiredFields = ['tariff_program_id', 'risk_id', 'tariff_def_damage_type_id', 'ts_age','payments_without_references_id', 'ts_sum'],
						self = insurance,
						data = this.data.calculate || {},
						submitReady;

					if (excludes.indexOf(event.original.target.name) != -1) {
						return;
					}

					for (var i = 0, l = requiredFields.length; i < l; i++) {
						var currentRequiredField = requiredFields[i];

						!i && (submitReady = true);

						if (submitReady && !data[currentRequiredField]) {
							data[currentRequiredField] = null;
							submitReady = false;
						}
					}

					if (submitReady) {
						this.set('additional.submitReady', submitReady);

						insurance.toggleLoader(true);
						insurance.validate(this.data.calculate);
					}

					return false;
				},
				getTotal: function(event) {
					var data = this.data.calculate || {},
						submitReady = false;

					$.get('/calculate/v1',
						data
					).then(function(response) {
						if (response.Result) {
							this.set('totalSum', response.Result.Contract.Sum);
						}
					}.bind(this));

					event.original.preventDefault();
					return false;
				}
			})

		}
	}

	insurance.init();
});