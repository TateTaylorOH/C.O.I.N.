Scriptname DES_FalmerTrackingScript Extends ReferenceAlias

Actor Property PlayerRef Auto
Formlist Property DES_ValeFormlist Auto
GlobalVariable Property DES_MallariFalmerChanceNone Auto
GlobalVariable Property DES_NchuarkFalmerChanceNone Auto
GlobalVariable Property DES_SeptimFalmerChanceNone Auto
Keyword Property LocSetDwarvenRuin Auto
Keyword Property LocSetFalmerRuin Auto
Worldspace Property Blackreach auto
Worldspace Property DLC01FalmerValley auto

EVENT OnLocationChange(Location akOldLoc, Location akNewLoc)
    IF akNewLoc
        IF !akNewLoc.HasKeyword(LocSetDwarvenRuin) && !PlayerRef.getWorldSpace() == Blackreach && !akNewLoc.HasKeyword(LocSetFalmerRuin) && !PlayerRef.getWorldSpace() == DLC01FalmerValley && !DES_ValeFormlist.HasForm(akNewLoc)
			DES_MallariFalmerChanceNone.SetValue(100)
			DES_NchuarkFalmerChanceNone.SetValue(100)
			DES_SeptimFalmerChanceNone.SetValue(0)
        ELSEIF akNewLoc.HasKeyword(LocSetDwarvenRuin) || PlayerRef.getWorldSpace() == Blackreach
			DES_MallariFalmerChanceNone.SetValue(100)
			DES_NchuarkFalmerChanceNone.SetValue(0)
			DES_SeptimFalmerChanceNone.SetValue(100)
        ELSEIF akNewLoc.HasKeyword(LocSetFalmerRuin) || PlayerRef.getWorldSpace() == DLC01FalmerValley || DES_ValeFormlist.HasForm(akNewLoc)
			DES_MallariFalmerChanceNone.SetValue(0)
			DES_NchuarkFalmerChanceNone.SetValue(100)
			DES_SeptimFalmerChanceNone.SetValue(100)
        ENDIF
    ENDIF
ENDEVENT
