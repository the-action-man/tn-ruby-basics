h = {
    january: 31,
    february: 28,
    march: 31,
    april: 30,
    may: 31,
    june: 30,
    luly: 31,
    august: 31,
    september: 30,
    october: 31,
    november: 30,
    december: 31
}

h.each {|k,v| puts k if v == 30}
