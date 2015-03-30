package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxRandom;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Juno Nguyen
 */
class Explosion extends FlxSprite {
	
	//var tweener:FlxTween;

	public function new() {
		super();
	}
	
	public function initiate(): Void {
		var scale = FlxRandom.floatRanged(G.exp_scale_min, G.exp_scale_max);
		var size = Std.int(G.exp_default_size * scale);
		
		makeGraphic(size, size, FlxColor.TRANSPARENT, true);
		
		var vertices = new Array<FlxPoint>();
		vertices[0] = new FlxPoint(width/2, 0);
		vertices[1] = new FlxPoint(width, height/2);
		vertices[2] = new FlxPoint(width/2, height);
		vertices[3] = new FlxPoint(0, height / 2) ;
		drawPolygon(vertices, FlxColor.WHITE);
		
		alpha = 0;
		
		revive();
		FlxTween.tween(this, { alpha: 1 }, 0.05, { complete:
				function(tween:FlxTween) {
					FlxTween.tween(this, { alpha: 0 }, 0.2, { complete: function(tween:FlxTween) { this.kill(); }} );
				}
		});
	}
	
	//override function kill(tween:FlxTween) {
		//super.kill();
	//}
	
	//public function spawn(X: Float, Y: Float) {
		//x = X - width/2;
		//y = Y - height / 2;
		
		//fadeIn(0.1, false);
	//}
	
	//public function fadeOutCust() {
		//fadeOut(0.4, true, function():Void { kill(); } );
	//}
}