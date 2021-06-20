Scriptname DES_CoinExchanger extends ReferenceAlias

FormList Property Coins Auto
MiscObject Property Gold001 Auto
Actor ref
float value

Event OnInit()
	addInventoryEventFilter(Coins)
	ref = getReference() as Actor
	value = 0.0
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	DES_CoinReplaceable coin = akBaseItem as DES_CoinReplaceable
	if(coin)
		int count = ref.getItemCount(coin)
		ref.removeItem(coin, count, true)
		value += coin.mult * count
		count = value as int
		value -= count
		ref.addItem(Gold001, count, true)
	endIf
EndEvent