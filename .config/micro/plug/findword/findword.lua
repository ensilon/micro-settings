local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local util = import("micro/util")
local regexp = import("regexp")

function findUp(bp)
    if bp.Cursor:HasSelection() then
		bp:FindPrevious()
    else
        if not util.IsWordChar(util.RuneAt(bp.Buf:LineBytes(bp.Cursor.Y), bp.Cursor.X)) then
		    bp:Search()
        end
        bp.Cursor:SelectWord()
        local search = "\\b"..util.String(bp.Cursor:GetSelection()).."\\b"
		bp:Search(search, true, false)
		bp:FindPrevious()
    end
    return true
end

function findDown(bp)
    if bp.Cursor:HasSelection() then
		bp:FindNext()
    else
        if not util.IsWordChar(util.RuneAt(bp.Buf:LineBytes(bp.Cursor.Y), bp.Cursor.X)) then
            bp:Search()
        end
        bp.Cursor:SelectWord()
        local search = "\\b"..util.String(bp.Cursor:GetSelection()).."\\b"
		bp:Search(search, true, true)
    end
    return true
end

function init()
    config.TryBindKey("Ctrl-r", "lua:findword.findUp", true)
    config.TryBindKey("Ctrl-s", "lua:findword.findDown", true)
end
