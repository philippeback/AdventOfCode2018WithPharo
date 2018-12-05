Class {
	#name : #AoCDay5,
	#superclass : #Object,
	#category : #AdventOfCode2018
}

{ #category : #examples }
AoCDay5 class >> runPart1 [
	<example>
	"["
	| engine useSample input output |
	
	engine := self new.
	useSample := false.
	input := useSample
		ifTrue: [ engine puzzleInputExample ]
		ifFalse: [ engine puzzleInput ].
	output := engine solvePart1: input.
	output size inspect
]

{ #category : #examples }
AoCDay5 class >> runPart2 [
	<example>
 | engine useSample input output |
	
	engine := self new.
	useSample := false.
	input := useSample
		ifTrue: [ engine puzzleInputExample ]
		ifFalse: [ engine puzzleInput ].
	output := engine solvePart2: input.
	output inspect
]

{ #category : #accessing }
AoCDay5 >> condense: aString [
	"Too bad, this doesn't work properly yet"
	| in out |
	in := aString.

	out := WriteStream on: (String new: aString size).
	in
		readStreamDo: [ :stream | 
			
		
			[ stream atEnd ]
				whileFalse: [ | a b |
					a := stream next.
					b := stream peek.
					b
						ifNotNil: [ (a = b uppercase or: [ b = a uppercase ])
								ifTrue: [ stream next ]
								ifFalse: [ out nextPut: a ] ]
						ifNil: [ out nextPut: a ] ] ].
	^ out contents
]

{ #category : #accessing }
AoCDay5 >> condenseAlt: aString [
	
	| input |
	input := aString copy.
	
	'abcdefghijklmnopqrstuvwxyz' do: [ :each |
		input := input copyReplaceAll: (each asString, (each uppercase asString)) with: ''.
		input := input copyReplaceAll: ((each uppercase asString), each asString) with: ''.
	 ].
	 ^input
	

]

{ #category : #accessing }
AoCDay5 >> puzzleInput [
	^ 'input4.txt' asFileReference contents
]

{ #category : #accessing }
AoCDay5 >> puzzleInputExample [
	^'dabAcCaCBAcCcaDA'
]

{ #category : #accessing }
AoCDay5 >> solvePart1: aString [
	| input oldInput iter |

	input := aString.
	iter := 0.
	[ input := self condenseAlt: (oldInput := input).
	iter := iter + 1 ] doWhileTrue: [ input size < oldInput size and: [ iter < 2000 ] ].
	^ input 
]

{ #category : #accessing }
AoCDay5 >> solvePart2: aString [
	|  input improved |
	input := aString.
	improved := OrderedDictionary new.
	'abcdefghijklmnopqrstuvwxyz'
		do: [ :each | 
			| cleaned |
			cleaned := (input copyReplaceAll: each asString with: '')
				copyReplaceAll: each uppercase asString	with: ''.
			improved at: each put: (self solvePart1: cleaned) size ].
	^ improved values min
]
