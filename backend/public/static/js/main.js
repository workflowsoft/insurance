$(function () {
	// Собственно, наша приложуха
	insurance = {
		init: function() {
			this.processTemplates();
		},

		// сюда складываем объекты Ractivejs темплейт
		templates: {},

		initialData: {},

		defaults: {
			visible_ts_age: 0,
			calculate: {
				commercial_carting_flag: 0,
				ts_age: 0
			}
		},

		toggleLoader: function (toggle) {
			toggle = toggle || false;

			var loader = $('.b-loader-backdrop');

			loader.toggle(toggle);
		},

		preprocessResponse: function(data) {
			var temp = [];

			_.each(data.driver_age.values, function(item) {
				temp.push(item);
			}, this);

			_.each(data, function(item, key) {
				var defaultItem = _.findWhere(item.values, {
					is_default: 1
				});

				if (defaultItem) {
					this.defaults.calculate[item.request_parameter] = defaultItem.value;
				}
			}, this);

			data.drivers_count.values = _.toArray(data.drivers_count.values);

			data.driver_age.values = temp;

			return data;
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
					console.log(response);

					templateFactory('CalcTemplate', {
						el: 'calc',
						template: '#calcTemplate',
						data: _.extend(this.preprocessResponse(response), this.defaults)
					});

				}.bind(this))
				.then(function() {
					this.afterLoad();
				}.bind(this));

			templateFactory('ProgramsTemplate', {
				el: 'programs',
				template: '#programsTemplate',
				data: {}
			});
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
				case 'ts_antitheft_id':
				debugger;
				
				tpl.set('calculate.ts_antitheft_id', $('input[name=ts_antitheft_id]:checked').val());	
				
				break;
			}
		},

		// Дата биндинг, обработка событий, вот это вот всё
		initBindings: function() {
			// Описываем события Ractivejs вьюшек

			this.templates.CalcTemplate.on({
				// Обработчик, срабатывающий при изменении любого контрола в калькуляторе
				processFormData: function(event) {
					var excludes = ['additional_equip'],
						requiredFields = ['ts_sum'],
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

					$.get('/programs',
						data
					).then(function(response) {
						if (response.Result) {
							response.Result.references = _.toArray(response.Result.references);
							insurance.templates.ProgramsTemplate.set({
								programs: response.Result,
								inputParams: response.inputParams
							});

						}
					}.bind(this));

					event.original.preventDefault();
					return false;
				}
			});

		this.templates.ProgramsTemplate.on({
			recalc: function(event) {
				$.get('/calculate/v1');

			},
			toggle: function (event) {
				$(event.node).next().toggle();

				event.original.preventDefault();
			}
		});

		}
	}

	insurance.init();
});