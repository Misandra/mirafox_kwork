{strip}
    <div class="order-steps">
        {foreach item=histItem from=$order.trackHistory name=history key=key}
            <div class="order-step {if $order.trackHistory|@count-1 === $key}-last{/if} {if $histItem->getShortDescription() !== 'Заказ отменен'}{'-active'}{else}{'-cancel'}{/if} clearfix">
                <div class="order-step_title fw600 floatleft pr20">
                    {if $histItem->getShortDescription() == 'Заказ создан'}
                        Заказ<br/>создан
                    {elseif $histItem->getShortDescription() == 'Взят в работу'}
                        Взят<br/>в работу
                    {elseif $histItem->getShortDescription() === 'Сдан на проверку'}
                        Сдан<br/>на проверку
                    {else}
                        {$histItem->getShortDescription()}
                    {/if}
                </div>
                <div class="order-step_info floatleft">
                    <div class="order-step_info_title f14 fw600">
                        {if $histItem->getShortDescription() === 'Заказ создан'}
                            {'Получена информация от покупателя'}
                        {elseif $histItem->getShortDescription() === 'Взят в работу'}
                            {'Вы приступили к работе над заказом'}
                        {elseif $histItem->getShortDescription() === 'Сдан на проверку'}
                            {'Заказ отправлен на проверку'}
                        {elseif $histItem->getShortDescription() === 'Принят'}
                            {'Поздравляем! Работа принята заказчиком!'}
                        {elseif $histItem->getShortDescription() === 'Заказ отменен'}
                            {'Заказ отменен'}
                        {/if}
                    </div>
                    <div class="order-step_info_text">
                        {if $histItem->getShortDescription() === 'Заказ создан'}
                            <p>Покупатель следовал вашим инструкциям. Если отправленной информации недостаточно, уточните ее, отправив сообщение покупателю.</p>
                            <p>Если информации достаточно, приступайте</p>
                            {if $order.trackHistory|@count-1 === $key}
                                <button type="button" class="order-get-btn order-step_btn order-step_btn_green js-order-get">Взять в работу</button>
                            {/if}
                        {elseif $histItem->getShortDescription() === 'Взят в работу'}
                            <p>Приложите результат, когда будете готовы</p>
                            {if $order.trackHistory|@count-1 === $key}
                                <button type="button" class="order-send-btn order-step_btn order-step_btn_green js-track-pass-work-button" data-id="{$order.OID}">
                                    Отправить заказ
                                </button>
                            {/if}
                        {elseif $histItem->getShortDescription() === 'Принят'}
                            <p>
                                {if $order.timeInWork}
                                    На выполнение у вас ушло <div class="js-order-time" data-time="{$order.timeInWork}"></div>,<br/>
                                    вознаграждение уже переведено вам на расчётный счёт
                                {else}
                                    Вознаграждение уже переведено вам на расчётный счёт
                                {/if}
                            </p>
                        {elseif $histItem->getShortDescription() === 'Заказ отменен'}
                            <p>Произошла отмена заказа</p>
                        {/if}
                    </div>
                </div>
            </div>
        {/foreach}

        {if $order.status == \OrderManager::STATUS_DONE}
            <div class="order-step">
                <div class="order-step_title fw600 pr20">Опубликован<br/>в портфолио</div>
                <div class="order-step_info">
                    <div class="order-step_info_title f14 fw600">
                        Отличная работа, теперь можно опубликовать работу в портфолио
                    </div>
                    <div class="order-step_info_text">
                        <div class="order-step_btns">
                            <button type="button" class="order-step_btn order-step_btn_green js-order-portfolio-send">Опубликовать</button>
                            <button type="button" class="order-step_btn order-step_btn_transparent js-order-portfolio-cancel">Оставить без публикации</button>
                        </div>
                    </div>
                </div>
            </div>
        {/if}

        {if !in_array((int)$order.status,[\OrderManager::STATUS_CANCEL,\OrderManager::STATUS_DONE])}
            {foreach \Track\TrackHistory::getMustHaveTypes() as $type}
                {if !in_array($type, $order.trackHistoryDescriptions) }
                    <div class="order-step clearfix">
                        <div class="order-step_title floatleft fw600">
                            {if $type == 'Заказ создан'}
                                Заказ<br/>создан
                            {elseif $type == 'Взят в работу'}
                                Взят<br/>в работу
                            {elseif $type === 'Сдан на проверку'}
                                Сдан<br/>на проверку
                            {elseif $type === 'Опубликован в портфолио'}
                                Опубликован<br/>в портфолио
                            {else}
                                {$type}
                            {/if}
                        </div>
                        {if $type === 'Сдан на проверку'}
                        <div class="order-step_info floatleft hidden js-check-title">
                            <div class="order-step_info_title f14 fw600">
                                Заказ отправлен на проверку
                            </div>
                        </div>
                        {/if}
                    </div>
                {/if}
            {/foreach}
        {/if}
    </div>
{/strip}