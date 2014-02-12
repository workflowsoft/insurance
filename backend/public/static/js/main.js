$(function () {
	// Собственно, наша приложуха
	insurance = {
		init: function() {
			this.processTemplates();
		},

		// сюда складываем объекты Ractivejs темплейт
		templates: {},

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

			// Грузим вьюшки

			// $.get('static/html/common_info.html')
			// 	.then(function(template) {
			// 		templateFactory('MainInfoTemplate', {
			// 			el: 'mainInfo',
			// 			template: template,
			// 			data: {
			// 				groupMembersCount: 5,
			// 				progressPercent: 45
			// 			}
			// 		});
			// 	})
			$.get('/references')
				.then(function(response) {
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

					// templateFactory('MainInfoTemplate', {
					// 	el: 'mainInfo',
					// 	template: template,
					// 	data: {
					// 		groupMembersCount: 5,
					// 		progressPercent: 45
					// 	}
					// });
				}.bind(this))
				.then(function() {
					this.afterLoad();
				}.bind(this));
		},

		afterLoad: function() {
			var loader = $('.b-loader-backdrop');

			loader.hide();

			this.initBindings();
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

					return false;
				},
				getTotal: function(event) {
					$.get('/calculate/v1', {
						data: this.data.calculate
					});

					event.original.preventDefault();
					return false;
				}
			})

		}
	}

	insurance.init();
});