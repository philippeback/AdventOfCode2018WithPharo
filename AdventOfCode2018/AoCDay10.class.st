Class {
	#name : #AoCDay10,
	#superclass : #Object,
	#instVars : [
		'iteration',
		'factor'
	],
	#category : #AdventOfCode2018
}

{ #category : #parsing }
AoCDay10 class >> parseInput [
	<example>
	self new data inspect
]

{ #category : #parsing }
AoCDay10 class >> runPart1 [
	<example>
	self new runPart1
]

{ #category : #'as yet unclassified' }
AoCDay10 >> data [
	^self puzzleInput collect: [ :line | self extractPointsFrom: line ]
]

{ #category : #'as yet unclassified' }
AoCDay10 >> extractPointsFrom: anInput [
	"anInput:='position=<-50429,  40580> velocity=< 5, -4>'."

	| parsed |
	parsed := (anInput
		reject: [ :e | 
			{Character space.
			$<.
			$>} anySatisfy: [ :each | each = e ] ]) splitOn: $=.
	parsed at: 2 put: ((parsed at: 2) copyReplaceAll: 'velocity' with: '').
	parsed removeFirst.
	^ parsed collect: [ :each |(each splitOn: $,) in: [ :parts | Point x: parts first asInteger y: parts second asInteger] ]
]

{ #category : #'as yet unclassified' }
AoCDay10 >> factor [
	^factor
]

{ #category : #'as yet unclassified' }
AoCDay10 >> factor: aFactor [

	factor := aFactor
]

{ #category : #'as yet unclassified' }
AoCDay10 >> nextIteration [
	^ iteration := (iteration ifNil: [ 0 ]) + 1
]

{ #category : #'as yet unclassified' }
AoCDay10 >> puzzleInput [
	^ (FileLocator imageDirectory / 'in10.txt') asFileReference contents lines
]

{ #category : #'as yet unclassified' }
AoCDay10 >> puzzleInputSample [
	^'position=< 9,  1> velocity=< 0,  2>
position=< 7,  0> velocity=<-1,  0>
position=< 3, -2> velocity=<-1,  1>
position=< 6, 10> velocity=<-2, -1>
position=< 2, -4> velocity=< 2,  2>
position=<-6, 10> velocity=< 2, -2>
position=< 1,  8> velocity=< 1, -1>
position=< 1,  7> velocity=< 1,  0>
position=<-3, 11> velocity=< 1, -2>
position=< 7,  6> velocity=<-1, -1>
position=<-2,  3> velocity=< 1,  0>
position=<-4,  3> velocity=< 2,  0>
position=<10, -3> velocity=<-1,  1>
position=< 5, 11> velocity=< 1, -2>
position=< 4,  7> velocity=< 0, -1>
position=< 8, -2> velocity=< 0,  1>
position=<15,  0> velocity=<-2,  0>
position=< 1,  6> velocity=< 1,  0>
position=< 8,  9> velocity=< 0, -1>
position=< 3,  3> velocity=<-1,  1>
position=< 0,  5> velocity=< 0, -1>
position=<-2,  2> velocity=< 2,  0>
position=< 5, -2> velocity=< 1,  2>
position=< 1,  4> velocity=< 2,  1>
position=<-2,  7> velocity=< 2, -2>
position=< 3,  6> velocity=<-1, -1>
position=< 5,  0> velocity=< 1,  0>
position=<-6,  0> velocity=< 2,  0>
position=< 5,  9> velocity=< 1, -2>
position=<14,  7> velocity=<-2,  0>
position=<-3,  6> velocity=< 2, -1>' lines
]

{ #category : #'as yet unclassified' }
AoCDay10 >> render: someData [

	| shiftedPoints form scaledForm maxX minX maxY minY deltaX deltaY factorY factorX points |
	
	factorX := factorY := self factor.

	((someData at: 1) at: 1) in: [ :point | 
		minX := maxX := point x.
		minY := maxY := point y ].
	
	someData do: [ :each |
		| point  px py |
		point := each first.
		px := point x.
		py := point y.
		minX := minX min: px.
		maxX := maxX max: px.
		minY := minY min: py.
		maxY := maxX max: py.
		 ].
			
	shiftedPoints := someData collect: [ :each | 
		| point |
		point := each first.
		(point x - minX + 10)@( point y - minY + 10)  ].
	
	deltaX := maxX - minX.
	deltaY := maxY - minY.

	deltaY < 30 ifTrue: [ factorX := factorY := 1.
		1 second wait ].	
		
	form := (ColorForm extent: (deltaX // factorX + 100)@(deltaY // factorY + 100)  depth: 8) fillBlack; yourself.	
	shiftedPoints do: [ :each | form colorAt: (each x // factorX)@(each y) // factorY put: Color green].
	scaledForm := form scaledToSize: 900@600.
	^scaledForm
	

]

{ #category : #'as yet unclassified' }
AoCDay10 >> runPart1 [ 
 
	| startingData currentData renderedForm file m w |
	startingData := self data.
	
	currentData := startingData.
	m := (Form extent: 800@800) asMorph.
	w := StandardWindow labelled: 'AoC Day10'.
	w addMorph: m frame: (0@0 corner: 1@1).
	w bounds: World clearArea.
	w openInWorld.

	self factor: 100.
	1 to: 50 do: [ :i | 
		self nextIteration.
		currentData := self update: currentData speedUp: 100 ].
	self factor: 50.
	1 to: 500 do: [ :i | 
		self nextIteration.
		currentData := self update: currentData speedUp: 1 ].
	self factor: 1.
	1 to: 30 do: [ :i |
		self nextIteration.
		renderedForm := self render: currentData.
		
		"file := ('AoC-Day10-RenderPart1-frame{1}.gif' format:{ ('000', i asString) last: 4 }) asFileReference.
		file ensureDelete.
		file binaryWriteStreamDo: [ :out | (GIFReadWriter on: out) nextPutImage: renderedForm ].
		"
		m form: renderedForm.
		World doOneCycle.
		1 second wait.
		currentData := self update: currentData speedUp: 1 ]
	
]

{ #category : #'as yet unclassified' }
AoCDay10 >> update: someData speedUp: speedUp [

	^ someData withIndexDo: [ :each :index | 
		| point velocity |
		point := each first.
		velocity := each second.
		(someData at: index) at: 1 put: (point + (velocity * speedUp)) ]
]
