{strip}
	{if $order.status eq "1"}
		{if $order.in_work eq "1"}
			<div class="order-item_status f10 wMin lh24 order-item_status_green nowrap tooltipster"
				 data-tooltip-text="{if $order.deadline && $order.deadline - time() < Helper::ONE_DAY && !$order.isCancelRequest}
						{if $order.timeLeftStr}
							{'Внимание! Осталось менее суток, чтобы сдать заказ на проверку.'|t}
						{else}
							{'Внимание! Заказ не сдан вовремя. Покупатель может в любой момент отменить заказ.'|t}
						{/if}
					 {else}
							{'Вы работаете над заказом. Пожалуйста, соблюдайте сроки выполнения.'|t}
					 {/if}">
				{if $order.progress}
					<span class="order-page-fill-rectangle" style="width: {$order.progress}%"></span>
					<span class="">{"Готово на"|t} {$order.progress}%</span>
				{else}

					{'В работе'|t}
				{/if}
			</div>
		{else}
			<div class="order-item_status f10 wMin lh24 order-item_status_gray nowrap tooltipster"
				 data-tooltip-text="
					{if $order.time_isLost == "1" && !$order.isCancelRequest}
						{'Внимание! Осталось менее %s, чтобы начать работу над заказом.'|t:$order['timeToCancelInWork']}
					{elseif $order.time_isLost == "-2" && !$order.isCancelRequest}
						{'Внимание! Заказ не сдан вовремя. Покупатель может в любой момент отменить заказ'|t}
					{else}
						{if $order.restarted && $order.has_stages}
							{'<strong>Возьмите заказ в работу как можно скорее или откажитесь от него!</strong><br> Покупатель предлагает вам вернуться к работе над заказом. Если вы не откажетесь от заказа через интерфейс или не приступите к нему в течение 1 суток, то произойдет автоотмена заказа. Автоотмена снижает рейтинг ответственности и негативно сказывается на продажах.'|t}
						{else}
							{'<strong>Возьмите заказ в работу как можно скорее!</strong><br> Если не начать работу в первые 24 часа, происходит автоотмена заказа. Автоотмена снижает ваш рейтинг ответственности и негативно сказывается на продажах.'|t}
						{/if}
					{/if}
				">
				{'Не начат'|t}
			</div>
		{/if}
	{elseif $order.status eq "2"}
		<div class="order-item_status order-item_status_orange f10 wMin lh24 nowrap tooltipster" data-tooltip-text="{'Спор по заказу отправлен в Арбитраж. Ожидайте решения арбитров'|t}">
			{'Арбитраж'|t}
		</div>
	{elseif $order.status eq "3"}
		<div class="order-item_status f10 wMin lh24 nowrap order-item_status_red tooltipster" data-tooltip-text="{$order.track_type|orderStatusDesc:$userType}">
			{'Отменен'|t}
		</div>
	{elseif $order.status eq "4"}
		<div class="order-item_status f10 wMin lh24 order-item_status_orange nowrap tooltipster" data-tooltip-text="{'Заказ сдан на проверку покупателю. Ожидайте результата'|t}">
			{'Сдан на проверку'|t}
		</div>
	{elseif $order.status eq "5"}
		<div class="order-item_status f10 wMin lh24 order-item_status_green -done nowrap tooltipster" data-tooltip-text="{'Выполнение заказа подтверждено покупателем'|t}">
			{'Выполнен'|t}
		</div>
	{elseif $o[i].status eq "6"}
		<div class="order-item_status f10 wMin lh24 order-item_status_orange wMax nowrap tooltipster" data-tooltip-text="{'Дождитесь, когда покупатель внесет оплату под следующую задачу. Только после этого приступайте к работе над ним.'|t}">
			{'Ожидается оплата'|t}
		</div>
	{/if}
{/strip}