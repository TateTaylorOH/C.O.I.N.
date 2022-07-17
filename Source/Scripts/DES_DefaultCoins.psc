Scriptname DES_DefaultCoins extends Quest

DES_CoinManager Property CoinData Auto

int property numDefaultCoins = 7 auto hidden

MiscObject Property DES_Auri Auto
float property AuriValue = 0.6 auto hidden

MiscObject Property DES_DrakrDragon Auto
MiscObject Property DES_DrakrMoth Auto
MiscObject Property DES_DrakrOwl Auto
MiscObject Property DES_DrakrWhale Auto
float property DrakrValue = 0.15 auto hidden

MiscObject Property DES_Harald Auto
float property HaraldValue = 0.2 auto hidden

MiscObject Property DES_Mede Auto
float property MedeValue = 0.8 auto hidden

MiscObject Property DES_Nchuark Auto
float property NchuarkValue = 0.2 auto hidden

MiscObject Property DES_Sancar Auto
float property SancarValue = 1.25 auto hidden

MiscObject Property DES_Ulfric Auto
float property UlfricValue  = 0.8 auto hidden

Event OnInit()
	while (!CoinData.ready)
		utility.wait(0.1)
	endWhile
	setDefaultCoinValues()
endEvent

function setDefaultCoinValues()
	CoinData.setCoinValue(DES_Auri, AuriValue)
	CoinData.setCoinValue(DES_DrakrDragon, DrakrValue)
	CoinData.setCoinValue(DES_DrakrMoth, DrakrValue)
	CoinData.setCoinValue(DES_DrakrOwl, DrakrValue)
	CoinData.setCoinValue(DES_DrakrWhale, DrakrValue)
	CoinData.setCoinValue(DES_Harald, HaraldValue)
	CoinData.setCoinValue(DES_Mede, MedeValue)
	CoinData.setCoinValue(DES_Nchuark, NchuarkValue)
	CoinData.setCoinValue(DES_Sancar, SancarValue)
	CoinData.setCoinValue(DES_Ulfric, UlfricValue)
endFunction