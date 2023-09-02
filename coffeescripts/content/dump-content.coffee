
manifest = require './manifest.js'
cards = require './xwingcontent.js'
util = require 'util'

getXws = (cardName, cardList) ->
    for card in cardList
        if card.name == cardName
            if card.xws?
                return card.xws
            else
                return cardName.canonicalize()
    return ""

basicCards = cards.basicCardData()
expansionsAsXws = []
for e, contents of manifest.manifestByExpansion
    #console.log(e, contents)
    for item in contents
        name = item.name
        #console.log(item)
        switch item["type"]
            when "pilot"
                item.xws = getXws(name, basicCards.pilotsById)
            when "upgrade"
                item.xws = getXws(name, basicCards.upgradesById)
            else
                item.xws = name.canonicalize()
        delete item["name"]

    expansionsAsXws.push {"name": e, "contents": contents, "sku": "swz"}

console.log(JSON.stringify(expansionsAsXws, null, 2))
