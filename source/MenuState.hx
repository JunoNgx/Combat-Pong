package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;


class MenuState extends FlxState {
	
	var version: Float = 1.0;
	
	var text_title: FlxText;
	var text_version: FlxText;
	var text_twitter: FlxText;
	var text_play: FlxText;
	var text_control: FlxText;
	var text_copyright: FlxText;
	
	var pila:Pila;
	
	override public function create():Void {
		super.create();
		
		this.bgColor = 0xFF202020;
		pila = new Pila();
		pila.menu_mode = true;
		add(pila);
		pila.push(new FlxTimer(0));
		
		text_title = new FlxText(0, FlxG.height * 0.25, FlxG.width, "PONGCERTO");
		text_title.setFormat("assets/fonts/boring.ttf", 100, FlxColor.WHITE, "center");
		add(text_title);
		
		text_version = new FlxText(0, 0, FlxG.width / 2, Std.string(version));
		text_version.setFormat("assets/fonts/boring.ttf", 30, FlxColor.WHITE, "left");
		add(text_version);
		
		text_twitter = new FlxText(FlxG.width/2, 0, FlxG.width/2, "@JunoNgx");
		text_twitter.setFormat("assets/fonts/boring.ttf", 30, FlxColor.WHITE, "right");
		add(text_twitter);
		
		text_play = new FlxText(0, FlxG.height * 0.50, FlxG.width);
#if mobile
		text_play.text = "Tap to play";
#else
		text_play.text = "Press to play";
#end
		text_play.setFormat("assets/fonts/boring.ttf", 50, FlxColor.WHITE, "center");
		add(text_play);
		
		
		text_control = new FlxText(0, FlxG.height * 0.7, FlxG.width);
#if mobile
		text_control.text = "for each half of the screen \n swipe to move \n long press and release \n with another finger to fire";
#else
		text_control.text = "Left // Shoot // Right \n A // S // D \n Left Arrow // Down Arrow // Right Arrow";
#end
		text_control.setFormat("assets/fonts/boring.ttf", 30, FlxColor.WHITE, "center");
		add(text_control);
		
		
		text_copyright = new FlxText(0, FlxG.height * 0.95, FlxG.width, "2015 Aureoline Tetrahedron");
		text_copyright.setFormat("assets/fonts/boring.ttf", 40, FlxColor.WHITE, "center");
		add(text_copyright);
		

		
		
		//
		//text_zion = new FlxText(FlxG.width/2 - 100, FlxG.height/2 - 180, 200);
		//text_zion.text = str_win;
		//text_zion.setFormat("assets/fonts/boring.ttf", 50, FlxColor.WHITE, "center");
		//text_zion.angle = -180;
	}
	
	override public function update():Void {
		super.update();
		
#if mobile
		if (FlxG.mouse.justPressed) {
#else
		if (FlxG.keys.anyJustPressed(["SPACE", "ENTER"])) {
#end
			FlxG.switchState(new PlayState());
		}
	}
	
	override public function destroy():Void {
	
		text_title.destroy();
		text_title = null;
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
		
		pila.destroy();
		pila = null;
	
		super.destroy();
	}	
}