package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;

import G;

/**
 * ...
 * @author Juno Nguyen
 */
class Zion extends FlxSpriteGroup {
	
	var input_lt: Bool;
	var input_rt: Bool;
	
	var forceRate: Float;
	
	public function new() {
		super();
		//makeGraphic(196, 8, FlxColor.FOREST_GREEN);
		this.x = FlxG.width / 2;
		this.y = FlxG.height * 0.1 + G.padThickness/2;
		this.maxSize = G.numOfPad;
		
		for (i in 1...(G.numOfPad+1)) {
			var pad = new FlxSprite(i);
			pad.makeGraphic(G.padLength, G.padThickness, FlxColor.FOREST_GREEN);
			pad.ID = i;
			this.add(pad);
		}
	}
	
	override public function update(): Void {
		super.update();
		
		updateInput();
		updatePosition();
	}
	
	public function updatePosition(): Void {
		this.forEachAlive(function (pad: FlxSprite):Void {
			pad.x = this.x + (pad.ID - ((G.numOfPad + 1)/2)) * (pad.width + G.padSpacing) - G.padSpacing/2;
		});
	}
	
	public function updateInput(): Void {
		
		if (FlxG.keys.anyPressed(["A"])) {
			this.velocity.x = -G.playerSpeed;
		} else if (FlxG.keys.anyPressed(["D"])) {
			this.velocity.x = G.playerSpeed;
		} else this.velocity.x = 0;
		
		//if (FlxG.keys.anyJustPressed( ["S"] )) {
			//
		//}
		
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
}