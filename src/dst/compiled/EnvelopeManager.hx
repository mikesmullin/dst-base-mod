package dst.compiled;

@:native("_G.EnvelopeManager")
extern class EnvelopeManager
{
	private function new();

	public function AddColourEnvelope(): Dynamic;
	public function AddFloatEnvelope(): Dynamic;
	public function AddVector2Envelope(): Dynamic;
}