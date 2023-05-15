function loadInbox(list)
{
    $('#inboxList').empty();

    if (list.length > 0)
    {
        list.forEach(function(letter)
        {
            if (letter.status == 1)
            {
                $("#inboxList").append(`
                    <li class="inbox_row" data-id="`+letter.id+`">
                    <div class="inbox_subject"><i class="fa fa-envelope-open"></i> `+letter.subject+`</div>
                    <div class="inbox_sendername">`+letter.sendername+`</div>
                    <div class="inbox_date">`+letter.sentDate+`</div>
                    <a href="#"><i class="fas fa-angle-double-right"></i></a>
                    </li>`
                );
            }
            else
            {
                $("#inboxList").append(`
                    <li class="inbox_row" data-id="`+letter.id+`">
                    <div class="inbox_subject"><i class="fa fa-envelope"></i> <b>`+letter.subject+`</b></div>
                    <div class="inbox_sendername">`+letter.sendername+`</div>
                    <div class="inbox_date">`+letter.sentDate+`</div>
                    <a href="#"><i class="fas fa-angle-double-right"></i></a>
                    </li>`
                );
            }
        });
    }
    else
    {
        $(".inboxList").text("No messages!")
    }
}

$(function ()
{
    window.addEventListener('message', function (event)
    {
        if (event.data.type === "openGeneral")
        {
            $('.inbox').css('display', 'block');
            let today = new Date().toLocaleDateString();
            $('#today').text(today);
        }

        if (event.data.type === "view")
        {
            $("#view_id").text(event.data.telegram.id)
            $("#view_recipient").text(event.data.telegram.recipient)
            $("#view_sender").text(event.data.telegram.sender)
            $("#view_sendername").text(event.data.telegram.sendername)
            $("#view_date").text(event.data.telegram.sentDate)
            $("#view_subject").text(event.data.telegram.subject)
            $("#view_message").text(event.data.telegram.message)
        }

        if (event.data.type === "inboxlist")
        {
            var msglist = event.data.response.list
            box = event.data.response.box
            loadInbox(msglist);
            $('#firstname').text(event.data.response.firstname);
        }

        if (event.data.type === "closeAll")
        {
            $('.inbox').css('display', 'none')
            $('.view').css('display', 'none')
        }
    });
});

$(document).ready(function()
{
    $("#inboxList").on("click",'li',function(event)
    {
        itemToDel = $(this).data('id');
        $.post('https://rsg-telegram/getview', JSON.stringify({id: $(this).data('id')}));
        $(".inbox").fadeOut().hide();
        $(".view").fadeIn().show();
    });
});

//Close view
$(".close_view").on("click", function ()
{
    $(".view").fadeOut().hide();
    $(".inbox").fadeIn().show();
});

//Close post office
$(".closePostoffice").on("click",function()
{
    $.post('https://rsg-telegram/NUIFocusOff', JSON.stringify({}));
});

// delete message
$(".telegram_delete_button").click(function(event)
{
    $.post('https://rsg-telegram/delete', JSON.stringify({id: itemToDel}));
    $.post('https://rsg-telegram/NUIFocusOff', JSON.stringify({}));
});