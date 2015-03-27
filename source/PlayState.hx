package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState {
	
	private var aino: AinoCtrl;
	private var zion: ZionCtrl;
	private var pila: Pila;
	
	private var bulletPool: BulletPool;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void {
		super.create();
		
		aino = new AinoCtrl();
		add(aino);
		
		FlxSpriteUtil.drawRect(aino, aino.x - aino.width / 2, aino.y - aino.height / 2, aino.width, aino.height, FlxColor.CRIMSON);
		
		zion = new ZionCtrl();
		add(zion);
		
		pila = new Pila();
		add(pila);
		
		bulletPool = new BulletPool();
		add(bulletPool);
		
		FlxG.debugger.track(bulletPool);
		//FlxG.watch(bulletPool, maxSize);
		
		pila.push();
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void {
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void {
		super.update();
		
		//Don't work, apparently. And they're funny, causing the paddle to slide.
		//FlxG.collide(aino, pila);
		//FlxG.collide(zion, pila);
		
		if (aino.isFiring) bulletPool.fireBullet(true, aino.x);
		if (zion.isFiring) bulletPool.fireBullet(false, zion.x);
		
		FlxG.overlap(aino, pila, collideAino);
		FlxG.overlap(zion, pila, collideZion);
		
		FlxG.collide(bulletPool, aion, aionHit);
		FlxG.collide(bulletPool, zion), zionHit;
	}	
	
	private function collideAino(aino: AinoCtrl, pila: Pila):Void {
		pila.collideBottom();
	}
	
	private function collideZion(zion: ZionCtrl, pila: Pila):Void {
		pila.collideTop();
	}
	
	private function aionHit(aino: AinoCtrl, bullet:BulletPool):Void {
		
	}
	
	private function zionHit(zion: ZionCtrl, bullet:BulletPool):Void {
		
	}
}