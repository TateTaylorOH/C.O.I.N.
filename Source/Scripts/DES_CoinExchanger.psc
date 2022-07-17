Scriptname DES_CoinExchanger extends ReferenceAlias

DES_CoinManager Property CoinData Auto
MiscObject Property Gold001 Auto
Actor ref
float value

Event OnInit()
	ref = getReference() as Actor
	value = 0.0
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	MiscObject coin = akBaseItem as MiscObject
	if(coin)
		float valueMult = CoinData.getCoinValue(coin)
		if(valueMult > 0.0)
			int count = ref.getItemCount(akBaseItem)
			ref.removeItem(akBaseItem, count)
			value += count * valueMult
			count = value as int
			value -= count as float
			ref.addItem(Gold001, count)
		endIf
	endIf
EndEvent