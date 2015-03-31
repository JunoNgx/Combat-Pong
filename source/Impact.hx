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
		
		makeGraphic(512, 512, FlxColor.TRANSPARENT, true);
		
		var vertices = new Array<FlxPoint>();
		vertices[0] = new FlxPoint(width/2, 0);
		vertices[1] = new FlxPoint(width, height/2);
		vertices[2] = new FlxPoint(width/2, height);
		vertices[3] = new FlxPoint(0, height / 2);

		drawPolygon(vertices, FlxColor.TRANSPARENT,
			{ color: FlxColor.WHITE, thickness: 5 });
	}
	
	public function initiate(targetScale: Float): Void {
		revive();
		
		this.scale.x = 0.1;
		this.scale.y = 0.1;
		this.alpha = 1;

		FlxTween.tween(this.scale, { x: targetScale, y: targetScale }, G.impact_lifetime);
		FlxTween.tween(this, { alpha: 0 }, G.impact_lifetime, { complete: function(tween:FlxTween) {
				this.kill();
			}
		});
	}
}