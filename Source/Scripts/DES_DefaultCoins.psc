Scriptname DES_DefaultCoins extends Quest

DES_CoinManager Property CoinData Auto

MiscObject Property DES_Auri Auto
float defaultAuriValue = 0.6

MiscObject Property DES_DrakrDragon Auto
MiscObject Property DES_DrakrMoth Auto
MiscObject Property DES_DrakrOwl Auto
MiscObject Property DES_DrakrWhale Auto
float defaultDrakrValue = 0.15

MiscObject Property DES_Harald Auto
float defaultHaraldValue = 0.2

MiscObject Property DES_Mede Auto
float defaultMedeValue = 0.8

MiscObject Property DES_Nchuark Auto
float defaultNchuarkValue = 0.2

MiscObject Property DES_Sancar Auto
float defaultSancarValue = 1.25

MiscObject Property DES_Ulfric Auto
float defaultUlfricValue  = 0.8

Event OnInit()
	while (!CoinData.ready)
		utility.wait(0.1)
	endWhile
	CoinData.setCoinValue(DES_Auri, defaultAuriValue)
	CoinData.setCoinValue(DES_DrakrDragon, defaultDrakrValue)
	CoinData.setCoinValue(DES_DrakrMoth, defaultDrakrValue)
	CoinData.setCoinValue(DES_DrakrOwl, defaultDrakrValue)
	CoinData.setCoinValue(DES_DrakrWhale, defaultDrakrValue)
	CoinData.setCoinValue(DES_Harald, defaultHaraldValue)
	CoinData.setCoinValue(DES_Mede, defaultMedeValue)
	CoinData.setCoinValue(DES_Nchuark, defaultNchuarkValue)
	CoinData.setCoinValue(DES_Sancar, defaultSancarValue)
	CoinData.setCoinValue(DES_Ulfric, defaultUlfricValue)
endEvent