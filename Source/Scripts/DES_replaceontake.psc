Scriptname DES_ReplaceOnTake extends ObjectReference  

MiscObject Property ThisCoin Auto
MiscObject Property Gold Auto
float property mult = 1.0 auto

Event OnContainerChanged(ObjectReference akNewContainer, ObjectReference akOldContainer)
    if(akNewContainer as Actor)
        int count = akNewContainer.getItemCount(ThisCoin)
        int newCount = (count * mult) as int
        if(newCount <= 0 && count > 0)
          newcount = 1
        endIf
        akNewContainer.removeItem(ThisCoin, count, true)
        akNewContainer.addItem(Gold, newCount, true)
    endIf
endEvent