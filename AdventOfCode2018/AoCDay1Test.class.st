"
Tests for AoC Day 1
"
Class {
	#name : #AoCDay1Test,
	#superclass : #TestCase,
	#category : #AdventOfCode2018
}

{ #category : #tests }
AoCDay1Test >> testFinalFrequencyPart1 [
	self assert: (AoCDay1 new finalFrequency = 578)
]

{ #category : #tests }
AoCDay1Test >> testFirstRepeatedFrequency [
	self assert: (AoCDay1 new firstRepeatedFrequency = 82516)
]

{ #category : #tests }
AoCDay1Test >> testShifts [
	self assert: (AoCDay1 new shifts size > 100)
]
