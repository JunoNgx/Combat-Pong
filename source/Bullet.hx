package;
import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * ...
 * @author Juno Nguyen
 */
class Bullet extends FlxSprite {
	
	var SPEED: Float = 500;

	public function new(X: Float, Y: Float) {
		super(X, Y);
		
		makeGraphic(32, 16, FlxColor.CRIMSON);
		
		this.velocity.y = -SPEED;
	}
	
	//public function fire
	
	//override public function update() {
		//super.update();
		
		//if (!this.isOnScreen()) this.kill();
	//}
	
}