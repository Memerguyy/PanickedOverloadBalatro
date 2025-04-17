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
		text = {"What else can be more fun than 5 cards?","Correct! a whole whoppin {C:white,X:green}SIX!{} of em!","Allows you to {C:chips}select{} {C:white,X:mult}6{} cards","instead of {C:white,X:mult}5{} on your last {C:chips}hand{}.","Every card {C:chips}played{} becomes a {C:white,X:attention}scoring{} card."},
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
			if context.modify_scoring_hand and G.GAME.current_round.hands_left < 2 then
			  return {
				add_to_hand = true
			  }
			end
			if context.joker_main and G.GAME.current_round.hands_left < 2 then
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
			elseif context.joker_main and G.GAME.current_round.hands_left > 2 then
				G.hand.config.highlighted_limit = 6
			end
			if context.end_of_round and context.cardarea == G.jokers then
					sendDebugMessage("EOR", "PanickedOverload")
					G.hand.config.highlighted_limit = 5
			end
			

			-- OLD CODE, LEAVING IT HERE FOR DISCOVERY PURPOSES

			-- if context.joker_main and G.GAME.current_round.hands_left < 2 then
			-- 	sendDebugMessage("less than 2 hands left", "PanickedOverload")
			-- 	G.hand.config.highlighted_limit = 6
			-- 	G.FUNCS.can_play = function(e)
			-- 		if #G.hand.highlighted <= 0 or G.GAME.blind.block_play or #G.hand.highlighted > G.hand.config.highlighted_limit then
			-- 			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			-- 			e.config.button = nil
			-- 		else
			-- 			e.config.colour = G.C.BLUE
			-- 			e.config.button = 'play_cards_from_highlighted'
			-- 		end
			-- 	end
			-- elseif context.joker_main and G.GAME.current_round.hands_left > 2 then
			-- 	G.hand.config.highlighted_limit = 5
			-- 	G.FUNCS.can_play = function(e)
			-- 		if #G.hand.highlighted <= 0 or G.GAME.blind.block_play or #G.hand.highlighted > 5 then
			-- 			e.config.colour = G.C.UI.BACKGROUND_INACTIVE
			-- 			e.config.button = nil
			-- 		else
			-- 			e.config.colour = G.C.BLUE
			-- 			e.config.button = 'play_cards_from_highlighted'
			-- 		end
			-- 	end
			-- end
			-- if context.end_of_round and context.cardarea == G.jokers then
			-- 	sendDebugMessage("EOR", "PanickedOverload")
			-- 	G.hand.config.highlighted_limit = 5
			-- end
			-- if context.before and context.cardarea then
			-- 	return {
			-- 		add_to_hand = true
			-- 	}
			-- end
		end
}
