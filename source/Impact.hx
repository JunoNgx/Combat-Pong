package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import flixel.tweens.FlxTween;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Juno Nguyen
 */
class Impact extends FlxSprite {

	public function new() {
		super();
		
		makeGraphic(128, 128, FlxColor.TRANSPARENT, true);
		
		var vertices = new Array<FlxPoint>();
		vertices[0] = new FlxPoint(width/2, 0);
		vertices[1] = new FlxPoint(width, height/2);
		vertices[2] = new FlxPoint(width/2, height);
		vertices[3] = new FlxPoint(0, height / 2);

		drawPolygon(vertices, FlxColor.TRANSPARENT,
			{ color: FlxColor.WHITE, thickness: 1 }, { color: FlxColor.TRANSPARENT, alpha: 0 } );
	}
	
	public function initiate(): Void {
		revive();

		FlxTween.tween(this.scale, { x: 5, y: 5 }, G.impact_lifetime);
		FlxTween.tween(this, { alpha: 0 }, G.impact_lifetime, { complete: function(tween:FlxTween) {
				this.kill();
			}
		});
	}
}