Scriptname DES_COINCompatibilityInjectionScript extends Quest  

;-- Propeties ---------------------------------------

MiscItem Property myCoin  Auto

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

Function COINCompatibilityInjection()
;Debug.Notification("IntCOINCompatibilityInjection has fired!")
FormList DES_NonGoldCoins = Game.GetForm(01DE5002) As FormList
    if (DES_NonGoldCoins && !DES_NonGoldCoins.hasForm(myCoin))
		DES_NonGoldCoins.AddForm(myCoin)
		;Debug.Notification("myCoin has been added to the formlist!")
    endif
EndFunction

Event OnInit()
	;Debug.Notification("OnInit has fired!")
	COINCompatibilityInjection()
	self.Stop()
EndEvent

Event OnPlayerLoadGame()
	;Debug.Notification("OnPlayerLoadGame has fired!")
	COINCompatibilityInjection()
	self.Stop()
EndEvent