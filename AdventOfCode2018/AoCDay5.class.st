Class {
	#name : #AoCDay5,
	#superclass : #Object,
	#category : #AdventOfCode2018
}

{ #category : #examples }
AoCDay5 class >> runPart1 [
	<example>
	| engine useSample input output |
	engine := self new.
	useSample := false.
	input := useSample
		ifTrue: [ engine puzzleInputExample ]
		ifFalse: [ engine puzzleInput ].
	output := engine solve: input.
	output inspect
]

{ #category : #accessing }
AoCDay5 >> condense: aString [
	| in out |
	in := aString.
	out := WriteStream on: (String new: aString size).
	in
		readStreamDo: [ :stream | 
			[ stream atEnd ]
				whileFalse: [ | a b |
					a := stream next.
					b := stream peek.
					(b isNotNil or: [ a = b uppercase or: [ b = a uppercase ] ])
						ifTrue: [ stream next ]
						ifFalse: [ out nextPut: a ] ] ].
	^ out contents
]

{ #category : #accessing }
AoCDay5 >> puzzleInput [
	^ 'input4.txt' asFileReference contents allButLast
]

{ #category : #accessing }
AoCDay5 >> puzzleInputExample [
	^'dabAcCaCBAcCcaDA'
]

{ #category : #accessing }
AoCDay5 >> solve: aString [
	| input output count |
	input := aString.
	output := ''.
	
	count := 0.
	
	[ input size = output size ]
		whileFalse: [ 
			output ifNotEmpty: [ input := output ].
			output := self condense: input.
			count := count + 1.
			(count \\ 1000 = 0) ifTrue: [ 
				Transcript nextPutAll: '.' ] ].
	^ output
]
