local Translations = {
    error = {
        error_var = 'Example Text',
    },
    success = {
        success_var = 'Example Text',
    },
    primary = {
        primary_var = 'Example Text',
    },
    menu = {
        make_a_note  = 'Make a note',
        message      = 'Message:',
        written_by   = 'Written By: ',
        tear_up_note = 'Tear up note',
    },
    text = {
        enter_message = 'Enter your message here'
    },
    targetinfo = {
        read_note = 'Read Note',
    },
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
