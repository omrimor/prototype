# Import file "flightBooking-Android-prototype"
sketch1 = Framer.Importer.load("imported/flightBooking-Android-prototype@1x")


# Import file "flightBooking-Android-01" (sizes and positions are scaled 1:3)
$ = Framer.Importer.load("imported/flightBooking-Android-prototype@3x")

# Modules
{Pointer} = require "Pointer"
android = require "androidRipple"

# Defauls set up
Utils.globalLayers($)
Framer.Defaults.Animation = 
	curve: 'spring(300,20)'
	
# Define Vars	
animateInCurve = 'ease-out'
timeIn = 0.3
animateOutCurve = 'ease-in-out'
timeOut = 0.25
modelUpCurve = 'spring(190,24)'
modelUpTime = 0.3
modelDownCurve = 'spring(190,24)'
modelDownTime = 0.3

# Define animation functions

animateNextView = (clickLayer, animateLayer) ->
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
		animateBackView(backBtn, animateLayer)
		
		animateLayer.x = 0
		animateLayer.y = 400
		animateLayer.opacity = 0
		animateLayer.animate
			properties:
				y: 0
				opacity: 1
			time: timeIn
			curve: animateInCurve
##################################################################			
animateBackView = (clickLayer, animateLayer) ->
	clickLayer.on(Events.Click, android.ripple)
	clickLayer.on Events.Click, ->
		animateLayer.animate
			properties:
				y: 400
				opacity: 0
			time: timeOut
			curve: animateOutCurve
		clickLayer.destroy()
##################################################################

animateModelUp = (clickLayer, animateLayer) ->
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
		animateBackView(backBtn, animateLayer)
		
		animateLayer.x = 0
		animateLayer.y = Screen.height
		animateLayer.opacity = 0
		animateLayer.animate
			properties:
				y: 0
				opacity: 1
			curve: modelUpCurve
##################################################################

animateModelDown = (clickLayer, animateLayer) ->
	clickLayer.on(Events.Click, android.ripple)
	clickLayer.on Events.Click, ->
		animateLayer.animate
			properties:
				y: Screen.height
				opacity: 0
			time: modelDownTime
			curve: modelDownCurve
##################################################################

# INIT PROTOTYPE
# hide filled group form home
filled.opacity = 0

#click the arrival cell
animateModelUp(arrivalClick, search)

# hide all suggestion cells from search
for cell in [sCellItem01, sCellItem02, sCellItem03, sCellItem04]
	cell.opacity = 0
	
# Click keyboard to simulate search	
keyboardLightRecent.on Events.Click, ->
	placeHolderText.animate
		properties:
			y: 100
			width: 180
			height: 32
			opacity: 0
		time: 0.4
		curve: 'ease-out'
	AppBarSearchPlaceHolder.opacity = 0
	recentCellItem.animate
		properties:
			opacity: 0
	# show suggestion cells		
	for cell, i in [sCellItem01, sCellItem02, sCellItem03, sCellItem04]
		cell.animate
			properties:
				opacity: 1
			delay: .1 * i
			curve: "spring-dho(1200, 100, 10, 0.01)"
	# show filled group
	filled.opacity = 1
			

# animate the search model back down
animateModelDown(sCellItem02, search)

# click the dates cell
animateModelUp(datesHomeActive, datePickerPrepopulated)

#click the done button in date picker
animateModelDown(doneDates, datePickerPrepopulated)

#click find my flights button
animateNextView(findMyFlights, outboundResults)

#hide layers from outbound results
for layer in [dialog, scrim, results, planeAnimationPlaceholder]
	layer.opacity = 0
# place loading gif animation
loadingLayer = new Layer
loadingLayer.superLayer = outboundResults
loadingLayer.x = 46*3
loadingLayer.y = 155*3
loadingLayer.width = 269*3
loadingLayer.height = 79*3
loadingLayer.image = 'images/planeLoading.gif'




		
		
		






