Scriptname DES_CoinExchanger extends ReferenceAlias

DES_CoinManager Property CoinData Auto
MiscObject Property Gold001 Auto
FormList Property DES_AllCoins Auto
Keyword Property DES_NoExchange auto
Actor ref
float value

bool property autoExchange = true auto hidden
bool property verbose = false auto hidden

Event OnInit()
	ref = getReference() as Actor
	value = 0.0
	AddInventoryEventFilter(DES_AllCoins)
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