
function TitanAggro_SelectTargeterOnUnit(unit)
	local mobName;
	local lastTarget = UnitName("target");
	local targetOk = nil;
	for j=1, 15 do
		TargetNearestEnemy();
		if (UnitIsUnit(unit, "targettarget")) then
			j = 21; --found
			targetOk = 1;
		end
	end
	if (not targetOk) then
		if (lastTarget) then
			TargetByName(lastTarget);
		else
			ClearTarget();
		end
	end
end

function TitanAggro_CheckUpdatedAggroList()
	if(GetTime() - AggroVars.LastUpdateAggroList > AggroVars.ScanFreq) then
		local init_time = GetTime();
		TitanAggro_UpdateAggroList();
		AggroVars.LastUpdateAggroList = GetTime();
		AggroVars.ScanFreq = (AggroVars.LastUpdateAggroList - init_time) * 10;

		if (AggroVars.ScanFreq < 1) then
			AggroVars.ScanFreq = 1;
		elseif (AggroVars.ScanFreq > 10) then
			AggroVars.ScanFreq = 10;
			TitanAggro_Debug("CheckUpdatedAggroList(): Exec very slow next scan in 10s");
		end
	end
end

function TitanAggro_UpdateAggroList()
	local mob;
	AggroVars.DstToTTable = {};
	AggroVars.MobToTTable = {};
	local init_time = GetTime();

	if (TitanAggroGetVar("AggroDetect") > 0) then
		local unit, player;
		local max = 0;
		local groupstr = "party";
		if (TitanAggroGetVar("AggroDetect") == 2) then max = 4; end
		if (TitanAggroGetVar("AggroDetect") == 3) then
			if (UnitInRaid("player")) then
				max = 40;
				groupstr = "raid";
			else
				max = 4;
				groupstr = "party";
			end
		end
		local petstr = groupstr.."pet";
		for i=0, max do
			for j=1, 2 do
				if (TitanAggroGetVar("AggroDetectPets") ~= 1) then
					j = 10;
				end
				if (j==2) then
					if (i==0) then unit = "pet"; else unit = petstr..i; end
				else
					if (i==0) then unit = "player"; else unit = groupstr..i; end
				end
				player = UnitName(unit);
				if (player) then
					mob = UnitName(unit.."target");
					if (mob and not UnitIsFriend("player", unit.."target")) then
						--DEFAULT_CHAT_FRAME:AddMessage(unit.." -> "..mob);
						local ttunit, trash = UnitName(unit.."targettarget");
						tinsert(AggroVars.SrcToTTable, unit);
						tinsert(AggroVars.MobToTTable, mob);
						tinsert(AggroVars.DstToTTable, ttunit);
					end
				end
			end
		end
	end
	TitanAggro_Debug("UpdateAggroList(): "..string.format("%.4f",GetTime()-init_time).." seconds.")

	if (TitanAggroGetVar("AggroDetect") > 0) then
		TitanAggro_UpdateAggroIcon();
	end
end


function TitanAggro_UpdateAggroIcon()
	init_time = GetTime();
	TitanAggro_Icons_ResetIcon();
	local tableSize = getn(AggroVars.DstToTTable);
	local unit, player;
	for i=0, 4 do
		for j=1, 2 do
			if (j==2) then
				if (i==0) then unit = "pet"; else unit = "party"..i; end
			else
				if (i==0) then unit = "player";	else unit = "party"..i; end
			end

			player = UnitName(unit);
			if (player) then
				for j=1, tableSize do
					if (AggroVars.DstToTTable[j] == player) then
						TitanAggro_Debug("Someone got aggro: "..player);
						TitanAggro_Icons_ShowIconByUnit(unit);
						j = tableSize+1;
					end
				end
			end
		end
	end
end

function TitanAggro_GetAggroTooltip(unit)
	init_time = GetTime();
	local text = "";
	local moblist = "";
	local player = UnitName(unit);
	local sources = {};
	local uniq_src = {};
	local count = 0;

	if(player) then
		for j=1, getn(AggroVars.DstToTTable) do
			if(AggroVars.DstToTTable[j] == player) then
				local found;
				for i=1, getn(sources) do
					if (UnitIsUnit(sources[i].."target", AggroVars.SrcToTTable[j].."target") and getn(AggroVars.DstToTTable) > 1) then
						found = 1;
					end
				end
				if (not found) then
					tinsert(sources, AggroVars.SrcToTTable[j]);
				end
			end
		end

		for j=1, getn(sources) do
			if (UnitName(sources[j].."target")) then
				mob = "["..UnitLevel(sources[j].."target").."] "..UnitName(sources[j].."target");
				moblist = moblist..AggroVars.TargetedBy_Extra..TitanAggro_GetColoredText(mob, NORMAL_FONT_COLOR);
				TitanAggro_Icons_ShowIconByUnit(unit);
				count=count+1;
			end
		end
		if (count > 0) then
			text = AggroVars.TargetedBy_Text..TitanAggro_GetColoredText(player, GREEN_FONT_COLOR)..": "..count;
			text = text..moblist;
		end
	end
	return text;
end
