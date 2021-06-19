Scriptname DES_NordicTrackingScript Extends ReferenceAlias

;-- Properties --------------------------------------

Actor Property PlayerRef Auto
Formlist Property DES_NonCultFormlist Auto
GlobalVariable Property DES_Cult Auto
GlobalVariable Property DES_NonCult Auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
  if DES_NonCultFormlist.HasForm()
	DES_NonCult.SetValue(0)
	DES_Cult.SetValue(100)
  ;elseif
	;DES_NonCult.SetValue(100)
	;DES_Cult.SetValue(0)
  endif
endevent