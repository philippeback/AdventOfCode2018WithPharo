"
AoCDay3 new answers
"
Class {
	#name : #AoCDay3,
	#superclass : #Object,
	#category : #AdventOfCode2018
}

{ #category : #examples }
AoCDay3 class >> answers [
	<example>
	self new answers inspect
]

{ #category : #acccessing }
AoCDay3 >> answers [
	| claims filler fabric startLeft startTop width height counter sharedSurface nonOverlappingChecker nonOverlappingClaim |
	
	fabric := Array2D new: 1000.
	fabric atAllPut: 0.	"Paranoid"
	filler := [ :f :l :t :w :h | 
	l + 1 to: l + w do: [ :x | 
		t + 1 to: t + h do: [ :y | 
			| current |
			current := f at: x at: y.
			f at: x at: y put: current + 1 ] ] ].
	counter := [ :f | 
	| shared |
	shared := 0.
	1 to: f numberOfColumns do: [ :x | 
		1 to: f numberOfRows do: [ :y | 
			| current |
			current := f at: x at: y.
			current > 1
				ifTrue: [ shared := shared + 1 ] ] ].
	shared ].
	claims := self claims.
	claims
		do: [ :claim | 
			claim value
				in: [ :claimSpec | 
					startLeft := claimSpec first.
					startTop := claimSpec second.
					width := claimSpec third.
					height := claimSpec fourth.
					filler
						valueWithArguments:
							{fabric.
							startLeft.
							startTop.
							width.
							height} ] ].
	sharedSurface := counter value: fabric.
	nonOverlappingChecker := [ :f :l :t :w :h | 
	| res |
	res := true.
	l + 1 to: l + w do: [ :x | 
		t + 1 to: t + h do: [ :y | 
			| current |
			current := f at: x at: y.
			current > 1
				ifTrue: [ res := false ] ] ].
	res ].
	nonOverlappingClaim := claims
		select: [ :claim | 
			claim value
				in: [ :claimSpec | 
					startLeft := claimSpec first.
					startTop := claimSpec second.
					width := claimSpec third.
					height := claimSpec fourth ].
			nonOverlappingChecker
				valueWithArguments:
					{fabric.
					startLeft.
					startTop.
					width.
					height} ].
	^ {(#part1_in_two_or_more_claims -> sharedSurface).
	(#part2_non_overlapping_claim -> nonOverlappingClaim first key)} asDictionary
]

{ #category : #acccessing }
AoCDay3 >> claims [
	| regexp |
	regexp := '\#(\d+) @ (\d+),(\d+)\: (\d+)x(\d+)'  asRegex.
^'in3.txt' asFileReference contents lines collect: [ :line |
	(regexp matches: line)
		ifTrue: [
			
			(regexp subexpression: 2) -> { 
			(regexp subexpression: 3) asInteger .
			(regexp subexpression: 4) asInteger.
			(regexp subexpression: 5) asInteger.
			(regexp subexpression: 6) asInteger}
			 ] 
	 ].
]
