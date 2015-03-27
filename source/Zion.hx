package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

import G;

/**
 * ...
 * @author Juno Nguyen
 */
class Zion extends FlxSprite {
	
	var input_lt: Bool;
	var input_rt: Bool;
	
	var forceRate: Float;
	
	public function new() {
		super();
		makeGraphic(196, 8, FlxColor.FOREST_GREEN);
		this.x = FlxG.width / 2;
		this.y = FlxG.height * 0.1;
	}
	
	override public function update(): Void {
		super.update();
		
		if (FlxG.keys.anyPressed(["A"])) {
			this.velocity.x = -G.playerSpeed;
		} else if (FlxG.keys.anyPressed(["D"])) {
			this.velocity.x = G.playerSpeed;
		} else this.velocity.x = 0;
		
		if (FlxG.keys.anyJustPressed( ["S"] )) {
			
		}
		
		if (FlxG.keys.anyPressed( ["S"] )) {
			if (forceRate < 5) forceRate += FlxG.elapsed;
		}
		
		if (FlxG.keys.anyJustReleased( ["S"] )) {
			if (forceRate > G.forceRate_min) {
				PlayState.bulletPool.fireBullet(false, this.x, forceRate);
			}
			forceRate = 0;
		}
	}
	
	public function fire(): Void {
		
	}
}