scriptname DES_CoinManager extends Quest
{don't change or recompile this script. it's just here for the compiler to look at the functions.}

function resetCoins()
endFunction

float function getCoinValue(MiscObject coin, float defaultValue = 0.0)
	return defaultValue
endFunction

float function setCoinValue(MiscObject coin, float value)
	return 0.0
endFunction

bool function removeCoinExchange(MiscObject coin)
	return false
endFunction

MiscObject function getCoin(int i)
	return None
endFunction

int function getNumCoins()
	return 0
endFunction