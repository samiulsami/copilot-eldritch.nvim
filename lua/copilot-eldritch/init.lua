---@class CopilotEldritchColorRange
---@field min integer Minimum RGB value (0-255)
---@field max integer Maximum RGB value (0-255)

---@class CopilotEldritchColors
---@field red CopilotEldritchColorRange
---@field green CopilotEldritchColorRange
---@field blue CopilotEldritchColorRange

---@class CopilotEldritchConfig
---@field max_length integer Maximum length of the generated string
---@field min_length integer Minimum length of the generated string
---@field max_distance_from_cursor integer Maximum random distance from cursor start
---@field max_lines integer Maximum number of lines to spread the across
---@field repeat_ms integer Speed of the animation in milliseconds
---@field jitter_ms integer Random jitter added to the repeat speed for flickering effect (0-N ms)
---@field rand_hl_group string Highlight group name to use for the spinner
---@field chars string[]|string[][] List of characters (glyphs) or list of character sets to randomly choose from on activation
---@field colors CopilotEldritchColors RGB color ranges for the flickering effect

local M = {}

---@type CopilotEldritchConfig
local defaults = {
	max_length = 73,
	min_length = 1,
	max_distance_from_cursor = 10,
	max_lines = 3,
	repeat_ms = 50,
	jitter_ms = 100,
	rand_hl_group = "CopilotEldritchHLGroup",
	colors = {
		red = { min = 133, max = 255 },
		green = { min = 0, max = 0 },
		blue = { min = 68, max = 68 },
	},
	-- stylua: ignore
	chars = {
		"Ȁ", "ȁ", "Ș", "ș", "Ț", "ț", "Ȝ", "ȝ", "ȿ", "Ⱥ", "Ⱦ", "Ƚ", "Ҁ", "ҁ", "Ҍ", "ҍ", "Ґ", "ґ", "Ғ", "ғ", "Җ",
		"җ", "Қ", "қ", "Ң", "ң", "Ү", "ү", "Ҽ", "ҽ", "א", "ב", "ג", "ד", "ה", "ו", "ز", "ح", "خ", "ک", "ګ", "ڭ",
		"گ", "ھ", "ۀ", "ہ", "ۃ", "ۄ", "ۅ", "ۆ", "ۇ", "ۈ", "ۉ", "ۊ", "ۋ", "ی", "α", "β", "γ", "δ", "ε", "ζ", "η",
		"θ", "ι", "κ", "λ", "μ", "ν", "ξ", "ο", "π", "ρ", "σ", "τ", "υ", "φ", "χ", "ψ", "ω", "Α", "Β", "Γ", "Δ",
		"Ε", "Ζ", "Η", "Θ", "Ι", "Κ", "Λ", "Μ", "Ν", "Ξ", "Ο", "Π", "Ρ", "Σ", "Τ", "Υ", "Φ", "Χ", "Ψ", "Ω", "0",
		"1", "2", "3", "4", "5", "6", "7", "8", "9", "@", "#", "$", "%", "&", "*", "+", "-", "=", "~", "?", "!",
		"/", "\\", "|", "<", ">", "^", "∂", "∑", "∏", "∫", "√", "∞", "≈", "≠", "≤", "≥", "⊕", "⊗", "⊥", "∇", "∃",
		"∀", "∈", "∉", "∩", "∪", "∧", "∨", "♠", "♥", "♣", "♪", "♫", "☼", "☽", "☾", "☿", "♃", "♄", "⚳", "⚴",
		"⚵", "⚶", "⚷", "⚸", "⚹", "⚺", "ꙮ", "꙯", "꙰", "꙱", "꙲", "꙳", "ꙴ", "ꙵ", "ꙶ", "ꙷ", "ꙸ", "ꙹ", "ꙺ", "ꙻ", "꙼",
		"꙽", "꙾", "ꙿ", "𐌀", "𐌁", "𐌂", "𐌃", "𐌄", "𐌅", "𐌆", "𐌇", "𐌈", "𐌉", "𐌊", "𐌋", "𐌌", "𐌍", "𐌎", "𐌏", "𐌐", "𐌑",
		"𐌒", "𐌓", "𐌔", "𐌕", "𓂀", "𓂁", "𓂂", "𓂃", "𓂄", "𓂅", "𓂆", "𓂇", "𓂈", "𓂉", "𓂊", "𓂋", "𓂌", "𓂍", "𓂎", "𓂏", "𓂐",
		"𓂑", "𓂒", "𓂓", "𓂔", "𓂕", "𓂖", "𓂗", "𓂘", "𓂙", "𓂚", "𓂛", "𓂜", "𓂝", "𓂞", "𓂟", "𓂠", "𓂡", "𓂢", "𓂣", "𓂤", "𓂥",
		"𓂦", "𓂧", "𓂨", "𓂩", "𓂪", "𓂫", "𓂬", "𓂭", "𓂮", "𓂯", "𓂰", "𓂱", "𓂲", "𓂳", "𓂴", "𓂵", "𓂶", "𓂷", "𓂸", "𓂹", "𓂺",
		"𓂻", "𓂼", "𓂽", "𓂾", "𓂿", "𓃀", "𓃁", "𓃂", "𓃃", "𓃄", "𓃅", "𓃆", "𓃇", "𓃈", "𓃉", "𓃊", "𓃋", "𓃌", "𓃍", "𓃎", "𓃏",
		"𓃐", "𓃑", "𓃒", "𓃓", "𓃔", "𓃕", "𓃖", "𓃗", "𓃘", "𓃙", "𓃚", "𓃛", "𓃜", "𓃝", "𓃞", "𓃟", "𓃠", "𓃡", "𓃢", "𓃣", "𓃤",
		"𓃥", "𓃦", "𓃧", "𓃨", "𓃩", "𓃪", "𓃯", "𓃰", "𓃱", "𓃲", "𓃳", "𓃴", "𓃵", "𓃶", "𓃷", "𓃸", "𓃹", "𓃺", "𓃻", "𓃼", "𓃽", "𓃾", "𓃿"
	},
}

---@param opts CopilotEldritchConfig|nil
function M.setup(opts)
	opts = vim.tbl_deep_extend("force", defaults, opts or {})
	local spinner = {
		timer = nil,
		ns = vim.api.nvim_create_namespace("copilot_eldritch"),
		current_chars = nil,
	}

	function spinner:next_string()
		local result = {}
		local spaces = math.random(0, opts.max_distance_from_cursor)
		for _ = 1, spaces do
			table.insert(result, " ")
		end

		local chars_list = self.current_chars or opts.chars
		if type(chars_list[1]) == "table" then
			chars_list = chars_list[math.random(1, #chars_list)]
		end

		local length = math.random(opts.min_length, opts.max_length)
		for _ = 1, length do
			local index = math.random(1, #chars_list)
			table.insert(result, chars_list[index])
		end

		return table.concat(result)
	end

	function spinner:reset()
		vim.api.nvim_buf_clear_namespace(0, self.ns, 0, -1)
		if self.timer then
			self.timer:stop()
			self.timer = nil
		end
	end

	require("copilot.status").register_status_notification_handler(function(data)
		spinner:reset()
		if data.status ~= "InProgress" then
			return
		end

		if type(opts.chars[1]) == "table" then
			spinner.current_chars = opts.chars[math.random(1, #opts.chars)]
		else
			spinner.current_chars = opts.chars
		end

		if spinner.timer then
			spinner.timer:stop()
		end
		spinner.timer = vim.uv.new_timer()
		if not spinner.timer then
			return
		end

		vim.api.nvim_create_autocmd({ "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("CopilotEldritchInsertLeave", { clear = true }),
			once = true,
			callback = function()
				spinner:reset()
			end,
		})

		spinner.timer:start(
			0,
			opts.repeat_ms,
			vim.schedule_wrap(function()
				if vim.b.copilot_suggestion_hidden then
					return
				end
				if require("copilot.suggestion").is_visible() then
					spinner:reset()
					return
				end

				local pos = vim.api.nvim_win_get_cursor(0)
				local cursor_row, cursor_col = pos[1] - 1, pos[2]
				local cursor_line = vim.api.nvim_buf_get_lines(0, cursor_row, cursor_row + 1, false)[1] or ""
				if cursor_col > #cursor_line then
					cursor_col = #cursor_line
				end

				vim.api.nvim_set_hl(0, opts.rand_hl_group, {
					fg = string.format(
						"#%02x%02x%02x",
						math.random(opts.colors.red.min, opts.colors.red.max),
						math.random(opts.colors.green.min, opts.colors.green.max),
						math.random(opts.colors.blue.min, opts.colors.blue.max)
					),
					bold = true,
				})

				local extmark_ids = {}
				local num_lines = math.random(1, opts.max_lines)
				local buf_line_count = vim.api.nvim_buf_line_count(0)

				for i = 1, num_lines do
					local row = cursor_row + i - 1
					if row >= buf_line_count then
						break
					end
					local col = (i == 1) and cursor_col or 0

					local extmark_id = vim.api.nvim_buf_set_extmark(0, spinner.ns, row, col, {
						virt_text = { { spinner:next_string(), opts.rand_hl_group } },
						virt_text_pos = "overlay",
						priority = 0,
					})
					table.insert(extmark_ids, extmark_id)
				end

				for _, extmark_id in ipairs(extmark_ids) do
					vim.defer_fn(function()
						pcall(vim.api.nvim_buf_del_extmark, 0, spinner.ns, extmark_id)
					end, opts.repeat_ms + math.random(0, opts.jitter_ms))
				end
			end)
		)
	end)
end

return M
