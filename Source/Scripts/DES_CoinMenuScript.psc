Scriptname DES_CoinMenuScript extends Quest

DES_CoinManager Property CoinData Auto

MiscObject Property DES_DrakrDragon Auto
MiscObject Property DES_DrakrMoth Auto
MiscObject Property DES_DrakrOwl Auto
MiscObject Property DES_DrakrWhale Auto

MiscObject Property DES_Nchuark Auto

MiscObject Property DES_Auri Auto

MiscObject Property DES_Mede Auto

MiscObject Property DES_Sancar Auto

MiscObject Property DES_Ulfric Auto

MiscObject Property DES_Harald Auto

float DrakrValue
float NchuarkValue
float AuriValue
float MedeValue
float SancarValue
float UlfricValue
float HaraldValue

float defaultDrakrValue   = 0.15
float defaultNchuarkValue = 0.2
float defaultAuriValue    = 0.6
float defaultMedeValue    = 0.8
float defaultSancarValue  = 1.25
float defaultUlfricValue  = 0.8
float defaultHaraldValue  = 0.2

Event OnInit()
	initializeNewCoins()
endEvent

function initializeNewCoins()
	DrakrValue   = defaultDrakrValue
	NchuarkValue = defaultNchuarkValue
	AuriValue    = defaultAuriValue
	MedeValue    = defaultMedeValue
	SancarValue  = defaultSancarValue
	UlfricValue  = defaultUlfricValue
	HaraldValue  = defaultHaraldValue
	while (!CoinData.ready)
		utility.wait(0.1)
	endWhile
	CoinData.setCoinValue(DES_DrakrDragon, DrakrValue)
	CoinData.setCoinValue(DES_DrakrMoth,   DrakrValue)
	CoinData.setCoinValue(DES_DrakrOwl,    DrakrValue)
	CoinData.setCoinValue(DES_DrakrWhale,  DrakrValue)
	CoinData.setCoinValue(DES_Nchuark,     NchuarkValue)
	CoinData.setCoinValue(DES_Auri,        AuriValue)
	CoinData.setCoinValue(DES_Mede,        MedeValue)
	CoinData.setCoinValue(DES_Sancar,      SancarValue)
	CoinData.setCoinValue(DES_Ulfric,      UlfricValue)
	CoinData.setCoinValue(DES_Harald,      HaraldValue)
endFunction