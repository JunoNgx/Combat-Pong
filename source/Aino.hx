package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;

//import BulletPool;
//import PlayState;

using flixel.util.FlxSpriteUtil;
import G;

/**
 * ...
 * @author Juno Nguyen
 */
class Aino extends FlxSprite {
	
	var input_lt: Bool;
	var input_rt: Bool;
	
	var forceRate: Float;
	
	public var isFiring:Bool;
	
	private static var SPEED: Int = 300;

	//var 
	
	public function new() {
		super();
		makeGraphic(196, 32, FlxColor.AZURE, true);

		
		//setSize(196, 32);
		
		//this.setSize(500, 40);
		//this.offset.set(-98, -32);
		//this.origin.set(-98, -32);
		
		//this.centerOrigin();
		//this.centerOffsets();
		this.x = FlxG.width / 2;
		this.y = FlxG.height * 0.9;
		
		//FlxSpriteUtil.drawRect(this, this.x - this.width / 2, this.y - this.height / 2, this.width, this.height, FlxColor.CRIMSON);
	}
	
	override public function update(): Void {
		super.update();
		
		//input_lt = FlxG.inputs.anyPressed(["LEFT"]);
		
		if (FlxG.keys.anyPressed(["LEFT"])) {
			this.velocity.x = -SPEED;
		} else if (FlxG.keys.anyPressed(["RIGHT"])) {
			this.velocity.x = SPEED;
		} else this.velocity.x = 0;
		
		//if (FlxG.keys.anyPressed(["DOWN"])) {
			////fire();
			//isFiring = true;
		//} else isFiring = false;
		if (FlxG.keys.anyJustPressed( ["DOWN"] )) {
			
		}
		
		if (FlxG.keys.anyPressed( ["DOWN"] )) {
			if (forceRate < 5) forceRate += FlxG.elapsed;
		}
		
		if (FlxG.keys.anyJustReleased( ["DOWN"] )) {
			if (forceRate > G.forceRate_min) {
				PlayState.bulletPool.fireBullet(true, this.x, forceRate);
			}
			forceRate = 0;
		}
	}
	
	//public function fire(state:FlxState): Void {
		//state.bulletPool.fireBullet(false, this.x);
	//}
	
	//override public function destroy():Void {
		//super.destroy();
	//}
}