package;

import flixel.addons.effects.FlxTrail;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.RatioScaleMode;

class MenuState extends FlxState {
	
	var version: String = "1.0";
	
	var text_title: FlxText;
	var text_subtitle: FlxText;
	var text_version: FlxText;
	var text_twitter: FlxText;
	var text_play: FlxText;
	var text_control: FlxText;
	var text_copyright: FlxText;
	
	var pila:Pila;
	var pila_trail: FlxTrail;
	
	var font_default: String = "assets/fonts/quer.ttf";
	var font_size_upper: Int = 17;
	var font_size_tutorial: Int = 17;
	
	public static var fillScale: FillScaleMode;
	public static var ratioScale: RatioScaleMode;
	
	override public function create():Void {
		super.create();
		
		this.bgColor = 0xFF202020;
		
		ratioScale = new RatioScaleMode();
		fillScale = new FillScaleMode();
#if mobile
		FlxG.scaleMode = fillScale;
#else
		FlxG.scaleMode = ratioScale;
#end
		
		pila = new Pila();
		pila_trail = new FlxTrail(pila);
		pila.menu_mode = true;
		add(pila);
		add(pila_trail);
		pila.push(new FlxTimer(0));
		
		text_title = new FlxText(0, FlxG.height * 0.20, FlxG.width, "PONGCERTO");
		text_title.setFormat(font_default, 60, FlxColor.WHITE, "center");
		add(text_title);		
		
		text_subtitle = new FlxText(0, FlxG.height * 0.27, FlxG.width, "a less sporty pong");
		text_subtitle.setFormat(font_default, 24, FlxColor.WHITE, "center");
		add(text_subtitle);
		
		text_version = new FlxText(0, 0, FlxG.width / 2, version);
		text_version.setFormat(font_default, font_size_upper, FlxColor.WHITE, "left");
		add(text_version);
		
		text_twitter = new FlxText(FlxG.width/2, 0, FlxG.width/2, "@JunoNgx");
		text_twitter.setFormat(font_default, font_size_upper, FlxColor.WHITE, "right");
		add(text_twitter);
		
		text_play = new FlxText(0, FlxG.height * 0.50, FlxG.width);
#if mobile
		text_play.text = "Touch to play";
#else
		text_play.text = "Press to play";
#end
		text_play.setFormat(font_default, 40, FlxColor.WHITE, "center");
		add(text_play);
		
		
		text_control = new FlxText(0, FlxG.height * 0.65, FlxG.width);
#if mobile
		text_control.text = "(find someone to play with) \n\n for each half of the screen: \n\n touch and drag to move \n\n with another finger long press \n and release to fire \n\n (hold longer for deadlier assailment)";
#else
		text_control.text = "(find someone to play with) \n\n (a) // (d) // (left) // (right) to move \n\n hold down (s) // (down) for a while \n and release to shoot \n\n (hold longer for deadlier assailment)";
#end
		text_control.setFormat(font_default, font_size_tutorial, FlxColor.WHITE, "center");
		add(text_control);
		
		
		text_copyright = new FlxText(0, FlxG.height * 0.95, FlxG.width, "2015 Aureoline Tetrahedron");
		text_copyright.setFormat(font_default, 24, FlxColor.WHITE, "center");
		add(text_copyright);
	}
	
	override public function update():Void {
		super.update();
		
//#if mobile
		//if (FlxG.mouse.justPressed) {
//#else
		//if (FlxG.keys.anyJustPressed(["SPACE", "ENTER"])) {
//#end
			//FlxG.switchState(new PlayState());
		//}
		
		if (FlxG.mouse.justPressed || FlxG.keys.anyJustPressed(["SPACE", "ENTER"])) {
			FlxG.switchState(new PlayState());
		}
	}
	
	override public function destroy():Void {
	
		text_title.destroy();
		text_title = null;		
		text_subtitle.destroy();
		text_subtitle = null;
		text_version.destroy();
		text_version = null;
		text_twitter.destroy();
		text_twitter = null;
		text_play.destroy();
		text_play = null;
		text_control.destroy();
		text_control = null;
		text_copyright.destroy();
		text_copyright = null;
		
		//pila_trail.destroy();
		pila_trail = null;
		pila.destroy();
		pila = null;
	
		super.destroy();
	}	
}