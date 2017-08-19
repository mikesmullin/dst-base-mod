package dst.compiled;

@:native("_G.ParticleEmitter")
extern class ParticleEmitter
{
	private function new();

	public function AddParticle(): Dynamic;
	public function AddParticleUV(): Dynamic;
	public function AddRotatingParticle(): Dynamic;
	public function AddRotatingParticleUV(): Dynamic;
	public function ClearAllParticles(): Dynamic;
	public function EnableBloomPass(): Dynamic;
	public function EnableDepthTest(): Dynamic;
	public function FastForward(): Dynamic;
	public function GetNumLiveParticles(): Dynamic;
	public function SetAcceleration(): Dynamic;
	public function SetBlendMode(): Dynamic;
	public function SetColourEnvelope(): Dynamic;
	public function SetDragCoefficient(): Dynamic;
	public function SetLayer(): Dynamic;
	public function SetMaxLifetime(): Dynamic;
	public function SetMaxNumParticles(): Dynamic;
	public function SetRadius(): Dynamic;
	public function SetRenderResources(): Dynamic;
	public function SetRotationStatus(): Dynamic;
	public function SetScaleEnvelope(): Dynamic;
	public function SetSortOrder(): Dynamic;
	public function SetSpawnVectors(): Dynamic;
	public function SetUVFrameSize(): Dynamic;
}