"
A simple checkbox, I have a bhaviour similar to a toggle button, but click is on the box, not on the label
"
Class {
	#name : 'ICCheckBox',
	#superclass : 'ICLabelButton',
	#instVars : [
		'clickBox',
		'clickSymbol'
	],
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'examples' }
ICCheckBox class >> exampleThreeSizes [ 
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
		| box |
		box := self new
			       inputText: 'SYNC';
			       widgetSize: each;
			       yourself.
		each = 80 ifTrue: [ box toggle ].
		container addChild: box ].

	container openInSpace

]

{ #category : 'evaluating' }
ICCheckBox >> clickBox [

^ clickBox
]

{ #category : 'evaluating' }
ICCheckBox >> clickBox: aBlElement [

clickBox := aBlElement 
]

{ #category : 'api - events' }
ICCheckBox >> defaultIsToggleable [
	^ true
]

{ #category : 'api - events' }
ICCheckBox >> eventTarget [
	^ clickBox
]

{ #category : 'initialization' }
ICCheckBox >> initializeClickBox [

	self clickBox: (BlElement new
			 geometry: (BlRoundedRectangleGeometry cornerRadius: 8);
			 background: Color white;
			 layout: BlFrameLayout new;
			 extent: 30 @ 32;
			 border: (BlBorder paint: Color darkGray width: 4)).
	self initializeClickSymbol.
	self addChild: clickBox
]

{ #category : 'initialization' }
ICCheckBox >> initializeClickSymbol [

	| check |
	check := (Unicode value: 16r2713) asRopedText attributes: {
			         (BlTextForegroundAttribute paint: Color red).
			         BlFontWeightAttribute bold.
			         (BlFontSizeAttribute size: 30) }.
	clickSymbol := BlTextElement new text: check.

	clickSymbol constraintsDo: [ :c |
		c frame horizontal alignCenter.
		c frame vertical alignCenter ]
]

{ #category : 'evaluating' }
ICCheckBox >> toggle [

	self toggleValue.
	self value = 0
		ifTrue: [ clickBox removeChild: clickSymbol ]
		ifFalse: [ clickBox addChild: clickSymbol ]
]
