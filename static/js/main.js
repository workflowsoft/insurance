$(function () {
	// Собственно, наша приложуха
	insurance = {
		init: function() {
			this.initTemplateEngine();
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
		}
	}

	insurance.init();
});