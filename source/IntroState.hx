package;

import flixel.FlxSprite;
import flixel.FlxState;
import flixel.tweens.FlxTween;
import flixel.FlxG;

import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
/**
 * ...
 * @author Juno Nguyen
 */
class IntroState extends FlxState {
	
	var logo:FlxSprite;
	
	public static var fillScale: FillScaleMode;
	public static var ratioScale: RatioScaleMode;

	override public function create() {
		super.create();

		this.bgColor = 0xFF202020;
		
		ratioScale = new RatioScaleMode();
		fillScale = new FillScaleMode();
#if mobile
		FlxG.scaleMode = fillScale;
#else
		FlxG.scaleMode = ratioScale;
#end
		
		logo = new FlxSprite().loadGraphic("assets/images/AureoTetra.png");
		logo.x = FlxG.width / 2 - logo.width / 2;
		logo.y = FlxG.height / 2 - logo.height / 2;
		logo.alpha = 0;
		
		add(logo);

		fadeIn();
	}
	
	public function fadeIn():Void {
		FlxTween.tween(logo, { alpha: 1 }, 1.5, { startDelay: 1, complete: fadeOut});
	}
	
	public function fadeOut(tween:FlxTween):Void {
		FlxTween.tween(logo, { alpha: 0 }, 1.5, { startDelay: 1.5,
			complete: function(tween:FlxTween){
				FlxG.switchState(new MenuState());
		}});
	}
	
	override public function update() {
		super.update();
		
		if (FlxG.mouse.justPressed || FlxG.keys.anyJustPressed(["SPACE", "ENTER"])) {
			FlxG.switchState(new MenuState());
		}
	}
	
	override public function destroy(): Void {
		super.destroy();
		
		logo.destroy();
		logo = null;
	}
	
	
}