$(function () {
	// Собственно, наша приложуха
	insurance = {
		init: function() {
			this.initTemplateEngine();
			this.initBindings();
		},

		// Заводим инстансы Ractive.js
		initTemplateEngine: function () {
			var MainInfoTemplate = new Ractive({
			el: 'mainInfo',
			template: '#mainInfoTemplate',
			data: {
					groupMembersCount: 5,
					progressPercent: 45
				}
			});

			MainInfoTemplate.on({
				showDatepickerModal: function(event, container) {
					
			}});
		},

		initBindings: function() {

		}
	}

	insurance.init();
});