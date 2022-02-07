{strip}
	<div class="order-item clearfix">
		<div class="order-item_header">
			<div class="order-item_info">
					<a href="{absolute_url route="profile_view" params=["username" => $order.username|lower]}">
						{include file="user_avatar.tpl" profilepicture=$order.profilepicture username=$order.username size="large" class="order-item_avatar"}
					</a>
				<div class="order-item_info_inner mt3 ml24">
					{include file="manage_orders/block_order_name.tpl"}
					<div class="order-item_info_user">
						{include file="manage_orders/block_user_status.tpl"}
					</div>
					<button type="button" class="order-item_info_btn order-item_info_btn_blue mt8 js-order-send-message">Отправить сообщение</button>
				</div>
			</div>

			<div class="order-item_status-wrap">
				{include file="manage_orders/block_status_and_action.tpl"}
			</div>
		</div>
		{include file="manage_orders/block_order_steps.tpl"}
		<a href="#" class="order-item_more floatright js-order-more"></a>
	</div>
{/strip}
