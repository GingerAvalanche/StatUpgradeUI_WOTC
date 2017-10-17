class UIScreen_StatUI extends UIScreen;

var UIButton MinusHP, MinusMobility, MinusOffense, MinusWill, MinusArmor, MinusDodge, MinusDefense, MinusHack, MinusPsiOffense;
var UIButton PlusHP, PlusMobility, PlusOffense, PlusWill, PlusArmor, PlusDodge, PlusDefense, PlusHack, PlusPsiOffense;
var UIImage ImageHP, ImageMobility, ImageOffense, ImageWill, ImageArmor, ImageDodge, ImageDefense, ImageHack, ImagePsiOffense;
var UIText ResearchComplete, TechLabel, TechLabelLarge, RewardName, RewardLabel;
var UIPanel BGBox;

var int iLockboxRarity;
var array<int> ChoiceIndices;

simulated function InitStatUI(UIAlert Alert, int LockboxRarity, XComGameState_Tech Tech)
{
	//`Log("GrimyLoot_UIScreen.InitScreen starting...");
	AlertScreen = Alert;
	iLockboxRarity = LockboxRarity;
	TechState = Tech;
	
	//`Log("GrimyLoot_UIScreen.InitScreen setting width and height");
	SetWidth(Width);
	SetHeight(Height);
	AnchorCenter();
	OriginCenter();
	
	BGBox = Spawn(class'UIPanel', self);
	BGBox.bAnimateOnInit = true;
	BGBox.bIsNavigable = false;
	BGBox.InitPanel('', 'X2BackgroundSimple');
	BGBox.SetSize(Width, Height);
	BGBox.AnchorCenter();
	BGBox.OriginCenter();
	SetBGColor(bIsFocused);
	
	//`Log("GrimyLoot_UIScreen.InitScreen initializing ResearchComplete UIText");
	ResearchComplete = Spawn(class'UIText', self);
	ResearchComplete.bAnimateOnInit = true;
	ResearchComplete.InitText('', AlertScreen.m_strResearchProjectComplete);
	ResearchComplete.OriginCenter();
	ResearchComplete.AnchorCenter();
	ResearchComplete.SetPosition(-40, 0);
	
	//`Log("GrimyLoot_UIScreen.InitScreen initializing TechLabel UIText");
	TechLabel = Spawn(class'UIText',self);
	TechLabel.bAnimateOnInit = true;
	TechLabel.InitText('', AlertScreen.m_strResearchCompleteLabel);
	TechLabel.OriginCenter();
	TechLabel.AnchorCenter();
	TechLabel.SetPosition(-20, 0);
	
	//`Log("GrimyLoot_UIScreen.InitScreen initializing TechLabelLarge UIText");
	TechLabelLarge = Spawn(class'UIText', self);
	TechLabelLarge.bAnimateOnInit = true;
	TechLabelLarge.InitText('', AlertScreen.m_strResearchCompleteLabel);
	TechLabelLarge.OriginCenter();
	TechLabelLarge.AnchorCenter();
	TechLabelLarge.SetPosition(0, 0);
	
	//`Log("GrimyLoot_UIScreen.InitScreen initializing RewardName UIText");
	RewardName = Spawn(class'UIText', self);
	RewardName.bAnimateOnInit = true;
	RewardName.InitText();
	RewardName.OriginCenter();
	RewardName.AnchorCenter();
	RewardName.SetPosition(20, 0);
	
	//`Log("GrimyLoot_UIScreen.InitScreen initializing RewardLabel UIText");
	RewardLabel = Spawn(class'UIText', self);
	RewardLabel.bAnimateOnInit = true;
	RewardLabel.InitText();
	RewardLabel.OriginCenter();
	RewardLabel.AnchorCenter();
	RewardLabel.SetPosition(40, 0);
	
	//`Log("GrimyLoot_UIScreen.InitScreen initializing RewardImage UIImage");
	RewardImage = Spawn(class'UIImage', self);
	RewardImage.InitImage('', TechState.GetImage());
	RewardImage.OriginCenter();
	RewardImage.AnchorCenter();
	RewardImage.SetY(-Height / 4);
	
	//`Log("GrimyLoot_UIScreen.InitLoot picking indices");
	PickIndices();
	
	//`Log("GrimyLoot_UIScreen.InitScreen spawning Choice1 UIButton");
	Choice1 = Spawn(class'UIButton', self);
	Choice1.bAnimateOnInit = true;
	Choice1.InitButton('Choice1', ChoiceNames[ChoiceIndices[0]], GiveItem);
	Choice1.SetResizeToText(false);
	Choice1.OriginCenter();
	Choice1.AnchorCenter();
	Choice1.SetFontSize(28);
	Choice1.SetHeight(40);
	Choice1.SetWidth(Width / 1.5);
	Choice1.SetY((Height / 2) - (Choice1.Height * 4));

	if( `ISCONTROLLERACTIVE)
	{
		//Choice1.SetGamepadIcon(class'UIUtilities_Input'.const.ICON_Y_TRIANGLE);
		Choice1.DisableNavigation();
		ImageY = Spawn(class'UIImage', self);
		ImageY.InitImage('', "img:///gfxComponents." $ class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_Y_TRIANGLE);
		ImageY.DisableNavigation();
		ImageY.OriginCenter();
		ImageY.AnchorCenter();
		ImageY.SetSize(Choice1.Height, Choice1.Height);
		ImageY.SetPosition(Choice1.X - (Choice1.Width / 2 + ImageY.Width), Choice1.Y);
	}
	
	//`Log("GrimyLoot_UIScreen.InitScreen spawning Choice2 UIButton");
	Choice2 = Spawn(class'UIButton', self);
	Choice2.bAnimateOnInit = true;
	Choice2.InitButton('Choice2', ChoiceNames[ChoiceIndices[1]], GiveItem);
	Choice2.SetResizeToText(false);
	Choice2.OriginCenter();
	Choice2.AnchorCenter();
	Choice2.SetFontSize(28);
	Choice2.SetHeight(Choice1.Height);
	Choice2.SetWidth(Choice1.Width);
	Choice2.SetY(Choice1.Y + (Choice1.Height / 2) + (Choice2.Height / 2));
	
	if( `ISCONTROLLERACTIVE)
	{
		//Choice2.SetGamepadIcon(class'UIUtilities_Input'.const.ICON_X_SQUARE);
		Choice2.DisableNavigation();
		ImageX = Spawn(class'UIImage', self);
		ImageX.InitImage('', "img:///gfxComponents." $ class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_X_SQUARE);
		ImageX.DisableNavigation();
		ImageX.OriginCenter();
		ImageX.AnchorCenter();
		ImageX.SetSize(Choice2.Height, Choice2.Height);
		ImageX.SetPosition(Choice2.X - (Choice2.Width / 2 + ImageX.Width), Choice2.Y);
	}
	
	//`Log("GrimyLoot_UIScreen.InitScreen spawning Choice3 UIButton");
	Choice3 = Spawn(class'UIButton', self);
	Choice3.bAnimateOnInit = true;
	Choice3.InitButton('Choice3', ChoiceNames[ChoiceIndices[2]], GiveItem);
	Choice3.SetResizeToText(false);
	Choice3.OriginCenter();
	Choice3.AnchorCenter();
	Choice3.SetFontSize(28);
	Choice3.SetHeight(Choice1.Height);
	Choice3.SetWidth(Choice1.Width);
	Choice3.SetY(Choice2.Y + (Choice2.Height / 2) + (Choice3.Height / 2));
	
	if( `ISCONTROLLERACTIVE)
	{
		//Choice3.SetGamepadIcon(class'UIUtilities_Input'.const.ICON_B_CIRCLE);
		Choice3.DisableNavigation();
		ImageB = Spawn(class'UIImage', self);
		ImageB.InitImage('', "img:///gfxComponents." $ class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_B_CIRCLE);
		ImageB.DisableNavigation();
		ImageB.OriginCenter();
		ImageB.AnchorCenter();
		ImageB.SetSize(Choice3.Height, Choice3.Height);
		ImageB.SetPosition(Choice3.X - (Choice3.Width / 2 + ImageB.Width), Choice3.Y);
	}
	
	//`Log("GrimyLoot_UIScreen.InitScreen spawning Choice4 UIButton");
	Choice4 = Spawn(class'UIButton', self);
	Choice4.bAnimateOnInit = true;
	Choice4.InitButton('Choice4', ChoiceNames[ChoiceIndices[3]], GiveItem);
	Choice4.SetResizeToText(false);
	Choice4.OriginCenter();
	Choice4.AnchorCenter();
	Choice4.SetFontSize(28);
	Choice4.SetHeight(Choice1.Height);
	Choice4.SetWidth(Choice1.Width);
	Choice4.SetY(Choice3.Y + (Choice3.Height / 2) + (Choice4.Height / 2));
	
	if( `ISCONTROLLERACTIVE)
	{
		//Choice4.SetGamepadIcon(class'UIUtilities_Input'.const.ICON_A_X);
		Choice4.DisableNavigation();
		ImageA = Spawn(class'UIImage', self);
		ImageA.InitImage('', "img:///gfxComponents." $ class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_A_X);
		ImageA.DisableNavigation();
		ImageA.OriginCenter();
		ImageA.AnchorCenter();
		ImageA.SetSize(Choice4.Height, Choice4.Height);
		ImageA.SetPosition(Choice4.X - (Choice4.Width / 2 + ImageA.Width), Choice4.Y);
	}
	
	//`Log("GrimyLoot_UIScreen.InitScreen completing");
}

function PickIndices() {
	//`Log("GrimyLoot_UIScreen.PickIndices starting...");

	//ChoiceIndices[0] = class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1);
	ChoiceIndices.AddItem(class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1));
	
	//ChoiceIndices[1] = class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1);
	ChoiceIndices.AddItem(class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1));
	while ( ChoiceIndices[1] == ChoiceIndices[0] ) {
		ChoiceIndices[1] = class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1);
	}

	//ChoiceIndices[2] = class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1);
	ChoiceIndices.AddItem(class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1));
	while ( ChoiceIndices[2] == ChoiceIndices[1] || ChoiceIndices[2] == ChoiceIndices[0] ) {
		ChoiceIndices[2] = class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1);
	}

	//ChoiceIndices[3] = class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1);
	ChoiceIndices.AddItem(class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1));
	while ( ChoiceIndices[3] == ChoiceIndices[2] || ChoiceIndices[3] == ChoiceIndices[1] || ChoiceIndices[3] == ChoiceIndices[0] ) {
		ChoiceIndices[3] = class'GrimyLoot_Research'.static.IdentifyIndex(iLockboxRarity > 1);
	}
	//`Log("GrimyLoot_UIScreen.PickIndices picked indices are:" @ ChoiceIndices[0] $ "," @ ChoiceIndices[1] $ "," @ ChoiceIndices[2] $ ", and" @ ChoiceIndices[3]);
	//`Log("GrimyLoot_UIScreen.PickIndices picked rewards are:" @ ChoiceNames[ChoiceIndices[0]] $ "," @ ChoiceNames[ChoiceIndices[1]] $ "," @ ChoiceNames[ChoiceIndices[2]] $ ", and" @ ChoiceNames[ChoiceIndices[3]]);
	
	//`Log("GrimyLoot_UIScreen.PickIndices completing...");
}

simulated function bool OnUnrealCommand(int cmd, int arg)
{
	if(!CheckInputIsReleaseOrDirectionRepeat(cmd, arg))
		return false;

	switch(cmd)
	{
		case class'UIUtilities_Input'.const.FXS_BUTTON_Y:
			Choice1.OnClickedDelegate(Choice1);
			return true;
		case class'UIUtilities_Input'.const.FXS_BUTTON_X:
			Choice2.OnClickedDelegate(Choice2);
			return true;
		case class'UIUtilities_Input'.const.FXS_BUTTON_B:
			Choice3.OnClickedDelegate(Choice3);
			return true;
		case class'UIUtilities_Input'.const.FXS_BUTTON_A:
		case class'UIUtilities_Input'.const.FXS_KEY_ENTER:
		case class'UIUtilities_Input'.const.FXS_KEY_SPACEBAR:
			Choice4.OnClickedDelegate(Choice4);
			return true;
	}

	return super.OnUnrealCommand(cmd, arg);
}

function GiveItem(UIButton ButtonChoice) {
	local XComGameState_Item ItemState;
	
	//`Log("GrimyLoot_UIScreen.GiveItem starting...");
	//`Log("GrimyLoot_UIScreen.GiveItem ButtonChoice:" @ ButtonChoice); 

	if ( ButtonChoice == Choice1 ) {
		ItemState = class'GrimyLoot_Research'.static.IdentifyByIndex(TechState, ChoiceIndices[0], iLockboxRarity);
	}
	if ( ButtonChoice == Choice2 ) {
		ItemState = class'GrimyLoot_Research'.static.IdentifyByIndex(TechState, ChoiceIndices[1], iLockboxRarity);
	}
	if ( ButtonChoice == Choice3 ) {
		ItemState = class'GrimyLoot_Research'.static.IdentifyByIndex(TechState, ChoiceIndices[2], iLockboxRarity);
	}
	if ( ButtonChoice == Choice4 ) {
		ItemState = class'GrimyLoot_Research'.static.IdentifyByIndex(TechState, ChoiceIndices[3], iLockboxRarity);
	}

	if ( MyItemCard == none ) {
		MyItemCard = GrimyLoot_UIItemCard(AlertScreen.Spawn(class'GrimyLoot_UIItemCard', AlertScreen).InitItemCard());
		MyItemCard.SetPosition(8, 90);
	}
	MyItemCard.PopulateItemCard(ItemState.GetMyTemplate(),ItemState.GetReference());
	MyItemCard.Show();
	
	Choice1.Remove();
	Choice2.Remove();
	Choice3.Remove();
	Choice4.Remove();

	UpdateData();

	//`Log("GrimyLoot_UIScreen.GiveItem completing...");
}

static function SetRecentName(String RetName) {
	//`Log("GrimyLoot_UIScreen.SetRecentName starting...");

	default.RecentName = RetName;
	
	//`Log("GrimyLoot_UIScreen.SetRecentName completing...");
}

// GrimyLootMod vanilla is based upon the concept of one item reward per tech of any kind, so WOTC version has to aassume the proper reward is ItemRewards[ItemsRewards.Length-1]. --Ginger
function UpdateData(optional int RewardNo=-1) {
	local XGParamTag ParamTag;
	local TAlertCompletedInfo kInfo;
	local X2ItemTemplateManager ItemTemplateManager;
	local X2SchematicTemplate SchematicTemplate;
	local X2ItemTemplate ItemReward; // Previously a property of TechState, ItemReward was of type X2ItemTemplate, now must be initialized from TechState.ItemRewards[RewardNo], of type array<X2ItemTemplate>. -- Ginger
	
	//`Log("GrimyLoot_UIScreen.UpdateData starting...");

	if (RewardNo == -1)
		RewardNo += TechState.ItemRewards.Length; // HAX: The ItemReward being given *should* always be the last in the array. Apparently ItemRewards is a dynamic array to store every reward given.
	ItemReward = TechState.ItemRewards[RewardNo];

	if (ItemReward != none ) { // TechState.ItemReward -> ItemReward
		switch ( TechState.GetMyTemplateName() )
		{
			case 'Tech_IdentifyRareLockbox':
				ParamTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
				ParamTag.StrValue0 = m_strRareName @ ItemReward.GetItemFriendlyNameNoStats(); // TechState.ItemReward -> ItemReward
				break;
			case 'Tech_IdentifyEpicLockbox':
			case 'Tech_IdentifyEpicLockboxInstant':
				ParamTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
				ParamTag.StrValue0 = m_strEpicName @ ItemReward.GetItemFriendlyNameNoStats(); // TechState.ItemReward -> ItemReward
				break;
			case 'Tech_IdentifyLegendaryLockbox':
			case 'Tech_IdentifyLegendaryLockboxInstant':
				ParamTag = XGParamTag(`XEXPANDCONTEXT.FindTag("XGParam"));
				ParamTag.StrValue0 = m_strLegendaryName @ ItemReward.GetItemFriendlyNameNoStats(); // TechState.ItemReward -> ItemReward
				break;
			default:
				return;
		}
		
		kInfo.strName = TechState.GetDisplayName();
		kInfo.strHeaderLabel = AlertScreen.m_strResearchCompleteLabel;
				
		if ( class'GrimyLoot_Research'.default.RANDOMIZE_NICKNAMES && RecentName != "" ) {
			RecentName = default.RecentName;
			kInfo.strBody = ParamTag.StrValue0;
			ParamTag.StrValue0 = RecentName;
		}
		else {
			kInfo.strBody = AlertScreen.m_strResearchProjectComplete;
		}
		kInfo.strBody $= "\n" $ `XEXPAND.ExpandString(TechState.GetMyTemplate().UnlockedDescription);

		kInfo.strConfirm = AlertScreen.m_strAssignNewResearch;
		kInfo.strCarryOn = AlertScreen.m_strCarryOn;
		kInfo = AlertScreen.FillInTyganAlertComplete(kInfo);
		kInfo.eColor = eUIState_Warning;
		kInfo.clrAlert = MakeLinearColor(0.75, 0.75, 0.0, 1);

		//`Log("ItemReward is" @ ItemReward);
		//`Log("Its eInvSlot is" @ X2EquipmentTemplate(ItemReward).InventorySlot);
		//`Log("Its CreatorTemplateName is" @ ItemReward.CreatorTemplateName);
		//`Log("Its DataName is" @ ItemReward.DataName);

		if ( X2EquipmentTemplate(ItemReward).InventorySlot != eInvSlot_PrimaryWeapon ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = ItemReward.strImage; // TechState.ItemReward -> ItemReward
		}
		// XPack armor must be done before schematic search because they use the same schematic as base armor
		// All XPack armors within the same tier use the same image, so just use ORs
		else if ( ItemReward.DataName == 'ReaperArmor' || ItemReward.DataName == 'SkirmisherArmor' || ItemReward.DataName == 'TemplarArmor' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_HORArmorConv";
		}
		else if ( ItemReward.DataName == 'PlatedReaperArmor' || ItemReward.DataName == 'PlatedSkirmisherArmor' || ItemReward.DataName == 'PlatedTemplarArmor' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_HORArmorPlat";
		}
		else if ( ItemReward.DataName == 'PoweredReaperArmor' || ItemReward.DataName == 'PoweredSkirmisherArmor' || ItemReward.DataName == 'PoweredTemplarArmor' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_HORArmorPowr";
		}
		else if ( ItemReward.CreatorTemplateName != '' ) { // TechState.ItemReward -> ItemReward
			ItemTemplateManager = class'X2ItemTemplateManager'.static.GetItemTemplateManager();
			SchematicTemplate = X2SchematicTemplate(ItemTemplateManager.FindItemTemplate(ItemReward.CreatorTemplateName)); // TechState.ItemReward -> ItemReward
			kInfo.strImage = SchematicTemplate.strImage;
		}
		else if ( ItemReward.DataName == 'AssaultRifle_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///GrimyLootConvWeapons.GrimyConvAssaultRifle";
		}
		else if ( ItemReward.DataName == 'Cannon_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///GrimyLootConvWeapons.GrimyConvCannon";
		}	
		else if ( ItemReward.DataName == 'Shotgun_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///GrimyLootConvWeapons.GrimyConvShotgun";
		}
		else if ( ItemReward.DataName == 'SniperRifle_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///GrimyLootConvWeapons.GrimyConvSniperRifle";
		}
		else if ( ItemReward.DataName == 'AlienHunterRifle_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_DLC2Images.ConvBoltCaster";
		}
		else if ( ItemReward.DataName == 'VektorRifle_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_ConvVektor_Base";
		}
		else if ( ItemReward.DataName == 'Bullpup_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_ConvSMG_Base";
		}
		else if ( ItemReward.DataName == 'WristBlade_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_ConvSGauntlet";
		}
		else if ( ItemReward.DataName == 'WristBladeLeft_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_Common.ConvSecondaryWeapons.Sword"; // probably unnecessary
		}
		else if ( ItemReward.DataName == 'ShardGauntlet_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_ConvTGauntlet";
		}
		else if ( ItemReward.DataName == 'ShardGauntletLeft_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_ConvTGauntlet"; // probably unnecessary
		}
		else if ( ItemReward.DataName == 'Sidearm_CV' ) { // TechState.ItemReward -> ItemReward
			kInfo.strImage = "img:///UILibrary_XPACK_StrategyImages.Inv_ConvTPistol_Base"; // maybe remove "_Base"? 
		}
		else {
			kInfo.strImage = "img:///GrimyLootPackage.Inv_Storage_Module";
		}
		AlertScreen.BuildCompleteAlert(kInfo);
	}

	`SCREENSTACK.Pop(self);
	
	//`Log("GrimyLoot_UIScreen.UpdateData completing...");
}

simulated function SetBGColor(bool focused)
{
	BGBox.mc.FunctionString("gotoAndPlay", focused ? "cyan" : "gray");
}

simulated function OnReceiveFocus()
{
	super.OnReceiveFocus();
	SetBGColor(bIsFocused);
}

simulated function OnLoseFocus()
{
	super.OnLoseFocus();
	SetBGColor(bIsFocused);	
}

defaultproperties
{
	Width=800
	Height=600
}