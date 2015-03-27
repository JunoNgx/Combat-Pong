package;

import flixel.FlxG;
import flixel.FlxState;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import flixel.util.FlxColor;

import flixel.util.FlxTimer;

import G;

using flixel.util.FlxSpriteUtil;
//using flixel.util.LineStyle;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState {
	
	public var aino: Aino;
	public var zion: Zion;
	public var pila: Pila;
	
	public var hp_aino: Int = 5;
	public var hp_zion: Int = 5;
	
	public static var bulletPool: BulletPool;
	public var timer_push: FlxTimer;
	public var timer_reset: FlxTimer;
	
	public static var ui: UI;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void {
		super.create();
		
		this.bgColor = 0xFF202020;
		
		bulletPool = new BulletPool();
		add(bulletPool);
		
		aino = new Aino();
		zion = new Zion();
		pila = new Pila();
		ui = new UI();
		
		add(ui);
		add(aino);
		add(zion);
		add(pila);
		
		ui.drawAinoHP(hp_aino);
		ui.drawZionHP(hp_zion);
		
		timer_push = new FlxTimer(1.5, pila.push);
		
		//timer_reset = new FlxTimer(2, resetGame);

		
		//FlxG.debugger.track(bulletPool);
		

		//FlxG.watch(bulletPool, maxSize);
		
		//resetGame();
		
		//pila.push();
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
		
		FlxG.overlap(bulletPool, aino, killAllHit);
		FlxG.overlap(bulletPool, zion, killAllHit);
		
		FlxG.overlap(bulletPool, bulletPool, killAllHit);
	}	
	
	private function collideAino(pad: FlxSprite, pila: Pila):Void {
		pila.collideBottom();
	}
	
	private function collideZion(pad: FlxSprite, pila: Pila):Void {
		pila.collideTop();
	}
	
	private function killAllHit(Obj1: FlxSprite, Obj2:FlxSprite):Void {
		Obj1.kill();
		Obj2.kill();
	}
	
	
	function resetGame(timer_push:FlxTimer):Void {

		
		
	}
	//private function zionHit(zion: Zion, bullet:BulletPool):Void {
		//
	//}
}