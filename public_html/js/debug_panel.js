var DebugPanelModule = (function () {
	var getSqlLog = function () {
		// получим урл страницы
		var pageUrl = document.location.href;
		pageUrl = encodeURIComponent(pageUrl.replace(document.location.origin, "").split("#")[0]);
		$.post('/get_dev_log_data', {request: pageUrl}, function (res) {
			requestResult(res);
		}, 'json');
	};

	return {
		init: function () {
			getSqlLog();
		}
	}
})();
var select;
var selectedVal;

function requestResult(res) {
	if (!res.success) return;
	var $div = $(res.data);
	$('#sql_count', $div).click(function () {
		$('#debug_sql_table', $div).toggle();
	});
	$('#redis_count', $div).click(function () {
		$('#debug_redis_table', $div).toggle();
	});

	// клик по строке запроса - открывает параметры (если есть)
	$('.js-debug-panel-show-params', $div).click(function (e) {
		var index = $(e.target).parents("tr.js-debug-panel-show-params").data("index");
		var $targetBlock = $('# js-debug-params-block-' + index, $div);
		if (!$targetBlock.is(":visible")) {
			$('.js-debug-params-block', $div).slideUp(300);
		}
		$targetBlock.slideToggle(300);
	});

	$('.js-debug-panel-show-trace', $div).click(function (e) {
		var parents = $(e.target).parents("tr.js-debug-panel-show-trace");
		var index = parents.data("index");
		var $targetBlock = $('#js-debug-trace-block-' + index, parents);

		if (!$targetBlock.is(":visible")) {
			$('.js-debug-trace-block', $div).slideUp(300);
		}
		$targetBlock.slideToggle(300);
	});
	$(".debug-panel").remove();

	$("body").append($div);


	if (select) {
		jQuery(".debug-panel-select").html(select);
		jQuery(".debug-panel-select").val(selectedVal);
	}
} 
window.addEventListener('DOMContentLoaded', function () {
	jQuery(document).on("change", ".debug-panel-select", function () {
		$.post('/get_dev_log_data', {id: jQuery(".debug-panel-select").val()}, function (res) {
			selectedVal = jQuery(".debug-panel-select").val();
			select = jQuery(".debug-panel-select").html();
			requestResult(res);
		}, "json");
	});
});
(function () {
	const send = XMLHttpRequest.prototype.send
	XMLHttpRequest.prototype.send = function () {
		this.addEventListener("load", function () {
			if (jQuery(".debug-panel-select").length &&
				this.responseURL.indexOf("get_dev_log") == -1 &&
				this.responseURL.indexOf(".js") == -1 &&
				this.responseURL.indexOf(".json") == -1) {
				var pageUrl = this.responseURL;
				var url = pageUrl.replace(document.location.origin, "").split("#")[0];
				setTimeout(function () {
					$.post("/get_dev_log_list", {request: encodeURIComponent(url)}, function (res) {
						if (res.data) {
							jQuery(".debug-panel-select").append("<option value=\"" + res.data.id + "\">" + url + "</option>");
						}
					}, "json");
				}, 1000);

			}
		})
		return send.apply(this, arguments)
	}
})()