(function() {
	// Навешиваем всяческие UI-компонентны после того, как справочники получены и форма отрендерена
	$(document).on('webAppReady', function (argument) {

		_.extend(insurance, {

			initSuggest: function() {
				var template = insurance.templates.CalcTemplate,
					calculate = template.get('calculate'),
					processResponse = function(response, res) {
						if (response.reference.length) {
							res(_.map(response.reference, function (item) {
								return {
									label: item.name,
									value: item.name,
									id: item.id
								};
							}));
						}

						if (response.ts_group_id) {
							insurance.selectCategory(response.ts_group_id);
						}
					};

				$(document.getElementById('calcForm').ts_make).autocomplete({
					source: function(req, res) {
						$.get('/reference/make/' + calculate.ts_type_id, {
								name_pfx: req.term
							}
						).then(function(response){
							processResponse(response, res);
						});
					},
					select: function(event, item) {
						template.set('calculate.ts_make', item.item.id);
					}
				});

				$(document.getElementById('calcForm').ts_model).autocomplete({
					source: function(req, res) {
						var makeId = calculate.ts_make;

						if (makeId) {
							$.get(['/reference', 'model', calculate.ts_type_id, makeId].join('/'), {
								name_pfx: req.term
							}
							).then(function(response){
								processResponse(response, res);
							});
						}
					},
					select: function(event, item) {
						template.set('calculate.ts_model', item.item.id);

						$.get('/ts/group', {
							ts_type_id: calculate.ts_type_id,
							ts_make_id: calculate.ts_make,
							ts_model_id: calculate.ts_model
						}).then(function (response) {
							response && insurance.selectCategory(response.ts_group_id);
						}.bind(this));
					}
				});
				return this;
			},

			initSliders: function() {
				var tpl = this.templates.CalcTemplate;

				_.each($('.js-slider'), function(el) {
					var reference = el.id,
						references = tpl.get(reference);

					$(el).slider({
						min: references.values[0].value,
						max: _.last(references.values).value,
						slide: function(event, ui) {
							var val = ui.value,
								referencesList = tpl.get(reference).values,
								newVal = _.findWhere(referencesList, {
									value: val
								});

							tpl.set('visible_' + reference, newVal.name);
							tpl.set('calculate.' + reference, val);
						}
					});

				});

				return this;
			},

			bootstrapTooltips: function() {

				$('.js-popover').popover();

				return this;
			}
		});

		insurance
			.initSuggest()
			.initSliders()
			.bootstrapTooltips();
	})
}());