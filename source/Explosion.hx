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

	public function new() {
		super();
	}
	
	public function initiate(): Void {
		var scale = FlxRandom.floatRanged(G.exp_scale_min, G.exp_scale_max);
		var size = Std.int(G.exp_default_size * scale);
		
		makeGraphic(size, size, FlxColor.TRANSPARENT, true);
		
		var vertices = new Array<FlxPoint>();
		vertices[0] = new FlxPoint(size/2, 0);
		vertices[1] = new FlxPoint(size, size/2);
		vertices[2] = new FlxPoint(size/2, size);
		vertices[3] = new FlxPoint(0, size / 2) ;
		drawPolygon(vertices, FlxColor.WHITE);

		revive();

		FlxTween.tween(this.scale, { x: 1.5, y: 1.5 }, 0.05, { complete:
				function(tween:FlxTween) {
					FlxTween.tween(this.scale, { x: 0.1, y: 0.1 }, 0.2, { complete: function(tween:FlxTween) { this.kill(); }} );
				}
		});
	}
}