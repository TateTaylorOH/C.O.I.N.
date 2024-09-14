Scriptname DES_CoinMenuScript extends SKI_ConfigBase

DES_CoinManager Property CoinData Auto
DES_DefaultCoins Property Defaults Auto

keyword property DES_NoMCM auto

float defaultMallariValue   = 0.6
float defaultDrakrValue     = 0.15
float defaultMalaValue      = 0.4
float defaultDramValue      = 0.30
float defaultNchuarkValue   = 0.25
float defaultGibberMania    = 1.6
float defaultGibberDementia = 1.0
float defaultMedeValue      = 0.8
float defaultSancarValue    = 1.25
float defaultUlfricValue    = 0.8

bool autoExchangeDefault = true
bool verboseDefault = false

Form[] coinForms
string[] coinNames
float[] coinValues
int currentIndex
int coinsMaxIndex
string[] coinStates

float maxCoinValue

Event OnConfigInit()
	utility.wait(2.0)
	initializeMCM()
	initializeSettingDefaults()
	initializeNewCoins()
endEvent

function initializeMCM()
	ModName = "C.O.I.N."
	Pages = new string[2]
	Pages[0] = "$COIN_LABEL_SETTINGS"
	Pages[1] = "$COIN_LABEL_VALUES"
	coinsMaxIndex = -1
endFunction

function initializeSettingDefaults()
	autoExchangeDefault = true
	verboseDefault = false
	CoinData.PlayerAlias.autoExchange = autoExchangeDefault
	CoinData.PlayerAlias.verbose = verboseDefault
	maxCoinValue = 2.0
endFunction

function initializeNewCoins()
	Defaults.MallariValue     = defaultMallariValue
	Defaults.DrakrValue       = defaultDrakrValue
	Defaults.MalaValue        = defaultMalaValue
	Defaults.DramValue        = defaultDramValue	
	Defaults.NchuarkValue     = defaultNchuarkValue
	Defaults.GibberFrontValue = defaultGibberMania
	Defaults.GibberBackValue  = defaultGibberDementia
	Defaults.MedeValue        = defaultMedeValue
	Defaults.SancarValue      = defaultSancarValue
	Defaults.UlfricValue      = defaultUlfricValue
	while (!CoinData.ready)
		utility.wait(0.1)
	endWhile
	Defaults.setDefaultCoinValues()
	coinStates = new String[10]
	coinStates[0] = "Mallari"
	coinStates[1] = "Drakr"
	coinStates[2] = "Mala"
	coinStates[3] = "Dram"
	coinStates[4] = "Nchuark"
	coinStates[5] = "GibberMania"
	coinStates[6] = "GibberDementia"
	coinStates[7] = "Mede"
	coinStates[8] = "Sancar"
	coinStates[9] = "Ulfric"
endFunction

function buildSettingsPage()
	setCursorFillMode(TOP_TO_BOTTOM)
	bool autoExchange = CoinData.PlayerAlias.autoExchange
	bool verbose = CoinData.PlayerAlias.verbose
	int verboseFlags = OPTION_FLAG_DISABLED * ((!autoExchange) as int)
	AddToggleOptionST("toggleAutoExchange", "$COIN_LABEL_AUTOEXCHANGE", autoExchange)
	AddToggleOptionST("toggleVerboseExchange", "$COIN_LABEL_VERBOSE", verbose, verboseFlags)
endFunction

int function addCoinsListEntry(MiscObject coin, float value = -1.0, string name = "")
	if(name == "")
		name = coin.getName()
	endIf
	if(value < 0.0)
		value = CoinData.getCoinValue(coin)
	endIf
	coinForms[currentIndex] = coin
	coinNames[currentIndex] = name
	coinValues[currentIndex] = value
	currentIndex += 1
	return currentIndex
endFunction

int function buildCoinsList()
	int numDrakrAlts = 4 ; 5 drakrs share one entry
	currentIndex = 0
	int numCoins = CoinData.getNumCoins() - numDrakrAlts
	coinForms = Utility.createFormArray(numCoins)
	coinNames = Utility.createStringArray(numCoins)
	coinValues = Utility.createFloatArray(numCoins)
	addCoinsListEntry(Defaults.DES_Mallari,    Defaults.MallariValue)
	addCoinsListEntry(None,                    Defaults.DrakrValue, Defaults.DES_DrakrDragon.getName())
	addCoinsListEntry(Defaults.DES_Mala,       Defaults.MalaValue)
	addCoinsListEntry(Defaults.DES_Dram,       Defaults.DramValue)	
	addCoinsListEntry(Defaults.DES_Nchuark,    Defaults.NchuarkValue)
	addCoinsListEntry(Defaults.DES_GibberFront,Defaults.GibberFrontValue, "Gibber (Mania)")
	addCoinsListEntry(Defaults.DES_GibberBack, Defaults.GibberBackValue, "Gibber (Dementia)")
	addCoinsListEntry(Defaults.DES_Mede,       Defaults.MedeValue)
	addCoinsListEntry(Defaults.DES_Sancar,     Defaults.SancarValue)
	addCoinsListEntry(Defaults.DES_Ulfric,     Defaults.UlfricValue)
;	int i = 0
;	while(i < coinsMaxIndex && currentIndex < numCoins)
;		MiscObject coin = CoinData.getCoin(i)
;		string coinName = coin.getName()
;		if(coinNames.find(coinName) < 0)
;			addCoinsListEntry(coin, name = coinName)
;		endIf
;		i += 1
;	endWhile
	return CoinData.getNumCoins()
endFunction

function buildCoinsPage()
	;if(CoinData.getNumCoins() > coinsMaxIndex) ; rebuild coin arrays if they're out of date
		coinsMaxIndex = buildCoinsList()
	;endIf
	setCursorFillMode(TOP_TO_BOTTOM)
	int i = 0
	int numCoins = coinNames.length
	while(i < numCoins)
		if(i < Defaults.numDefaultCoins)
			IF coinForms[i].HasKeyword(DES_NoMCM)
				AddSliderOptionST(coinStates[i], coinNames[i], coinValues[i], "$COIN_FORMAT_VALUE", OPTION_FLAG_DISABLED)
			ELSE
				AddSliderOptionST(coinStates[i], coinNames[i], coinValues[i], "$COIN_FORMAT_VALUE")
			ENDIF
;		else; non default coins are handled by index instead of name
;			AddSliderOption(coinNames[i], coinValues[i], "$COIN_FORMAT_VALUE")
		endIf
		i += 1
	endWhile
endFunction

Event OnPageReset(string page)
	if(page == Pages[0])
		buildSettingsPage()
	elseif(page == Pages[1])
		buildCoinsPage()
	endIf
endEvent

Event OnConfigClose()
	Defaults.setDefaultCoinValues()
	int i = Defaults.numDefaultCoins
	int n = coinForms.length
	while(i < n)
		Form f = coinForms[i]
		MiscObject coin = f as MiscObject
		float value = coinValues[i]
		if(coin)
			CoinData.setCoinValue(coin, value)
		endIf
		i += 1
	endWhile
endEvent

state toggleAutoExchange
	Event OnHighlightST()
		setInfoText("$COIN_INFO_AUTOEXCHANGE")
	endEvent
	Event OnDefaultST()
		CoinData.PlayerAlias.autoExchange = autoExchangeDefault
		SetToggleOptionValueST(autoExchangeDefault, true)
		int verboseFlags = OPTION_FLAG_DISABLED * ((!autoExchangeDefault) as int)
		SetOptionFlagsST(verboseFlags, false, "toggleVerboseExchange")
	endEvent
	Event OnSelectST()
		bool autoExchange = !CoinData.PlayerAlias.autoExchange
		CoinData.PlayerAlias.autoExchange = autoExchange
		SetToggleOptionValueST(autoExchange, true)
		int verboseFlags = OPTION_FLAG_DISABLED * ((!autoExchange) as int)
		SetOptionFlagsST(verboseFlags, false, "toggleVerboseExchange")
	endEvent
endState

state toggleVerboseExchange
	Event OnHighlightST()
		setInfoText("$COIN_INFO_VERBOSE")
	endEvent
	Event OnDefaultST()
		CoinData.PlayerAlias.verbose = verboseDefault
		SetToggleOptionValueST(verboseDefault)
	endEvent
	Event OnSelectST()
		bool verbose = !CoinData.PlayerAlias.verbose
		CoinData.PlayerAlias.verbose = verbose
		SetToggleOptionValueST(verbose)
	endEvent
endState

state Mallari
	Event OnHighlightST()
		setInfoText("$MALLARI_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.MallariValue = defaultMallariValue
		SetSliderOptionValueST(defaultMallariValue, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.MallariValue)
		SetSliderDialogDefaultValue(defaultMallariValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.MallariValue = value
		coinValues[0] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Drakr
	Event OnHighlightST()
		setInfoText("$DRAKR_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.DrakrValue = defaultDrakrValue
		SetSliderOptionValueST(defaultDrakrValue, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.DrakrValue)
		SetSliderDialogDefaultValue(defaultDrakrValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.DrakrValue = value
		coinValues[1] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Mala
	Event OnHighlightST()
		setInfoText("$MALA_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.MalaValue = defaultMalaValue
		SetSliderOptionValueST(defaultMalaValue, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.MalaValue)
		SetSliderDialogDefaultValue(defaultMalaValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.MalaValue = value
		coinValues[2] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Dram
	Event OnHighlightST()
		setInfoText("$DRAM_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.DramValue = defaultDramValue
		SetSliderOptionValueST(defaultDramValue, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.DramValue)
		SetSliderDialogDefaultValue(defaultDramValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.DramValue = value
		coinValues[3] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Nchuark
	Event OnHighlightST()
		setInfoText("$NCHUARK_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.NchuarkValue = defaultNchuarkValue
		SetSliderOptionValueST(defaultNchuarkValue, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.NchuarkValue)
		SetSliderDialogDefaultValue(defaultNchuarkValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.NchuarkValue = value
		coinValues[4] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state GibberMania
	Event OnHighlightST()
		setInfoText("$GIBBERMANIA_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.GibberFrontValue = defaultGibberMania
		SetSliderOptionValueST(defaultGibberMania, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.GibberFrontValue)
		SetSliderDialogDefaultValue(defaultGibberMania)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.GibberFrontValue = value
		coinValues[5] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state GibberDementia
	Event OnHighlightST()
		setInfoText("$GIBBERDEMENTIA_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.GibberBackValue = defaultGibberDementia
		SetSliderOptionValueST(defaultGibberDementia, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.GibberBackValue)
		SetSliderDialogDefaultValue(defaultGibberDementia)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.GibberBackValue = value
		coinValues[6] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Mede
	Event OnHighlightST()
		setInfoText("$MEDE_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.MedeValue = defaultMedeValue
		SetSliderOptionValueST(defaultMedeValue, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.MedeValue)
		SetSliderDialogDefaultValue(defaultMedeValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.MedeValue = value
		coinValues[7] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Sancar
	Event OnHighlightST()
		setInfoText("$SANCAR_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.SancarValue = defaultSancarValue
		SetSliderOptionValueST(defaultSancarValue, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.SancarValue)
		SetSliderDialogDefaultValue(defaultSancarValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.SancarValue = value
		coinValues[8] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

state Ulfric
	Event OnHighlightST()
		setInfoText("$ULFRIC_INFO_TEXT")
	endEvent
	Event OnDefaultST()
		Defaults.UlfricValue = defaultUlfricValue
		SetSliderOptionValueST(defaultUlfricValue, "$COIN_FORMAT_VALUE")
	endEvent
	Event OnSliderOpenST()
		SetSliderDialogStartValue(Defaults.UlfricValue)
		SetSliderDialogDefaultValue(defaultUlfricValue)
		SetSliderDialogRange(0.0, maxCoinValue)
		SetSliderDialogInterval(0.05)
	endEvent
	Event OnSliderAcceptST(float value)
		Defaults.UlfricValue = value
		coinValues[9] = value
		SetSliderOptionValueST(value, "$COIN_FORMAT_VALUE")
	endEvent
endState

;Event OnOptionSliderOpen(int option)
;	int index = option/2
;	float value = coinValues[index]
;	SetSliderDialogStartValue(value)
;	SetSliderDialogDefaultValue(value)
;	SetSliderDialogRange(0.0, maxCoinValue)
;	SetSliderDialogInterval(0.05)
;endEvent
;
;Event OnOptionSliderAccept(int option, float value)
;	int index = option/2
;	coinValues[index] = value
;	SetSliderOptionValue(option, value, "$COIN_FORMAT_VALUE")
;endEvent

;state TemplateStateCloneMe
;	Event onHighlightST() ; text, toggles, sliders, menus, colors, keymaps, inputs
;	endEvent
;	Event onDefaultST() ; text, toggles, sliders, menus, colors, keymaps, inputs
;	endEvent
;	Event onSelectST() ; text, toggles
;	endEvent
;	Event onSliderOpenST() ; sliders
;	endEvent
;	Event onSliderAcceptST(float value) ; sliders
;	endEvent
;	Event onMenuOpenST() ; menus
;	endEvent
;	Event onMenuAcceptST(int index) ; menus
;	endEvent
;	Event onColorOpenST() ; colors
;	endEvent
;	Event onColorAcceptST(int color) ; colors
;	endEvent
;	Event onKeyMapChangeST(int keyCode, string conflictControl, string conflictName) ; keymaps
;	endEvent
;	Event onInputOpenST() ; inputs
;	endEvent
;	Event onInputAcceptST(string value) ; inputs
;	endEvent
;endState