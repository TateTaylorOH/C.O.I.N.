Scriptname DES_DefaultCoins extends Quest

DES_CoinManager Property CoinData Auto

MiscObject Property DES_Auri Auto
MiscObject Property DES_DrakrDragon Auto
MiscObject Property DES_DrakrMoth Auto
MiscObject Property DES_DrakrOwl Auto
MiscObject Property DES_DrakrWhale Auto
MiscObject Property DES_Harald Auto
MiscObject Property DES_Mede Auto
MiscObject Property DES_Nchuark Auto
MiscObject Property DES_Sancar Auto
MiscObject Property DES_Ulfric Auto
Event OnInit()
	while (!CoinData.ready)
		utility.wait(0.1)
	endWhile
	CoinData.setCoinValue(DES_Auri, 0.6)
	CoinData.setCoinValue(DES_DrakrDragon, 0.15)
	CoinData.setCoinValue(DES_DrakrMoth, 0.15)
	CoinData.setCoinValue(DES_DrakrOwl, 0.15)
	CoinData.setCoinValue(DES_DrakrWhale, 0.15)
	CoinData.setCoinValue(DES_Harald, 0.2)
	CoinData.setCoinValue(DES_Mede, 0.8)
	CoinData.setCoinValue(DES_Nchuark, 0.2)
	CoinData.setCoinValue(DES_Sancar, 1.25)
	CoinData.setCoinValue(DES_Ulfric, 0.8)
endEvent