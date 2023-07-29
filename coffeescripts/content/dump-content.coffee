
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
expansionsAsXws = {}
for e, contents of manifest.manifestByExpansion
    #console.log(e, contents)
    for item in contents
        name = item.name
        #console.log(item)
        switch item["type"]
            when "pilot"
                item.name = getXws(name, basicCards.pilotsById)
            when "upgrade"
                item.name = getXws(name, basicCards.upgradesById)
            when "ship"
                item.name = name.canonicalize()

    expansionsAsXws[e.canonicalize()] = contents

console.log(JSON.stringify(expansionsAsXws, null, 2))