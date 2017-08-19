package dst.compiled;

@:native("_G.AnimState")
extern class AnimState
{
	private function new();

	public function AddOverrideBuild(): Dynamic;
	public function AnimDone(): Dynamic;
	public function AssignItemSkins(): Dynamic;
	public function BuildHasSymbol(): Dynamic;
	public function ClearAllOverrideSymbols(): Dynamic;
	public function ClearBloomEffectHandle(): Dynamic;
	public function ClearOverrideBuild(): Dynamic;
	public function ClearOverrideSymbol(): Dynamic;
	public function ClearSymbolExchanges(): Dynamic;
	public function FastForward(): Dynamic;
	public function GetAddColour(): Dynamic;
	public function GetCurrentAnimationLength(): Dynamic;
	public function GetCurrentAnimationTime(): Dynamic;
	public function GetCurrentFacing(): Dynamic;
	public function GetMultColor(): Dynamic;
	public function GetSymbolPosition(): Dynamic;
	public function Hide(): Dynamic;
	public function HideSymbol(): Dynamic;
	public function IsCurrentAnimation(): Dynamic;
	public function OverrideItemSkinSymbol(): Dynamic;
	public function OverrideMultColor(): Dynamic;
	public function OverrideShade(): Dynamic;
	public function OverrideSymbol(): Dynamic;
	public function Pause(): Dynamic;
	public function PlayAnimation(): Dynamic;
	public function PushAnimation(): Dynamic;
	public function Resume(): Dynamic;
	public function SetAddColour(): Dynamic;
	public function SetBank(): Dynamic;
	public function SetBloomEffectHandle(): Dynamic;
	public function SetBuild(): Dynamic;
	public function SetClientSideBuildOverrideFlag(): Dynamic;
	public function SetClientsideBuildOverride(): Dynamic; // sic
	public function SetDeltaTimeMultipler(): Dynamic;
	public function SetDepthBias(): Dynamic;
	public function SetDepthTestEnabled(): Dynamic;
	public function SetErosionParams(): Dynamic;
	public function SetFinalOffset(): Dynamic;
	public function SetHaunted(): Dynamic;
	public function SetHighlightColour(): Dynamic;
	public function SetLayer(): Dynamic;
	public function SetLightOverride(): Dynamic;
	public function SetManualBB(): Dynamic;
	public function SetMultColour(): Dynamic;
	public function SetMultiSymbolExchange(): Dynamic;
	public function SetOrientation(): Dynamic;
	public function SetPercent(): Dynamic;
	public function SetRayTestOnBB(): Dynamic;
	public function SetScale(): Dynamic;
	public function SetSkin(): Dynamic;
	public function SetSortOrder(): Dynamic;
	public function SetSortWorldOffset(): Dynamic;
	public function SetSymbolExchange(): Dynamic;
	public function SetTime(): Dynamic;
	public function Show(): Dynamic;
	public function ShowSymbol(): Dynamic;
}