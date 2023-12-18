# Neovim lspconfig 깔끔하게 관리하기

neovim `lspconfig`는 언어별 설정이 많아짐에 따라 라인 수가 너무 길어져서 점점 감당이 안되는 경향이있어요. 이번 포스트에서는 lspconfig를 깔끔하게 관리하는 방법에 대해서 알아보겠습니다.
<!--more-->

## 디렉토리 구조 
먼저, 디렉토리 구조는 다음과 같이 구성했습니다.
```
~/.config/nvim
├── init.lua
└── lua
    └── plugins
        └── lspconfig
            ├── common.lua
            ├── init.lua
            └── languages
                ├── cpp.lua
                └── typescript.lua
```

## 편집기 설정
`lspconfig/init.lua`  파일에서 `vim.diagnstic`, `vim.lsp.*` 관련 설정을 기록하고, `lspconfig/lanuages` 하위의 lua 설정 파일을 일괄적으로 불러오는 코드를 작성합니다.
```lua
-- ~/.config/nvim/lua/lspconfig/init.lua
vim.diagnostic.config({
  -- vim diagnostic config
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    update_in_insert = false,
  })

local config_dir = vim.fn.stdpath "config" .. "/lua/plugins/lspconfig/languages"
for _, file in ipairs(vim.fn.readdir(config_dir, [[v:val =~ '\.lua$']])) do
  require('plugins.lspconfig.languages.' .. file:gsub('%.lua$', ''))
end
```

## 공통 설정
`common.lua`에 공통적으로 사용할 녀석들을 만들어서 table에 담아 리턴해줍니다.
```lua
-- ~/.config/nvim/lua/lspconfig/common.lua
-- :help vim.lsp.diagnostic.on_publish_diagnostics
local on_attach = function(client, bufnr)
  -- Common settings like keymaps, autocmds
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
  on_attach = on_attach,
  capabilities = capabilities
}
```

## 언어별 설정
이제 `lspconfig/languages` 디렉토리에 언어별 설정을 분리해서 작성합니다. 아래는 `cpp`, `typescript`에 설정 대한 예시입니다.
```lua
-- languages/cpp.lua
local lspconfig = require("lspconfig")
local common = require("plugins.lspconfig.common")

-- clangd config
local capabilities = common.capabilities
capabilities.offsetEncoding = { "utf-16" } -- language specific capabilities

lspconfig.clangd.setup {
  filetypes = { "cpp" },
  cmd = {
    'clangd',
    '--header-insertion=never',
    '--query-driver=~/.config/assets/clangd/**', -- MacOS bits/stc++ 불러오기!
  },
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr) 
    -- language specific한 설정들을 아래에 추가할 수 있습니다.
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
}
```

```lua
-- lanuages/typescript.lua
local lspconfig = require("lspconfig")
local common = require("plugins.lspconfig.common")

-- typescript config
lspconfig.tsserver.setup {
  capabilities = common.capabilities,
  on_attach = function(client, bufnr)
    common.on_attach(client, bufnr)
    -- prettier 사용할꺼니까 formatter 끄기!
    client.server_capabilities.documentFormattingProvider = false
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
  end,
  cmd = {
    'typescript-language-server',
    '--stdio',
  }
}
```

## 플러그인 매니저 설정
이제 마지막으로 플러그인 설정에 다음과 같이 입력하면 끝!
```lua
  -- other plugins ..
  {
    'neovim/nvim-lspconfig',
    config = function() require('plugins.lspconfig') end,
    dependencies = {
      -- 의존성들
    }
  },
  -- other plugins ..
```


