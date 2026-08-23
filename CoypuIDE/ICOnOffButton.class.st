"
I am an On/Off button to be used to toggle between states (On/Off , Start/Stop).

Use label: to change the the textLabel
"
Class {
	#name : 'ICOnOffButton',
	#superclass : 'ICButton',
	#instVars : [
		'label',
		'textLabel'
	],
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'initialization' }
ICOnOffButton >> applyButtonSize [
	super applyButtonSize.
	button
		border: (BlBorder paint: Color black width: self borderWidth);
		effect: (BlGaussianShadowEffect
				 color: (Color black alpha: 1.0)
				 offset: self borderWidth @ 0
				 width: self shadowWidth).
	textLabel ifNotNil: [
		textLabel text: (self configuredString: self stateText) ]
]

{ #category : 'defaults' }
ICOnOffButton >> buttonInsetRatio [
	^ 5 / 16

]

{ #category : 'evaluating' }
ICOnOffButton >> configuredString: aString [ 
	^ aString asRopedText attributes:{(BlTextForegroundAttribute
	paint: Color black) . (BlFontWeightAttribute bold) . (BlFontSizeAttribute size:18) }

]

{ #category : 'defaults' }
ICOnOffButton >> fontSizeRatio [
	^ 9 / 40

]

{ #category : 'evaluating' }
ICOnOffButton >> fromDictionary: aDictionary forDsp: aDsp [ 
]

{ #category : 'initialization' }
ICOnOffButton >> initializeButton [
	self button: (BlElement new
			 geometry: BlCircleGeometry new;
			 background: Color gray;
			 layout: BlFrameLayout new;
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ];
			 yourself).
	self textLabel: (BlTextElement new
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ];
			 yourself).
	button addChild: self textLabel.
	self addChild: button
]

{ #category : 'accessing' }
ICOnOffButton >> label [ 
	^ label.
]

{ #category : 'accessing' }
ICOnOffButton >> label: aText [

	label := aText.
	textLabel text: (self configuredString: label)
]

{ #category : 'initialization' }
ICOnOffButton >> onfiguredString: aString [
	^ aString asRopedText attributes: {
			  (BlTextForegroundAttribute paint: Color black).
			  BlFontWeightAttribute bold.
			  (BlFontSizeAttribute size: self fontSize) }
]

{ #category : 'defaults' }
ICOnOffButton >> shadowWidthRatio [
	^ 1 / 8
]

{ #category : 'defaults' }
ICOnOffButton >> stateText [
	^ label ifNil: [ self value = 0 ifTrue: [ 'OFF' ] ifFalse: [ 'ON' ] ]
]

{ #category : 'accessing' }
ICOnOffButton >> textLabel [

^ textLabel 
]

{ #category : 'accessing' }
ICOnOffButton >> textLabel: aText [

	textLabel := aText
]

{ #category : 'evaluating' }
ICOnOffButton >> toggle [

	self toggleValue.

	self value = 0
		ifTrue: [
			button
				background: (Color gray alpha: 1.0);
				border: (BlBorder paint: Color black width: 4);
				effect: (BlGaussianShadowEffect
						 color: (Color black alpha: 1.0)
						 offset: 4 @ 0
						 width: 10).
			textLabel text: (self configuredString: 'OFF') ]
		ifFalse: [
			button
				background: (Color white alpha: 1.0);
				border: (BlBorder paint: Color gray width: 3);
				effect: (BlGaussianShadowEffect
						 color: (Color gray alpha: 1.0)
						 offset: 0 @ 0
						 width: 15).
			textLabel text: (self configuredString: 'ON') ]
]
