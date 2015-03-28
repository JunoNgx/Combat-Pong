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
#if mobile
	var touchID: Int = -1;
	var touchID2: Int = -1;
	
	var t_sx: Float;
	var ox: Float;
#end

	public function new() {
		super();
		this.maxSize = G.numOfPad;
		
		initiate();
	}
	
	public function initiate():Void {
		this.x = FlxG.width / 2;
		this.y = FlxG.height * 0.1 + G.padThickness / 2;
		
		this.forEach(function (pad:FlxSprite): Void {
			remove(pad);
		});
		
		for (i in 1...(G.numOfPad+1)) {
			var pad = new FlxSprite(i);
			pad.makeGraphic(G.padLength, G.padThickness, G.gameColor);
			pad.ID = i;
			this.add(pad);
		}
	}
	
	override public function update(): Void {
		super.update();
		
		updateInput();
		updatePosition();
		
		keepOnScreen();
	}
	
	public function updatePosition(): Void {
		this.forEachAlive(function (pad: FlxSprite):Void {
			pad.x = this.x + (pad.ID - ((G.numOfPad + 1)/2)) * (pad.width + G.padSpacing) - G.padSpacing/2;
		});
	}
	
	public function updateInput(): Void {
		
#if (web || flash || desktop)
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
				fire();
			}
			forceRate = 0;
		}
#end

#if mobile
		for (t in FlxG.touches.list) {
			if (t.justPressed && t.screenY < FlxG.height / 2 && touchID == -1) {
				touchID = t.touchPointID;
				t_sx = t.x;
				ox = x;
			}
				
			//Second touch on half of the screen
			for (t2 in FlxG.touches.list) {
				if ((t2.justPressed) && (t2.screenY < FlxG.height / 2) && (t2.touchPointID != touchID) && (touchID != -1)) {
					touchID2 = t2.touchPointID;
				}
			}
		}
		
		if (touchID != -1) {
				var t = FlxG.touches.getByID(touchID);
				if (t.pressed) x = ox + t.x - t_sx;
				if (t.justReleased) touchID = -1;
		}
		
		if (touchID2 != -1) {
				var t = FlxG.touches.getByID(touchID2);
				if (t.pressed) {
					if (forceRate < 5) forceRate += FlxG.elapsed;
				}
				if (t.justReleased) {
					fire();
					forceRate = 0;
					touchID2 = -1;
				}
		}
#end
	}
	
	public function keepOnScreen(): Void {
		if (x > FlxG.width - G.margin_x) {
			x = FlxG.width - G.margin_x;
		}
		
		if (x < G.margin_x) {
			x = G.margin_x;
		}
	}
	
	public function fire():Void {
		PlayState.bulletPool.fireBullet(false, this.x, forceRate);
	}
}