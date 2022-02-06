{strip}
{if App::config("sqllog.enable") && App::config("app.mode") == "local"}
    {Helper::printJsFile("/js/libs/jquery-ui.resizable.min.js"|cdnBaseUrl, 1)}
    {Helper::printJsFile("/js/libs/jquery.tablesorter/jquery.tablesorter.min.js"|cdnBaseUrl, 1)}
    {Helper::printCssFile("/js/libs/jquery.tablesorter/theme.bootstrap_4.min.css"|cdnBaseUrl)}
    {Helper::printCssFile("/css/dist/debug_panel.css"|cdnBaseUrl)}
	{Helper::printJsFile("/js/debug_panel.js"|cdnBaseUrl, 1)}
	<script>
		window.addEventListener('DOMContentLoaded', function () {
			DebugPanelModule.init();
		});
	</script>
{/if}
{Helper::printJsFiles()}
{Helper::printCssFiles()}
{if $controlEnLang}
<script>
	window.addEventListener('DOMContentLoaded', function() {
        $('.control-en').on('input', (e) => e.target.value = e.target.value.replace(/[А-Яа-яЁё]/g, ''));
    });
</script>
{/if}
{if $refIframe}
	<iframe id="iframe_ref" src="{$refIframe}" width="0" height="0" align="left"></iframe>
{/if}

{if $authHash && $authBaseurls}
	{foreach $authBaseurls as $authBaseurl}
		<iframe id="iframe_auth" src="{$authBaseurl}/setcookie?auth_hash={$authHash}" width="0" height="0" align="left"></iframe>
	{/foreach}
{/if}

</body>
</html>
{/strip}