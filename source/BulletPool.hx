package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.FlxG;

import G;

/**
 * ...
 * @author Juno Nguyen
 */
class BulletPool extends FlxSpriteGroup {
	
	static var distFromCtrl: Float = 40;

	public function new() {
		super();
		
		this.maxSize = 50;
	}
	
	override public function update() {
		super.update();
		
		this.checkOnScreen();
	}
	
	public function fireBullet( fromAino:Bool, X:Float, forceRate:Float ) {
		var bullet = this.getFirstDead();
		if (bullet == null) bullet = createEntity();
		
		if (fromAino) {
			bullet.y = FlxG.height * 0.9 - bullet.height - distFromCtrl;
			bullet.velocity.y = -G.bulletSpeed * forceRate * G.forceRate_multiplier;
		} else {
			bullet.y = FlxG.height * 0.1 + distFromCtrl;
			bullet.velocity.y = G.bulletSpeed * forceRate * G.forceRate_multiplier;
		}
		
		bullet.x = X + bullet.width/2;
		bullet.revive();
	}
	
	public function createEntity() {
		var bullet:FlxSprite = new FlxSprite();
		bullet.makeGraphic(8, 24, FlxColor.CRIMSON);
		this.add(bullet);
		
		return bullet;
	}
	
	public function checkOnScreen(): Void {
		this.forEachAlive(function(bullet:FlxSprite):Void {
			if (!bullet.isOnScreen()) bullet.kill();
		});
	}
	
	public function killAll(): Void {
		this.forEachAlive(function(bullet:FlxSprite):Void {
			bullet.kill();
		});
	}
}