"
I am an ICCheckBox: a labelled box that shows a tick when my value is 1.
Unlike my siblings, my click target is the box, not the button: clicking the label does nothing. I latch, so one click leaves the tick showing.

```language=Pharo
	ICCheckBox new
		inputText: 'SYNC';
		callback: [ :v | v traceCr ];
		yourself
```
Sizing follows the family pattern: widgetSize: is my only size parameter and everything derives from it through applySize. My box takes three eighths of my shorter side (_clickBoxRatio_) and my tick fills it (_fontSizeRatio_):
```language=Pharo
	self new inputText: 'SYNC'; widgetSize: 160.
```
Send inputText: before widgetSize: so the label exists when the font is derived.

The tick is added once at build time and shown or hidden by applyCheckVisibility.

Override checkGlyph to use a different mark:
```language=Pharo
	ICCheckBox >> checkGlyph
		^ (Unicode value: 16r2717) asString
```
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

{ #category : 'size' }
ICCheckBox >> applyButtonSize [

	super applyButtonSize.
	clickBox ifNotNil: [
			clickBox
				geometry:
					(BlRoundedRectangleGeometry cornerRadius: self cornerRadius);
				extent: self clickBoxSize;
				border: (BlBorder paint: Color darkGray width: self borderWidth) ].
	clickSymbol ifNotNil: [
		clickSymbol text: (self labelText: self checkGlyph color: Color red) ].
	self applyCheckVisibility
]

{ #category : 'initialization' }
ICCheckBox >> applyCheckVisibility [
	clickSymbol ifNotNil: [
		self currentValue = 0
			ifTrue: [ clickSymbol visibility: BlVisibility hidden ]
			ifFalse: [ clickSymbol visibility: BlVisibility visible ] ]
]

{ #category : 'size' }
ICCheckBox >> checkGlyph [
	^ (Unicode value: 16r2713) asString
]

{ #category : 'evaluating' }
ICCheckBox >> clickBox [

^ clickBox
]

{ #category : 'evaluating' }
ICCheckBox >> clickBox: aBlElement [

clickBox := aBlElement 
]

{ #category : 'defaults' }
ICCheckBox >> clickBoxRatio [
	^ 3 / 8
]

{ #category : 'size' }
ICCheckBox >> clickBoxSize [
	^ (self sizeUnit * self clickBoxRatio) asPoint
]

{ #category : 'accessing' }
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
	clickSymbol := BlTextElement new
		               constraintsDo: [ :c |
			               c frame horizontal alignCenter.
			               c frame vertical alignCenter ];
		               yourself.
	clickBox addChild: clickSymbol
]

{ #category : 'initialization' }
ICCheckBox >> toggle [
	self toggleValue.
	self applyCheckVisibility
]
