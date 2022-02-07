const minutesArr = ['минут', 'минута', 'минуты'];
const hoursArr = ['часов', 'час', 'часа'];

window.TrackUtils = (function () {
    var orderId = null;
    var activeOrder = null;

    var _onPassWorkButtonClick = function (e) {
        activeOrder = $(e.currentTarget).closest('.order-item')[0];
        orderId = e.currentTarget.dataset.id;
        $('.js-inprogress-confirm').modal('show');
    };

    /**
     * Отправка работы на проверку
     * @private
     */
    var _onInprogressConfirmSubmit = function () {
        if (typeof (yaCounter32983614) !== 'undefined') {
            yaCounter32983614.reachGoal('START-WORK-DONE');
        }

        $('.js-inprogress-confirm').modal('hide');
        $('#form_pass_work').submit();
    };

    var _startShow = function () {
        $('.js-track-inprogress-check-button').show();

        $('.js-track-pass-work-button')
            .off('click', _onPassWorkButtonClick)
            .on('click', _onPassWorkButtonClick)
            .show();

        // отправка работы на проверку
        $(document)
            .off('click', '.js-inprogress-confirm-submit', _onInprogressConfirmSubmit)
            .on('click', '.js-inprogress-confirm-submit', _onInprogressConfirmSubmit);
        return true;
    };

    var _defSubmitPassWorkForm = function() {
        var sendData = new SendData();
        var form = $('#form_pass_work');

        sendData.append('orderId', orderId);
        sendData.append('action', 'worker_inprogress_check');
        sendData.append('message', '');
        sendData.append('message_send_ajax', '1');
        sendData.append('is_ajax', true);
        sendData.append('need_ajax', true);

        var xhr = new XMLHttpRequest();
        var action = form.attr('action');
        xhr.open('post', action, true);
        xhr.onload = function (response) {
            if (xhr.status === 200) {
                $(activeOrder.querySelector('.js-track-pass-work-button')).hide();
                form.closest('.popup').find('.popup-close-js:first').trigger('click');
                var status = activeOrder.querySelector('.order-item_status');
                status.innerText = "Сдан на проверку";
                status.classList.remove('order-item_status_green');
                status.classList.add('order-item_status_orange');

                var lastItem = activeOrder.querySelector('.order-step.-last.-active');
                var nextItem = lastItem.nextSibling;
                lastItem.classList.remove('-last');
                nextItem.classList.add('-last');
                nextItem.classList.add('-active');
                activeOrder.querySelector('.js-check-title').classList.remove('hidden');
            } else {
                try {
                    alert(response.data.message);
                } catch (e) {
                    throw Error('Ошибка изменения статуса');
                }
            }
            orderId = null;
            activeOrder = null;
        };

        var formData = sendData.getFormData();
        xhr.send(formData);
    }

    return {
        startShow: _startShow,
        onPassWorkButtonClick: _onPassWorkButtonClick,
        onInprogressConfirmSubmit: _onInprogressConfirmSubmit,
        defSubmitPassWorkForm: _defSubmitPassWorkForm,
    }
})();

function alertFunc() {
    alert(1);
}

function getTimeText(count, arr) {
    let text;
    if (count) {
        if (count < 11 || count > 19) {
            switch (count % 10) {
                case 1:
                    text = arr[1];
                    break;
                case 2:
                    text = arr[2];
                    break;
                case 3:
                    text = arr[2];
                    break;
                case 4:
                    text = arr[2];
                    break;
                default:
                    text = arr[0];
            }
        } else {
            text = arr[0];
        }
    }
    return text || '';
}

function getTime(count) {
    let hoursText, minutesText;

    let hoursCount = Math.floor(count / 60 / 60);
    let minutesCount = Math.ceil((count - hoursCount * 60 * 60) / 60);

    if (hoursCount) {
        hoursText = `${hoursCount} ${getTimeText(hoursCount, hoursArr)} `;
    }
    if (minutesCount) {
        minutesText = `${minutesCount} ${getTimeText(minutesCount, minutesArr)}`;
    }

    return (hoursCount ? `${hoursText }` : '') + minutesText;
}

$(document).ready(function () {
    $(document).on('click', '.js-order-more', function (e) {
        let a = e.target.previousSibling;
        a.classList.toggle('-show');
        e.target.classList.toggle('-show');
        e.preventDefault();
    });

    $(document).on('click', '.js-order-send-message', alertFunc);

    $(document).on('click', '.js-order-portfolio-send', alertFunc);

    $(document).on('click', '.js-order-portfolio-cancel', alertFunc);

    $(document).on('click', '.js-order-get', alertFunc);

    TrackUtils.startShow();

    document.querySelectorAll('.js-order-time').forEach((el)=>{
        let time = el.dataset.time;
        el.innerText = getTime(time);
    });
});