Scriptname DES_DefaultCoins extends Quest

DES_CoinManager Property CoinData Auto

int property numDefaultCoins = 9 auto hidden

MiscObject Property DES_DrakrDragon Auto
MiscObject Property DES_DrakrMoth Auto
MiscObject Property DES_DrakrOwl Auto
MiscObject Property DES_DrakrWhale Auto
MiscObject Property DES_DrakrNord Auto
float property DrakrValue = 0.15 auto hidden

MiscObject Property DES_GibberFront Auto
float property GibberFrontValue = 1.6 auto hidden

MiscObject Property DES_GibberBack Auto
float property GibberBackValue = 1.0 auto hidden

MiscObject Property DES_Mala Auto
float property MalaValue = 0.4 auto hidden

MiscObject Property DES_Mallari Auto
float property MallariValue = 0.6 auto hidden

MiscObject Property DES_Mede Auto
float property MedeValue = 0.8 auto hidden

MiscObject Property DES_Nchuark Auto
float property NchuarkValue = 0.25 auto hidden

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
	CoinData.setCoinValue(DES_DrakrDragon, DrakrValue)
	CoinData.setCoinValue(DES_DrakrMoth, DrakrValue)
	CoinData.setCoinValue(DES_DrakrOwl, DrakrValue)
	CoinData.setCoinValue(DES_DrakrWhale, DrakrValue)
	CoinData.setCoinValue(DES_DrakrNord, DrakrValue)
	CoinData.setCoinValue(DES_GibberFront, GibberFrontValue)
	CoinData.setCoinValue(DES_GibberBack, GibberBackValue)
	CoinData.setCoinValue(DES_Mala, MalaValue)
	CoinData.setCoinValue(DES_Mallari, MallariValue)	
	CoinData.setCoinValue(DES_Mede, MedeValue)
	CoinData.setCoinValue(DES_Nchuark, NchuarkValue)
	CoinData.setCoinValue(DES_Sancar, SancarValue)
	CoinData.setCoinValue(DES_Ulfric, UlfricValue)
endFunction
