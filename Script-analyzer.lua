--[[
Basic httpspy with logger analyzer that can block malicious requests from a domain you provide in Global.BlockedDomains

This was totally not made by me (SOULS) and i probably don't know who made this or else i would've gave them credits.
]]

local plr = game:GetService("Players").LocalPlayer

local placeid = game.PlaceId

local executor = identifyexecutor or getexecutor or getexecutorname
local userid = plr.UserId

executor = (type(executor) == "function" and executor()) or "Unknown"

local wwwjobid = game.JobId

local ins = table.insert
local rem = table.remove

-- you can add any malicious stuff but use the same protocol e.g "nigga.net";
_G.BlockedDomains  = _G.BlockedDomains or {
    -- Webhooks
    
    "discord.com/api/webhooks/";
    "webhook";
    "hypernite";
    "https://websec.services"; --used in luaU loggers (roblox studio scripts)
    "websec.services";
    "websec.services/ws/send/";   --webhook secure system so block it.
    "websec.services/ws/send";
    "websec.services/ws";
    "schervi.wtf";  -- exposed scammer website ( psx )
    "schervi.wtf/Pogchamp.lua";
    "schervi.wtf/";
    "schervi.wtf/Pogchamp";
    "discord";
    "https://story-of-jesus.xyz/";
    "roblox.com/Thumbs/Avatar.ashx?x=150&y=150&Format=Png&username="; --roblox avatar link
    "roblox.com/Thumbs/Avatar";
    "roblox.com/users/";
    "roblox.com/users";
    "roblox.com";
    "webhook.site/";
    "webhook.site";
    
    -- Server hosters
    
    "000webhost";
    "freehosting";
    "repl";
    "000webhostapp";

    -- Identifier websites
    "wtfismyip.com";
    "ident.me";
    "api.ipify.org";
    "api.ipify.org/";
    "story-of-jesus.xyz/";
    "ipify.org";
    "hypernite.xyz";
    "hypernite.xyz/";
    "hypernite.xyz/ScriptProject";
    "screenshare.pics/";
    "myprivate.pics/"; --// :fire:
    "noodshare.pics/";
    "cheapcinema.club/";
    "libsodium-wrappers";
    "iplocation.com";
    "ip-tracker.org/";
    "infosniper.net";
    "partpicker.shop/";
    "sportshub.bar/";
    "dyndns.org";
    "locations.quest/";
    "lovebird.guru/";
    "trulove.guru/";
    "dateing.club/";
    "shrekis.life/";
    "headshot.monster/";
    "gaming-at-my.best/";
    "progaming.monster/";
    "yourmy.monster/";
    "imageshare.best/";
    "screenshot.best/";
    "gamingfun.me/";
    "catsnthings.com/";
    "catsnthings.fun/";
    "joinmy.site/";
    "fortnitechat.site/";
    "fortnight.space/";
    "stopify.co/";
    "leancoding.co/";
    "checkip.amazonaws.com";
    "httpbin.org/ip";
    "ifconfig.io";
    "ipaddress.sh";
    "myip.com";
    "discord.com";
    "iplogger.org";
    "2no.co";
    "bit.ly/";
    "yip.su";
    "iplis.ru";
    "catsnthing.com";
    "ps3cfw.com/";
    "opentracker.net";
    "iplocation.net";
    "ip-tracker.org";
    "grabify.link/";
    "gg.gg/";
    "shorte.st/";
    "adf.ly/";
    "bc.v/";
    "soo.gd/";
    "adfoc.us/";
    "ouo.io/";
    "zzb.bz/";
    "goo.gl/";
    "grabify.link";
    "blasze.com";
    
    
    -- KFC obfuscator
    
    "ligma.wtf";
    "library.veryverybored";
}
_G.BlockedContent = _G.BlockedContent or {
    plr.Name;
    placeid;
    executor;
    wwwjobid;
    userid;
    
}

--// HTTPSpy and creds to who made it
local function rprint(color, msg) 
    rconsoleprint("@@"..color.."@@")
    rconsoleprint(msg)
end

do
    rconsoleclear()
    rprint("BLUE",[[
---------------------------------------------
   __ __ ______ ______ ___    ____          
  / // //_  __//_  __// _ \  / __/___  __ __
 / _  /  / /    / /  / ___/ _\ \ / _ \/ // /
/_//_/  /_/    /_/  /_/    /___// .__/\_, / 
                               /_/   /___/  
---------------------------------------------
]])
    
    rconsoleprint("@@LIGHT_MAGENTA@@")
    rprint("LIGHT_MAGENTA", "Made by topit, Enhanced by Heroic Satchel#5306, ENJOY!  \nUpdated 10/27/2022\n")
end

do
        local ncs = {"HttpGet","HttpPost","HttpGetAsync","HttpPostAsync","GetObjects"}
    
    rprint("LIGHT_BLUE","\n\nNamecalls hooked:")
    for i = 1, #ncs do 
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ":")
        rprint("YELLOW", ncs[i])    
    end
    
    for i = 1, #ncs do 
        ncs[ncs[i]] = true
    end
    
    
    
    local oldnc
    oldnc = hookmetamethod(game, "__namecall", function(a,b,...)
        local nc = getnamecallmethod()
        
        if ncs[nc] then

            if (nc:sub(1,7) == "HttpGet") then
                do
                    -- Check for blacklisted domains
                    local blocked = {}
                    for _,url in ipairs(_G.BlockedDomains) do
                        if b:match(url) then
                            ins(blocked, url)
                        end
                    end
                    
                    rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
                    rprint("LIGHT_RED", "game")
                    rprint("WHITE", ":")
                    rprint("YELLOW", nc)
                    
                    -- Log if blocked
                    rprint("LIGHT_CYAN", "\n    - Request blocked: ")
                    if (#blocked > 0) then
                        rprint("WHITE", "Yes")
                    else
                        rprint("WHITE", "No")
                    end
                    
                    rprint("LIGHT_CYAN", "\n    - URL: ")
                    rprint("WHITE", tostring(b))
                    
                    if (#blocked > 0) then 
                        rprint("LIGHT_RED", "\n    An attempt to make a request towards a possibly malicious site was made. Blacklisted content detected: \n")
                        
                        rconsoleprint("@@LIGHT_GRAY@@")
                        for i = 1, #blocked do
                            rconsoleprint("      - "..blocked[i].."\n")
                        end
                        return
                    end
                end
            elseif (nc:sub(1,8) == "HttpPost") then
                do
                    local blocked = {}
                    for _,url in ipairs(_G.BlockedDomains) do
                        if (b:match(url)) then
                            ins(blocked, url)
                        end
                    end
                    
                    local data = ...
                    for _, content in ipairs(_G.BlockedContent) do 
                        if (data:match(content)) then 
                            ins(blocked, content)
                        end
                    end
                    
                    rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
                    rprint("LIGHT_RED", "game")
                    rprint("WHITE", ":")
                    rprint("YELLOW", nc)
                    
                    rprint("LIGHT_CYAN", "\n    - Request blocked: ")
                    if (#blocked > 0) then
                        rprint("WHITE", "Yes")
                    else
                        rprint("WHITE", "No")
                    end
                    
                    rprint("LIGHT_CYAN", "\n    - URL: ")
                    rprint("WHITE", tostring(b))
                    
                    rprint("LIGHT_CYAN", "\n    - Data: ")
                    rprint("WHITE", tostring(data))
                    
                    if (#blocked > 0) then 
                        rprint("LIGHT_RED", "\n    An attempt to make a possibly malicious request was made. Blacklisted content detected: \n")
                        
                        rconsoleprint("@@LIGHT_GRAY@@")
                        for i = 1, #blocked do
                            rconsoleprint("      - "..blocked[i].."\n")
                        end
                        return
                    end
                end
            elseif (nc == "GetObjects") then
                do
                    rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
                    rprint("LIGHT_RED", "game")
                    rprint("WHITE", ":")
                    rprint("YELLOW", nc)
                    
                    rprint("LIGHT_CYAN", "\n    - Asset: ")
                    rprint("WHITE", tostring(b))
                    
                end 
            end
        end
        
        return oldnc(a,b,...) 
    end)
end

do 
    rprint("LIGHT_BLUE","\n\nFunctions hooked:")
    
    do
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "HttpGet")  
        
        local old
        old = hookfunction(game.HttpGet,function(a,b,...)
        
            local blocked = {}
            for _,url in ipairs(_G.BlockedDomains) do
                if b:match(url) then
                    ins(blocked, url)
                end
            end
            
            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ".")
            rprint("YELLOW", "HttpGet")
            
            rprint("LIGHT_CYAN", "\n    - Request blocked: ")
            if (#blocked > 0) then
                rprint("WHITE", "Yes")
            else
                rprint("WHITE", "No")
            end
            
            rprint("LIGHT_CYAN", "\n    - URL: ")
            rprint("WHITE", tostring(b))
            
            if (#blocked > 0) then 
                rprint("LIGHT_RED", "\n    An attempt to make a request towards a possibly malicious site was made. Blacklisted content detected: \n")
                
                rconsoleprint("@@LIGHT_GRAY@@")
                for i = 1, #blocked do
                    rconsoleprint("      - "..blocked[i].."\n")
                end
                return
            end
            return old(a,b,...)
        end)
    end
  
    do 
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "HttpGetAsync")  
        
        local old
        old = hookfunction(game.HttpGetAsync,function(a,b,...)
        
            local blocked = {}
            for _,url in ipairs(_G.BlockedDomains) do
                if b:match(url) then
                    ins(blocked, url)
                end
            end
            
            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ".")
            rprint("YELLOW", "HttpGetAsync")
            
            rprint("LIGHT_CYAN", "\n    - Request blocked: ")
            if (#blocked > 0) then
                rprint("WHITE", "Yes")
            else
                rprint("WHITE", "No")
            end
            
            rprint("LIGHT_CYAN", "\n    - URL: ")
            rprint("WHITE", tostring(b))
            
            if (#blocked > 0) then 
                rprint("LIGHT_RED", "\n    An attempt to make a request towards a possibly malicious site was made. Blacklisted content detected: \n")
                
                rconsoleprint("@@LIGHT_GRAY@@")
                for i = 1, #blocked do
                    rconsoleprint("      - "..blocked[i].."\n")
                end
                return
            end
            return old(a,b,...)
        end)
    end
  
    do 
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "HttpPost")  
        
        local old
        old = hookfunction(game.HttpPost, function(a,b,...)
            -- Check for blacklisted domains
            local blocked = {}
            for _,url in ipairs(_G.BlockedDomains) do
                if b:match(url) then
                    ins(blocked, url)
                end
            end
            
            local data = ...
            for _, content in ipairs(_G.BlockedContent) do 
                if (data:match(content)) then 
                    ins(blocked, content)
                end
            end
            
            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ".")
            rprint("YELLOW", "HttpPost")
            
            rprint("LIGHT_CYAN", "\n    - Request blocked: ")
            if (#blocked > 0) then
                rprint("WHITE", "Yes")
            else
                rprint("WHITE", "No")
            end
            
            rprint("LIGHT_CYAN", "\n    - URL: ")
            rprint("WHITE", tostring(b))
            
            rprint("LIGHT_CYAN", "\n    - Data: ")
            rprint("WHITE", tostring(data))
            
            if (#blocked > 0) then 
                rprint("LIGHT_RED", "\n    An attempt to make a possibly malicious request was made. Blacklisted content detected: \n")
                
                rconsoleprint("@@LIGHT_GRAY@@")
                for i = 1, #blocked do
                    rconsoleprint("      - "..blocked[i].."\n")
                end
                return
            end
            return old(a,b,...)
        end)
    end
  
    do 
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "HttpPostAsync")  
        
        local old
        old = hookfunction(game.HttpPostAsync, function(a,b,...)

            local blocked = {}
            for _,url in ipairs(_G.BlockedDomains) do
                if b:match(url) then
                    ins(blocked, url)
                end
            end
            

            local data = ...
            for _, content in ipairs(_G.BlockedContent) do 
                if (data:match(content)) then 
                    ins(blocked, content)
                end
            end
            

            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ".")
            rprint("YELLOW", "HttpPostAsync")
            

            rprint("LIGHT_CYAN", "\n    - Request blocked: ")
            if (#blocked > 0) then
                rprint("WHITE", "Yes")
            else
                rprint("WHITE", "No")
            end
            
    
            rprint("LIGHT_CYAN", "\n    - URL: ")
            rprint("WHITE", tostring(b))
            
            -- Data
            rprint("LIGHT_CYAN", "\n    - Data: ")
            rprint("WHITE", tostring(data))
            
            if (#blocked > 0) then 
                rprint("LIGHT_RED", "\n    An attempt to make a possibly malicious request was made. Blacklisted content detected: \n")
                
                rconsoleprint("@@LIGHT_GRAY@@")
                for i = 1, #blocked do
                    rconsoleprint("      - "..blocked[i].."\n")
                end
                return
            end
            return old(a,b,...)
        end)
    end

    do
        rprint("LIGHT_BLUE","\n => ")
        rprint("LIGHT_RED", "game")
        rprint("WHITE", ".")
        rprint("YELLOW", "GetObjects")  
        
        local old
        old = hookfunction(game.GetObjects, function(a,b,...)

            rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
            rprint("LIGHT_RED", "game")
            rprint("WHITE", ":")
            rprint("YELLOW", "GetObjects")

            rprint("LIGHT_CYAN", "\n    - Asset: ")
            rprint("WHITE", tostring(b))
            
            return old(a,b,...)
        end)
    end
end

do 
    local reqf = 
    ((type(syn) == "table" and type(syn.request) == "function") and syn.request) or 
    ((type(http) == "table" and type(http.request) == "function") and http.request) or
    ((type(fluxus) == "table" and type(fluxus.request) == "function") and fluxus.request) or 
    (http_request or request)
    
    
    if (reqf) then 
        local parent = (type(syn) == "table" and "syn") or (type("http") == "table" and "http") or (type(fluxus) == "table" and "fluxus")
        
        if (parent) then
            rprint("LIGHT_BLUE","\n => ")
            rprint("LIGHT_RED", parent)
            rprint("WHITE", ".")
            rprint("YELLOW", "request")  
        else
            rprint("LIGHT_BLUE","\n => ")
            rprint("YELLOW", request and "request" or http_request and "http_request") 
        end
        
        do 
            local old
            old = hookfunction(reqf, function(req,...)
                local r_url = req.Url
                local r_method = req.Method
                local r_body = req.Body
                
                local r_headers = req.Headers
                local r_cookies = req.Cookies
                
                
                local blocked = {}
                if (r_url) then 
                    for _,url in ipairs(_G.BlockedDomains) do
                        if r_url:match(url) then
                            ins(blocked, url)
                        end
                    end
                end
                
                if (r_body) then
                    for _, content in ipairs(_G.BlockedContent) do 
                        if (r_body:match(content)) then 
                            ins(blocked, content)
                        end
                    end
                end
                
                rprint("LIGHT_BLUE", "\n ["..os.date("%X").."] => ")
                if (parent) then
                    rprint("LIGHT_RED", parent)
                    rprint("WHITE", ".")
                end
                rprint("YELLOW", "request")
                
                rprint("LIGHT_CYAN", "\n    - Request blocked: ")
                if (#blocked > 0) then
                    rprint("WHITE", "Yes")
                else
                    rprint("WHITE", "No")
                end
                
                rprint("LIGHT_CYAN", "\n    - Request type: ")
                if (r_method) then 
                    rprint("WHITE", tostring(r_method))
                else
                    rprint("WHITE", 'GET')
                end
                
                rprint("LIGHT_CYAN", "\n    - URL: ")
                rprint("WHITE", tostring(r_url))
                
                rprint("LIGHT_CYAN", "\n    - Body: ")
                if (r_body) then 
                    rprint("WHITE", tostring(r_body))
                else
                    rprint("WHITE", 'N/A')
                end
                
                rprint("LIGHT_CYAN", "\n    - Headers: ")
                if (type(r_headers) == "table") then
                    for i,v in pairs(r_headers) do
                        if (type(v) == "table") then
                            for i,v in pairs(v) do
                                rprint("LIGHT_GRAY",  "\n        - "..i..": "..v)
                            end
                        else
                            rprint("LIGHT_GRAY",  "\n      - "..i..": "..v)
                        end
                    end
                else
                    rprint("WHITE", "N/A")
                end

                rprint("LIGHT_CYAN", "\n    - Cookies: ")
                if (type(r_cookies) == "table") then
                    for i,v in pairs(r_cookies) do
                        if (type(v) == "table") then
                            for i,v in pairs(v) do
                                rprint("LIGHT_GRAY",  "\n        - "..i..": "..v)
                            end
                        else
                            rprint("LIGHT_GRAY",  "\n      - "..i..": "..v)
                        end
                    end
                else
                    rprint("WHITE", "N/A")
                end
                
                if (#blocked > 0) then 
                    rprint("LIGHT_RED", "\n    An attempt to make a possibly malicious request was made. Blacklisted content detected: \n")
                    
                    rconsoleprint("@@LIGHT_GRAY@@")
                    for i = 1, #blocked do
                        rconsoleprint("      - "..blocked[i].."\n")
                    end
                    return
                end
                
                return old(req, ...)
            end)
        end
    end
end


rprint("LIGHT_BLUE","\n\nLogs:")
