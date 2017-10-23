class UIPanel_StatUI_StatLine extends UIPanel;

var ArtifactCost TotalCost, CurrentCost;
var UIButton MinusSign, PlusSign;
var UIImage Image;
var UIText StatName, UpgradeCost;

var delegate<NumResourcesForIncrease> NumResourcesForIncreaseFn;

delegate int NumResourcesForIncrease();

simulated function UIPanel InitStatLine()
{
	Image = Spawn(class'UIImage', self).InitImage('', );

	StatName = Spawn(class'UIText', self).InitText(, , , );

	MinusSign = Spawn(class'UIButton', self).InitButton('', , );

	PlusSign = Spawn(class'UIButton', self).InitButton('', , );
	
	UpgradeCost = Spawn(class'UIText', self).InitText(, , , );
	UpgradeCost.Hide();
}