"
--- Part Two ---

As you're about to begin construction, four of the Elves offer to help. ""The sun will set soon; it'll go faster if we work together."" Now, you need to account for multiple people working on steps simultaneously. If multiple steps are available, workers should still begin them in alphabetical order.

Each step takes 60 seconds plus an amount corresponding to its letter: A=1, B=2, C=3, and so on. So, step A takes 60+1=61 seconds, while step Z takes 60+26=86 seconds. No time is required between steps.

To simplify things for the example, however, suppose you only have help from one Elf (a total of two workers) and that each step takes 60 fewer seconds (so that step A takes 1 second and step Z takes 26 seconds). Then, using the same instructions as above, this is how each second would be spent:

Second   Worker 1   Worker 2   Done
   0        C          .        
   1        C          .        
   2        C          .        
   3        A          F       C
   4        B          F       CA
   5        B          F       CA
   6        D          F       CAB
   7        D          F       CAB
   8        D          F       CAB
   9        D          .       CABF
  10        E          .       CABFD
  11        E          .       CABFD
  12        E          .       CABFD
  13        E          .       CABFD
  14        E          .       CABFD
  15        .          .       CABFDE

Each row represents one second of time. The Second column identifies how many seconds have passed as of the beginning of that second. Each worker column shows the step that worker is currently doing (or . if they are idle). The Done column shows completed steps.

Note that the order of the steps has changed; this is because steps now take time to finish and multiple workers can begin multiple steps simultaneously.

In this example, it would take 15 seconds for two workers to complete these steps.

With 5 workers and the 60+ second step durations described above, how long will it take to complete all of the steps?

"
Class {
	#name : #AoCDay7Part2,
	#superclass : #Object,
	#instVars : [
		'ticks',
		'workers'
	],
	#category : #'AdventOfCode2018-Day7Part2'
}

{ #category : #examples }
AoCDay7Part2 class >> run [
	<example>
	Transcript open.
	self new run inspect
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> findStart: someNodes [
	"Assuming there is only one start. But there are more than one in the problem..."

	^ someNodes select: [ :node | node predecessors isEmpty ]
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> instructions: anInputString [
	^ anInputString lines
		collect: [ :line | 
			(line splitOn: Character space)
				in: [ :chunked | 
					{(chunked at: 2).
					(chunked at: 8)} ] ]
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> link: nodesDict accordingTo: instructions [
	instructions
		do: [ :instruction | 
			| to from |
			from := nodesDict at: instruction first first.
			to := nodesDict at: instruction second first.
			from successors addIfNotPresent: to.
			to predecessors addIfNotPresent: from ]
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> nodes: someInstructions [

	| nodeIds |
	nodeIds := ((someInstructions collect: [ :instruction |
		instruction first, instruction second ]) joinUsing: '') asSet.
	
	^ nodeIds collect: [ :nodeId | AoCDay7NodePart2 withNodeId: nodeId ]
	
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> nodesDict: someNodes [

	^ (someNodes collect: [ :node | node nodeId -> node  ]) asDictionary
	
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> puzzleInput [
	^ 'Step U must be finished before step A can begin.
Step F must be finished before step Z can begin.
Step B must be finished before step J can begin.
Step O must be finished before step R can begin.
Step H must be finished before step S can begin.
Step T must be finished before step R can begin.
Step L must be finished before step W can begin.
Step M must be finished before step I can begin.
Step Q must be finished before step K can begin.
Step Z must be finished before step V can begin.
Step C must be finished before step E can begin.
Step W must be finished before step I can begin.
Step K must be finished before step S can begin.
Step I must be finished before step Y can begin.
Step P must be finished before step V can begin.
Step V must be finished before step X can begin.
Step R must be finished before step E can begin.
Step N must be finished before step E can begin.
Step X must be finished before step J can begin.
Step A must be finished before step J can begin.
Step S must be finished before step G can begin.
Step J must be finished before step E can begin.
Step Y must be finished before step E can begin.
Step D must be finished before step G can begin.
Step E must be finished before step G can begin.
Step K must be finished before step N can begin.
Step B must be finished before step I can begin.
Step X must be finished before step S can begin.
Step V must be finished before step S can begin.
Step U must be finished before step L can begin.
Step N must be finished before step G can begin.
Step O must be finished before step L can begin.
Step X must be finished before step E can begin.
Step V must be finished before step E can begin.
Step Y must be finished before step G can begin.
Step A must be finished before step Y can begin.
Step M must be finished before step E can begin.
Step F must be finished before step Q can begin.
Step F must be finished before step X can begin.
Step L must be finished before step C can begin.
Step T must be finished before step L can begin.
Step B must be finished before step C can begin.
Step Q must be finished before step N can begin.
Step T must be finished before step G can begin.
Step R must be finished before step D can begin.
Step I must be finished before step A can begin.
Step B must be finished before step M can begin.
Step H must be finished before step A can begin.
Step F must be finished before step K can begin.
Step U must be finished before step F can begin.
Step R must be finished before step A can begin.
Step J must be finished before step D can begin.
Step V must be finished before step Y can begin.
Step F must be finished before step J can begin.
Step C must be finished before step K can begin.
Step M must be finished before step C can begin.
Step F must be finished before step E can begin.
Step I must be finished before step E can begin.
Step T must be finished before step A can begin.
Step J must be finished before step Y can begin.
Step R must be finished before step X can begin.
Step W must be finished before step S can begin.
Step V must be finished before step R can begin.
Step U must be finished before step V can begin.
Step C must be finished before step V can begin.
Step F must be finished before step Y can begin.
Step R must be finished before step G can begin.
Step W must be finished before step N can begin.
Step H must be finished before step N can begin.
Step H must be finished before step Y can begin.
Step B must be finished before step W can begin.
Step M must be finished before step Z can begin.
Step X must be finished before step A can begin.
Step A must be finished before step G can begin.
Step N must be finished before step A can begin.
Step H must be finished before step J can begin.
Step B must be finished before step O can begin.
Step W must be finished before step A can begin.
Step P must be finished before step N can begin.
Step Z must be finished before step G can begin.
Step W must be finished before step D can begin.
Step D must be finished before step E can begin.
Step W must be finished before step J can begin.
Step N must be finished before step D can begin.
Step C must be finished before step J can begin.
Step B must be finished before step Y can begin.
Step F must be finished before step P can begin.
Step L must be finished before step P can begin.
Step X must be finished before step G can begin.
Step R must be finished before step Y can begin.
Step K must be finished before step A can begin.
Step M must be finished before step Y can begin.
Step W must be finished before step Y can begin.
Step F must be finished before step I can begin.
Step L must be finished before step X can begin.
Step R must be finished before step J can begin.
Step V must be finished before step J can begin.
Step V must be finished before step D can begin.
Step H must be finished before step C can begin.
Step O must be finished before step G can begin.
Step P must be finished before step R can begin.'

]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> puzzleInputSample [
^ 'Step C must be finished before step A can begin.
Step C must be finished before step F can begin.
Step A must be finished before step B can begin.
Step A must be finished before step D can begin.
Step B must be finished before step E can begin.
Step D must be finished before step E can begin.
Step F must be finished before step E can begin.'
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> resetClock [

	ticks := 0
	

]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> run [
	| selector input instructions nodes nodesDict  tracks  sequence s |
	selector := #puzzleInputSample.
	"selector := #puzzleInput."
	input := self perform: selector.
	instructions := self instructions: input.
	nodes := self nodes: instructions.
	nodesDict := self nodesDict: nodes.
	self link: nodesDict accordingTo: instructions.
	"nodesDict inspect."

	tracks := self runTimeLoop: nodes withWorkerCount: 2.
	
	s := String new writeStream.
	"tracks do: [ :node | s nextPut: (node nodeId) ]."
	sequence := s contents.
	
	^ { "nodes. . tracks. "sequence}
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> runTimeLoop: someNodes withWorkerCount: workersCount [

	
	| availableTargets path addNodeToPath waitingList currentNode availableTargetsFinder startNodes availableWorker activeWorkers idleWorkers |

	"Initialization"
	path := OrderedCollection new.
	waitingList := SortedCollection sortBlock: [:a :b | a nodeId < b nodeId ].
	addNodeToPath := [ :node | 	path add: node.	node visit ].
	availableTargetsFinder := [ :node | node unvisitedAvailableSuccessors asSortedCollection: [ :a :b | a nodeId < b nodeId ] ] .
	startNodes := self findStart: someNodes.
	(startNodes asSortedCollection: [ :a :b | a nodeId < b nodeId ]) reversed do: [ :each | waitingList addIfNotPresent: each ].
	
	
	self resetClock.
	self workers: workersCount.
	
	availableWorker := workers detect: [:worker | worker isIdle ] ifNone: [  ].
	availableWorker startWorkingOn: (currentNode := waitingList removeFirst).
	currentNode visit.
		
	"Loop"
	
	150
		timesRepeat: [
			
			self tick.
			activeWorkers := workers select: [ :worker | worker isIdle not ].			
			idleWorkers := workers copyWithoutAll: activeWorkers.
			
			activeWorkers do: [ :activeWorker | activeWorker work ].
			idleWorkers do: [ :idleWorker |
				"Find something to do"
			
				(availableTargets := availableTargetsFinder value: currentNode) ifNotEmpty: [ :targets | targets reversed do: [ :each | waitingList addIfNotPresent: each ] ].
				waitingList 
					ifNotEmpty: [ idleWorker startWorkingOn: waitingList removeFirst ]
					ifEmpty: [ "Nothing to do " ] ] ].
					"Workers should do this: addNodeToPath value: currentNode."
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> tick [ 
	('Loop Run: {1}' format: { ticks }) logCr.
	ticks := ticks + 1.
	

]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> ticks [

	^ticks
	

]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> walkFrom: someNodes [
	| availableTargets path addNodeToPath waitingList currentNode availableTargetsFinder startNodes |
	path := OrderedCollection new.
	waitingList := SortedCollection sortBlock: [:a :b | a nodeId < b nodeId ].
	addNodeToPath := [ :node | 	path add: node.	node visit ].
	availableTargetsFinder := [ :node | node unvisitedAvailableSuccessors asSortedCollection: [ :a :b | a nodeId < b nodeId ] ].
	{  path. waitingList } inspect.
	startNodes := self findStart: someNodes.
	(startNodes asSortedCollection: [ :a :b | a nodeId < b nodeId ]) reversed do: [ :each | waitingList addIfNotPresent: each ].
	currentNode := waitingList removeFirst.
	150
		timesRepeat: [ 
			addNodeToPath value: currentNode.
			
			(availableTargets := availableTargetsFinder value: currentNode) ifNotEmpty: [ :targets | targets reversed do: [ :each | waitingList addIfNotPresent: each ] ].
			waitingList ifNotEmpty: [ 
			currentNode := waitingList removeFirst]
			ifEmpty: [ ^ path  ]  ].
]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> workers [

	^workers
	

]

{ #category : #'as yet unclassified' }
AoCDay7Part2 >> workers: aNumberOfWorkers [

	workers := (1 to: aNumberOfWorkers) collect: [ :i | AoCDay7Worker usingId: i ]
	

]
