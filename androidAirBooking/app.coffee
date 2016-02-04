# Import file "flightBooking-Android-01" (sizes and positions are scaled 1:3)
sketch = Framer.Importer.load("imported/flightBooking-Android-01@3x")


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
scrolloutboundResults = {}
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

filterModel = ->
	
	btnFilter = new Layer
		width: 240
		height: AppBarBackWithSubheader.height - StatusBarBlack.height
		y: 70
		backgroundColor: 'transparent'
		x: Screen.width - 240
	btnFilter.superLayer = outboundResults
	
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

createTimeFilters = () ->

	# define control container
	controls = new Layer
		width: slider.width
		height: slider.height
		y: slider.y
		backgroundColor: "transparent"
		clip: false
	controls.superLayer = slider
	
	# SLIDER RIGHT
	# define sliderLeft component
	sliderRight = new SliderComponent
		width: (controls.width - 120) / 2 - 30
		height: 6
		x: (controls.width - 120) / 2 + 70
		y: -35
		backgroundColor: "#cccfd3"
		superLayer: controls
	sliderRight.fill.backgroundColor = "#3dd0d8"
	
	# Customize knob appearence
	sliderRight.knobSize = 100
	sliderRight.knob.borderRadius = 50
	sliderRight.knob.backgroundColor = "#1FBAAD"
	sliderRight.knob.borderColor = "#2BA99F"
	sliderRight.knob.shadowColor = "rgba(0, 0, 0, 0.4)"
	sliderRight.knob.shadowX = -6
	sliderRight.knob.draggable.momentum = false
	# set x pos for right knob
	sliderRight.knob.x = sliderRight.width - 40
	
	# set up min/max val for the slider
	sliderRight.min = 20
	sliderRight.max = 38
	
	# add the icon to the knob
	landingIcon.superLayer = sliderRight.knob
	landingIcon.x = 18
	landingInnerShadow.superLayer = sliderRight.knob
	landingInnerShadow.y = 6
	
	# define tooltip
	toolTipRight.opacity = 0
	toolTipRight.index = 1000
	toolTipRight.html = "Landing by" + "<br/>" + ( (Utils.round(sliderRight.value, 0) + 11) % 12 + 1 ) +
	":" + "00" + "PM"
	
	toolTipRight.style = {"font-size":"42px","text-align":"left","line-height":"50px","padding-top": "18px","padding-left": "12px","color": "#1cebf7"}
	
	# Define time stamp
	timestampRight = new Layer
		width: 180
		height: 40
		y: -153
		x: controls.width - 190
		backgroundColor: "transparent"
		superLayer: controls
	timestampRight.html = ((Utils.round(sliderRight.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "PM"
	timestampRight.style = {"font-size":"42px","text-align":"center","line-height":"40px","color": "#2F4850","font-weight": "bold"}

	plusDayToolTip = new Layer
		width: 120
		height: 40
		y: 80
		x: 158
		backgroundColor: 'transparent'
		superLayer: toolTipRight
	plusDayToolTip.html = "(+1 Day)"
	plusDayToolTip.style = {"font-size":"25px","text-align":"right","line-height":"30px","color": "#1cebf7","font-weight": "bold"}
	
	plusDay = new Layer
		width: 120
		height: 40
		y: -190
		x: controls.width - 150
		backgroundColor: 'transparent'
	plusDay.superLayer = controls
	plusDay.html = "+1 Day"
	plusDay.style = {"font-size":"32px","text-align":"right","line-height":"30px","color": "#FF0000"}

	# Drag events
	sliderRight.knob.on Events.Move,->
		toolTipRight.x = (sliderRight.knob.midX + sliderRight.width) - 130
		toolTipRight.opacity = 1
		sliderRight.knobSize = 110
		sliderRight.knob.backgroundColor = "#2BA99F"
		
		if sliderRight.value < 24
			toolTipRight.html = "Landing by" + "<br/>" + 
			( (Utils.round(sliderRight.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "PM"
			timestampRight.html = ((Utils.round(sliderRight.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "PM"
			
		if sliderRight.value >= 24
			toolTipRight.html = "Landing by" + "<br/>" + 
			( (Utils.round(sliderRight.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "AM"
			timestampRight.html = ((Utils.round(sliderRight.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "AM"
			
		if sliderRight.value > 35
			toolTipRight.html = "Landing by" + "<br/>" + 
			( (Utils.round(sliderRight.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "PM"
			timestampRight.html = ((Utils.round(sliderRight.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "PM"
		
		# change the content list accordingly
# 		if sliderRight.value > 31
# 			scroll01.visible = false
# 			scroll02.visible = false
# 			scroll03.visible = false
# 			scroll04.visible = true
# 			scroll05.visible = false
# 			
# 		if sliderRight.value < 31
# 			scroll01.visible = true
# 			scroll02.visible = false
# 			scroll03.visible = false
# 			scroll04.visible = false
# 			scroll05.visible = false
# 			
# 		if sliderRight.value < 24
# 			scroll01.visible = false
# 			scroll02.visible = false
# 			scroll03.visible = false
# 			scroll04.visible = false
# 			scroll05.visible = true
			
		if sliderRight.value > 25
			plusDay.animate
				properties: {opacity: 1}
				time: 0.1
				curve: 'spring(350, 20, 0)'
			plusDayToolTip.animate
				properties: {opacity: 1}
				time: 0.1
				curve: 'spring(350, 20, 0)'
				
		if sliderRight.value < 25
			plusDay.animate
				properties: {opacity: 0}
				time: 0.1
				curve: 'spring(350, 20, 0)'
			plusDayToolTip.animate
				properties: {opacity: 0}
				time: 0.1
				curve: 'spring(350, 20, 0)'
	
	sliderRight.knob.on Events.DragEnd, ->
		toolTipRight.opacity = 0
		sliderRight.knobSize = 100
		sliderRight.knob.backgroundColor = "#1FBAAD"
	
	# SLIDER LEFT
	# define sliderLeft component
	sliderLeft = new SliderComponent
		width: (controls.width - 120) / 2 - 30
		height: 6
		x: 80
		y: -35
		backgroundColor: "#0D96FB"
		superLayer: controls
	sliderLeft.fill.backgroundColor = "#cccfd3"
	
	# Customize knob appearence
	sliderLeft.knobSize = 100
	sliderLeft.knob.borderRadius = 50
	sliderLeft.knob.backgroundColor = "#0D96FB"
	sliderLeft.knob.shadowColor = "rgba(0, 0, 0, 0.4)"
	sliderLeft.knob.shadowX = -6
	sliderLeft.knob.draggable.momentum = false
	
	# set up min/max val for the slider
	sliderLeft.min = 7
	sliderLeft.max = 21
	
	# add the icon to the knob
	takeoffIcon.superLayer = sliderLeft.knob
	takeoffIcon.x = 10
	takeoffInnerShadow.superLayer = sliderLeft.knob
	takeoffInnerShadow.y = 6
	
	# define tooltip
	toolTipLeft.opacity = 0
	toolTipLeft.index = 1000
	toolTipLeft.html = "Takeoff from" + "<br/>" + ( (Utils.round(sliderLeft.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "AM"
	toolTipLeft.style = {"font-size":"42px","text-align":"left","line-height":"50px","padding-top": "18px","padding-left": "12px","color": "#1cebf7"}
	
	# Define time stamp
	timestampLeft = new Layer
		width: 180
		height: 40
		y: -155
		x: 300
		backgroundColor: "transparent"
		superLayer: controls
	timestampLeft.html = ((Utils.round(sliderLeft.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "AM"
	timestampLeft.style = {"font-size":"42px","text-align":"center","line-height":"40px","color": "#2F4850","font-weight": "bold"}

	# Drag events 
	sliderLeft.knob.on Events.Move,->
		toolTipLeft.x = (sliderLeft.knob.midX + 10)
		toolTipLeft.opacity = 1
		sliderLeft.knobSize = 110
		sliderLeft.knob.backgroundColor = "#1A60B3"
	
		if sliderLeft.value > 0
			toolTipLeft.html = "Take-off from" + "<br/>" + 
			( (Utils.round(sliderLeft.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "AM"
			timestampLeft.html = ((Utils.round(sliderLeft.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "AM"
			
		if sliderLeft.value > 12
			toolTipLeft.html = "Take-off from" + "<br/>" +
			( (Utils.round(sliderLeft.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "PM"
			timestampLeft.html = ((Utils.round(sliderLeft.value, 0) + 11) % 12 + 1 ) + ":" + "00" + "PM"
		
	# 	change the content list accordingly
# 		if sliderLeft.value > 0
# 			scroll01.visible = true
# 			scroll02.visible = false
# 			scroll03.visible = false
# 			scroll04.visible = false
# 			scroll05.visible = false
# 		
# 		if sliderLeft.value > 15
# 			scroll01.visible = false
# 			scroll02.visible = true
# 			scroll03.visible = false
# 			scroll04.visible = false
# 			scroll05.visible = false
# 			
# 		if sliderLeft.value >= 21
# 			scroll01.visible = false
# 			scroll02.visible = false
# 			scroll03.visible = true
# 			scroll04.visible = false
# 			scroll05.visible = false		
	
	sliderLeft.knob.on Events.DragEnd, ->
		toolTipLeft.opacity = 0
		sliderLeft.knobSize = 100
		sliderLeft.knob.backgroundColor = "#0D96FB"
	
		
####################################################################################

enterOutboundResultsAnimation = (loadingAnimationLayer) ->
	# animate the loading msg out
	for layer, i in [msg, SearchingFlightTxt, loadingAnimationLayer]
		layer.animate
			properties: {y: layer.y + 200, opacity: 0}
			time: 0.16
			curve: 'spring(225, 50, 0)'
			
	# animate the results list in
	for i in [1...9]
		items = $["row" + i]
		items.states.switch 'fadein'
		
	# animate the timeFilters title
	slider.states.switch 'fadein'
	
#####################################################################################

outBoundResultsScreen = ->
	
	createTimeFilters()
	
	# hide layers from outbound results
	for layer in [planeAnimationPlaceholder, slider]
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
	for i in [1...9]
		items = $["row" + i]
		currentY = items.y
		items.states.add
		    hide: {y: currentY + 180, opacity:0}
		    fadein: {y: currentY, opacity:1}
		items.states.switchInstant "hide"
		  
		items.states.animationOptions = 
		    curve: "spring(320, 45, 0)"
		items.states.animationOptions.delay = 0.5 + (0.08 * i)
	
	# state animation for timeFilters
	sliderY = slider.y
	slider.states.add
		hide: {y: sliderY - slider.height, opacity: 0}
		fadein: {y: sliderY ,opacity: 1}
	slider.states.switchInstant "hide"
	
	slider.states.animationOptions = 
		curve: "spring(330, 35, 0)"
	slider.states.animationOptions.delay = 0.4
	
	# listen to x change on the whole screen to initiate
	outboundResults.on "change:x", ->
		Utils.delay 3, ->
			enterOutboundResultsAnimation(loadingLayer)
	
	# create scroll conponent of outbound flights results
	createScrollComponent(scrolloutboundResults, outboundRows, 160, outboundResults)
		
	filterModel()

	# click each item in the outboundResults
	for cell in [row1, row2, row3, row4, row5, row6, row7, row8, row9]
		cell.on Events.Click, ->
			return if scrolloutboundResults.isMoving
			animateNextView(@, outboundDetails, outboundResults)

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


