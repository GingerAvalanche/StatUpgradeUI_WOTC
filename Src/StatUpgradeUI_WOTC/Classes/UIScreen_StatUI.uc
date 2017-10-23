class UIScreen_StatUI extends UIScreen;

var UIPanel HP, Mobility, Offense, Will, Armor, Dodge, Defense, Hack, PsiOffense;
var UIPanel ContainerBox;

var XComGameState_Unit ThisUnitState;

simulated function InitStatUI(XComGameState_Unit UnitState)
{
	ThisUnitState = UnitState;

	SetWidth(Width);
	SetHeight(Height);
	AnchorCenter();
	OriginCenter();
	
	ContainerBox = Spawn(class'UIPanel', self);
	ContainerBox.bAnimateOnInit = true;
	ContainerBox.bIsNavigable = false;
	ContainerBox.InitPanel('', 'X2BackgroundSimple');
	ContainerBox.SetSize(Width, Height);
	ContainerBox.AnchorCenter();
	ContainerBox.OriginCenter();
	SetBGColor(bIsFocused);

	HP = Spawn(class'UIPanel_StatUI_StatLine', ContainerBox).InitStatLine();

	Mobility = Spawn(class'UIPanel_StatUI_StatLine', ContainerBox).InitStatLine();

	Offense = Spawn(class'UIPanel_StatUI_StatLine', ContainerBox).InitStatLine();

	Will = Spawn(class'UIPanel_StatUI_StatLine', ContainerBox).InitStatLine();

	Armor = Spawn(class'UIPanel_StatUI_StatLine', ContainerBox).InitStatLine();

	Dodge = Spawn(class'UIPanel_StatUI_StatLine', ContainerBox).InitStatLine();

	Defense = Spawn(class'UIPanel_StatUI_StatLine', ContainerBox).InitStatLine();

	Hack = Spawn(class'UIPanel_StatUI_StatLine', ContainerBox).InitStatLine();
	
	PsiOffense = Spawn(class'UIPanel_StatUI_StatLine', ContainerBox).InitStatLine();
	
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
		Choice1.DisableNavigation();
		ImageY = Spawn(class'UIImage', self);
		ImageY.InitImage('', "img:///gfxComponents." $ class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_Y_TRIANGLE);
		ImageY.DisableNavigation();
		ImageY.OriginCenter();
		ImageY.AnchorCenter();
		ImageY.SetSize(Choice1.Height, Choice1.Height);
		ImageY.SetPosition(Choice1.X - (Choice1.Width / 2 + ImageY.Width), Choice1.Y);
	}
	
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
		Choice2.DisableNavigation();
		ImageX = Spawn(class'UIImage', self);
		ImageX.InitImage('', "img:///gfxComponents." $ class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_X_SQUARE);
		ImageX.DisableNavigation();
		ImageX.OriginCenter();
		ImageX.AnchorCenter();
		ImageX.SetSize(Choice2.Height, Choice2.Height);
		ImageX.SetPosition(Choice2.X - (Choice2.Width / 2 + ImageX.Width), Choice2.Y);
	}
	
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
		Choice3.DisableNavigation();
		ImageB = Spawn(class'UIImage', self);
		ImageB.InitImage('', "img:///gfxComponents." $ class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_B_CIRCLE);
		ImageB.DisableNavigation();
		ImageB.OriginCenter();
		ImageB.AnchorCenter();
		ImageB.SetSize(Choice3.Height, Choice3.Height);
		ImageB.SetPosition(Choice3.X - (Choice3.Width / 2 + ImageB.Width), Choice3.Y);
	}
	
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
		Choice4.DisableNavigation();
		ImageA = Spawn(class'UIImage', self);
		ImageA.InitImage('', "img:///gfxComponents." $ class'UIUtilities_Input'.static.GetGamepadIconPrefix() $ class'UIUtilities_Input'.const.ICON_A_X);
		ImageA.DisableNavigation();
		ImageA.OriginCenter();
		ImageA.AnchorCenter();
		ImageA.SetSize(Choice4.Height, Choice4.Height);
		ImageA.SetPosition(Choice4.X - (Choice4.Width / 2 + ImageA.Width), Choice4.Y);
	}
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

simulated function SetBGColor(bool focused)
{
	ContainerBox.mc.FunctionString("gotoAndPlay", focused ? "cyan" : "gray");
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