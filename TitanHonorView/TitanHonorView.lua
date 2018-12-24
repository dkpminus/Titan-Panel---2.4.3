TITAN_HONORVIEW_ID = "HonorView";


TITAN_HONORVIEW_CFG = { };
TITAN_HONORVIEW_CFG["DISPLAY"] = { };
TITAN_HONORVIEW_CFG["DISPLAY"]["LifeTimeHonor"] = true;
TITAN_HONORVIEW_CFG["DISPLAY"]["TodayHonor"] = true;
TITAN_HONORVIEW_CFG["DISPLAY"]["YesterdayHonor"] = true;
TITAN_HONORVIEW_CFG["DISPLAY"]["RecentData"] = true;
TITAN_HONORVIEW_CFG["DISPLAY"]["CumulativeStats"] = true;
TITAN_HONORVIEW_CFG["DISPLAY"]["Warsong Gulch"] = true;
TITAN_HONORVIEW_CFG["DISPLAY"]["Arathi Basin"] = true;
TITAN_HONORVIEW_CFG["DISPLAY"]["Alterac Valley"] = true;
TITAN_HONORVIEW_CFG["DISPLAY"]["Eye of the Storm"] = true;

TITAN_HONORVIEW_DATA = { };
TITAN_HONORVIEW_DEBUG = false;

TITAN_HONORVIEW_PLAYER = nil;
TITAN_HONORVIEW_VARSLOADED = false;
TITAN_HONORVIEW_PENDINGUPDATE = false;

TITAN_HONORVIEW_CURRENT_BG	= "";
TITAN_HONORVIEW_CURRENT_BGQ		= { };

TITAN_HONORVIEW_BGS = { };
TITAN_HONORVIEW_BGS["Warsong Gulch"] = "WSG";
TITAN_HONORVIEW_BGS["Arathi Basin"] = "AB";
TITAN_HONORVIEW_BGS["Alterac Valley"] = "AV";
TITAN_HONORVIEW_BGS["Eye of the Storm"] = "EOS";

TITAN_HONORVIEW_QTIMERS	= { };
TITAN_HONORVIEW_BGTIME	=	{ };

TITAN_HONORVIEW_COLOR_RED = { r=0.8, g=0.43, b=0.19 };
TITAN_HONORVIEW_COLOR_BLUE = { r=0.23, g=0.35, b=0.98 };
TITAN_HONORVIEW_COLOR_GREY = { r=0.5, g=0.5, b=0.5 };

function TitanPanelHonorViewButton_OnLoad()

	this.registry = {
		id = TITAN_HONORVIEW_ID,
		builtIn = 0,
		version = 1.00,
		menuText = "HonorView",
		buttonTextFunction = "TitanPanelHonorViewButton_GetButtonText", 
		tooltipTitle ="Honor Summary", 
		tooltipTextFunction = "TitanPanelHonorViewButton_GetTooltipText", 
		frequency = 1,
		iconWidth = 16,
		savedVariables = {
			ShowLabelText = 1,
			ShowIcon = 1,
		}
	};	

 	this:RegisterEvent("PLAYER_LEAVING_WORLD");
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
	this:RegisterEvent("UPDATE_BATTLEFIELD_STATUS");
	this:RegisterEvent("UPDATE_BATTLEFIELD_SCORE");
	this:RegisterEvent("ITEM_PUSH");
	
end


function TitanPanelHonorViewButton_OnShow()
	TitanPanelHonorViewButton_SetIcon();
end

function TitanPanelHonorViewButton_OnEvent()

	if (event == "VARIABLES_LOADED") then
		TITAN_HONORVIEW_VARSLOADED = true;
		if (TITAN_HONORVIEW_PENDINGUPDATE) then
			TitanPanelHonorViewButton_GetPlayerName();
		end
	end

	if (event == "PLAYER_ENTERING_WORLD") then
		if(TITAN_HONORVIEW_DEBUG) then DEFAULT_CHAT_FRAME:AddMessage("PLAYER ENTERED WORLD."); end
		
		
		if (TITAN_HONORVIEW_VARSLOADED) then
			TitanPanelHonorViewButton_GetPlayerName();
		else
			TITAN_HONORVIEW_PENDINGUPDATE = true;
		end
	
		if (TITAN_HONORVIEW_CURRENT_MATCH) then
			local bgRunning = false;
			-- CHECKING IF THERE IS STILL A BATTLEFIELD RUNNING. (in case we did /console reloadui)
			for i=1, MAX_BATTLEFIELD_QUEUES do
				bgStatus, bgMapName, bgInstanceID, bgMinlevel, bgMaxlevel, bgTeamSize = GetBattlefieldStatus(i);
				if(bgInstanceID ~= 0) then
					if(TITAN_HONORVIEW_DEBUG) then DEFAULT_CHAT_FRAME:AddMessage("A battleground is still running. Setting bgRunning = true."); end
					bgRunning = true;
				end
			end
			
			if(not bgRunning or (bgRunning and TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].Calculated == false)) then
				-- PLAYER LEFT BATTLEGROUND
				if(TITAN_HONORVIEW_DEBUG) then DEFAULT_CHAT_FRAME:AddMessage("PLAYER LEFT/SWITCHED BATTLEGROUND:"); end
				
				matchData = TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH];
				
				matchData.EndTime = time();
				matchData.FieldTime = matchData.EndTime-matchData.StartTime;
				matchData.TotalMatchTime = matchData.FieldTime+matchData.TotalQueueTime;
				
				if(TITAN_HONORVIEW_DEBUG) then DEFAULT_CHAT_FRAME:AddMessage("EndTime="..matchData.EndTime.." - FieldTime="..matchData.FieldTime.." - TotalMatchTime="..matchData.TotalMatchTime.."."); end
				
				TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH] = matchData;
				TitanPanelHonorView_UpdateStats(TITAN_HONORVIEW_CURRENT_MATCH);
			  TITAN_HONORVIEW_CURRENT_MATCH = nil;
			end
			
		end

		local bgStatus, bgMapName, bgInstanceID, bgMinlevel, bgMaxlevel, bgTeamSize;
		
		for i=1, MAX_BATTLEFIELD_QUEUES do
			
			bgStatus, bgMapName, bgInstanceID, bgMinlevel, bgMaxlevel, bgTeamSize = GetBattlefieldStatus(i);
			
			if(bgInstanceID ~= 0) then
				-- PLAYER ENTERING BATTLEGROUND
				TITAN_HONORVIEW_CURRENT_BG = bgInstanceID;
				local _, hp = GetPVPSessionStats();
				
				TITAN_HONORVIEW_CURRENT_MATCH = table.getn(TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"])+1;
				TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH] = { MatchType = bgMapName, StartHonor = hp, Calculated = false, StartTime = time(), TotalQueueTime = time()-TITAN_HONORVIEW_QTIMERS[i], HonorFromKills = 0, KillingBlows = 0, Deaths = 0, BonusHonor = 0, TotalHonor = 0, HonorKills = 0 };
				TITAN_HONORVIEW_QTIMERS[i] = nil;
				
				if(TITAN_HONORVIEW_DEBUG) then 
					tMatchData = TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH];
					DEFAULT_CHAT_FRAME:AddMessage("PLAYER ENTERED BATTLEGROUND:"); 
					DEFAULT_CHAT_FRAME:AddMessage("bgMapName="..bgMapName.." - bgInstanceID="..bgInstanceID.." - bgStatus="..bgStatus.." - bgMinLevel="..bgMinlevel.." - bgMaxLevel"..bgMaxlevel.." - bgTeamSize="..bgTeamSize.."."); 
					DEFAULT_CHAT_FRAME:AddMessage("MATCH DATA:"); 
					DEFAULT_CHAT_FRAME:AddMessage("MatchType="..tMatchData.MatchType.." - StartHonor="..tMatchData.StartHonor.." - Calculated="..tMatchData.Calculated.." - StartTime="..tMatchData.StartTime.." - TotalQueueTime="..tMatchData.TotalQueueTime.."."); 
				end

				RequestBattlefieldScoreData();
				
			end
					
		end
					
	end
	
	if(event == "UPDATE_BATTLEFIELD_STATUS") then
		for i=1, MAX_BATTLEFIELD_QUEUES do
			
			bgStatus, bgMapName, bgInstanceID, bgMinlevel, bgMaxlevel, bgTeamSize = GetBattlefieldStatus(i);
			
			if(bgStatus == "queued") then
				-- PLAYER JUST WENT INTO QUEUE FOR A BATTLEGROUND
				
				if(TITAN_HONORVIEW_QTIMERS ~= nil and TITAN_HONORVIEW_QTIMERS[i] == nil) then
					TITAN_HONORVIEW_QTIMERS[i] = time();
				end
				if(TITAN_HONORVIEW_DEBUG) then 
					DEFAULT_CHAT_FRAME:AddMessage("PLAYER ENTERED BATTLEGROUND QUEUE:");
					DEFAULT_CHAT_FRAME:AddMessage("bgMapName="..bgMapName.." - bgInstanceID="..bgInstanceID.." - QTIMER="..TITAN_HONORVIEW_QTIMERS[i]..".");
				end

			end
			
			if(bgStatus == "none") then
				if(TITAN_HONORVIEW_QTIMERS[i] ~= nil) then
					TITAN_HONORVIEW_QTIMERS[i] = nil;
				end
			end
			
		end

	end
	
	if(event == "CHAT_MSG_COMBAT_HONOR_GAIN") then
		if(TITAN_HONORVIEW_DEBUG) then DEFAULT_CHAT_FRAME:AddMessage("CHAT_MSG_COMBAT_HONOR_GAIN:"); end
		RequestBattlefieldScoreData();
		TitanPanelHonorView_UpdateMatches(TITAN_HONORVIEW_DEBUG);
	end
	
	if(event == "UPDATE_BATTLEFIELD_SCORE") then
		if(TITAN_HONORVIEW_DEBUG) then DEFAULT_CHAT_FRAME:AddMessage("UPDATE_BATTLEFIELD_SCORE:"); end
		TitanPanelHonorView_UpdateMatches(TITAN_HONORVIEW_DEBUG);
	end
	
	if(TITAN_HONORVIEW_CURRENT_MATCH ~= nil and GetBattlefieldWinner() ~= nil) then
		--DEFAULT_CHAT_FRAME:AddMessage("Battleground ended, found a winner: "..GetBattlefieldWinner());
		TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].Winner = GetBattlefieldWinner();
		TitanPanelHonorView_UpdateMatches(TITAN_HONORVIEW_DEBUG);
	end
	
	TitanPanelButton_UpdateButton(TITAN_HONORVIEW_ID);
	
end


function TitanPanelHonorViewButton_OnClick(button)

end



function TitanPanelHonorViewButton_GetButtonText(id)
	TitanPanelHonorView_UpdateMatches();
	local Text;
	local hk, hp = GetPVPSessionStats();
	local hc = GetHonorCurrency();
	
	if(TITAN_HONORVIEW_CURRENT_MATCH == nil) then
		Text = format("%s  %s: %s  %s: %s", TitanUtils_GetGreenText(hc), TITAN_HONORVIEW_HK, TitanUtils_GetHighlightText(hk), TITAN_HONORVIEW_HP, TitanUtils_GetHighlightText(hp));
	else
		local mInfo = TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH];
		if(mInfo.HonorKills == nil) then
			mInfo.HonorKills = 0;
		end
		if(mInfo.TotalHonor == nil) then
			mInfo.TotalHonor = 0;
		end
		
		Text = format("%s  %s: %s/%s  %s: %s/%s", TitanUtils_GetGreenText(hc), TITAN_HONORVIEW_HK,  TitanUtils_GetHighlightText(mInfo.HonorKills), TitanUtils_GetHighlightText(hk), TITAN_HONORVIEW_HP, TitanUtils_GetHighlightText(mInfo.TotalHonor), TitanUtils_GetHighlightText(hp));	
	end
	
	return Text;
end

function TitanPanelHonorViewButton_GetTooltipText()
	TitanPanelHonorView_UpdateMatches();
	local DisplayText = "\n";
	
	-- DISPLAYING REGULAR HONOR INFORMATION	
	local hCurrency = GetHonorCurrency();
	local tKills, tPoints = GetPVPSessionStats();
	local yKills, yPoints = GetPVPYesterdayStats();
	local lKills = GetPVPLifetimeStats();
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["LifeTimeHonor"]) then 
		DisplayText = DisplayText .. TitanUtils_GetHighlightText(TITAN_HONORVIEW_LIFETIME .. ":") .. "\n";		
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HCURRENCY .. ":\t" .. TitanUtils_GetHighlightText(GetHonorCurrency()) .. " \n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HKILLS .. ":\t" .. TitanUtils_GetHighlightText(lKills) .. " \n";
	end
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["TodayHonor"]) then 
		DisplayText = DisplayText .. TitanUtils_GetHighlightText(TITAN_HONORVIEW_TODAY .. ":") .. "\n";		
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HKILLS .. ":\t" .. TitanUtils_GetHighlightText("~"..tKills) .. " \n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HPOINTS .. ":\t" .. TitanUtils_GetHighlightText("~"..tPoints) .. " \n";
	end
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["YesterdayHonor"]) then 
		DisplayText = DisplayText .. TitanUtils_GetHighlightText(TITAN_HONORVIEW_YESTERDAY .. ":") .. "\n";		
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HKILLS .. ":\t" .. TitanUtils_GetHighlightText(yKills) .. " \n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HPOINTS .. ":\t" .. TitanUtils_GetHighlightText(yPoints) .. " \n";
	end
	
	-- DISPLAYING CURRENT BATTLEGROUND DATA IF CURRENTLY IN A BATTLEGROUND
	if(TITAN_HONORVIEW_CURRENT_MATCH) then
		mInfo = TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH];
		DisplayText = DisplayText .. TitanUtils_GetHighlightText(TITAN_HONORVIEW_BGCURRENT .. ":") .. " \n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_KBLOWS .. ":\t" .. TitanUtils_GetHighlightText(mInfo.KillingBlows) .. " \n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_DEATHS .. ":\t" .. TitanUtils_GetHighlightText(mInfo.Deaths) .. " \n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HKILLS .. ":\t " .. TitanUtils_GetHighlightText(mInfo.HonorKills) .. " \n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HPOINTS .. ":\t" .. TitanUtils_GetHighlightText("~"..mInfo.HonorFromKills) .. " \n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HBONUS .. ":\t" .. TitanUtils_GetHighlightText(mInfo.BonusHonor) .. " \n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HTOTAL .. ":\t" .. TitanUtils_GetHighlightText(mInfo.TotalHonor) .. " \n";
	end
	
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["RecentData"]) then 
		
		-- DISPLAYING 5 LAST BATTLEGROUND MATCHES IF ANY
		local matchCount = table.getn(TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"]);
		local dMatches = 0;
		if(TITAN_HONORVIEW_CURRENT_MATCH ~= nil) then
			matchCount = matchCount-1;
		end
		if(matchCount > 0) then
			
			if(matchCount <= 5) then
				dMatches = matchCount;
			else 
				dMatches = 5;
			end
			
			if(matchCount > 0) then
				DisplayText = DisplayText .. TitanUtils_GetHighlightText(TITAN_HONORVIEW_BGRECENT .. " (" .. dMatches .. "/" .. matchCount .. "):") .. "\n";		
			end
		end
		
		for mIndex=matchCount, matchCount-(dMatches-1), -1 do
			if(mIndex ~= TITAN_HONORVIEW_CURRENT_MATCH) then
				mInfo = TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][mIndex];
				if(mInfo ~= nil and mInfo.TotalHonor ~= nil) then
					local matchText = mInfo.MatchType;
					if(mInfo.Winner == 0) then
						matchText = TitanUtils_GetColoredText(mInfo.MatchType, TITAN_HONORVIEW_COLOR_RED);
					elseif(mInfo.Winner == 1) then
						matchText = TitanUtils_GetColoredText(mInfo.MatchType, TITAN_HONORVIEW_COLOR_BLUE);
					else
						matchText = TitanUtils_GetColoredText(mInfo.MatchType, TITAN_HONORVIEW_COLOR_GREY);
					end
					
					DisplayText = DisplayText .. "  " .. matchText;
					DisplayText = DisplayText .. "\t " .. TitanUtils_GetHighlightText(mInfo.HonorKills) .. "Hk";
					DisplayText = DisplayText .. " " .. TitanUtils_GetHighlightText("~"..mInfo.HonorFromKills) .. "Hp";
					DisplayText = DisplayText .. " " .. TitanUtils_GetHighlightText(mInfo.BonusHonor) .. "Hb";
					DisplayText = DisplayText .. " " .. TitanUtils_GetHighlightText(mInfo.TotalHonor) .. "Ht";
					DisplayText = DisplayText .. "\n";
				end
			end
		end
	end
	
	-- COMPUTING TOTAL HONOR CUMULATED IN ALL THREE BGS
	local CumulatedBGHonor=0;
	local CumulatedMatches=0;
	local CumulatedWins=0;
	local CumulatedQueueTime=0;
	local CumulatedBgTime=0;
	
	for bgName, bgStats in pairs(TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGSTATS"]) do
		if(bgStats ~= nil and bgStats.TotalMatches ~= nil) then
			CumulatedBGHonor = CumulatedBGHonor+bgStats.TotalHonor;
			CumulatedMatches = CumulatedMatches+bgStats.TotalMatches;
			CumulatedWins = CumulatedWins+bgStats.TotalWins;
			CumulatedQueueTime = CumulatedQueueTime+bgStats.TotalQueueTime;
			CumulatedBgTime = CumulatedBgTime+bgStats.TotalBgTime;
		end
	end
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["CumulativeStats"] and CumulatedMatches ~= nil and CumulatedMatches > 0) then 
		DisplayText = DisplayText .. TitanUtils_GetHighlightText(TITAN_HONORVIEW_CUMULATIVE_STATS) .. "\n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_MATCHESWON .. ":\t" .. TitanUtils_GetHighlightText(CumulatedWins.."/"..CumulatedMatches.." ("..math.round((100*CumulatedWins)/CumulatedMatches, 1).."%)") .. "\n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HAVERAGES .. ":\t" .. TitanUtils_GetHighlightText(math.round(CumulatedBGHonor/CumulatedMatches, 0) .. "avg (".. math.round((CumulatedBGHonor*3600)/CumulatedBgTime, 0) .."/h)").."\n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_AVGQUEUE .. ":\t" .. TitanUtils_GetHighlightText(TitanPanelHonorView_GetTimeDisplay(math.round(CumulatedQueueTime/CumulatedMatches, 0))) .. "\n";
		DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_PLAYTIME .. ":\t" .. TitanUtils_GetHighlightText(TitanPanelHonorView_GetTimeDisplay(CumulatedBgTime)) .. "\n";
	end
	
	-- DISPLAYING BATTLEGROUND STATS IF ANY
	for bgName, bgStats in pairs(TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGSTATS"]) do
		
		if(TITAN_HONORVIEW_CFG["DISPLAY"][bgName]) then 
			if(bgStats ~= nil and bgStats.TotalMatches ~= nil) then
		
				DisplayText = DisplayText .. TitanUtils_GetHighlightText(bgName .. TITAN_HONORVIEW_STATS) .. "\n";
				DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_MATCHESWON .. ":\t" .. TitanUtils_GetHighlightText(bgStats.TotalWins.."/"..bgStats.TotalMatches.." ("..math.round((100*bgStats.TotalWins)/bgStats.TotalMatches, 1).."%)") .. "\n";
				DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HAVERAGES .. ":\t" .. TitanUtils_GetHighlightText(math.round(bgStats.TotalHonor/bgStats.TotalMatches, 0) .. "avg (".. math.round((bgStats.TotalHonor*3600)/bgStats.TotalBgTime, 0) .."/h)").."\n";
				--DisplayText = DisplayText .. " " .. TITAN_HONORVIEW_HAVERAGES.. ":\t" .. TitanUtils_GetHighlightText() .. "\n";
				DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_HTOTAL .. ":\t" .. TitanUtils_GetHighlightText(bgStats.TotalHonor.."/"..CumulatedBGHonor.." ("..math.round((100*bgStats.TotalHonor)/CumulatedBGHonor).."%)") .. "\n";
				DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_AVGQUEUE .. ":\t" .. TitanUtils_GetHighlightText(TitanPanelHonorView_GetTimeDisplay(math.round(bgStats.TotalQueueTime/bgStats.TotalMatches, 0))) .. "\n";
				DisplayText = DisplayText .. "  " .. TITAN_HONORVIEW_PLAYTIME .. ":\t" .. TitanUtils_GetHighlightText(TitanPanelHonorView_GetTimeDisplay(bgStats.TotalBgTime)) .. "\n";
				
			
			end	
			
		end
	
	end
	
	TitanPanelButton_UpdateButton(TITAN_HONORVIEW_ID);		
	return DisplayText;
end

function TitanPanelRightClickMenu_PrepareHonorViewMenu()
	TitanPanelRightClickMenu_AddTitle(TitanPlugins[TITAN_HONORVIEW_ID].menuText);
	TitanPanelRightClickMenu_AddToggleIcon(TITAN_HONORVIEW_ID);

	TitanPanelRightClickMenu_AddSpacer();

  local info = {};
  info.text = TITAN_HONORVIEW_MENU_SHOW_LIFETIME;
  info.func = TitanPanelHonorViewButton_ShowLifetimeHonor;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_CFG["DISPLAY"]["LifeTimeHonor"];
  UIDropDownMenu_AddButton(info);
	
  local info = {};
  info.text = TITAN_HONORVIEW_MENU_SHOW_TODAY;
  info.func = TitanPanelHonorViewButton_ShowTodayHonor;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_CFG["DISPLAY"]["TodayHonor"];
  UIDropDownMenu_AddButton(info);

  local info = {};
  info.text = TITAN_HONORVIEW_MENU_SHOW_YESTERDAY;
  info.func = TitanPanelHonorViewButton_ShowYesterdayHonor;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_CFG["DISPLAY"]["YesterdayHonor"];
  UIDropDownMenu_AddButton(info);

  local info = {};
  info.text = TITAN_HONORVIEW_MENU_SHOW_RECENTDATA;
  info.func = TitanPanelHonorViewButton_ShowRecentData;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_CFG["DISPLAY"]["RecentData"];
  UIDropDownMenu_AddButton(info);

  local info = {};
  info.text = TITAN_HONORVIEW_MENU_SHOW_CUMULATIVESTATS;
  info.func = TitanPanelHonorViewButton_ShowCumulativeStats;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_CFG["DISPLAY"]["CumulativeStats"];
  UIDropDownMenu_AddButton(info);

  local info = {};
  info.text = TITAN_HONORVIEW_MENU_SHOW_WSGSTATS;
  info.func = TitanPanelHonorViewButton_ShowWSGStats;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_CFG["DISPLAY"]["Warsong Gulch"];
  UIDropDownMenu_AddButton(info);

  local info = {};
  info.text = TITAN_HONORVIEW_MENU_SHOW_ABSTATS;
  info.func = TitanPanelHonorViewButton_ShowABStats;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_CFG["DISPLAY"]["Arathi Basin"];
  UIDropDownMenu_AddButton(info);

  local info = {};
  info.text = TITAN_HONORVIEW_MENU_SHOW_AVSTATS;
  info.func = TitanPanelHonorViewButton_ShowAVStats;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_CFG["DISPLAY"]["Alterac Valley"];
  UIDropDownMenu_AddButton(info);

  local info = {};
  info.text = TITAN_HONORVIEW_MENU_SHOW_EOSSTATS;
  info.func = TitanPanelHonorViewButton_ShowEOSStats;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_CFG["DISPLAY"]["Eye of the Storm"];
  UIDropDownMenu_AddButton(info);

	TitanPanelRightClickMenu_AddSpacer();
	TitanPanelRightClickMenu_AddCommand(TITAN_HONORVIEW_MENU_RESET_MATCHLIST, TITAN_HONORVIEW_ID , "TitanPanelHonorViewButton_ResetMatchList");
	TitanPanelRightClickMenu_AddCommand(TITAN_HONORVIEW_MENU_RESET_BGSTATS, TITAN_HONORVIEW_ID , "TitanPanelHonorViewButton_ResetBGStats");
	TitanPanelRightClickMenu_AddCommand(TITAN_HONORVIEW_MENU_RESET_ALL, TITAN_HONORVIEW_ID , "TitanPanelHonorViewButton_ResetStats");
	
	TitanPanelRightClickMenu_AddSpacer();	
	
  local info = {};
  info.text = TITAN_HONORVIEW_MENU_DEBUG;
  info.func = TitanPanelHonorViewButton_EnableDebug;
	info.keepShownOnClick = 1;
  info.checked = TITAN_HONORVIEW_DEBUG;
  UIDropDownMenu_AddButton(info);
  
	TitanPanelRightClickMenu_AddCommand(TITAN_PANEL_MENU_HIDE, TITAN_HONORVIEW_ID, TITAN_PANEL_MENU_FUNC_HIDE);
end

function TitanPanelHonorViewButton_ResetStats()

	TitanPanelHonorView_InitializeStats();

end

function TitanPanelHonorView_InitializeStats()
	TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER] = {};
	
	TitanPanelHonorViewButton_ResetBGStats();
	TitanPanelHonorViewButton_ResetMatchList();
	
end

function TitanPanelHonorViewButton_ResetBGStats()
		
	TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGSTATS"] = { };
	
	for bgAbbrev in pairs(TITAN_HONORVIEW_BGS) do
		TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGSTATS"][bgAbbrev] = { };
	end
	
end

function TitanPanelHonorViewButton_ResetMatchList()
	TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"] = { };
end

-- FUNCTION THAT GETS THE PLAYER INFO.
function TitanPanelHonorViewButton_GetPlayerName()
	local pname;

	pname = UnitName("player");
	if (pname and pname ~= UNKNOWNOBJECT and pname ~= UKNOWNBEING and pname ~= "Unknown Entity") then
		TitanPanelHonorViewButton_Login();
	end
end

-- FUNCTION THAT INITALIZES ALL PLAYER INFO.
function TitanPanelHonorViewButton_Login()

	TITAN_HONORVIEW_PLAYER = UnitName("player").." "..GetCVar("realmName");

	-- Check if player data is available and creates new entry if not.
	if (not TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]) then
		--DEFAULT_CHAT_FRAME:AddMessage("Player data not found. Creating new data template...");
	
		TitanPanelHonorView_InitializeStats();
	end
	
	
end

function TitanPanelHonorView_UpdateMatches(debug)
	
	if(TITAN_HONORVIEW_CURRENT_MATCH ~= nil) then
		for i=1, GetNumBattlefieldScores() do
			local pName = GetBattlefieldScore(i);
			
			if(pName ~= nil) then
				if(string.find(pName, UnitName("player"), 1, true)) then
					_, killingBlows, honorKills, deaths, honorGained = GetBattlefieldScore(i);
					local _, hp = GetPVPSessionStats();
					
					if(TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH] and hp ~= 0) then
						--DEFAULT_CHAT_FRAME:AddMessage("Match data available: HP:"..hp.." SH:"..TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].StartHonor);
						TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].KillingBlows = killingBlows;
						TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].HonorKills = honorKills;
						TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].Deaths = deaths;
						TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].BonusHonor = honorGained;
						TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].TotalHonor = hp-TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].StartHonor;
						TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].HonorFromKills = TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].TotalHonor-TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].BonusHonor;
						--DEFAULT_CHAT_FRAME:AddMessage("Match data computed: HP:"..TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH].TotalHonor);
						
						if(debug) then 
							tMatchData = TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][TITAN_HONORVIEW_CURRENT_MATCH];
							DEFAULT_CHAT_FRAME:AddMessage("KillingBlows="..tMatchData.KillingBlows.." - HonorKills="..tMatchData.HonorKills.." - Deaths="..tMatchData.Deaths.." - BonusHonor="..tMatchData.BonusHonor.." - TotalHonor="..tMatchData.TotalHonor.." - HonorFromKills="..tMatchData.HonorFromKills..".");
							DEFAULT_CHAT_FRAME:AddMessage("Match data updated.");
						end
						
					end
					
					break;
				end
			end
			
		end
	end
	
end

function TitanPanelHonorView_UpdateStats(matchNum)
	if(matchNum ~= nil) then
		local pFaction;
		if(UnitFactionGroup("player") == "Horde") then
			pFaction = 0;
		elseif(UnitFactionGroup("player") == "Alliance") then
			pFaction = 1;
		end
		
		if(TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][matchNum]) then 
			cStats = TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGSTATS"][TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][matchNum].MatchType];
			cMatch = TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][matchNum];
			
			if(cStats.TotalMatches == nil) then
				cStats = { TotalMatches = 0, TotalHonor = 0, TotalKillingBlows = 0, TotalDeaths = 0, TotalHonorableKills = 0, TotalBgTime = 0, TotalWins = 0, Calculated = false, TotalQueueTime = 0 };
			end
			
			cStats.TotalMatches = cStats.TotalMatches+1;
			
			cStats.TotalHonor					= cStats.TotalHonor+cMatch.TotalHonor;
			cStats.TotalKillingBlows	= cStats.TotalKillingBlows+cMatch.KillingBlows;
			cStats.TotalDeaths				= cStats.TotalDeaths+cMatch.Deaths;
			cStats.TotalHonorableKills				= cStats.TotalHonorableKills+cMatch.HonorKills;
			cStats.TotalBgTime				= cStats.TotalBgTime+cMatch.TotalMatchTime;
			cStats.TotalQueueTime			= cStats.TotalQueueTime+cMatch.TotalQueueTime;
			cStats.Calculated				= true;
			
			if(pFaction == cMatch.Winner) then
				cStats.TotalWins = cStats.TotalWins+1;
			end
			
		
			TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGSTATS"][TITAN_HONORVIEW_DATA[TITAN_HONORVIEW_PLAYER]["BGMATCHES"][matchNum].MatchType] = cStats;
			
			if(TITAN_HONORVIEW_DEBUG) then 
				DEFAULT_CHAT_FRAME:AddMessage("TotalHonor="..cStats.TotalHonor.." - TotalKillingBlows="..cStats.TotalKillingBlows.." - TotalDeaths="..cStats.TotalDeaths.." - TotalHonorableKills="..cStats.TotalHonorableKills.." - TotalBgTime="..cStats.TotalBgTime.." - TotalQueueTime="..cStats.TotalQueueTime.." - Calculated="..string.format("%d", cStats.Calculated)..".");
				DEFAULT_CHAT_FRAME:AddMessage("Stats data updated.");
			end
			
		end
	end

end

function math.round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num  * mult + 0.5) / mult
end

function TitanPanelHonorView_GetTimeDisplay(time)
	local hours, minutes, seconds;
	local TimeDisplay="";
	
	if(time-3600<0) then
		hours = 0;
	else
		hours = math.floor(time/3600);
	end
	
	if(time>(hours*3600)) then
		minutes = math.floor((time-(hours*3600))/60);
	else
		minutes = 0;
	end
	
	if(time>(hours*3600)+(minutes*60)) then
		seconds = time-(hours*3600)-(minutes*60);
	else
		seconds = 0;	
	end
	
	if(hours ~= 0) then
		TimeDisplay = TimeDisplay..hours.."h ";
	end
	
	if(minutes ~= 0) then
		TimeDisplay = TimeDisplay..minutes.."m ";
	end
	
	if(seconds ~= 0) then
		TimeDisplay = TimeDisplay..seconds.."s";
	end
	
	return TimeDisplay;

end

function TitanPanelHonorViewButton_SetIcon()
	local icon = TitanPanelHonorViewButtonIcon;
	local factionGroup, factionName = UnitFactionGroup("player");	

	if ( factionGroup == "Alliance" ) then
		icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-Alliance");
		icon:SetTexCoord(0.046875, 0.609375, 0.03125, 0.59375);
	elseif ( factionGroup == "Horde" ) then
		icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-Horde");
		icon:SetTexCoord(0.046875, 0.609375, 0.015625, 0.578125);
	else
		icon:SetTexture("Interface\\TargetingFrame\\UI-PVP-FFA");
		icon:SetTexCoord(0.046875, 0.609375, 0.03125, 0.59375);
	end
end

function TitanPanelHonorViewButton_ShowLifetimeHonor()
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["LifeTimeHonor"]) then
		TITAN_HONORVIEW_CFG["DISPLAY"]["LifeTimeHonor"] = false;
	else
		TITAN_HONORVIEW_CFG["DISPLAY"]["LifeTimeHonor"] = true;	
	end

end

function TitanPanelHonorViewButton_ShowTodayHonor()
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["TodayHonor"]) then
		TITAN_HONORVIEW_CFG["DISPLAY"]["TodayHonor"] = false;
	else
		TITAN_HONORVIEW_CFG["DISPLAY"]["TodayHonor"] = true;	
	end

end

function TitanPanelHonorViewButton_ShowYesterdayHonor()
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["YesterdayHonor"]) then
		TITAN_HONORVIEW_CFG["DISPLAY"]["YesterdayHonor"] = false;
	else
		TITAN_HONORVIEW_CFG["DISPLAY"]["YesterdayHonor"] = true;	
	end

end

function TitanPanelHonorViewButton_ShowRecentData()
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["RecentData"]) then
		TITAN_HONORVIEW_CFG["DISPLAY"]["RecentData"] = false;
	else
		TITAN_HONORVIEW_CFG["DISPLAY"]["RecentData"] = true;	
	end

end

function TitanPanelHonorViewButton_ShowCumulativeStats()
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["CumulativeStats"]) then
		TITAN_HONORVIEW_CFG["DISPLAY"]["CumulativeStats"] = false;
	else
		TITAN_HONORVIEW_CFG["DISPLAY"]["CumulativeStats"] = true;	
	end

end

function TitanPanelHonorViewButton_ShowWSGStats()
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["Warsong Gulch"]) then
		TITAN_HONORVIEW_CFG["DISPLAY"]["Warsong Gulch"] = false;
	else
		TITAN_HONORVIEW_CFG["DISPLAY"]["Warsong Gulch"] = true;	
	end

end

function TitanPanelHonorViewButton_ShowABStats()
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["Arathi Basin"]) then
		TITAN_HONORVIEW_CFG["DISPLAY"]["Arathi Basin"] = false;
	else
		TITAN_HONORVIEW_CFG["DISPLAY"]["Arathi Basin"] = true;	
	end

end

function TitanPanelHonorViewButton_ShowAVStats()
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["Alterac Valley"]) then
		TITAN_HONORVIEW_CFG["DISPLAY"]["Alterac Valley"] = false;
	else
		TITAN_HONORVIEW_CFG["DISPLAY"]["Alterac Valley"] = true;	
	end

end

function TitanPanelHonorViewButton_ShowEOSStats()
	
	if(TITAN_HONORVIEW_CFG["DISPLAY"]["Eye of the Storm"]) then
		TITAN_HONORVIEW_CFG["DISPLAY"]["Eye of the Storm"] = false;
	else
		TITAN_HONORVIEW_CFG["DISPLAY"]["Eye of the Storm"] = true;	
	end

end

function TitanPanelHonorViewButton_EnableDebug()
	
	if(TITAN_HONORVIEW_DEBUG) then
		TITAN_HONORVIEW_DEBUG = false;
	else
		TITAN_HONORVIEW_DEBUG = true;	
	end

end