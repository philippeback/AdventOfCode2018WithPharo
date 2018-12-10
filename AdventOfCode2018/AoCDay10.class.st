Class {
	#name : #AoCDay10,
	#superclass : #Object,
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
	^ parsed collect: [ :each | (each splitOn: $,) in: [ :parts | Point x: parts first asInteger y: parts second asInteger ] ]
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

	| points xmin xmax ymin ymax shiftedPoints form scaledForm |
	points := someData collect: [ :each | (each first x /  500) asInteger @ (each first y / 500) asInteger ].
	
	xmin := (points collect: #x) min.
	xmax := (points collect: #x) max.
	ymin := (points collect: #y) min.
	ymax := (points collect: #y) max.
	
	shiftedPoints := points collect: [ :each | (each x - xmin + 1)@( each y - ymin + 1)  ].
	
	form := (ColorForm extent: (xmax - xmin + 1)@(ymax - ymin + 1)  depth: 32) fillBlack; yourself.
	shiftedPoints do: [ :each | form colorAt: (each x)@(each y) put: Color green].
	scaledForm := form scaledToSize: 800@800.
	^scaledForm
	

]

{ #category : #'as yet unclassified' }
AoCDay10 >> runPart1 [ 
 
	| startingData currentData renderedForm file m w |
	startingData := self data.
	
	currentData := startingData.
	m := (Form extent: 800@800) asMorph.
	w := SystemWindow labelled: 'AoC Day10'.
	w addMorph: m frame: (0@0 corner: 1@1).
	w openInWorld.


	1 to: 50000 do: [ :i |
		
		renderedForm := self render: currentData.
		"file := ('AoC-Day10-RenderPart1-frame{1}.gif' format:{ ('000', i asString) last: 4 }) asFileReference.
		file ensureDelete.
		file binaryWriteStreamDo: [ :out | (GIFReadWriter on: out) nextPutImage: renderedForm ].
		"
		m form: renderedForm.
		World doOneCycle.
		currentData := self update: currentData ]
	
]

{ #category : #'as yet unclassified' }
AoCDay10 >> update: someData [

	^ someData copy collect: [ :each | 
		| point velocity |
		point := each first.
		velocity := each second.
		OrderedCollection with: (point + velocity) with: velocity ]
]
