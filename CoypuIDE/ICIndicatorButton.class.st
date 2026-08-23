"
I am an ICIndicatorButton: a round LED-style indicator that shows red when my value is 0
and green when it is 1. My glow always matches my current colour.

I am an ICButton, so a click toggles me and runs my callback:
```language=Pharo
	ICIndicatorButton new
		callback: [ :v | v traceCr ];
		yourself
```
Sizing follows the family pattern. widgetSize: is my only size parameter, it accepts a
number or a point, and everything else derives from it through applySize:

	self new widgetSize: 160.
	self new widgetSize: 120 @ 80.

My disk takes half my shorter side (buttonInsetRatio) and my glow five sixteenths of it
(shadowWidthRatio). Override either ratio to change my proportions, or indicatorColor to
change my palette:
```language=Pharo
	ICIndicatorButton >> indicatorColor
		^ self value = 0 ifTrue: [ Color brown ] ifFalse: [ Color yellow ]
```
resetSize puts me back to 80 @ 80.

"
Class {
	#name : 'ICIndicatorButton',
	#superclass : 'ICButton',
	#category : 'CoypuIDE-button',
	#package : 'CoypuIDE',
	#tag : 'button'
}

{ #category : 'examples' }
ICIndicatorButton class >> exampleThreeSizes [ 
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
		| indicator |
		indicator := self new widgetSize: each.
		each = 80 ifTrue: [ indicator toggle ].
		container addChild: indicator ].

	container openInSpace

]

{ #category : 'initialization' }
ICIndicatorButton >> applyButtonSize [
	super applyButtonSize.
	button effect: (BlGaussianShadowEffect
			 color: (self indicatorColor alpha: 1.0)
			 offset: 0 @ 0
			 width: self shadowWidth)
]

{ #category : 'size' }
ICIndicatorButton >> buttonInsetRatio [
	^ 1 / 2
]

{ #category : 'accessing' }
ICIndicatorButton >> indicatorColor [
	^ self value = 0 ifTrue: [ Color red ] ifFalse: [ Color green ]
]

{ #category : 'initialization' }
ICIndicatorButton >> initializeButton [
	self button: (BlElement new
			 geometry: BlCircleGeometry new;
			 background: Color red;
			 constraintsDo: [ :c |
				 c frame horizontal alignCenter.
				 c frame vertical alignCenter ];
			 yourself).
	self addChild: self button
]

{ #category : 'defaults' }
ICIndicatorButton >> shadowWidthRatio [
	^ 5 / 16
]

{ #category : 'evaluating' }
ICIndicatorButton >> toggle [
	self toggleValue.
	self value = 0 
		ifTrue: [ button background: (Color red alpha: 1.0);
								effect: (BlGaussianShadowEffect color: (Color red alpha:1.0)   offset: 0@ 0  width: 25).
	 ] 
		ifFalse: [ button background: (Color green alpha:
						1.0);
						effect: (BlGaussianShadowEffect color: (Color green alpha:1.0)   offset: 0@ 0  width: 25).
	].
]
