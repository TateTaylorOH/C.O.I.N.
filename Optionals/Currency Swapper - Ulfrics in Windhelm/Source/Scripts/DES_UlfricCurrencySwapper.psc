Scriptname DES_UlfricCurrencySwapper extends ReferenceAlias

Actor Property PlayerREF Auto
Form Property DES_Ulfric Auto 
Perk Property DES_WindhelmPriceAdjustmentPerk auto
Location Property WindhelmLocation auto

Bool ShouldRevertCurrency
Form LastCurrency

Import SEA_BarterFunctions 

EVENT OnLocationChange(Location akOldLoc, Location akNewLoc)
	IF akNewLoc == WindhelmLocation || akNewLoc.GetParent() == WindhelmLocation
	;debug.messagebox("We are in Windhelm.")
		IF (PlayerREF.HasPerk(DES_WindhelmPriceAdjustmentPerk))
			PlayerREF.RemovePerk(DES_WindhelmPriceAdjustmentPerk)
		ENDIF
		PlayerREF.AddPerk(DES_WindhelmPriceAdjustmentPerk)
		LastCurrency = GetCurrency()
		ShouldRevertCurrency = False
		IF (!LastCurrency)
			ShouldRevertCurrency = True
		ENDIF
		SetCurrency(DES_Ulfric)
	ELSEIF akNewLoc != WindhelmLocation && akNewLoc.GetParent() != WindhelmLocation
	;debug.messagebox("We are not in Windhelm.")
		IF (ShouldRevertCurrency)
			ResetCurrency()
			;debug.notification("ResetCurrency")
		ELSE
			SetCurrency(LastCurrency)
			;debug.notification("SetCurrency")
		ENDIF
		PlayerREF.RemovePerk(DES_WindhelmPriceAdjustmentPerk)
		LastCurrency = GetCurrency()
	ENDIF
ENDEVENT