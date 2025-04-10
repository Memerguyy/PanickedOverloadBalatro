--Made using the example joker template
SMODS.Atlas {
	-- Key for code to find it with
	key = "PanickedOverload",
	-- The name of the file, for the code to pull the atlas from
	path = "PanickedOverload.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

SMODS.Joker {
	key = 'PanickedOverload',
	loc_txt = {
		name = 'Panicked Overload',
		text = {"What else can be more fun than 5 cards?","Correct! a whole whoppin {C:white,X:green}SIX!{} of em!","Allows you to {C:chips}select{} {C:white,X:mult}6{} cards","instead of {C:white,X:mult}5{} on your last {C:chips}hand{}."},
	},
		discovered = true,
		unlocked = true,
		config = {extra={highlight_size=6}},
		loc_vars = function(self, info_queue, card)
			return { vars = {card.ability.extra.highlight_size} }
		end,
		atlas = 'PanickedOverload',
		pos = { x = 0, y = 0 },
		rarity = 2,
		cost = 5,
		calculate = function(self, card, context)
			--THIS CODE IS **REALLY** FUCKING MESSY, HELD TOGETHER BY DUCT TAPE, if you're here trying to learn something PLEASE be aware that this was put together in (a collective total of) AN HOUR, there's still probably some weird obscure interaction I didn't think off, but oh well :3
			if context.joker_main then
				sendTraceMessage(G.hand.config.highlighted_limit, "PanickedOverload")
				if (G.GAME.current_round.hands_left == 1) then
					G.hand.config.highlighted_limit = 6
					G.FUNCS.can_play = function(e)
						if #G.hand.highlighted <= 0 or G.GAME.blind.block_play or #G.hand.highlighted > G.hand.config.highlighted_limit then 
							e.config.colour = G.C.UI.BACKGROUND_INACTIVE
							e.config.button = nil
						else
							e.config.colour = G.C.BLUE
							e.config.button = 'play_cards_from_highlighted'
						end
					  end
				else
					G.hand.config.highlighted_limit = 5
					G.FUNCS.can_play = function(e)
						if #G.hand.highlighted <= 0 or G.GAME.blind.block_play or #G.hand.highlighted > G.hand.config.highlighted_limit then 
							e.config.colour = G.C.UI.BACKGROUND_INACTIVE
							e.config.button = nil
						else
							e.config.colour = G.C.BLUE
							e.config.button = 'play_cards_from_highlighted'
						end
					  end
				end
			end
		end
}
