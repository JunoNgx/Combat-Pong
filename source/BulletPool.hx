package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.FlxG;

/**
 * ...
 * @author Juno Nguyen
 */
class BulletPool extends FlxSpriteGroup {
	
	static var bulletSPEED: Float = 500;
	static var distFromCtrl: Float = 20;

	public function new() {
		super();
		
		this.maxSize = 50;
	}
	
	override public function update() {
		super.update();
		
		this.checkOnScreen();
	}
	
	public function fireBullet( fromAino:Bool, X:Float ) {
		var bullet = this.getFirstDead();
		if (bullet == null) bullet = createBullet();
		
		if (fromAino) {
			bullet.y = FlxG.height * 0.9 - distFromCtrl;
			bullet.velocity.y = -bulletSPEED;
		} else {
			bullet.y = FlxG.height * 0.1 + distFromCtrl;
			bullet.velocity.y = bulletSPEED;
		}
		
		bullet.x = X;
		bullet.revive();
	}
	
	public function createBullet() {
		var bullet:FlxSprite = new FlxSprite();
		
		bullet.makeGraphic(32, 16, FlxColor.CRIMSON);
		bullet.velocity.y = -bulletSPEED;
		this.add(bullet);
		
		return bullet;
	}
	
	public function checkOnScreen(): Void {
		this.forEachAlive(function(bullet:FlxSprite):Void {
			if (!bullet.isOnScreen()) bullet.kill();
		});
	}
}