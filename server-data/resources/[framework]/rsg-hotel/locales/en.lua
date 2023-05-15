local Translations = {
    error = {
        not_enought_cash_to_rent_room = 'not enought cash to rent a room!',
        you_already_have_room_here = 'you already have a room here!',
        you_dont_have_room_here = "you don\'t have a room here!",
        not_enough_cash = "you don\'t have enought cash for that!",
    },
    success = {
        you_rented_room = 'you rented room ',
        room_credit_added_for = 'room credit added for ',
    },
    primary = {
        your_credit_is_now = 'your credit is now $',
    },
    menu = {
        open = 'Open ',
        check_in = 'Check-In',
        rent_room_deposit = 'Rent a Room ($ %{startCredit} Deposit)',
        close_menu = 'Close Menu',
        room_menu = 'Room Menu',
        hotel_room = 'Hotel Room : ',
        add_credit = 'Add Credit',
        wardrobe = 'Wardrobe',
        room_locker = 'Room Locker',
        leave_room = 'Leave Room',
        add_credit_room = 'Add Credit to Room ',
        room = 'Room ',
    },
    text = {
        current_credit = 'current credit $',
        amount = 'Amount ($)',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
}


Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
