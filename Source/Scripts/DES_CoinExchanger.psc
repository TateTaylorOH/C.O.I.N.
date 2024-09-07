Scriptname DES_CoinExchanger extends ReferenceAlias

DES_CoinManager Property CoinData Auto
DES_DefaultCoins Property Defaults Auto
MiscObject Property Gold001 Auto
FormList Property DES_DefaultCoinsList Auto
Keyword Property DES_NoExchange auto
Actor ref
float value

bool property autoExchange = true auto hidden
bool property verbose = false auto hidden

Event OnInit()
	ref = getReference() as Actor
	value = 0.0
endEvent

Event OnPlayerLoadGame()
    int i = 1
    while(i < DES_DefaultCoinsList.getSize())
		float coinValue = CoinData.getCoinValue(DES_DefaultCoinsList.GetAt(i) as MiscObject)
		DES_DefaultCoinsList.GetAt(i).SetGoldValue(coinValue as int) 
		i += 1
    endWhile
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	MiscObject coin = akBaseItem as MiscObject
	if(autoExchange && coin && !akBaseItem.HasKeyword(DES_NoExchange))
		float valueMult = CoinData.getCoinValue(coin)
		if(valueMult > 0.0)
			int count = ref.getItemCount(akBaseItem)
			ref.removeItem(akBaseItem, count, true)
			value += count * valueMult
			count = value as int
			value -= count as float
			ref.addItem(Gold001, count, !verbose)
		endIf
	endIf
EndEvent