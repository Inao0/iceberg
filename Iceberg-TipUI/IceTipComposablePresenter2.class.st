Class {
	#name : #IceTipComposablePresenter2,
	#superclass : #ComposablePresenter,
	#category : #'Iceberg-TipUI-View'
}

{ #category : #specs }
IceTipComposablePresenter2 class >> title [
	^ self subclassResponsibility
]

{ #category : #adding }
IceTipComposablePresenter2 >> addShortcutsTo: aWidget [
	self enableCommanderShortcutsIn: aWidget
]

{ #category : #accessing }
IceTipComposablePresenter2 >> contextClass [
	"default context. This needs to be overriden for using presenters"
	^ IceTipContext
]

{ #category : #accessing }
IceTipComposablePresenter2 >> contextSelection [
	"to be overriden by my users"
	^ nil
]

{ #category : #'private factory' }
IceTipComposablePresenter2 >> createCommandContext [
	^ self newContextWithSelection: self contextSelection
]

{ #category : #'private factory' }
IceTipComposablePresenter2 >> createCommandContextForSelection: selectedItems [
	^ self newContextWithSelection: selectedItems
]

{ #category : #adding }
IceTipComposablePresenter2 >> eventKeyStrokesForNextFocus [
	"String describing the keystroke to perform to jump to the next widget"	
		
	^ { Character tab asKeyCombination }
]

{ #category : #adding }
IceTipComposablePresenter2 >> eventKeyStrokesForPreviousFocus [
	"String describing the keystroke to perform to jump to the previous widget"
	
	^ { Character tab shift asKeyCombination }
]

{ #category : #'private factory' }
IceTipComposablePresenter2 >> newContext [
	^ self contextClass for: self
]

{ #category : #'private factory' }
IceTipComposablePresenter2 >> newContextWithSelection: anObject [
	^ self newContext
]
