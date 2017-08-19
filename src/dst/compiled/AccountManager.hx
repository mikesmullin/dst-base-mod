package dst.compiled;

@:native("_G.AccountManager")
extern class AccountManager
{
	public function AddGameKeyToAccount(): Dynamic;
	public function CancelLogin(): Dynamic;
	public function CommunicationSucceeded(): Dynamic;
	public function CreateAccount(): Dynamic;
	public function GetSteamLoginURL(): Dynamic;
	public function GetToken(): Dynamic;
	public function GetUsername(): Dynamic;
	public function GetViewAccountURL(): Dynamic;
	public function HasAuthToken(): Dynamic;
	public function HasSteamTicket(): Dynamic;
	public function IsBanned(): Dynamic;
	public function IsWaitingForResponse(): Dynamic;
	public function Login(): Dynamic;
	public function Logout(): Dynamic;
	public function MustUpgradeClient(): Dynamic;
	public function MustValidateEmail(): Dynamic;
	public function RecoverPassword(): Dynamic;
	public function TokenPurpose(): Dynamic;
	public function ValidateToken(): Dynamic;
}