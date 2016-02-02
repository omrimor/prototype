# Import file "flightBooking-Android-01" (sizes and positions are scaled 1:3)
$ = Framer.Importer.load("imported/flightBooking-Android-01@3x")

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

# Define animation functions
animateNextView = (clickLayer, animateLayer) ->
	clickLayer.on(Events.Click, android.ripple)
	clickLayer.on Events.Click, ->
		# Create back button layer
		backBtn = new Layer
		backBtn.superLayer = animateLayer
		backBtn.placeBehind(backClick)
		backBtn.y = 72
		backBtn.height = 170
		backBtn.width = backBtn.height
		backBtn.backgroundColor = '#fff'
# 		backBtn.opacity = 0
		
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
			
animateBackView = (clickLayer, animateLayer) ->
	clickLayer.on(Events.Click, android.ripple)
	clickLayer.on Events.Click, ->
		animateLayer.animate
			properties:
				y: 400
				opacity: 0
			time: timeOut
			curve: animateOutCurve

			
animateNextView(arrivalClick, searchRecent)
