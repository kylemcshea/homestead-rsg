local Translations = {
    error = {
        not_enought_cash_to_rent_room = '¡no hay suficiente dinero para alquilar una habitación!',
        you_already_have_room_here = '¡ya tienes una habitación aquí!',
        you_dont_have_room_here = "¡No tienes una habitación aquí!",
    },
    success = {
        you_rented_room = 'habitación alquilada ',
        room_credit_added_for = 'crédito de habitación añadido para ',
    },
    primary = {
        your_credit_is_now = 'su crédito es ahora de $',
    },
    menu = {
        open = 'Abrir ',
        check_in = 'Registrarse',
        rent_room_deposit = 'Alquilar una habitación ($ %{startCredit} Deposito)',
        close_menu = 'Cerrar menu',
        room_menu = 'Menu de habitación',
        hotel_room = 'Habitación de hotel : ',
        add_credit = 'Agregar Credito',
        wardrobe = 'Armario',
        room_locker = 'Casillero',
        leave_room = 'Dejar la habitación',
        add_credit_room = 'Agregar Credito a la habitación ',
        room = 'Habitación ',
    },
    text = {
        current_credit = 'crédito actual $',
        amount = 'Cantidad ($)',
    },
    commands = {
        var = 'text goes here',
    },
    progressbar = {
        var = 'text goes here',
    },
}


if GetConvar('rsg_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
