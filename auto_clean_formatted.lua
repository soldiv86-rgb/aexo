if not game:IsLoaded()then
    game["Loaded"]:Wait()
end
print("[Exo] #Load")local S = {["Config"] = {["Version"] = "loader_1.0.0",["AuthUrl"] = "https://exotichub.app/loader/auth",["ScriptUrl"] = "https://exotichub.app/loader/script";
["UiUrl"] = "https://exotichub.app/live_mskmb7a2p8dj.lua";
["DiscordUrl"] = "https://discord.com/invite/v8g6tGJSGb";
["FreeKeyUrl"] = "https://exotichub.app/getnewkeyads";
["Root"] = "exotichub99",["Cache"] = "exotichub99/cache",["UiFile"] = "exotichub99/cache/exoui.lua";
["UiVersionFile"] = "exotichub99/cache/exoui.version";
["DeviceFile"] = "exotichub99/device.json";
["LegacyProFile"] = "780ad941-1694-4f37-8e81-2fd6cde9785b.d";
["AuthRetries"] = 7,["ScriptRetries"] = 3;
["RetryDelay"] = 1.25,["Heartbeat"] = 15};
["Services"] = {["HttpService"] = game:GetService("HttpService"),["Players"] = game:GetService("Players");
["UserInputService"] = game:GetService("UserInputService");
["StarterGui"] = game:GetService("StarterGui"),["LocalPlayer"] = nil};
["State"] = {["Key"] = "",["KeyType"] = "auto",["AuthFile"] = "";
["DeviceId"] = "",["Platform"] = "Unknown",["Headless"] = false,["FromGlobalKey"] = false;
["Authenticated"] = false;
["Premium"] = false;
["ExpiresAt"] = nil,["UiVersion"] = "";
["UiUrl"] = "",["ScriptToken"] = nil;
["Library"] = nil;
["Window"] = nil,["LoginTab"] = nil;
["LoginGroup"] = nil,["LoginStatus"] = nil;
["AccountAdded"] = false;
["AccountExpiryLabel"] = nil;
["LoginBusy"] = false,["ScriptLoaded"] = false,["HeartbeatRunning"] = false;
["Revoked"] = false;
["Resets"] = {}},["File"] = {},["Device"] = {};
["Net"] = {};
["Auth"] = {};
["UI"] = {},["Script"] = {};
["Security"] = {};
["Public"] = {}}S["Services"]["HttpService"] = game:GetService("HttpService")S["Services"]["Players"] = game:GetService("Players")S["Services"]["UserInputService"] = game:GetService("UserInputService")S["Services"]["StarterGui"] = game:GetService("StarterGui")S["Services"]["LocalPlayer"] = S["Services"]["Players"]["LocalPlayer"]S["Env"] = type(getgenv) == "function" and getgenv() or _G S["File"]["HasFS"] = function ()
    return type(isfile) == "function" and(type(readfile) == "function" and type(writefile) == "function")
end
S["File"]["EnsureFolders"] = function ()
    if type(isfolder) ~= "function" or type(makefolder) ~= "function" then
        return false
    end
    return pcall(function ()
        if not isfolder(S["Config"]["Root"])then
            makefolder(S["Config"]["Root"])
        end
        if not isfolder(S["Config"]["Cache"])then
            makefolder(S["Config"]["Cache"])
        end
    end
    )
end
S["File"]["Read"] = function (J)
    if type(J) ~= "string" or J == "" or not S["File"]["HasFS"]() or not isfile(J)then
        return nil
    end
    local z, N = pcall(readfile, J)return z and(type(N) == "string" and N) or nil
end
S["File"]["Write"] = function (J, z)
    if type(J) ~= "string" or J == "" or type(z) ~= "string" or not S["File"]["HasFS"]()then
        return false
    end
    S["File"]["EnsureFolders"]()local N = pcall(writefile, J, z)return N
end
S["File"]["Delete"] = function (S)
    if type(S) ~= "string" or S == "" or type(isfile) ~= "function" or type(delfile) ~= "function" then
        return false
    end
    if not isfile(S)then
        return true
    end
    local J = pcall(delfile, S)return J
end
S["File"]["AuthPaths"] = function ()
    local J = S["Services"]["LocalPlayer"] and S["Services"]["LocalPlayer"]["UserId"] or 0 return{"exologin.json";
    tostring(J) .. "_exologin.json"}
end
S["File"]["LoadAuth"] = function ()
    for J, z in ipairs(S["File"]["AuthPaths"]())do
        local N = S["File"]["Read"](z)if N and N ~= "" then
            local J, f = pcall(S["Services"]["HttpService"]["JSONDecode"], S["Services"]["HttpService"], N)local p = J and(type(f) == "table" and((f["token"] or f["key"]))) or nil if type(p) == "string" and p:gsub("%s+", "") ~= "" then
                S["State"]["AuthFile"] = z return tostring(f["type"] or f["key_type"] or "auto"), p
            end
        end
    end
    local J = S["File"]["AuthPaths"]()S["State"]["AuthFile"] = type(isfile) == "function" and(isfile(J[1]) and J[1]) or J[2]return nil, nil
end
S["File"]["SaveAuth"] = function (J, z)
    z = S["Auth"]["CleanKey"](z)if z == "" then
        return false
    end
    local N = S["State"]["AuthFile"]if N == "" then
        local J = S["File"]["AuthPaths"]()N = type(isfile) == "function" and(isfile(J[1]) and J[1]) or J[2]S["State"]["AuthFile"] = N
    end
    local f, p = pcall(S["Services"]["HttpService"]["JSONEncode"], S["Services"]["HttpService"], {["type"] = tostring(J or "auto");
    ["token"] = z})return f and S["File"]["Write"](N, p)
end
S["File"]["ClearAuth"] = function ()
    for J, z in ipairs(S["File"]["AuthPaths"]())do
        S["File"]["Delete"](z)
    end
    S["File"]["Delete"]("asa3323saasas.json")
end
S["Device"]["GetPlatform"] = function ()
    local J = S["Services"]["UserInputService"]if J["TouchEnabled"]then
        return "Mobile"
    end
    if J["GamepadEnabled"] and not J["KeyboardEnabled"]then
        return "Console"
    end
    return "PC"
end
S["Device"]["GetExecutorId"] = function ()
    local J = {["a"] = S["Env"]["gethwid"];
    ["b"] = S["Env"]["get_hwid"],["c"] = type(syn) == "table" and syn["get_hwid"] or nil}for S, J in pairs(J)do
        if type(J) == "function" then
            local S, z = pcall(J)z = S and tostring(z or "") or "" if#z >= 8 and(z ~= "unknown" and z ~= "nil")then
                return z
            end
        end
    end
    return nil
end
S["Device"]["Get"] = function ()
    local J = S["Device"]["GetExecutorId"]()if J then
        return J
    end
    local z = S["File"]["Read"](S["Config"]["DeviceFile"])if z then
        local J, N = pcall(S["Services"]["HttpService"]["JSONDecode"], S["Services"]["HttpService"], z)local f = J and(type(N) == "table" and N["device_id"]) or nil if type(f) == "string" and #f >= 8 then
            return f
        end
    end
    local N = S["Services"]["HttpService"]:GenerateGUID(false)local f, p = pcall(S["Services"]["HttpService"]["JSONEncode"], S["Services"]["HttpService"], {["device_id"] = N})if f then
        S["File"]["Write"](S["Config"]["DeviceFile"], p)
    end
    return N
end
S["Net"]["RequestFunction"] = function ()
    return type(syn) == "table" and syn["request"] or type(http) == "table" and http["request"] or http_request or request or type(fluxus) == "table" and fluxus["request"] or type(krnl) == "table" and krnl["request"]
end
S["Net"]["Post"] = function (J, z, N)
    if type(J) ~= "string" or J == "" then
        return false, 0, "", "Invalid URL"
    end
    local f = {["Content-Type"] = "application/json"}if type(N) == "string" and N ~= "" then
        f["Authorization"] = "Bearer " .. N
    end
    local p = "" if type(z) == "table" then
        local J, N = pcall(S["Services"]["HttpService"]["JSONEncode"], S["Services"]["HttpService"], z)if not J then
            return false, 0, "", "Failed to encode request"
        end
        p = N
    end
    local E = S["Net"]["RequestFunction"]()local M, Y = pcall(function ()
        if type(E) == "function" then
            return E({["Url"] = J,["Method"] = "POST",["Headers"] = f,["Body"] = p})
        end
        return S["Services"]["HttpService"]:RequestAsync({["Url"] = J,["Method"] = "POST";
        ["Headers"] = f;
        ["Body"] = p})
    end
    )if not M or type(Y) ~= "table" then
        return false, 0, "", tostring(Y or "Request failed")
    end
    local B = tonumber(Y["StatusCode"] or Y["Status"] or Y["status_code"]) or 0 local r = Y["Body"] or Y["body"] or "" r = type(r) == "string" and r or tostring(r or "")if B == 0 and r ~= "" then
        B = 200
    end
    return true, B, r, nil
end
S["Net"]["Decode"] = function (J)
    if type(J) ~= "string" or J == "" then
        return nil
    end
    local z, N = pcall(S["Services"]["HttpService"]["JSONDecode"], S["Services"]["HttpService"], J)return z and(type(N) == "table" and N) or nil
end
S["Net"]["IsTemporary"] = function (S)
    S = tonumber(S) or 0 return S == 0 or S == 408 or S == 425 or S == 429 or S >= 500
end
S["Auth"]["CleanKey"] = function (S)
    return(tostring(S or "")):gsub("%s+", "")
end
S["Auth"]["Payload"] = function (J, z, N)
    local f = S["Services"]["LocalPlayer"]return{["type"] = tostring(N or "auto"),["xkey"] = S["Auth"]["CleanKey"](z),["userid"] = f and f["UserId"] or 0;
    ["uname"] = f and f["Name"] or "";
    ["d_id"] = S["State"]["DeviceId"];
    ["platform"] = S["State"]["Platform"];
    ["game_id"] = game["GameId"];
    ["action"] = tostring(J or "login"),["place_id"] = game["PlaceId"]}
end
S["Auth"]["Apply"] = function (J, z)
    local N = type(J["ui"]) == "table" and J["ui"] or nil local f = J["ui_version"] or N and N["version"]local p = J["ui_url"] or N and N["url"]if type(f) == "string" and f ~= "" then
        S["State"]["UiVersion"] = f
    end
    if type(p) == "string" and p ~= "" then
        S["State"]["UiUrl"] = p
    end
    S["State"]["ExpiresAt"] = J["key_expires_at"] or J["expires_at"] or S["State"]["ExpiresAt"]S["State"]["Premium"] = J["pro"] == true or J["premium"] == true if z == "login" then
        local z = J["script_token"] or J["session_token"]S["State"]["ScriptToken"] = type(z) == "string" and(z ~= "" and z) or nil
    end
end
S["Auth"]["ResponseType"] = function (S, J)
    if type(S) == "table" then
        if S["pro"] == true or S["premium"] == true then
            return "pro"
        end
        local J = S["key_type"] or S["type"] or S["method"]if type(J) == "string" and J ~= "" then
            return J
        end
    end
    J = tostring(J or "auto")return J ~= "" and(J ~= "auto" and J) or "lootlabs"
end
S["Auth"]["CheckOnce"] = function (J, z, N)
    local f, p, E, M = S["Net"]["Post"](S["Config"]["AuthUrl"], S["Auth"]["Payload"](J, z, N))if not f then
        return false, M or "Request failed", true, nil
    end
    local Y = S["Net"]["Decode"](E)if type(Y) ~= "table" then
        return false, "Invalid server response", S["Net"]["IsTemporary"](p), nil
    end
    S["Auth"]["Apply"](Y, J)if S["Net"]["IsTemporary"](p)then
        return false, Y["msg"] or Y["message"] or "Server unavailable", true, nil
    end
    if Y["success"] == true then
        if J == "login" and not S["State"]["ScriptToken"]then
            return false, "Missing script token", true, nil
        end
        S["State"]["Authenticated"] = true return true, nil, false, Y
    end
    return false, tostring(Y["msg"] or Y["message"] or Y["code"] or "Authentication failed"), false, Y
end
S["Auth"]["Check"] = function (J, z, N)
    local f = "Request failed" for p = 1, S["Config"]["AuthRetries"], 1 do
        local E, M, Y, B = S["Auth"]["CheckOnce"](J, z, N)if E then
            return true, nil, B
        end
        f = M or f if not Y then
            return false, f, B
        end
        if p < S["Config"]["AuthRetries"]then
            task["wait"](S["Config"]["RetryDelay"] * p)
        end
    end
    return false, f, nil
end
S["Auth"]["Login"] = function (J, z, N)
    J = S["Auth"]["CleanKey"](J)z = tostring(z or "auto")local f, p, E = S["Auth"]["Check"]("login", J, z)if not f then
        S["State"]["Authenticated"] = false return false, p, E
    end
    S["State"]["Key"] = J S["State"]["KeyType"] = S["Auth"]["ResponseType"](E, z)if N then
        S["File"]["SaveAuth"](S["State"]["KeyType"], S["State"]["Key"])
    end
    return true, nil, E
end
S["Auth"]["StartHeartbeat"] = function ()
    if S["State"]["HeartbeatRunning"] or not S["State"]["Authenticated"]then
        return
    end
    S["State"]["HeartbeatRunning"] = true task["spawn"](function ()
        while S["State"]["HeartbeatRunning"] and S["State"]["Authenticated"]do
            task["wait"](S["Config"]["Heartbeat"])if not S["State"]["HeartbeatRunning"] or not S["State"]["Authenticated"]then
                break
            end
            local J = S["State"]["Premium"]local z, N, f = S["Auth"]["Check"]("heartbeat", S["State"]["Key"], S["State"]["KeyType"])if z then
                S["UI"]["UpdateExpiryLabel"]()if J and not S["State"]["Premium"]then
                    S["Security"]["RunResets"]("Premium access ended")
                end
            elseif type(f) == "table" then
                S["Security"]["Revoke"](N or "Access revoked")break
            end
        end
    end
    )
end
S["UI"]["Notify"] = function (J, z)
    J = tostring(J or "")if J == "" then
        return
    end
    if S["State"]["Library"] and type(S["State"]["Library"]["Notify"]) == "function" then
        pcall(function ()
            S["State"]["Library"]:Notify(J, tonumber(z) or 3)
        end
        )return
    end
    pcall(function ()
        S["Services"]["StarterGui"]:SetCore("SendNotification", {["Title"] = "Exotic Hub",["Text"] = J;
        ["Duration"] = tonumber(z) or 3})
    end
    )
end
S["UI"]["Copy"] = function (J)
    if type(setclipboard) == "function" then
        setclipboard(tostring(J or ""))S["UI"]["Notify"]("Link copied to clipboard", 3)return true
    end
    if type(syn) == "table" and type(syn["set_clipboard"]) == "function" then
        syn["set_clipboard"](tostring(J or ""))S["UI"]["Notify"]("Link copied to clipboard", 3)return true
    end
    S["UI"]["Notify"]("Clipboard is not supported", 3)return false
end
S["UI"]["RunSource"] = function (S)
    if type(S) ~= "string" or #S < 100 or type(loadstring) ~= "function" then
        warn("[EXO UI] Invalid source or loadstring unavailable")return nil
    end
    local J, z = loadstring(S)if type(J) ~= "function" then
        warn("[EXO UI] Compile failed: " .. tostring(z))return nil
    end
    local N, f = pcall(J)if not N then
        warn("[EXO UI] Startup failed: " .. tostring(f))return nil
    end
    return f
end
S["UI"]["Load"] = function ()
    if S["State"]["Headless"]then
        return true
    end
    local J = tostring(S["State"]["UiVersion"] or "")local z = S["State"]["UiUrl"] ~= "" and S["State"]["UiUrl"] or S["Config"]["UiUrl"]if J == "" then
        return false, "Server did not return UI version"
    end
    S["File"]["EnsureFolders"]()if S["File"]["Read"](S["Config"]["UiVersionFile"]) == J then
        local J = S["UI"]["RunSource"](S["File"]["Read"](S["Config"]["UiFile"]))if J then
            S["State"]["Library"] = J S["Public"]["Library"] = J return true
        end
    end
    local N = "?" if z:find("?", 1, true)then
        N = "&"
    end
    local f = z ..(N ..("version=" .. J))local p, E = pcall(function ()
        return game:HttpGet(f, true)
    end
    )if not p then
        warn("[EXO UI] Download failed: " .. tostring(E))
    end
    local M = p and S["UI"]["RunSource"](E) or nil if not M then
        return false, "Failed to load UI"
    end
    S["File"]["Write"](S["Config"]["UiFile"], E)S["File"]["Write"](S["Config"]["UiVersionFile"], J)S["State"]["Library"] = M S["Public"]["Library"] = M return true
end
S["UI"]["CreateWindow"] = function ()
    if S["State"]["Headless"] or S["State"]["Window"]then
        return true
    end
    local J = S["State"]["Library"]if not J or type(J["CreateWindow"]) ~= "function" then
        return false
    end
    local z, N = pcall(function ()
        return J:CreateWindow({["Title"] = S["State"]["Premium"] and "<font color='#FFFFFF'>Exotic Hub</font> <font color='#FF00C8'>PRO</font>" or "Exotic Hub",["Footer"] = "exotichub.app/join",["ToggleKeybind"] = Enum["KeyCode"]["RightControl"],["Center"] = true,["ShowCustomCursor"] = false,["AutoShow"] = S["State"]["AutoShow"]})
    end
    )if not z or not N then
        return false
    end
    S["State"]["Window"] = N S["Public"]["Window"] = N return true
end
S["UI"]["ExpiryText"] = function ()
    local J = tonumber(S["State"]["ExpiresAt"])if not J then
        return "Key expiry is not available"
    end
    if J > 100000000000 then
        J = math["floor"](J / 1000)
    end
    local z = math["floor"](J - os["time"]())if z <= 0 then
        return "Key expired"
    end
    local N = math["floor"](z / 86400)local f = math["floor"](((z % 86400)) / 3600)local p = math["floor"](((z % 3600)) / 60)local E = {}if N > 0 then
        table["insert"](E, N ..((N == 1 and " day" or " days")))
    end
    if f > 0 then
        table["insert"](E, f ..((f == 1 and " hour" or " hours")))
    end
    if p > 0 then
        table["insert"](E, p .. " min")
    end
    if#E == 0 then
        table["insert"](E, z .. " sec")
    end
    return "Key expires in " .. table["concat"](E, " ")
end
S["UI"]["UpdateExpiryLabel"] = function ()
    local J = S["State"]["AccountExpiryLabel"]if J and type(J["SetText"]) == "function" then
        J:SetText(S["UI"]["ExpiryText"]())
    end
end
S["UI"]["AddAccount"] = function ()
    if S["State"]["Headless"] or S["State"]["AccountAdded"] or not S["State"]["Window"]then
        return
    end
    local J = S["State"]["LoginTab"]if J then
        if J["TabLabel"]then
            J["TabLabel"]["Text"] = "Account"
        end
        if S["State"]["LoginGroup"] and S["State"]["LoginGroup"]["BoxHolder"]then
            S["State"]["LoginGroup"]["BoxHolder"]["Visible"] = false
        end
    else J = S["State"]["Window"]:AddTab({["Name"] = "Account";
    ["Description"] = "Exotic Hub account";
    ["Icon"] = "circle-user-round"})
end
if not J then
    return
end
local z = J:AddLeftGroupbox("Account", "circle-user-round", false)local N = J:AddRightGroupbox("Logout", "circle-user-round")if N then
    N:AddButton({["Text"] = "<font color='#FF5555'>Logout</font>";
    ["Func"] = function ()
        local J = S["State"]["Library"]if not J or type(J["Confirm"]) ~= "function" then
            return
        end
        J:Confirm({["Title"] = "Logout?";
        ["Description"] = "This will clear your saved key and remove you from the game.",["Risky"] = true;
        ["Callback"] = function (J)
            if J then
                S["Security"]["Logout"]()
            end
        end
        })
    end
    })
end
if z then
    S["State"]["AccountExpiryLabel"] = z:AddLabel({["Text"] = S["UI"]["ExpiryText"]();
    ["DoesWrap"] = true})z:AddButton({["Text"] = "Join Discord",["Func"] = function ()
        S["UI"]["Copy"](S["Config"]["DiscordUrl"])
    end
    })
end
S["State"]["AccountAdded"] = true
end
S["UI"]["SetStatus"] = function (J)
    if S["State"]["LoginStatus"] and type(S["State"]["LoginStatus"]["SetText"]) == "function" then
        S["State"]["LoginStatus"]:SetText(tostring(J or ""))
    end
end
S["UI"]["ShowLogin"] = function (J)
    if S["State"]["Headless"] or not S["State"]["Window"]then
        return false
    end
    local z = S["State"]["Window"]:AddTab({["Name"] = "Key System",["Description"] = "Enter your Exotic Hub key",["Icon"] = "key-round"})local N = z and z:AddLeftGroupbox("Key Entry", "key-round", false) or nil if not N then
        return false
    end
    S["State"]["LoginTab"] = z S["State"]["LoginGroup"] = N N:AddInput("exo_loader_key_input", {["Text"] = "Access Key";
    ["Default"] = S["State"]["Key"],["Numeric"] = false,["AllowEmpty"] = true;
    ["Finished"] = false;
    ["ClearTextOnFocus"] = false;
    ["Tooltip"] = "Enter your Exotic Hub key.";
    ["Placeholder"] = "Enter key"})S["State"]["LoginStatus"] = N:AddLabel({["Text"] = tostring(J or "Enter your key to continue.");
    ["DoesWrap"] = true})N:AddButton({["Text"] = "Login";
    ["Func"] = function ()
        if S["State"]["LoginBusy"]then
            return
        end
        S["State"]["LoginBusy"] = true S["UI"]["SetStatus"]("Checking key...")task["spawn"](function ()
            local J = S["State"]["Library"] and S["State"]["Library"]["Options"]local z = J and J["exo_loader_key_input"]local N, f = S["Auth"]["Login"](z and z["Value"] or "", "auto", true)if not N then
                S["UI"]["SetStatus"]("\226\157\140 " .. tostring(f or "Login failed"))S["State"]["LoginBusy"] = false return
            end
            S["UI"]["SetStatus"]("\226\156\133 Key accepted. Loading script...")local p, E = S["Script"]["Load"]()if not p then
                S["UI"]["SetStatus"]("\226\157\140 " .. tostring(E or "Script failed to load"))S["State"]["LoginBusy"] = false return
            end
            S["UI"]["AddAccount"]()S["Auth"]["StartHeartbeat"]()S["State"]["LoginBusy"] = false
        end
        )
    end
    })N:AddButton({["Text"] = "Get Free Key";
    ["Func"] = function ()
        S["UI"]["Copy"](S["Config"]["FreeKeyUrl"])
    end
    })N:AddButton({["Text"] = "Join Discord";
    ["Func"] = function ()
        S["UI"]["Copy"](S["Config"]["DiscordUrl"])
    end
    })return true
end
S["Script"]["Fetch"] = function (J)
    if type(J) ~= "string" or J == "" then
        return false, "Missing script token", true
    end
    local z, N, f, p = S["Net"]["Post"](S["Config"]["ScriptUrl"], nil, J)if not z then
        return false, p or "Script request failed", true
    end
    if N == 401 or N == 403 or N == 409 or N == 410 then
        local J = S["Net"]["Decode"](f)return false, J and((J["msg"] or J["message"] or J["code"])) or "Script token rejected", true
    end
    if S["Net"]["IsTemporary"](N)then
        return false, "Script server unavailable", true
    end
    if N < 200 or N >= 300 then
        local J = S["Net"]["Decode"](f)return false, J and((J["msg"] or J["message"] or J["code"])) or "Script request rejected", false
    end
    local E = f:match("^%s*{") and S["Net"]["Decode"](f) or nil if E and E["success"] == false then
        return false, E["msg"] or E["message"] or E["code"] or "Script request failed", true
    end
    if type(f) ~= "string" or #f < 50 then
        return false, "Script response was empty", true
    end
    local M, Y = loadstring(f)if type(M) ~= "function" then
        return false, "Script compile failed: " .. tostring(Y), true
    end
    return true, M, false
end
S["Script"]["FreshToken"] = function ()
    return S["Auth"]["Login"](S["State"]["Key"], S["State"]["KeyType"], false)
end
S["Script"]["Load"] = function ()
    if S["State"]["ScriptLoaded"]then
        return true
    end
    local J = "Failed to download script" for z = 1, S["Config"]["ScriptRetries"], 1 do
        local N = S["State"]["ScriptToken"]S["State"]["ScriptToken"] = nil if type(N) ~= "string" or N == "" then
            local z, f = S["Script"]["FreshToken"]()if not z then
                return false, f or J
            end
            N = S["State"]["ScriptToken"]S["State"]["ScriptToken"] = nil
        end
        local f, p, E = S["Script"]["Fetch"](N)if f then
            if S["State"]["Premium"]then
                S["File"]["Write"](S["Config"]["LegacyProFile"], "true")S["Env"]["exoprov"] = true _G["exoprov"] = true
            end
            local J, z = pcall(p, S["Public"])if not J then
                return false, "Script startup failed: " .. tostring(z)
            end
            S["State"]["ScriptLoaded"] = true return true
        end
        J = p or J if not E then
            return false, J
        end
        if z < S["Config"]["ScriptRetries"]then
            task["wait"](S["Config"]["RetryDelay"] * z)local N, f = S["Script"]["FreshToken"]()if not N then
                return false, f or J
            end
        end
    end
    return false, J
end
S["Security"]["RunResets"] = function (J)
    for S, z in ipairs(S["State"]["Resets"])do
        pcall(z, tostring(J or "Access ended"))
    end
end
S["Security"]["Revoke"] = function (J)
    if S["State"]["Revoked"]then
        return
    end
    S["State"]["Revoked"] = true S["State"]["Authenticated"] = false S["State"]["Premium"] = false S["State"]["HeartbeatRunning"] = false S["Security"]["RunResets"](J)S["File"]["ClearAuth"]()S["UI"]["Notify"](tostring(J or "Access revoked") .. ". Rejoin to continue.", 5)task["delay"](2, function ()
        if S["Services"]["LocalPlayer"]then
            S["Services"]["LocalPlayer"]:Kick(tostring(J or "Access revoked"))
        end
    end
    )
end
S["Security"]["Logout"] = function ()
    S["State"]["Authenticated"] = false S["State"]["Premium"] = false S["State"]["HeartbeatRunning"] = false S["Security"]["RunResets"]("Logged out")S["File"]["ClearAuth"]()S["File"]["Delete"](S["Config"]["LegacyProFile"])S["Env"]["__EXO_SHARED"] = nil S["UI"]["Notify"]("Logged out. Rejoin to use Exotic Hub again.", 5)task["delay"](2, function ()
        if S["Services"]["LocalPlayer"]then
            S["Services"]["LocalPlayer"]:Kick("Logged out. Rejoin to continue.")
        end
    end
    )
end
S["Public"]["IsPremium"] = function ()
    return S["State"]["Authenticated"] and S["State"]["Premium"]
end
S["Public"]["IsHeadless"] = function ()
    return S["State"]["Headless"]
end
S["Public"]["RegisterReset"] = function (J)
    if type(J) ~= "function" then
        return false
    end
    table["insert"](S["State"]["Resets"], J)return true
end
S["Public"]["Library"] = nil S["Public"]["Window"] = nil S["Run"] = function ()
    if type(S["Env"]["__EXO_SHARED"]) == "table" then
        warn("[EXO] Loader is already running")return
    end
    local J =(tostring(S["Env"]["mode"] or _G["mode"] or "")):lower()local z = S["Env"]["exo_key"] or _G["exo_key"]S["State"]["Headless"] = J == "noui" S["State"]["DeviceId"] = S["Device"]["Get"]()S["State"]["Platform"] = S["Device"]["GetPlatform"]()S["Env"]["exo_key"] = nil S["Env"]["mode"] = nil _G["exo_key"] = nil _G["mode"] = nil local N = S["Env"]["exo_autoshow"]S["Env"]["exo_autoshow"] = nil _G["exo_autoshow"] = nil S["State"]["AutoShow"] = N ~= false local f, p = S["File"]["LoadAuth"]()if type(z) == "string" and S["Auth"]["CleanKey"](z) ~= "" then
        S["State"]["Key"] = S["Auth"]["CleanKey"](z)S["State"]["KeyType"] = "auto" S["State"]["FromGlobalKey"] = true
    elseif p then
        S["State"]["Key"] = S["Auth"]["CleanKey"](p)S["State"]["KeyType"] = tostring(f or "auto")
    end
    local E, M, Y = S["Auth"]["Login"](S["State"]["Key"], S["State"]["KeyType"], not S["State"]["FromGlobalKey"] and S["State"]["Key"] ~= "")if S["State"]["Headless"]then
        if not E then
            local J = tostring(M or "Authentication failed")warn("[EXO] " .. J)if type(Y) == "table" and S["Services"]["LocalPlayer"]then
                S["Services"]["LocalPlayer"]:Kick("Exotic Hub: " .. J)
            end
            return
        end
        S["Env"]["__EXO_SHARED"] = S["Public"]local J, z = S["Script"]["Load"]()if not J then
            warn("[EXO] " .. tostring(z))return
        end
        S["Auth"]["StartHeartbeat"]()return
    end
    local B, r = S["UI"]["Load"]()if not B then
        warn("[EXO] " .. tostring(r))return
    end
    if not S["UI"]["CreateWindow"]()then
        warn("[EXO] Failed to create UI window")return
    end
    S["Env"]["__EXO_SHARED"] = S["Public"]if not E then
        S["UI"]["ShowLogin"](M)return
    end
    S["UI"]["AddAccount"]()local k, K = S["Script"]["Load"]()if not k then
        S["UI"]["Notify"](tostring(K), 6)warn("[EXO] " .. tostring(K))return
    end
    S["Auth"]["StartHeartbeat"]()
end
S["Run"]()
end
)(...)
