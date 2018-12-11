Class {
	#name : #AoCDay11,
	#superclass : #Object,
	#instVars : [
		'puzzleInput'
	],
	#category : #AdventOfCode2018
}

{ #category : #examples }
AoCDay11 class >> runPart2 [
	<example>
	self new part2 inspect
]

{ #category : #accessing }
AoCDay11 >> fuelCellPowerLevelAtX: x andY: y forGridSerialNumber: aGridSerialNumber [

"The power level in a given fuel cell can be found through the following process:

    Find the fuel cell's rack ID, which is its X coordinate plus 10.
    Begin with a power level of the rack ID times the Y coordinate.
    Increase the power level by the value of the grid serial number (your puzzle input).
    Set the power level to itself multiplied by the rack ID.
    Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
    Subtract 5 from the power level."

	| rackID initialPowerLevel powerLevel digitOfPowerLevel |
	rackID := x + 10.
	initialPowerLevel := rackID * y.
	powerLevel := initialPowerLevel + aGridSerialNumber.
	powerLevel := powerLevel * rackID.
	digitOfPowerLevel := (powerLevel asString) in: [ :powerLevelString |
		powerLevelString size < 3 
			ifTrue: [ 0 ]
		 	ifFalse: [ (powerLevelString allButLast:2) last asString asInteger ] ].
	digitOfPowerLevel := digitOfPowerLevel - 5.
	^ digitOfPowerLevel
	
]

{ #category : #accessing }
AoCDay11 >> grid300x300ForSerialNumber: aGridSerialNumber [

	^ Array2D rows: 300 columns: 300 tabulate: [ :row :col | self fuelCellPowerLevelAtX: col andY: row forGridSerialNumber: aGridSerialNumber  ]
]

{ #category : #accessing }
AoCDay11 >> gridSerialNumber [ 
	^ puzzleInput
]

{ #category : #accessing }
AoCDay11 >> gridSerialNumber: anInteger [
	puzzleInput := anInteger
]

{ #category : #accessing }
AoCDay11 >> part2 [
	
"For grid serial number 18, the largest total square (with a total power of 113) is 16x16 and has a top-left corner of 90,269, so its identifier is 90,269,16."

	
	| engine aGrid absoluteTotal absoluteTopLeftCoordinates absoluteGridSide totals coordinates |
	engine := self.
	aGrid := engine grid300x300ForSerialNumber: 8979.
	"For grid serial number 18, the largest total 3x3 square has a top-left corner of 33,45 (with a total power of 29)"


	absoluteTotal := -999999999.
	absoluteTopLeftCoordinates := -1@1.
	absoluteGridSide := -1.
		
	3 to: 300 do: [ :gridSide |
		totals := engine totalsForGrid: aGrid ofSide: gridSide.
		coordinates := engine topLeftCoordinatesOfMax: totals.
		
		(totals at: #maxsum) > absoluteTotal 
			ifTrue:[
				absoluteTotal := totals at: #maxsum.
				absoluteTopLeftCoordinates := coordinates.
				absoluteGridSide := gridSide.
				]
		].
	
	
	{absoluteTopLeftCoordinates. absoluteTotal. absoluteGridSide}
]

{ #category : #accessing }
AoCDay11 >> sumOfSubgridOfSize: s origin: origin forGrid: g [
| sum |
	sum := 0.
	
		0 to: (s-1) do: [ :x |
			0 to: (s-1) do: [: y |
				sum := sum + (g at: (origin y + y) at: (origin x + x))
				]].
		^sum
]

{ #category : #accessing }
AoCDay11 >> topLeftCoordinatesOfMax: totals [

	| maxSum sums |
	maxSum := totals at: #maxsum.
	sums := totals at: #sums.
	
	^sums keyAtValue: maxSum
]

{ #category : #accessing }
AoCDay11 >> totalsForGrid: g [

	| sums sum maxSum|
	sums := OrderedDictionary new.
	
	maxSum := -999999999.
	
	1 to: (300-2) do: [ :y |
		1 to: (300-2) do: [ :x |
			sum := (g at: y at: x)
			 + (g at: y+1 at: x)
			 + (g at: y+2 at: x)

			 + (g at: y at: x+1)
			 + (g at: y+1 at: x+1)
			 + (g at: y+2 at: x+1)
			 + (g at: y at: x+2)
			 + (g at: y+1 at: x+2)
			 + (g at: y+2 at: x+2).
			
			sums at: x@y put: sum.
			
			maxSum := maxSum max: sum.
			
			 ] ].
	
	^{#maxsum-> maxSum. #sums -> sums} asDictionary
]

{ #category : #accessing }
AoCDay11 >> totalsForGrid: g ofSide: s [

	| sums sum maxSum|
	sums := OrderedDictionary new.
	
	maxSum := -999999999.
	
	1 to: (300-s+1) do: [ :y |
		1 to: (300-s+1) do: [ :x |
			
			sum := self sumOfSubgridOfSize: s origin: x@y forGrid: g.
		
			sums at: x@y put: sum.
			
			maxSum := maxSum max: sum.
			
			 ] ].
	
	^{#maxsum-> maxSum. #sums -> sums} asDictionary
]
