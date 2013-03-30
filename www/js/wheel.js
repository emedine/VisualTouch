//Convert Radians into degrres:
var trans=180/Math.PI;
// Array for storing the center-coordinates of our wheel: 
var center;
//Radius of our wheel:
var wheelRadius=82;

//On mousedown we activate ourSlider:
function activateSlider(target, event){
	center=	[($('#wheel').outerWidth()/2), ($('#wheel').outerHeight()/2)] ;
	//after activation, we add a mousemove-event to the wheel-div for repositioning the slider
	$('#wheel').mousemove(function(e) {
		moveSlider(this, e);
	});
}

function moveSlider(target, event){
	//this handler is executed on mouse-move:
	//detect the mouse-coordinates relative to center:
	var x = event.pageX - target.offsetLeft;
	var y = event.pageY - target.offsetTop;
	x-=center[0];
	y-=center[1];
	
	//calculate the mouse-angle relative to center:
	var angle= detectAngle(x, y);
	
	//calculate the new position of the slider on the wheel:
	var pos= polar(wheelRadius, angle);
	pos=addPoint(pos, center);
	
	//reposition slider:
	$('#slider').css('left', pos[0]);
	$('#slider').css('top', pos[1]);
	
	//Convert radians into degrees and display result in textfield
	//(for aesthetical reasons we add 270 deg, so we get nice positive numbers ;-)
	//If there are more/other functions to execute on moving sLider, place them here:
	$('#val_angle').html((Math.floor(angle*trans)+270)+" deg");
    updateGravity(Math.floor(angle*trans)+270);
}

function detectAngle(x, y){
	//some math. More info here: http://en.wikipedia.org/wiki/Trigonometry 
	var angle =Math.atan(y/x);
	if (x<0) {
		angle-=Math.PI;
		}
	return angle;
}

function polar(radius, angle){
	//some math. More info here: http://en.wikipedia.org/wiki/Trigonometry
	var cos=Math.cos(angle);
	var sin=Math.sin(angle);
	var point=[radius*cos, radius*sin-1];
	return point;
}
			
function addPoint(pt_1, pt_2){
	var x=pt_1[0]+pt_2[0];
	var y=pt_1[1]+pt_2[1];
	var point=[x, y];
	return point;
}


jQuery(window).load(function(){
	//calculate coordinates of wheel-center:
	//activate slider on mousedown
	$('#slider').mousedown(function(e) {
		//Prevent text-selection while dragging:
		document.onmousedown = disableMouseSelect;//Unselectable.enable;
		activateSlider(this, e);
	});
	
	//Deactivate slider on mouseup:
	$('#slider').mouseup(function(e) {
		$('#wheel').unbind('mousemove');
		//Re-enable text-selection:
		document.onmousedown = enableMouseSelect;//Unselectable.disable;
	});
	
	$('#wheel').mouseup(function(e) {
		$('#wheel').unbind('mousemove');
		//Re-enable text-selection:
		document.onmousedown = enableMouseSelect;//Unselectable.disable;
	});
})

function disableMouseSelect(e){
	return false;
}

function enableMouseSelect(){
	return true;
}