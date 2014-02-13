$(function () {
	// Собственно, наша приложуха
	insurance = {
		init: function() {
			this.processTemplates();
		},

		// сюда складываем объекты Ractivejs темплейт
		templates: {},

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
						data: response,
						init: function() {
							console.log(123);

							this.on({bzz: function() {
								console.log('waka!');
							}});
						}
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

		preprocessResponseData: function(data) {
			_.each(data, function(item, key) {
				_.isArray(item) && !item.length && (data[key] = false);
			});

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
						data = this.data.calculate || {};

					if (excludes.indexOf(event.original.target.name) != -1) {
						return;
					}

					// Заполняем необходимые поля наллами даже если пользователь их не указал.
					for (var i = 0, l = requiredFields.length; i < l; i++) {
						var currentRequiredField = requiredFields[i];

						if (!data.hasOwnProperty(currentRequiredField)) {							
							return;
						} else {
							this.set('additional.submitReady', true);
						}
					}

					// insurance.toggleLoader(true);

					// $.get('/validate',
					// 	this.data.calculate
					// ).then(function(response) {
					// 	this.set(self.preprocessResponseData(response));
					// 	self.toggleLoader(false);
					// }.bind(this));

					return false;
				},
				getTotal: function(event) {
					var data = this.data.calculate || {},
						submitReady = false;

					$.get('/calculate/v1',
						data
					).then(function(response) {

					}.bind(this));

					event.original.preventDefault();
					return false;
				}
			})

		}
	}

	insurance.init();
});