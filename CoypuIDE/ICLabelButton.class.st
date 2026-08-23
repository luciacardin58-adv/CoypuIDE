"
A button with a label.
By default a click button, can become a toggle by sending the message isToggleable: true
"
Class {
	#name : 'ICLabelButton',
	#superclass : 'ICButton',
	#instVars : [
		'inputText',
		'inputLabel'
	],
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'instance creation' }
ICLabelButton class >> fromDictionary: aDictionary forDsp: aDsp [

	| paramLabel btn paramLabelAndType |
	paramLabel := (aDictionary at: #address) afterLastSlash .
	"we split the actual label from its type"
	paramLabelAndType := paramLabel splitOn: $~.
	btn := self label: (paramLabelAndType at: 1).
	btn callback: [ :x | aDsp setValue: x parameter: paramLabel ].
	"if the button is a checkbox"

	paramLabelAndType size > 1 ifTrue: [ btn isToggleable: true ].

	^ btn
]

{ #category : 'accessing' }
ICLabelButton class >> label: aString [
	^ self new label: aString
]

{ #category : 'size' }
ICLabelButton >> applyButtonSize [
	"I hug my label, so my button takes padding and corner radius, not a size."

	button
		geometry: (BlRoundedRectangleGeometry cornerRadius: self cornerRadius);
		padding: (BlInsets all: self widgetPadding);
		border: (BlBorder paint: Color darkGray width: self borderWidth);
		effect: (BlGaussianShadowEffect
				 color: (Color gray alpha: 1.0)
				 offset: 0 @ 0
				 width: self shadowWidth).
	self applyLabelSize
]

{ #category : 'accessing' }
ICLabelButton >> backColor [ 
	^Color veryVeryDarkGray.
]

{ #category : 'accessing' }
ICLabelButton >> buttonColor [ 
	"^ Color lightGreen ."
	"^Color cyan."
	^ Color yellow.

]

{ #category : 'evaluating' }
ICLabelButton >> configuredString: aString [
	^ aString asRopedText attributes: {
			  (BlTextForegroundAttribute paint: Color black).
			  BlFontWeightAttribute bold.
			  (BlFontSizeAttribute size: self fontSize) }
]

{ #category : 'evaluating' }
ICLabelButton >> configuredStringDark: aString [
	^ aString asRopedText attributes: {
			  (BlTextForegroundAttribute paint: Color white).
			  BlFontWeightAttribute bold.
			  (BlFontSizeAttribute size: self fontSize) }

]

{ #category : 'defaults' }
ICLabelButton >> defaultFitsContent [

^ true
]

{ #category : 'defaults' }
ICLabelButton >> defaultOffColor [
	^ Color veryVeryDarkGray
]

{ #category : 'size' }
ICLabelButton >> glowBorderWidth [
	^ ((self borderWidth * 3 / 4) max: 1) rounded

]

{ #category : 'accessing' }
ICLabelButton >> glowColor [ 
	"^ Color green ."
	"^ Color lightBlue."
	^ Color yellow.

]

{ #category : 'size' }
ICLabelButton >> glowWidth [
	^ self sizeUnit * self glowWidthRatio
]

{ #category : 'defaults' }
ICLabelButton >> glowWidthRatio [
	^ 1 / 4
]

{ #category : 'initialization' }
ICLabelButton >> initializeButton [
	self button: (BlElement new
			 background: self offColor;
			 layout: BlFrameLayout new;
			 constraintsDo: [ :c |
				 c horizontal fitContent.
				 c vertical fitContent ];
			 yourself).
	self addChild: button
]

{ #category : 'initialization' }
ICLabelButton >> initializeLabel [
	inputLabel ifNil: [
		inputLabel := BlTextElement new
			              constraintsDo: [ :c |
				              c frame horizontal alignCenter.
				              c frame vertical alignCenter ];
			              yourself.
		self button addChild: inputLabel ].
	self applyLabelSize
]

{ #category : 'initialization' }
ICLabelButton >> initializeWidget [
	self background: self backColor.
	self layout: BlGridLayout horizontal

]

{ #category : 'size' }
ICLabelButton >> initializeWidgetSize [ 
	widgetSize:= 200@200.
]

{ #category : 'accessing' }
ICLabelButton >> inputText [ 
	^ inputText.
]

{ #category : 'accessing' }
ICLabelButton >> inputText: aString [
	inputText := aString.
	self applyLabelSize
]

{ #category : 'accessing' }
ICLabelButton >> label: aString [
	inputText := aString.
	self initializeLabel
]

{ #category : 'evaluating' }
ICLabelButton >> lightDown [
	button
		background: (self buttonColor alpha: 1.0);
		border: (BlBorder paint: (self glowColor alpha: 0.5) width: self glowBorderWidth);
		effect: (BlGaussianShadowEffect
				 color: (self glowColor alpha: 1.0)
				 offset: 0 @ 0
				 width: self glowWidth).
	inputLabel text: (self configuredString: inputText)
]

{ #category : 'evaluating' }
ICLabelButton >> lightUp [
	button
		background: (self offColor alpha: 1.0);
		border: (BlBorder paint: Color darkGray width: self borderWidth);
		effect: (BlGaussianShadowEffect
				 color: (Color white alpha: 0.0)
				 offset: 0 @ 0
				 width: self shadowWidth).
	inputLabel text: (self configuredStringDark: inputText)
]

{ #category : 'accessing' }
ICLabelButton >> offColor [ 
	^ Color veryVeryDarkGray.
]

{ #category : 'evaluating' }
ICLabelButton >> toggle [
	self toggleValue.
	self value = 0
		ifTrue: [ self lightUp ]
		ifFalse: [ self lightDown ]
]
