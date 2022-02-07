{extends file="layout.tpl"}

{* content *}
{block name="content"}
	{Helper::registerFooterJsFile("/js/pages/orders/orders.js"|cdnBaseUrl)}
	{Helper::registerFooterJsFile("/js/urlparams.js"|cdnBaseUrl)}
	{Helper::registerFooterJsFile("/js/dist/manage_orders.js"|cdnBaseUrl)}
	{Helper::printCssFile("/css/dist/manage_orders.css"|cdnBaseUrl)}
	{Helper::printJsFile("/js/bootstrap.modal.min.js"|cdnBaseUrl)}
	{Helper::printCssFile("/css/bootstrap.modal.css"|cdnBaseUrl)}

	{strip}
		<div class="clearfix pt20 block-response manage-orders mt10">
			<h1 class="f32 fw700 orders-title manage-orders_title">{'Заказы'|t}</h1>
			{if $orders|@count eq "0" && $searchQuery eq null}
				<div class="mt25 font-OpenSans t-align-c">
					{'Здесь будут отображаться Ваши заказы'|t}
				</div>
			{else}
				<div class="m-hidden pull-right">
					{if $includeLimitField}
						{include file="manage_orders/count_switcher.tpl"}
					{/if}
				</div>

				<div class="clearfix pb50 block-response m-p0 m-m0">
					{if $searchQuery neq null}
						{if $orders|@count > 0}
							<div class="orders-search-result mt20 mb20">{"<b>Результаты поиска</b> по запросу:"|t} "{$searchQuery}"</div>
						{else}
							<div class="orders-search-result mt20 mb20">{"<b>К сожалению, поиск не дал результатов. Измените запрос.</b> Вы можете искать по названию заказа и/или логину покупателя"|t}</div>
						{/if}
					{/if}

					{if $orders|@count > 0}
						<div class="orders-list">
							{foreach from=$orders item=order}
								{control name="manage_orders/order_item" order=$order}
							{/foreach}
						</div>
						<form action="{absolute_url route="track_worker_inprogress_check"}" enctype="multipart/form-data" id="form_pass_work" class="ajax-disabling hidden" method="post" onsubmit="TrackUtils.defSubmitPassWorkForm(); return false;"></form>
					{/if}
				</div>
				<div class="t-align-c mb10">
					{insert name=paging_block assign=pages value=a data=$pagingdata}
					{$pages}
				</div>
			{/if}
			<div class="clear"></div>
		</div>
	{/strip}

	{include file="popup/order_change_name.tpl"}
	{include file="track/popup/inprogress_confirm.tpl"}
{/block}
{* /content *}