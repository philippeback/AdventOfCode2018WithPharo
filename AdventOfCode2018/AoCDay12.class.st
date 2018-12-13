"
For example, given the following input:

initial state: #..#.#..##......###...###

...## => #
..#.. => #
.#... => #
.#.#. => #
.#.## => #
.##.. => #
.#### => #
#.#.# => #
#.### => #
##.#. => #
##.## => #
###.. => #
###.# => #
####. => #

For brevity, in this example, only the combinations which do produce a plant are listed. (Your input includes all possible combinations.) Then, the next 20 generations will look like this:

                 1         2         3     
       0         0         0         0     
 0: ...#..#.#..##......###...###...........
 1: ...#...#....#.....#..#..#..#...........
 2: ...##..##...##....#..#..#..##..........
 3: ..#.#...#..#.#....#..#..#...#..........
 4: ...#.#..#...#.#...#..#..##..##.........
 5: ....#...##...#.#..#..#...#...#.........
 6: ....##.#.#....#...#..##..##..##........
 7: ...#..###.#...##..#...#...#...#........
 8: ...#....##.#.#.#..##..##..##..##.......
 9: ...##..#..#####....#...#...#...#.......
10: ..#.#..#...#.##....##..##..##..##......
11: ...#...##...#.#...#.#...#...#...#......
12: ...##.#.#....#.#...#.#..##..##..##.....
13: ..#..###.#....#.#...#....#...#...#.....
14: ..#....##.#....#.#..##...##..##..##....
15: ..##..#..#.#....#....#..#.#...#...#....
16: .#.#..#...#.#...##...#...#.#..##..##...
17: ..#...##...#.#.#.#...##...#....#...#...
18: ..##.#.#....#####.#.#.#...##...##..##..
19: .#..###.#..#.#.#######.#.#.#..#.#...#..
20: .#....##....#####...#######....#.#..##.

The generation is shown along the left, where 0 is the initial state. The pot numbers are shown along the top, where 0 labels the center pot, negative-numbered pots extend to the left, and positive pots extend toward the right. Remember, the initial state begins at pot 0, which is not the leftmost pot used in this example.

After one generation, only seven plants remain. The one in pot 0 matched the rule looking for ..#.., the one in pot 4 matched the rule looking for .#.#., pot 9 matched .##.., and so on.

In this example, after 20 generations, the pots shown as # contain plants, the furthest left of which is pot -2, and the furthest right of which is pot 34. Adding up all the numbers of plant-containing pots after the 20th generation produces 325.

After 20 generations, what is the sum of the numbers of all pots which contain a plant?
"
Class {
	#name : #AoCDay12,
	#superclass : #Object,
	#instVars : [
		'firstPotIndex'
	],
	#category : #AdventOfCode2018
}

{ #category : #examples }
AoCDay12 class >> runPart1 [

	<example>
	self new runPart1 "inspect"
]

{ #category : #'as yet unclassified' }
AoCDay12 >> applyRuleSet: ruleSet to: aCurrentState [
	| sequence out newStateStream currentState |
	currentState := '....' , aCurrentState , '....'.	"Need to match beginning and ending #'s. No rule has more than 3 leading and 4 ending dots in the puzzle"
	self firstPotIndex: self firstPotIndex - 3.
	newStateStream := String new writeStream.
	1 to: currentState size - 4 do: [ :i | 
		sequence := currentState copyFrom: i to: i + 4.
		out := ruleSet at: sequence ifAbsent: [ '.' ].
		newStateStream << out ].
	^ newStateStream contents
]

{ #category : #'as yet unclassified' }
AoCDay12 >> applyV2RuleSet: ruleSet to: aCurrentState [
	| sequence out newStateStream currentState |
	currentState := aCurrentState .	"Need to match beginning and ending #'s. No rule has more than 3 leading and 4 ending dots in the puzzle"
	self firstPotIndex: self firstPotIndex.
	newStateStream := String new writeStream.
	1 to: currentState size - 4 do: [ :i | 
		sequence := currentState copyFrom: i to: i + 4.
		out := ruleSet at: sequence ifAbsent: [ '.' ].
		newStateStream << out ].
	^ newStateStream contents
]

{ #category : #'as yet unclassified' }
AoCDay12 >> firstPotIndex [
	^firstPotIndex ifNil: [  firstPotIndex := 0 ]
]

{ #category : #'as yet unclassified' }
AoCDay12 >> firstPotIndex: anInteger [
	firstPotIndex := anInteger
]

{ #category : #'as yet unclassified' }
AoCDay12 >> historySample [
^' 0: ...#..#.#..##......###...###...........
 1: ...#...#....#.....#..#..#..#...........
 2: ...##..##...##....#..#..#..##..........
 3: ..#.#...#..#.#....#..#..#...#..........
 4: ...#.#..#...#.#...#..#..##..##.........
 5: ....#...##...#.#..#..#...#...#.........
 6: ....##.#.#....#...#..##..##..##........
 7: ...#..###.#...##..#...#...#...#........
 8: ...#....##.#.#.#..##..##..##..##.......
 9: ...##..#..#####....#...#...#...#.......
10: ..#.#..#...#.##....##..##..##..##......
11: ...#...##...#.#...#.#...#...#...#......
12: ...##.#.#....#.#...#.#..##..##..##.....
13: ..#..###.#....#.#...#....#...#...#.....
14: ..#....##.#....#.#..##...##..##..##....
15: ..##..#..#.#....#....#..#.#...#...#....
16: .#.#..#...#.#...##...#...#.#..##..##...
17: ..#...##...#.#.#.#...##...#....#...#...
18: ..##.#.#....#####.#.#.#...##...##..##..
19: .#..###.#..#.#.#######.#.#.#..#.#...#..
20: .#....##....#####...#######....#.#..##.'
]

{ #category : #'as yet unclassified' }
AoCDay12 >> openContents: contents label: aString [
	| window m |
	window := (SystemWindow labelled: aString) model: self.
	m := RubPluggableTextMorph new
		getTextSelector: #getText;
		setTextSelector: #clear;
		on: (RubScrolledTextModel new setText: contents; yourself);
		withAdornment;
		withLineNumbers;
		withColumns;
		beForSmalltalkScripting.
	(m rulerNamed: #column) tabWidth: 10.
	m textArea font: StandardFonts codeFont.
	window addMorph: m frame: (0 @ 0 corner: 1 @ 1).
	^ window openInWorld
]

{ #category : #'as yet unclassified' }
AoCDay12 >> openContents: contents sLabel: aString [
	| window m |
	window := (SystemWindow labelled: aString) model: self.
	m := RubPluggableTextMorph new
		getTextSelector: #yourself;
		"setTextSelector: #clear;"
		on: contents;
		beForSmalltalkScripting.
	m textArea font: StandardFonts codeFont.
	window addMorph: m frame: (0 @ 0 corner: 1 @ 1).
	^ window openInWorld
]

{ #category : #'as yet unclassified' }
AoCDay12 >> potsWithPlants: currentState. [
	self flag: #TODO. "Actually compute this"
	^ -9999
]

{ #category : #'as yet unclassified' }
AoCDay12 >> puzzleInput [

	^{
	 #initialState ->'#...##.#...#..#.#####.##.#..###.#.#.###....#...#...####.#....##..##..#..#..#..#.#..##.####.#.#.###'.
	#ruleSet -> '..... => .
..#.. => #
..##. => #
#..## => .
..#.# => #
####. => .
##.## => .
#.... => .
###.. => #
##### => #
##..# => #
#.### => #
#..#. => #
.#### => #
#.#.. => #
.###. => #
.##.. => #
.#... => #
.#.## => #
##... => #
..### => .
##.#. => .
...## => .
....# => .
###.# => .
#.##. => #
.##.# => .
.#..# => #
#.#.# => #
.#.#. => #
...#. => #
#...# => #' } asDictionary
	
]

{ #category : #'as yet unclassified' }
AoCDay12 >> puzzleInputSample [

^{
	 #initialState ->'#..#.#..##......###...###'.
	#ruleSet ->	'...## => #
..#.. => #
.#... => #
.#.#. => #
.#.## => #
.##.. => #
.#### => #
#.#.# => #
#.### => #
##.#. => #
##.## => #
###.. => #
###.# => #
####. => #' } asDictionary
	
]

{ #category : #'as yet unclassified' }
AoCDay12 >> runPart1 [
	
	| input initialState ruleSet ruleSetString potsWithPlant  currentState newState  states sumOfNumbersOfAllPots textRendition |
	input:= self puzzleInputSample.
	
	initialState := input at: #initialState.
	ruleSetString := input at: #ruleSet.

	ruleSet := OrderedDictionary new.
	ruleSetString lines collect: [ :line | (line splitOn: ' => ') in: [ :parsed |
			ruleSet at: parsed first put: parsed second  ] ].
	
	potsWithPlant := 0.
	currentState := (String new: 100 withAll: $.) , initialState, (String new: 100 withAll: $.).
	states := OrderedCollection new.
	states add: currentState.
	20 timesRepeat: [ 
		
		"potsWithPlant := potsWithPlant + (self potsWithPlants: currentState)."

		newState := self applyV2RuleSet: ruleSet to: currentState.
		currentState := newState.
		states add: currentState].
	
	
	sumOfNumbersOfAllPots := 0.
	
		1 to: (self firstPotIndex + currentState size) do: [ :currentPotIndex |
			(currentState at: currentPotIndex) = $# ifTrue: [ sumOfNumbersOfAllPots := sumOfNumbersOfAllPots + (currentPotIndex - 100)]
		 ].
	 
	Halt now.
	textRendition := states joinUsing: Character cr.
	
	
	self openContents: textRendition label: 'AoC Day 12 Rendition'.
	
	
	^ { #potsWithPlant -> potsWithPlant. #currentState -> currentState. #firstPotIndex -> self firstPotIndex. #sumOfNumbersOfAllPots->sumOfNumbersOfAllPots. #states->states } asOrderedDictionary
	
]
