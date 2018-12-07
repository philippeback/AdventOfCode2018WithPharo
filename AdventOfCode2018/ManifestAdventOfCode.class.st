"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestAdventOfCode,
	#superclass : #PackageManifest,
	#category : #'AdventOfCode2018-Manifest'
}

{ #category : #'code-critics' }
ManifestAdventOfCode class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AoCDay7Part1 #part1 #false)) #'2018-12-07T23:19:31.722842+01:00') )
]

{ #category : #'code-critics' }
ManifestAdventOfCode class >> ruleRBCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AoCDay7Part1 #walkFrom: #false)) #'2018-12-07T22:17:19.991769+01:00') )
]

{ #category : #'code-critics' }
ManifestAdventOfCode class >> ruleRBNotEliminationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#AoCDay7NodePart1 #unvisitedSuccessors #false)) #'2018-12-07T21:40:58.860769+01:00') )
]
