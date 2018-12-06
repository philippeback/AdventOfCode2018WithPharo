Class {
	#name : #AoCDay6,
	#superclass : #Object,
	#category : #AdventOfCode2018
}

{ #category : #examples }
AoCDay6 class >> part1 [
	<example>
	| selector engine coordinates minCoordinatedGrid filteredOutGrid areas computationDuration |
	selector := #puzzleInputSample.
	selector := #puzzleInput.
	engine := AoCDay6 new.
	coordinates := engine coordinates: (engine perform: selector).
	computationDuration := [ minCoordinatedGrid := engine
		computeCoordinatesAtMinimumDistanceFromCoordinates: coordinates.
	filteredOutGrid := engine filterOutItemsOfInfiniteSurfaces: minCoordinatedGrid.
	areas := engine countAreas: filteredOutGrid ] timeToRun.
	{(#computationDuration -> computationDuration).
	(#computed -> filteredOutGrid).
	(#areas -> areas).
	(#maxarea -> areas values max)} asDictionary inspect
]

{ #category : #examples }
AoCDay6 class >> part2 [
	<example>
	| selector engine coordinates computationDuration regionSize |
	selector := #puzzleInputSample.
	selector := #puzzleInput.
	engine := AoCDay6 new.
	coordinates := engine coordinates: (engine perform: selector).
	computationDuration := [ regionSize := engine computeDistancesForCoordinates: coordinates within: 10000.
	 ] timeToRun.
	{(#computationDuration -> computationDuration).
	(#regionSize -> regionSize)} asDictionary inspect
]

{ #category : #initialize }
AoCDay6 >> compute: coordinates [
	|  bounds origin corner grid  |
	bounds := coordinates asPointArray bounds.
	origin := bounds origin.
	corner := bounds corner.

	grid := Array2D rows: corner y columns: corner x tabulate: [ :r :c | 
		coordinates copy
			collect: [ :aCoordinate | aCoordinate -> (self manhattanDistanceBetween: aCoordinate and: c@r) ] ].
		
	^grid
	

]

{ #category : #initialize }
AoCDay6 >> computeCoordinatesAtMinimumDistanceFromCoordinates: coordinates [
	|  bounds origin corner grid  |
	bounds := coordinates asPointArray bounds.
	origin := bounds origin.
	corner := bounds corner.

	grid := Array2D rows: corner y columns: corner x tabulate: [ :r :c | 
		| distancesForCoordinates minDistance minCoordinate equidistants key |
	
		distancesForCoordinates := (coordinates copy
			collect: [ :aCoordinate | 
				aCoordinate -> (self manhattanDistanceBetween: aCoordinate and: c@r) ]) asDictionary.
	
		minDistance := distancesForCoordinates values min.
	
		equidistants := 0.
		distancesForCoordinates associationsDo: [:association | 
			minDistance = association value ifTrue: [ key := association key. equidistants := equidistants +1 ]].

		minCoordinate := equidistants = 1 ifTrue: [  key ] ifFalse: [ nil ].
		minCoordinate].
	^grid
	

]

{ #category : #initialize }
AoCDay6 >> computeDistances: coordinates [
	|  bounds origin corner grid  |
	bounds := coordinates asPointArray bounds.
	origin := bounds origin.
	corner := bounds corner.

	grid := Array2D rows: corner y columns: corner x tabulate: [ :r :c | 
		| distancesForCoordinates minDistance minCoordinate equidistants key |
	
		distancesForCoordinates := (coordinates copy
			collect: [ :aCoordinate | 
				aCoordinate -> (self manhattanDistanceBetween: aCoordinate and: c@r) ]) asDictionary.
	
		minDistance := distancesForCoordinates values min.
	
		equidistants := 0.
		distancesForCoordinates associationsDo: [:association | 
			minDistance = association value ifTrue: [ key := association key. equidistants := equidistants +1 ]].

		minCoordinate := equidistants = 1 ifTrue: [  key ] ifFalse: [ nil ].
		minCoordinate].
	^grid
	

]

{ #category : #initialize }
AoCDay6 >> computeDistancesForCoordinates: coordinates within: aTotalDistance [
	|  bounds regionSize |
	bounds := coordinates asPointArray bounds.

	regionSize := 0.
	
	bounds origin y to: bounds corner y do: [:r |
		bounds origin x to: bounds corner x do: [:c |
			 
		| distancesForCoordinates |
	
		distancesForCoordinates := coordinates collect: [ :aCoordinate | self manhattanDistanceBetween: aCoordinate and: c@r ].
		distancesForCoordinates sum < aTotalDistance ifTrue: [ regionSize := regionSize + 1 ].
		]].
	^regionSize
	

]

{ #category : #'as yet unclassified' }
AoCDay6 >> coordinates: someInput [

	^ self puzzleInput lines collect: [ :line | ((line copyReplaceAll: ' ' with: '') splitOn: $,) in: [ :pair | (pair first asInteger) @ (pair second asInteger) ] ]
]

{ #category : #initialize }
AoCDay6 >> countAreas: aGrid [

	| groups |
	groups := aGrid asArray groupedBy: [ :each | each ].
	groups removeKey: nil.
	^ groups collect:  [ :each | each size ]
]

{ #category : #initialize }
AoCDay6 >> filterOutItemsOfInfiniteSurfaces: aMinCoordinatedGrid [
	| rows columns excludedCoordinates coord filtered |
	rows := aMinCoordinatedGrid numberOfRows.
	columns := aMinCoordinatedGrid numberOfColumns.
	
	excludedCoordinates := {
	aMinCoordinatedGrid atRow: 1.
	aMinCoordinatedGrid atRow: rows.
	aMinCoordinatedGrid atColumn: 1.
	aMinCoordinatedGrid atColumn: columns.
	} flattened asSet.
	
	
	filtered := Array2D 
		rows: rows
		columns: columns
		tabulate: [ :r :c | 
			coord :=  aMinCoordinatedGrid at: r at: c. 
			(excludedCoordinates anySatisfy: [ :each | each = coord ]) 
				ifTrue: [  nil  ]
				ifFalse: [ coord ] ].
			
	^filtered
]

{ #category : #'as yet unclassified' }
AoCDay6 >> manhattanDistanceBetween: aPoint and: anotherPoint [

	^ (aPoint x - anotherPoint x) abs + (aPoint y - anotherPoint y) abs
]

{ #category : #'as yet unclassified' }
AoCDay6 >> puzzleInput [

^'66, 204
55, 226
231, 196
69, 211
69, 335
133, 146
321, 136
220, 229
148, 138
42, 319
304, 181
101, 329
72, 244
242, 117
83, 237
169, 225
311, 212
348, 330
233, 268
99, 301
142, 293
239, 288
200, 216
44, 215
353, 289
54, 73
73, 317
55, 216
305, 134
343, 233
227, 75
139, 285
264, 179
349, 263
48, 116
223, 60
247, 148
320, 232
60, 230
292, 78
247, 342
59, 326
333, 210
186, 291
218, 146
205, 246
124, 204
76, 121
333, 137
117, 68'
]

{ #category : #'as yet unclassified' }
AoCDay6 >> puzzleInputSample [
^'1, 1
1, 6
8, 3
3, 4
5, 5
8, 9'
]
