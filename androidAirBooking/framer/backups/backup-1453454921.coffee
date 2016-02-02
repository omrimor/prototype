
# Import file "flightBooking-Android-01" (sizes and positions are scaled 1:3)
$ = Framer.Importer.load("imported/flightBooking-Android-prototype@3x")

# Modules
{Pointer} = require "Pointer"
android = require "androidRipple"

# Defauls set up
Utils.globalLayers($)
Framer.Defaults.Animation = 
	curve: 'spring(300,20)'

# define empty vars for scroll components
scrollOutboundDetails = null
scrollReturnResults = {}
scrollReturnDetails = null
scrollCheckout = null
scrollFilterList = null

# hide filled group form home
filled.opacity = 0

# make all artboards invisible
allArtboards = [
	search,
	datePickerPrepopulated,
	outboundResults,
	filterModal,
	outboundDetails,
	returnResults,
	returnDetails,
	checkout,
	confirmation
]

for artboard in allArtboards
	artboard.visible = false

# Define Handler functions

###################################################################

animateNextView = (clickLayer, animateLayer, layerToHide) ->
	clickLayer.on(Events.Click, android.ripple)
	clickLayer.on Events.Click, ->
		# Create back button layer
		backBtn = new Layer
		backBtn.superLayer = animateLayer
		backBtn.y = 72
		backBtn.height = 170
		backBtn.width = backBtn.height
		backBtn.opacity = 0
		
		# animate backBtn
		backBtn.on(Events.Click, android.ripple)
		animateBackView(backBtn, animateLayer, layerToHide)
		
		animateLayer.visible = true
		animateLayer.x = 0
		animateLayer.y = 400
		animateLayer.opacity = 0
		animateLayer.animate
			properties: { y: 0, opacity: 1 }
			time: 0.3
			curve: "spring(270, 30, 0)"
		Utils.delay 0.5, ->
			layerToHide.visible = false
		
##################################################################			
animateBackView = (clickLayer, animateLayer, originalLayer) ->
	clickLayer.on(Events.Click, android.ripple)
	clickLayer.on Events.Click, ->
		originalLayer.visible = true

		animateLayer.animate
			properties: {y: 400, opacity: 0}
			time: 0.3
			curve: "spring(257, 35, 0)"
		clickLayer.destroy()
		
		Utils.delay 2, ->
			animateLayer.visible = false
		
##################################################################

animateModelUp = (clickLayer, animateLayer, layerToHide) ->
	clickLayer.on(Events.Click, android.ripple)
	clickLayer.on Events.Click, ->
		# Create back button layer
		backBtn = new Layer
		backBtn.superLayer = animateLayer
		backBtn.y = 72
		backBtn.height = 170
		backBtn.width = backBtn.height
		backBtn.opacity = 0
		
		# animate backBtn
		backBtn.on(Events.Click, android.ripple)
		animateModelDown(backBtn, animateLayer, layerToHide)
		
		animateLayer.visible = true
		animateLayer.x = 0
		animateLayer.y = Screen.height
		animateLayer.opacity = 0
		animateLayer.animate
			properties: { y: 0, opacity: 1 }
			curve: "spring(310, 32, 0)"
		Utils.delay 0.5, ->
			layerToHide.visible = false
			
##################################################################

animateModelDown = (clickLayer, animateLayer, originalLayer) ->
	clickLayer.on(Events.Click, android.ripple)
	clickLayer.on Events.Click, ->
		originalLayer.visible = true
		
		animateLayer.animate
			properties: { y: Screen.height, opacity: 0 }
			time: 0.3
			curve: "spring(255, 40, 0)"
			
	animateLayer.visible = false
			
##################################################################

createScrollComponent = (containerName, wrapThis, insetNumber, superLayerName) ->
	containerName = ScrollComponent.wrap(wrapThis)
	containerName.contentInset =
		bottom: insetNumber
	containerName.scrollHorizontal = false
	containerName.superLayer = superLayerName

###################################################################

filterFooter = ->
	btnsContainer = new Layer
		width: Screen.width
		height: 65 * 3
		y: Screen.height - navbar.height * 2 - 46
		backgroundColor: 'transparent'
	btnsContainer.superLayer = outboundResults
	
	btnSort = new Layer
		width: Screen.width / 2
		height: btnsContainer.height
		backgroundColor: 'transparent'
	btnSort.superLayer = btnsContainer
	
	btnFilter = new Layer
		width: Screen.width / 2
		height: btnsContainer.height
		backgroundColor: 'transparent'
		x: Screen.width / 2
	btnFilter.superLayer = btnsContainer
	
	# add states to dialog and overlay layer	
	scrim.states.add
		hide: {visible: false, opacity: 0}
		fadein: {visible: true, opacity: 1}
	scrim.states.switchInstant "hide"
	scrim.states.animationOptions = 
		curve: "spring(320, 20, 0)"
	
	dialog.states.add
		hide: {visible: false, opacity: 0}
		fadein: {visible: true, opacity: 1}
	dialog.states.switchInstant "hide"
	dialog.states.animationOptions = 
		curve: "spring(320, 20, 0)"
	dialog.states.animationOptions.delay = 0.06

	scrim.on Events.Click, ->
		dialog.states.switch 'hide'
		scrim.states.switch 'hide'
	
	dialog.on(Events.Click, android.ripple)
	dialog.on Events.Click, ->
		dialog.states.switch 'hide'
		scrim.states.switch 'hide'
	
	btnSort.on(Events.Click, android.ripple)
	btnSort.on Events.Click, ->
		scrim.states.switch 'fadein'
		dialog.states.switch 'fadein'

	# click the filter button
	animateModelUp(btnFilter, filterModal, outboundResults)
	# create scroll conponent of filter modal
	createScrollComponent(scrollFilterList, scrollContentFilters, 350, filterModal)
	# click the apply button in filters modal
	animateModelDown(applyBtn, filterModal, outboundResults)

#####################################################################################

searchModal = ->
	# recent search row array
	recentCells = [sCellItem01, sCellItem02, sCellItem03, sCellItem04]
	
	# hide all suggestion cells from search
	for cell in recentCells
		cell.opacity = 0
		
	# Click keyboard to simulate search	
	keyboardLightRecent.on Events.Click, ->
		placeHolderText.originX = 0
		placeHolderText.originY = 0
		
		placeHolderText.animate
			properties: {y: 102, width: 210, height: 36}
			time: 0.3
			curve: "spring(330, 17, 0)"
			
		placeHolderText.animate
			properties: {opacity: 0}
			time: 2
			curve: "ease-in"
			
		AppBarSearchPlaceHolder.animate
			properties: {opacity: 0}
			time: 1.5
			curve: "ease-in-out"

		recentCellItem.animate
			properties: {opacity: 0}
			
		# show suggestion cells		
		for cell, i in recentCells
			cell.animate
				properties: {opacity: 1}
				delay: 0.09 * i
				curve: "spring(250, 35, 0)"
				
		# show filled group
		filled.opacity = 1
		
	# animate the search model back down on click
	for cell, i in recentCells
		animateModelDown(cell, search, home)
		
####################################################################################

enterOutboundResultsAnimation = (loadingAnimationLayer) ->
	# animate the loading msg out
	for layer, i in [msg, SearchingFlightTxt, loadingAnimationLayer]
		layer.animate
			properties: {y: layer.y + 200, opacity: 0}
			time: 0.16
			curve: 'spring(225, 50, 0)'
			delay: 0.08 * i
			
	# animate the results list in
	for i in [1..5]
		items = $["row" + i]
		items.states.switch 'fadein'
			
		
	# animate the subheaderOutbound title
	subheaderOutbound.states.switch 'fadein'
	# animate the filtersOutbound footer
	filtersOutbound.states.switch 'fadein'
	
#####################################################################################

outBoundResultsScreen = ->
	# hide layers from outbound results
	for layer in [dialog, scrim, planeAnimationPlaceholder, subheaderOutbound, filtersOutbound]
		layer.opacity = 0
		
	# place loading gif animation
	loadingLayer = new Layer
	loadingLayer.superLayer = outboundResults
	loadingLayer.x = 46 * 3
	loadingLayer.y = 155 * 3
	loadingLayer.width = 269 * 3
	loadingLayer.height = 79 * 3
	loadingLayer.image = 'images/planeLoading.gif'
	
	# state animation for results items
	for i in [1..5]
		items = $["row" + i]
		currentY = items.y
		items.states.add
		    hide: {y: currentY + 80, opacity:0}
		    fadein: {y: currentY, opacity:1}
		items.states.switchInstant "hide"
		  
		items.states.animationOptions = 
		    curve: "spring(225, 70, 0)"
		items.states.animationOptions.delay = 0.5 + (0.08 * i)
	
	# state animation for filtersOutbound
	currentFiltersY = filtersOutbound.y
	filtersOutbound.states.add
		hide: {y: currentFiltersY + 100, opacity: 0}
		fadein: {y: currentFiltersY, opacity: 1}
	filtersOutbound.states.switchInstant "hide"
	
	filtersOutbound.states.animationOptions = 
		curve: "spring(300, 40, 0)"
	filtersOutbound.states.animationOptions.delay = 1.2
	
	# state animation for subheaderOutbound
	subheaderOutbound.states.add
		hide: {opacity: 0}
		fadein: {opacity: 1}
	subheaderOutbound.states.switchInstant "hide"
	
	subheaderOutbound.states.animationOptions = 
		curve: "spring(225, 70, 0)"
	subheaderOutbound.states.animationOptions.delay = 1
	
	# listen to x change on the whole screen to initiate
	outboundResults.on "change:x", ->
		Utils.delay 3, ->
			enterOutboundResultsAnimation(loadingLayer)
	
	# click each item in the outboundResults
	for cell in [row1, row2, row3, row4, row5]
		animateNextView(cell, outboundDetails, outboundResults)
	
	filterFooter()

#####################################################################################

enterConfirmationAnimation =(loadingAnimationLayer) ->
	# animate the loading msg out
	for layer, i in [processMsg, loadingAnimationLayer]
		layer.animate
			properties: {y: layer.y + 200, opacity: 0}
			time: 0.2 + (0.6 * i)
			curve: 'spring(225, 40, 0)'
			
	# animate conf msg in
	confirmationMsgBgCurrentHeight = confirmationMsgBg.height
	confirmationMsgBg.originY = 0
	confirmationMsgBg.height = 0
	confirmationMsgBg.animate
		properties: {height: confirmationMsgBgCurrentHeight, opacity: 1}
		time: 0.1
		curve: 'spring(320, 25, 0)'
		delay: 0.43
	confirmationMsgContent.animate
		properties: {opacity: 1}
		time: 0.4
		curve: 'spring(280, 40, 0)'
		delay: 0.8
	hotelSuggestion.animate
		properties: {opacity: 1}
		time: 1
		curve: 'ease-out'
		delay: 1.6
	viewMore.animate
		properties: {opacity: 1}
		time: 1.3
		curve: 'ease-out'
		delay: 1.7	
		
#####################################################################################

confirmationScreen = ->
	# hide groups in confirmation page
	for group in [confirmationMsgBg, confirmationMsgContent, hotelSuggestion, viewMore]
		group.opacity = 0
	
	# place loading gif animation
	loadingLayerConfirmation = new Layer
	loadingLayerConfirmation.superLayer = confirmation
	loadingLayerConfirmation.x = 46 * 3
	loadingLayerConfirmation.y = 155 * 3
	loadingLayerConfirmation.width = 269 * 3
	loadingLayerConfirmation.height = 79 * 3
	loadingLayerConfirmation.image = 'images/planeLoading.gif'
	
	# listen to x change on the whole screen to initiate
	confirmation.on "change:x", ->
		Utils.delay 3, ->
			enterConfirmationAnimation(loadingLayerConfirmation)
			
#####################################################################################

homeScreen = ->
	#click the arrival cell
	animateModelUp(arrivalClick, search, home)
	# handle search modal
	searchModal()
	# click the dates cell
	animateModelUp(datesHomeActive, datePickerPrepopulated, home)
	# click the done button in date picker
	animateModelDown(doneDates, datePickerPrepopulated, home)
	# click find my flights button
	animateNextView(findMyFlights, outboundResults, home)
	
#####################################################################################

outBoundDetailsScreen = ->
	# create scroll conponent of outbound details page
	createScrollComponent(scrollOutboundDetails, scrollContentOutboundDetails, 95, outboundDetails)
	# click select this outbound btn to next screen
	animateNextView(selectOutBoundBtn, returnResults, outboundDetails)
	
#####################################################################################

returnResultsScreen = ->
	# create scroll conponent of return flights results
	createScrollComponent(scrollReturnResults, scrollContentReturnResults, 95, returnResults)
	
	# click each item in the return returnResults
	for returnCell in [returnRow1, returnRow2, returnRow3, returnRow4]
		returnCell.on Events.Click, ->
			return if scrollReturnResults.isMoving
			animateNextView(@, returnDetails, outboundDetails)
				
#####################################################################################

returnDetailsScreen = ->
	# create scroll conponent of return flights results
	createScrollComponent(scrollReturnDetails, scrollContentReturnDetails, 95, returnDetails)
	
	# click select this return btn to next screen
	animateNextView(selectReturnBtn, checkout, returnDetails)
	
#####################################################################################

checkoutScreen = ->
	# create scroll conponent of checkout
	createScrollComponent(scrollCheckout, scrollContentCheckout, 130, checkout)
	
	# click finialize booking btn to next screen
	animateNextView(finalizeBookingBtn, confirmation, checkout)
	
#####################################################################################

init = ->
	# init prototype
	homeScreen()
	outBoundResultsScreen()
	outBoundDetailsScreen()
	returnResultsScreen()
	returnDetailsScreen()
	checkoutScreen()
	confirmationScreen()

#####################################################################################

init()


