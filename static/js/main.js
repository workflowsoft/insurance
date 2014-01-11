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
					groupMembersCount: 100500
				}
			});
		},

		initBindings: function() {
			
		}
	}

	insurance.init();
});