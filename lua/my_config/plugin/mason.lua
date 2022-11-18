local M = {}

local install_pkgs = require("mason.api.command").MasonInstall
local is_installed = require("mason-registry").is_installed

function M.config(pkgs)
    local ensure_installed = pkgs.ensure_installed or {}
    local want_pkgs = {}

    for _, pkg in pairs(ensure_installed) do
        if not is_installed(pkg) then
            table.insert(want_pkgs, pkg)
        end
    end
    install_pkgs(want_pkgs)

end

return M
