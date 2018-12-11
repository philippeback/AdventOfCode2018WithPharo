Class {
	#name : #AoCDay11Test,
	#superclass : #TestCase,
	#category : #AdventOfCode2018
}

{ #category : #tests }
AoCDay11Test >> testFirst [ 

	"For example, to find the power level of the fuel cell at 3,5 in a grid with serial number 8:
	

    The rack ID is 3 + 10 = 13.
    The power level starts at 13 * 5 = 65.
    Adding the serial number produces 65 + 8 = 73.
    Multiplying by the rack ID produces 73 * 13 = 949.
    The hundreds digit of 949 is 9.
    Subtracting 5 produces 9 - 5 = 4.

So, the power level of this fuel cell is 4."

		
	self assert: (AoCDay11 new fuelCellPowerLevelAtX: 3 andY: 5 forGridSerialNumber: 8) equals: 4.
	
"Fuel cell at  122,79, grid serial number 57: power level -5.
Fuel cell at 217,196, grid serial number 39: power level  0.
Fuel cell at 101,153, grid serial number 71: power level  4"

	self assert: (AoCDay11 new fuelCellPowerLevelAtX: 123 andY: 79 forGridSerialNumber: 57) equals: -5.
	self assert: (AoCDay11 new fuelCellPowerLevelAtX: 217 andY: 196 forGridSerialNumber: 39) equals: 0.
	self assert: (AoCDay11 new fuelCellPowerLevelAtX: 101 andY: 153 forGridSerialNumber: 71) equals: 4.


	
]

{ #category : #tests }
AoCDay11Test >> testGrid300x300 [
	| aGrid engine |
	engine := AoCDay11 new grid300x300ForSerialNumber: 18.
	aGrid := engine
]

{ #category : #tests }
AoCDay11Test >> testLargestForGrid300x300AndSerial18 [
	| aGrid enigne engine totals coordinates |
	engine := AoCDay11 new.
	aGrid := engine grid300x300ForSerialNumber: 18.
	"For grid serial number 18, the largest total 3x3 square has a top-left corner of 33,45 (with a total power of 29)"
	totals := engine totalsForGrid: aGrid.
	
	coordinates := engine topLeftCoordinatesOfMax: totals.
	
	self assert: coordinates equals: 33@45.
	self assert: (totals at: #maxsum) equals: 29
	
	
	
]

{ #category : #tests }
AoCDay11Test >> testLargestForGrid300x300AndSerial8979 [
	| aGrid enigne engine totals coordinates |
	engine := AoCDay11 new.
	aGrid := engine grid300x300ForSerialNumber: 8979.
	"For grid serial number 18, the largest total 3x3 square has a top-left corner of 33,45 (with a total power of 29)"
	totals := engine totalsForGrid: aGrid.
	
	coordinates := engine topLeftCoordinatesOfMax: totals.
	
	self assert: coordinates equals: 33@34.
	self assert: (totals at: #maxsum) equals: 29
	
	
	
]

{ #category : #tests }
AoCDay11Test >> testLargestForGrid300x300AndSerial8979OfSide3 [
	| aGrid  engine totals coordinates absoluteTotal absoluteTopLeftCoordinates absoluteGridSide |
	
	self timeLimit: 5 minutes.
	
    "For grid serial number 18, the largest total square (with a total power of 113) is 16x16 and has a top-left corner of 90,269, so its identifier is 90,269,16.
    For grid serial number 42, the largest total square (with a total power of 119) is 12x12 and has a top-left corner of 232,251, so its identifier is 232,251,12."

	
	engine := AoCDay11 new.
	aGrid := engine grid300x300ForSerialNumber: 18.
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
	
	
	self assert: absoluteTopLeftCoordinates equals: 33@45.
	self assert: absoluteTotal equals: 29.
	Halt now.
	
	
]

{ #category : #tests }
AoCDay11Test >> testLargestForGrid300x300AndSerial8979OfSideN [
	| aGrid  engine totals coordinates absoluteTotal absoluteTopLeftCoordinates absoluteGridSide |
	
	self timeLimit: 5 minutes.
	
"For grid serial number 18, the largest total square (with a total power of 113) is 16x16 and has a top-left corner of 90,269, so its identifier is 90,269,16."

	
	engine := AoCDay11 new.
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
	
	
	self assert: absoluteTopLeftCoordinates equals: 90@269.
	self assert: absoluteTotal equals: 113.
	self assert: absoluteGridSide equals: 16
	
	
	
]
