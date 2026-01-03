-- SQL snippets
-- Generic, dialect-agnostic, generally ANSI-compliant SQL snippets.

---@module 'luasnip'

local util = require 'plugins.snippet.util'

-- Slightly lower priority so that other dialects may override
local s = util.snippet_with_def_prio(800)

-- stylua: ignore start
return {
	-- Data Types

	s({trig = 'n?v?ch', desc = '(N)(VAR)CHAR', regTrig = true}, fmt('{}{}CHAR({})', {
		util.if_trigger('n', 'N'),
		util.if_trigger('v', 'VAR'),
		i(1)
	})),

	s({trig = 's?int', desc = '(SMALL)INT', regTrig = true}, fmt('{}INTEGER', util.if_trigger('s', 'SMALL'))),

	s({trig = 'num', desc = 'NUMERIC'}, fmt('NUMERIC({}, {})', { i(1, 'p'), i(2, 's') })),

	-- NUMERIC and DECIMAL are synonyms
	s({trig = 'dec', desc = 'DECIMAL'}, fmt('DECIMAL({}, {})', { i(1, 'p'), i(2, 's') })),

	s({trig = 'fl', desc = 'FLOAT'}, fmt('FLOAT({})', i(1, 'n'))),

	-- Constraints

	s({trig = 'pk', desc = 'PRIMARY KEY'}, t 'PRIMARY KEY'),

	s({trig = 'fk', desc = 'FOREIGN KEY ... REFERENCES'}, fmt('FOREIGN KEY ({}) REFERENCES {}({})', {
		i(1, 'foo'), i(2, 'table'), i(3, 'id'),
	})),

	s({trig = 'nn', desc = 'NOT NULL'}, { t 'NOT NULL' }),

	s({trig = 'def', desc = 'DEFAULT'}, fmt('DEFAULT {}', i(1))),

	s({trig = 'def', desc = 'DEFAULT'}, fmt('DEFAULT {}', i(1))),

	-- Operators

	s({trig = 'betw', desc = 'BETWEEN expr AND expr'}, fmt('BETWEEN {} AND {}', { i(1, 'expr'), i(2, 'expr') })),

	s({trig = 'in(%d?)', desc = 'IN (a, b, c)', regTrig = true}, fmt('IN ({})', {
		d(1, function(_, snip)
			local n = #snip.captures[1] > 0 and snip.captures[1] or 2
			local placeholders = {}
			local nodes = {}
			for x = 1, n do
				table.insert(placeholders, '{}')
				table.insert(nodes, i(x))
			end
			return sn(nil, fmt(table.concat(placeholders, ', '), nodes))
		end),
	})),

	s({trig = 'isnn?', desc = 'IS (NOT) NULL', regTrig = true}, fmt('IS {}NULL', util.if_trigger('nn$', 'NOT '))),

	s({trig = 'like', desc = 'LIKE ...'}, fmt("LIKE '{}'", { i(1) })),

	-- DDL

	s({trig = 'ct', desc = 'CREATE TABLE'}, fmt([[
		CREATE TABLE {} (
			{} INTEGER PRIMARY KEY,
			{}
		);
	]], { i(1, 'foo'), i(2, 'id'), i(3) })),

	s({trig = 'cta', desc = 'CREATE TABLE AS ... SELECT'}, fmt([[
		CREATE TABLE {} AS
			SELECT {}
			FROM {};
	]], { i(1, 'foo'), i(2, '*'), i(3, 'src') })),

	s({trig = 'ci', desc = 'CREATE (UNIQUE) INDEX'}, fmt([[
		CREATE {}{}_idx
			ON {}({});
	]], {
		c(1, { t '', t 'UNIQUE ' }), i(1, 'foo'), i(2, 'table'), i(3, 'col')
	})),

	s({trig = 'at', desc = 'ALTER TABLE ...'}, fmt([[
		ALTER TABLE {}
		{}
	]], { i(1, 'table'), i(2) })),

	s({trig = 'ata', desc = 'ALTER TABLE - ADD'}, fmt('ADD {} {}', { i(1, 'col'), i(2, 'INTEGER') })),

	s({trig = 'atm', desc = 'ALTER TABLE - MODIFY'}, fmt('MODIFY {} {}', { i(1, 'col'), i(2, 'INTEGER') })),

	s({trig = 'atd', desc = 'ALTER TABLE - DROP'}, fmt('DROP {}{}', {
		c(1, { t '', t 'CONSTRAINT ' }), i(1, 'name')
	})),

	s({trig = 'd[tv]', desc = 'DROP TABLE|VIEW', regTrig = true}, {
		c(1, {
			sn(nil, fmt('DROP {} {};', { util.when_trigger { t = 'TABLE', v = 'VIEW' }, i(1, 'name') })),
			sn(nil, fmt('DROP {} IF EXISTS {};', { util.when_trigger { t = 'TABLE', v = 'VIEW' }, i(1, 'name') })),
		}),
	}),

	s({trig = 'trt', desc = 'TRUNCATE TABLE'}, fmt('TRUNCATE TABLE {};', i(1, 'table'))),

	-- DQL

	s({trig = 'sel', desc = 'SELECT ... FROM'}, fmt([[
		SELECT {}{}
		FROM {}
	]], {
		c(1, { t '', t 'DISTINCT ', t 'ALL ' }),
		i(2, '*'),
		i(3, 'table'),
	})),

	s({trig = 'n?[clrf]?join', desc = 'JOIN clause', regTrig = true}, fmt('{}{}JOIN {} {}', {
		util.if_trigger('^n', 'NATURAL '),
		util.when_trigger { c = 'CROSS ', l = 'LEFT ', r = 'RIGHT ', f = 'FULL ' },
		i(1, 'table'),
		c(2, {
			sn(nil, fmt('USING ({})', i(1, 'col'))),
			sn(nil, fmt('ON {} = {}', { i(1, 'left_col'), i(2, 'right_col') })),
			sn(nil, fmt('ON {}', i(1, 'expr'))),
		}),
	})),

	s({trig = 'gb', desc = 'GROUP BY'}, {
		c(1, {
			sn(nil, fmt('GROUP BY {}', i(1, 'cols'))),
			sn(nil, fmt([[
				GROUP BY {}
				HAVING {}
			]], { i(1, 'cols'), i(2, 'expr') })),
		}),
	}),

	s({trig = 'ob', desc = 'ORDER BY'}, {
		c(1, {
			sn(nil, fmt('ORDER BY {}', i(1, 'expr'))),
			sn(nil, fmt('ORDER BY {} DESC', i(1, 'expr'))),
		}),
	}),

	-- DML

	s({trig = 'wh', desc = 'WHERE ...'}, fmt('WHERE {}', i(1, 'expr'))),

	s({trig = 'ins', desc = 'INSERT INTO'}, fmt([[
		INSERT INTO {}{}
		VALUES ({});
	]], {
		i(1, 'table'),
		c(2, {
			sn(nil, fmt(' ({})', i(1, 'cols'), { dedent = false })),
			t '',
		}),
		d(3, util.generate_insertnodes '%w+', ai[2][1]),
	})),

	s({trig = 'up', desc = 'UPDATE ... SET'}, fmt([[
		UPDATE {}
		SET {} = {}
		WHERE {};
	]], { i(1, 'table'), i(3, 'col'), i(4, 'expr'), i(2, 'expr') })),

	s({trig = 'set', desc = 'SET clause'}, fmt('SET {} = {}', { i(1, 'col'), i(2, 'expr') })),

	s({trig = 'del', desc = 'DELETE FROM ...'}, fmt([[
		DELETE FROM {}
		WHERE {};
	]], { i(1, 'table'), i(2, 'expr') })),

	-- DCL

	-- TODO: DCL

	-- TCL

	-- TODO: TCL
}, { -- Autosnippets
}
-- stylua: ignore end

-- vim: noet sta sw=2 ts=2 sts=-1
