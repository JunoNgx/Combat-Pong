package;

import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxPoint;

import G;

using flixel.util.FlxSpriteUtil;
/**
 * ...
 * @author Juno Nguyen
 */
class Aino extends FlxSpriteGroup {
	
	var input_lt: Bool;
	var input_rt: Bool;
	
	public var forceRate: Float;
	//static var core:FlxSprite;
	public var sfx_fire: FlxSound;
	
#if mobile
	var touchID: Int = -1;
	var touchID2: Int = -1;
	
	var t_sx: Float;
	var ox: Float;
#end

	public function new() {
		super();
		this.maxSize = G.numOfPad;

		sfx_fire = FlxG.sound.load("assets/sounds/fire.ogg");

		//core = new FlxSprite();
		//core.makeGraphic(25, 25, FlxColor.TRANSPARENT, true);
		////var vertices = new Array<FlxPoint>();
		////vertices[0] = new FlxPoint(core.width/2, 0);
		////vertices[1] = new FlxPoint(core.width/2 + forceRate * G.player_core_multiplier, core.height/2);
		////vertices[2] = new FlxPoint(core.width/2, height);
		////vertices[3] = new FlxPoint(core.width/2 - forceRate * G.player_core_multiplier, core.height/2);
		////
		////core.drawPolygon(vertices, FlxColor.CRIMSON);
		//
		//makeGraphic(16, 16, FlxColor.TRANSPARENT, true );
				//
		//var vertices = new Array<FlxPoint>();
		//vertices[0] = new FlxPoint(width/2, 0);
		//vertices[1] = new FlxPoint(width, height/2);
		//vertices[2] = new FlxPoint(width/2, height);
		//vertices[3] = new FlxPoint(0, height/2) ;		
		//
		//drawPolygon(vertices, FlxColor.CRIMSON);
		
		initiate();
	}
	
	public function initiate(): Void {
		this.x = FlxG.width / 2;
		this.y = FlxG.height * 0.9 - G.padThickness / 2;
		
		this.forEach(function (pad:FlxSprite): Void {
			remove(pad);
		});
		
		for (i in 1...(G.numOfPad+1)) {
			var pad = new FlxSprite(i);
			pad.makeGraphic(G.padLength, G.padThickness, G.gameColor);
			pad.ID = i;
			pad.immovable = true;
			this.add(pad);
		}
		
		forceRate = 0;
	}
	
	override public function update(): Void {
		super.update();
		
		updateInput();
		updatePosition();
		
		keepOnScreen();
	}
	
	public function updatePosition(): Void {
		this.forEachAlive(function (pad: FlxSprite):Void {
			pad.x = this.x + (pad.ID - ((G.numOfPad + 1)/2)) * (pad.width + G.padSpacing) - pad.width/2;
		});
	}
	
	public function updateInput(): Void {
#if (web || flash || desktop)
		if (FlxG.keys.anyPressed(["LEFT"])) {
			this.velocity.x = -G.playerSpeed;
		} else if (FlxG.keys.anyPressed(["RIGHT"])) {
			this.velocity.x = G.playerSpeed;
		} else this.velocity.x = 0;

		//if (FlxG.keys.anyJustPressed( ["DOWN"] )) {
			//
		//}
		
		if (FlxG.keys.anyPressed( ["DOWN"] )) {
			if (forceRate < G.forceRate_max) forceRate += FlxG.elapsed;
		}
		
		if (FlxG.keys.anyJustReleased( ["DOWN"] )) {
			if (forceRate > G.forceRate_min) {
				fire();
			}
			forceRate = 0;
		}
#end

#if mobile
		for (t in FlxG.touches.list) {
			if (t.justPressed && t.screenY > FlxG.height / 2 && touchID == -1) {
				touchID = t.touchPointID;
				t_sx = t.x;
				ox = x;
			}
				
			//Second touch on half of the screen
			for (t2 in FlxG.touches.list) {
				if ((t2.justPressed) && (t2.screenY > FlxG.height / 2) && (t2.touchPointID != touchID) && (touchID != -1)) {
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
					if (forceRate < G.forceRate_max) forceRate += FlxG.elapsed;
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
		PlayState.bulletPool.fireBullet(true, this.x, forceRate);
		sfx_fire.play();
	}

#if mobile
	public function resetTouch(): Void {
		touchID = -1;
		touchID2 = -1;
	}
#end
}