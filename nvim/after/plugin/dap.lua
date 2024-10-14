  local dap = require('dap')
  dap.adapters.python = {
    type = 'executable';
    command = 'python';
    args = { '-m', 'debugpy.adapter' };
  }

  -- Set the log level to DEBUG
dap.set_log_level('DEBUG')

-- Specify the log file path
vim.fn.mkdir(vim.fn.stdpath('data') .. '/dap_logs', 'p')
local log_path = vim.fn.stdpath('data') .. '/dap_logs/dap.log'
dap.defaults.fallback.terminal_win_cmd = '20vsplit new'
dap.defaults.fallback.external_terminal = {
  command = 'alacritty';
  args = {'-e'};
}
dap.defaults.fallback.logging = true
dap.defaults.fallback.log_output = log_path

dap.configurations.python = {
	{
		type = 'python';
		request = 'launch';
		name = "Launch file";
		program = "${file}";
		pythonPath = 'python';
		cwd = "/";
		console = "integratedTerminal";
	},
	{
        type = 'python',
        request = 'launch',
        name = 'Launch Flask',
        program = "${file}",
        pythonPath = function()
            return '/usr/bin/python'  -- or your Python path
        end,
        args = {
            "run",
            "--no-debugger",
            "--no-reload"
        },
        env = {
            FLASK_APP = "main.py",  -- or your Flask app entry point
        },
        justMyCode = true,
    },
        {
            name= 'flask ubuntu',
            type= 'python',
            request= 'launch',
            module= 'flask',
	    pythonPath = function()
        	    local cwd = vim.fn.getcwd()
            	if vim.fn.executable(cwd .. '/venv37/bin/python') == 1 then
               	 return cwd .. '/venv37/bin/python'
            	else
                	return '/usr/bin/python'
            	end
       		end,
	    env = {
            	FLASK_APP = "app/main_actual.py",
            	FLASK_ENV = "development",
            	ATOOL_OIDC_CERT_ENDPOINT = "https://lemur-9.cloud-iam.com/auth/realms/atool/protocol/openid-connect/certs",
            	ATOOL_OIDC_CHECK_AUDIENCE = "account",
            	ATOOL_OIDC_ISSUER = "",
            	ATOOL_LANGUAGES = "de",
            	ATOOL_PATTERN_START = "Beschwerdeentscheid|Zwischenverfügung|Décision|Zwischenentscheid",
		ATOOL_PATTERN_END = "Bildungs- und Kulturdirektion|la directrice|Direction del'instruction||Direction de l'instruction",
		ATOOL_PATTERN_BESETZUNG = "Besetzung\\s*\\t+[\\r\\n\\S ]*\\t",
		ATOOL_PATTERN_UNTERSCHRIFTENBLOCK = "(\\tBildungs- und Kulturdirektion\\r|La directrice de l(’|`)instruction publique et de la culture\\t)(.+)$",
		ATOOL_ADR_BLOCKS = "1",
		ATOOL_PATTERN_W16START = "'^(.+?)(Beschwerdeentscheid|Zwischenverfügung|Décision|Zwischenentscheid)'",
		ATOOL_SEPARATE_HOUSENUMBERS = "1",
		ATOOL_REMOVE_TITLES = "1"
        	},
	 	args= {
                "run",
                "--cert",
                "/home/bk/certs/localhost.crt",
                "--key",
                "/home/bk/certs/localhost.key"
		},
		justMyCode = true,

        },
    }
-- Funktion zum Laden der launch.json
local function load_launchjs()
  local cwd = vim.fn.getcwd()
  require('dap.ext.vscode').load_launchjs(cwd .. '/.vscode/launch.json', { node2 = { 'javascript', 'typescript' } })
end

-- Adapter konfigurieren
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {os.getenv('HOME') .. '/.npm-global/lib/node_modules/vscode-node-debug2/out/src/nodeDebug.js'},
}

-- Automatisches Laden der launch.json beim Starten von Neovim
vim.cmd [[autocmd BufEnter,BufReadPost *.js,*.ts lua load_launchjs()]]



dap.configurations.javascript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

dap.configurations.typescript = {
  {
    name = 'Launch',
    type = 'node2',
    request = 'launch',
    program = '${workspaceFolder}/dist/${fileBasenameNoExtension}.js',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
    outFiles = {'${workspaceFolder}/dist/**/*.js'},
  },
}
require('telescope').load_extension('dap')
vim.api.nvim_set_keymap('n', '<leader>db', '<cmd>Telescope dap list_breakpoints<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dc', '<cmd>Telescope dap commands<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dv', '<cmd>Telescope dap variables<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>df', '<cmd>Telescope dap frames<CR>', { noremap = true, silent = true })
local dapui = require('dapui')

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	 dapui.open()
end
--dap.listeners.before.event_terminated.dapui_config = function()
--  dapui.close()
--end
--dap.listeners.before.event_exited.dapui_config = function()
--  dapui.close()
--end

dapui.setup()
