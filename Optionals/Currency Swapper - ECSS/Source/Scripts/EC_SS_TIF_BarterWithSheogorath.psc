;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname EC_SS_TIF_BarterWithSheogorath Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
BarterWithSheo(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerREF Auto
Form Property DES_GibberFront Auto 
Form  Property DES_GibberBack Auto
Perk Property EC_SS_SIPriceAdjustmentPerk auto

Bool ShouldRevertCurrency
Form LastCurrency

Import SEA_BarterFunctions 

Function BarterWithSheo(Actor a_kSheo)

    If (!a_kSheo)

        Return
    EndIf

    If (PlayerREF.HasPerk(EC_SS_SIPriceAdjustmentPerk))

        PlayerREF.RemovePerk(EC_SS_SIPriceAdjustmentPerk)
    EndIf
    PlayerREF.AddPerk(EC_SS_SIPriceAdjustmentPerk)

    LastCurrency = GetCurrency()
    ShouldRevertCurrency = False
    If (!LastCurrency)

        ShouldRevertCurrency = True
    EndIf
    SetCurrency(DES_GibberFront)

    a_kSheo.ShowBarterMenu()

    ;We do this for Skyrim Souls compatibility.
    While (Utility.IsInMenuMode())

        Utility.Wait(0.1)
    EndWhile

    If (ShouldRevertCurrency)

        ResetCurrency()
    Else

        SetCurrency(LastCurrency)
    EndIf
	PlayerREF.RemovePerk(EC_SS_SIPriceAdjustmentPerk)
EndFunction
