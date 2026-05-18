Scriptname DES_FalmerTrackingScript Extends ReferenceAlias

Actor Property PlayerRef Auto
Formlist Property DES_ValeFormlist Auto
GlobalVariable Property DES_MallariChance Auto
GlobalVariable Property DES_NchuarkChance Auto
GlobalVariable Property DES_SeptimChance Auto
Keyword Property LocTypeDwarvenRuin Auto
Keyword Property LocTypeAncientFalmerRuin Auto
Worldspace Property DLC1FalmerValley auto

EVENT OnLocationChange(Location akOldLoc, Location akNewLoc)
    IF akNewLoc
        IF akNewLoc.HasKeyword(LocTypeDwarvenRuin)
			DES_MallariChance.SetValue(100)
			DES_NchuarkChance.SetValue(0)
			DES_SeptimChance.SetValue(100)
        ELSEIF akNewLoc.HasKeyword(LocTypeAncientFalmerRuin) || PlayerRef.getWorldSpace() == DLC1FalmerValley || DES_ValeFormlist.HasForm(akNewLoc)
			DES_MallariChance.SetValue(0)
			DES_NchuarkChance.SetValue(100)
			DES_SeptimChance.SetValue(100)
        ELSE
			DES_MallariChance.SetValue(100)
			DES_NchuarkChance.SetValue(100)
			DES_SeptimChance.SetValue(0)
        ENDIF
    ENDIF
ENDEVENT
