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

		selectCategory: function(id) {
			var categorySelect = $('#category_select');

			if (id) {
				categorySelect.find('option:selected').each(function(){
					this.selected=false;
				});

				categorySelect.find('[value="' + id +'"]').attr('selected', 'selected');
			} else {
				categorySelect.find('[value="1"]').attr('selected', 'selected');
			}
		},

		afterLoad: function() {
			this.toggleLoader(false);

			this.initBindings();

			$(document).trigger('webAppReady');
		},

		validate: function(name) {
			var form = document.getElementById('calcForm'),
				el = form[name],
				val = el.value,
				tpl = this.templates.CalcTemplate;
			
			switch(name) {
				case 'ts_type_id':

				$.get('/ts/group', {
					ts_type_id: el.value
				}).then(function (response) {
					response && this.selectCategory(response.ts_group_id);
				}.bind(this));
				break;

				case 'ts_sum':
				if (_.isNaN(parseInt(val))) {			
					tpl.set('calculate.ts_sum', '');
				} else {
					tpl.set('calculate.ts_sum', parseInt(val));
				}
				break;
			}
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

					this.set('additional.submitReady', submitReady);

					self.validate(event.original.target.name);

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