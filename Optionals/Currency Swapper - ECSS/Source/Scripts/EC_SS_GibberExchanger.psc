Scriptname EC_SS_GibberExchanger extends ReferenceAlias

MiscObject Property DES_GibberBack auto
MiscObject Property DES_GibberFront auto
Actor ref

Event OnInit()
	ref = getReference() as Actor
	AddInventoryEventFilter(DES_GibberBack)
endEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if akBaseItem == DES_GibberBack
		int count = ref.getItemCount(akBaseItem)
		ref.removeItem(akBaseItem, count, true)
		ref.addItem(DES_GibberFront, count)
	endif
EndEvent