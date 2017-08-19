package dst.compiled;

@:native("_G.SoundEmitter")
extern class SoundEmitter
{
	public function GetEntity(): Dynamic;
	public function KillAllSounds(): Dynamic;
	public function KillSound(): Dynamic;
	public function OverrideVolumeMultiplier(): Dynamic;
	public function PlaySound(): Dynamic;
	public function PlaySoundWithParams(): Dynamic;
	public function PlayingSound(): Dynamic;
	public function SetMute(): Dynamic;
	public function SetParameter(): Dynamic;
	public function SetVolume(): Dynamic;
}