"
I am an ICButton. I need a label and a callbackDown for MouseDown events and a callBackUp for MouseUp events
"
Class {
	#name : 'ICButton',
	#superclass : 'BlElement',
	#instVars : [
		'widgetSize',
		'button',
		'isOn',
		'currentValue',
		'callbackDown',
		'callBackUp',
		'callback',
		'isToggleable',
		'onColor',
		'offColor',
		'id',
		'fitsContent',
		'buttonEventHandlers'
	],
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'examples' }
ICButton class >> allButtonExamples [
	<script>
	| container e1 e2 e3 e4 e5 e6 |
	container:= BlElement new
		
		geometry: BlRectangleGeometry new;
		layout: (BlGridLayout new
		columnCount: 6;
		cellSpacing: 0
		);
		constraintsDo: [:c |
			c horizontal matchParent.
			c vertical matchParent.
			];
		background: Color darkGray.

e1:= ICIndicatorButton new.
e2:= ICOnOffButton new.
e3:= ICLabelButton label:'MONO'.

	"e1 value.
	e2 value.
	e3 value."
e4:= ICIndicatorButton new.
e5:= ICOnOffButton new.
e6:= ICLabelButton label:'STEREO'.
	e4 toggle.
	e5 toggle.
	e6 setValue:1.
	
	"e4 value.
	e5 value.
	e6 value."
container addChildren: { e1. e4. e2. e5 . e3. e6}.
container openInSpace.

]

{ #category : 'api - events' }
ICButton >> addButtonEventHandler: aHandler [
	self buttonEventHandlers add: aHandler.
	self eventTarget addEventHandler: aHandler
]

{ #category : 'size' }
ICButton >> applyButtonSize [
	"Everything my button wears that depends on size. Subclasses add corner
	radius, border, shadow and label size by overriding me and sending super."

	button size: self buttonSize

]

{ #category : 'size' }
ICButton >> applySize [
	"Single pass: derive every dimension from widgetSize and push it onto the
	parts. Safe to send any number of times, and safe before the parts exist."

	self applyWidgetConstraints.
	self padding: (BlInsets all: self widgetPadding).
	button ifNotNil: [ self applyButtonSize ]
]

{ #category : 'size' }
ICButton >> applyWidgetConstraints [
	"How widgetSize reaches my own extent. Subclasses that hug their content
	answer true to fitsContent and let padding and font drive their size instead."

	self fitsContent
		ifTrue: [
			self constraintsDo: [ :c |
				c horizontal fitContent.
				c vertical fitContent ] ]
		ifFalse: [ self extent: self widgetSize ]
]

{ #category : 'evaluating' }
ICButton >> backColor [
	^ (Color veryVeryDarkGray alpha:1.0)

]

{ #category : 'size' }
ICButton >> borderWidth [
	^ ((self sizeUnit * self borderWidthRatio) max: 1) rounded

]

{ #category : 'defaults' }
ICButton >> borderWidthRatio [
	^ 1 / 20
]

{ #category : 'evaluating' }
ICButton >> button [
	^ button.
]

{ #category : 'evaluating' }
ICButton >> button: anElement [
	button:= anElement.
]

{ #category : 'api - events' }
ICButton >> buttonEventHandlers [
	^ buttonEventHandlers ifNil: [ buttonEventHandlers := OrderedCollection new ]
]

{ #category : 'defaults' }
ICButton >> buttonInsetRatio [
	^ 1 / 4
]

{ #category : 'size' }
ICButton >> buttonSize [
	^ widgetSize - (self sizeUnit * self buttonInsetRatio) asPoint
]

{ #category : 'accessing' }
ICButton >> callBackUp [

	^ callBackUp
]

{ #category : 'accessing' }
ICButton >> callBackUp: aBlock [

	callBackUp := aBlock
]

{ #category : 'accessing' }
ICButton >> callback [

	^ callback ifNil: [ [ :v |  ] ]
]

{ #category : 'accessing' }
ICButton >> callback: aBlock [

	callback := aBlock
]

{ #category : 'accessing' }
ICButton >> callbackDown [

	^ callbackDown
]

{ #category : 'accessing' }
ICButton >> callbackDown: aBlock [

	callbackDown := aBlock
]

{ #category : 'size' }
ICButton >> cornerRadius [
	^ self sizeUnit * self cornerRadiusRatio
]

{ #category : 'defaults' }
ICButton >> cornerRadiusRatio [
	^ 1 / 10
]

{ #category : 'accessing' }
ICButton >> currentValue [ 
^ currentValue 
]

{ #category : 'accessing' }
ICButton >> currentValue: aNumber [
"Bare setter: no toggle, no callback. Use setValue: for the public path."

	currentValue := aNumber 
]

{ #category : 'defaults' }
ICButton >> defaultFitsContent [
	^ false

]

{ #category : 'accessing' }
ICButton >> defaultIsToggleable [
	^ false

]

{ #category : 'defaults' }
ICButton >> defaultOffColor [
	^ Color darkGray
]

{ #category : 'defaults' }
ICButton >> defaultOnColor [

	^ Color yellow
]

{ #category : 'defaults' }
ICButton >> defaultWidgetSize [
	^ 80 @ 80
]

{ #category : 'api - events' }
ICButton >> eventTarget [
	"The element that receives my mouse events. Subclasses that click somewhere
	other than the button itself override me."

	^ button
]

{ #category : 'api - events' }
ICButton >> fire [
	"One place for what a click does, shared by the down and up handlers."

	self toggle.
	self callback value: self currentValue
]

{ #category : 'accessing' }
ICButton >> fitsContent [
	^ fitsContent ifNil: [ fitsContent := self defaultFitsContent ]

]

{ #category : 'accessing' }
ICButton >> fitsContent: aBoolean [
	fitsContent := aBoolean.
	button ifNotNil: [ self applySize ]
]

{ #category : 'size' }
ICButton >> fontSize [
	^ ((self sizeUnit * self fontSizeRatio) max: 6) rounded
]

{ #category : 'defaults' }
ICButton >> fontSizeRatio [
	^ 1 / 5

]

{ #category : 'accessing' }
ICButton >> id [ 
^ id
]

{ #category : 'accessing' }
ICButton >> id: anIntegerOrAString [

	"set an id to the Button to control its behvaiour in compositional contexts"
	id := anIntegerOrAString 
]

{ #category : 'initialization' }
ICButton >> initialize [
	super initialize.
	widgetSize := self defaultWidgetSize.
	self currentValue: 0.
	self onColor: self defaultOnColor.
	self offColor: self defaultOffColor.
	self initializeWidget.
	self initializeClickBox.
	self initializeButton.
	self initializeEvents.
	self applySize
]

{ #category : 'initialization' }
ICButton >> initializeButton [
	"Bare. Size comes from applyButtonSize."

	self button: (BlElement new
			 geometry: BlCircleGeometry new;
			 background: self offColor;
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ];
			 yourself).
	self addChild: self button
]

{ #category : 'initialization' }
ICButton >> initializeClickBox [ 

^ 'Must be implemented in clickBox subclass'
]

{ #category : 'initialization' }
ICButton >> initializeEvents [
	self removeButtonEventHandlers.
	self addButtonEventHandler:
		(BlEventHandler on: BlMouseDownEvent do: [ :anEvent | self fire ]).
	self isToggleable ifFalse: [
		self addButtonEventHandler:
			(BlEventHandler on: BlMouseUpEvent do: [ :anEvent | self fire ]) ]
]

{ #category : 'initialization' }
ICButton >> initializeWidget [
	"No extent, no padding: applySize owns both."

	self background: self backColor.
	self layout: BlFrameLayout new
]

{ #category : 'evaluating' }
ICButton >> initializeWidgetSize [
	widgetSize:= 200@200.
]

{ #category : 'accessing' }
ICButton >> isOn [

	^ isOn
]

{ #category : 'accessing' }
ICButton >> isOn: anObject [

	isOn := anObject
]

{ #category : 'accessing' }
ICButton >> isToggleable [
	^ isToggleable ifNil: [ isToggleable := self defaultIsToggleable ]
]

{ #category : 'accessing' }
ICButton >> isToggleable: aBoolean [
	self isToggleable = aBoolean ifTrue: [ ^ self ].
	isToggleable := aBoolean.
	self eventTarget ifNotNil: [ self initializeEvents ]
]

{ #category : 'accessing' }
ICButton >> offColor [

	^ offColor
]

{ #category : 'accessing' }
ICButton >> offColor: aColor [

	offColor := aColor
]

{ #category : 'accessing' }
ICButton >> onColor [ 
^ onColor
]

{ #category : 'accessing' }
ICButton >> onColor: aColor [

	onColor := aColor
]

{ #category : 'defaults' }
ICButton >> paddingRatio [
	^ 1 / 8

]

{ #category : 'api - events' }
ICButton >> removeButtonEventHandlers [
	self eventTarget ifNil: [ ^ self ].
	self buttonEventHandlers do: [ :each |
		self eventTarget removeEventHandler: each ].
	buttonEventHandlers := OrderedCollection new
]

{ #category : 'size' }
ICButton >> resetSize [
	self widgetSize: self defaultWidgetSize
]

{ #category : 'evaluating' }
ICButton >> setValue: req [
	self currentValue = req ifFalse: [ self toggle ].
	self callback value: req
]

{ #category : 'size' }
ICButton >> shadowWidth [
	^ self sizeUnit * self shadowWidthRatio
]

{ #category : 'defaults' }
ICButton >> shadowWidthRatio [
	^ 1 / 20

]

{ #category : 'size' }
ICButton >> sizeUnit [
	"Scalar reference for all proportional geometry: my shorter side."

	^ widgetSize x min: widgetSize y
]

{ #category : 'evaluating' }
ICButton >> toggle [

	self toggleValue.
	self value = 0
		ifTrue: [ button background: (self offColor alpha:  1.0) ]
		ifFalse: [ button background: (self onColor alpha: 1.0) ]
]

{ #category : 'evaluating' }
ICButton >> toggleValue [
	self currentValue = 0
		ifTrue: [ self currentValue: 1 ]
		ifFalse: [ self currentValue: 0 ]
]

{ #category : 'size' }
ICButton >> widgetPadding [
	^ self sizeUnit * self paddingRatio

]

{ #category : 'accessing' }
ICButton >> widgetSize [
	^ widgetSize
]

{ #category : 'accessing' }
ICButton >> widgetSize: aPointOrNumber [
	"My only size parameter. Accepts 120 or 120 @ 80."

	widgetSize := aPointOrNumber asPoint.
	button ifNotNil: [ self applySize ]
]
