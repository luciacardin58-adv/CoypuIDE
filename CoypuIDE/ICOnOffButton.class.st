"
I am an On/Off button to be used to toggle between states (On/Off , Start/Stop).

Use label: to change the the textLabel
"
Class {
	#name : 'ICOnOffButton',
	#superclass : 'ICButton',
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'examples' }
ICOnOffButton class >> exampleThreeSizes [ 

	<script>
	| container |
	container := BlElement new
		             layout: (BlGridLayout new
				              columnCount: 3;
				              cellSpacing: 20;
				              yourself);
		             padding: (BlInsets all: 20);
		             background: Color veryVeryDarkGray;
		             constraintsDo: [ :c |
			             c horizontal fitContent.
			             c vertical fitContent ];
		             yourself.

	#( 40 80 160 ) do: [ :each |
		| onOff |
		onOff := self new widgetSize: each.
		each = 80 ifTrue: [ onOff toggle ].
		container addChild: onOff ].

	container openInSpace
]

{ #category : 'size' }
ICOnOffButton >> applyButtonSize [
	super applyButtonSize.
	button
		border: (BlBorder paint: Color black width: self borderWidth);
		effect: (BlGaussianShadowEffect
				 color: (Color black alpha: 1.0)
				 offset: self borderWidth @ 0
				 width: self shadowWidth).
	self applyLabelSize
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
	self addChild: button.
	self initializeLabel
]

{ #category : 'accessing' }
ICOnOffButton >> labelColor [
	^ Color black


]

{ #category : 'accessing' }
ICOnOffButton >> labelString [
	^ inputText ifNil: [
		  self currentValue = 0
			  ifTrue: [ 'OFF' ]
			  ifFalse: [ 'ON' ] ]
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

{ #category : 'size' }
ICOnOffButton >> toggle [
	self toggleValue.
	self currentValue = 0
		ifTrue: [
			button
				background: (Color gray alpha: 1.0);
				border: (BlBorder paint: Color black width: self borderWidth);
				effect: (BlGaussianShadowEffect
						 color: (Color black alpha: 1.0)
						 offset: self borderWidth @ 0
						 width: self shadowWidth) ]
		ifFalse: [
			button
				background: (Color white alpha: 1.0);
				border: (BlBorder paint: Color gray width: self glowBorderWidth);
				effect: (BlGaussianShadowEffect
						 color: (Color gray alpha: 1.0)
						 offset: 0 @ 0
						 width: self glowWidth) ].
	self applyLabelSize
]
