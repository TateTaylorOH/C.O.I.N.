Scriptname DES_COINCompatibilityScript extends Quest  
{don't change or recompile this script. if you need this script to do something else, make a new one.}
;-- Properties ---------------------------------------

MiscObject Property myCoin Auto
{this is your coin. it will be automatically exchanged for gold when you pick it up.}
float property myValue = 1.0 auto
{the coin is worth this many septims. fractional values are allowed, they'll add up and roll over into a whole coin when you have enough.}

;-- Variables ---------------------------------------

;-- Functions ---------------------------------------

Function COINCompatibilityInjection()
Debug.Notification("COINCompatibilityInjection has fired!")
DES_CoinManager CoinHandler = Quest.getQuest("DES_CoinHandler") as DES_CoinManager
CoinHandler.setCoinValue(myCoin, myValue)
	Debug.Notification("myCoin's value has been set!")
EndFunction

Event OnInit()
	Debug.Notification("OnInit has fired!")
	COINCompatibilityInjection()
	self.Stop()
EndEvent

Event OnPlayerLoadGame()
	Debug.Notification("OnPlayerLoadGame has fired!")
	COINCompatibilityInjection()
	self.Stop()
EndEvent