package;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.util.FlxPoint;

import G;

using flixel.util.FlxSpriteUtil;

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
			bullet.angle = -180;
		}
		
		bullet.x = X - bullet.width/2;
		bullet.revive();
	}
	
	public function createEntity() {
		var bullet:FlxSprite = new FlxSprite();
		//bullet.makeGraphic(8, 24, FlxColor.CRIMSON);
		bullet.makeGraphic(G.bullet_width, G.bullet_height, FlxColor.TRANSPARENT, true);
		
		var vertices = new Array<FlxPoint>();
		vertices[0] = new FlxPoint(bullet.width/2, 0);
		vertices[1] = new FlxPoint(bullet.width, bullet.height * 0.7);
		vertices[2] = new FlxPoint(bullet.width/2, bullet.height);
		vertices[3] = new FlxPoint(0, bullet.height * 0.7);		
		
		bullet.drawPolygon(vertices, FlxColor.CRIMSON);
		//bullet.drawRect(bullet.x, bullet.y, bullet.width, bullet.height, FlxColor.CRIMSON);
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