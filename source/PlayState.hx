package;

import flixel.FlxG;
import flixel.FlxState;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

import flixel.util.FlxMath;
import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;

import G;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState {
	
	public var aino: Aino;
	public var zion: Zion;
	public var pila: Pila;
	
	public static var bulletPool: BulletPool;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void {
		super.create();
		
		aino = new Aino();
		add(aino);
		
		zion = new Zion();
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
		
		//if (aino.isFiring) bulletPool.fireBullet(true, aino.x);
		//if (zion.isFiring) bulletPool.fireBullet(false, zion.x);
		
		FlxG.overlap(aino, pila, collideAino);
		FlxG.overlap(zion, pila, collideZion);
		
		FlxG.overlap(bulletPool, aino, aionHit);
		FlxG.overlap(bulletPool, zion, zionHit);
	}	
	
	private function collideAino(pad: FlxSprite, pila: Pila):Void {
		pila.collideBottom();
	}
	
	private function collideZion(pad: FlxSprite, pila: Pila):Void {
		pila.collideTop();
	}
	
	private function aionHit(aino: Aino, bullet:BulletPool):Void {
		
	}
	
	private function zionHit(zion: Zion, bullet:BulletPool):Void {
		
	}
}