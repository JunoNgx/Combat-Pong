package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.system.scaleModes.RatioScaleMode;

import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxMath;
import flixel.util.FlxColor;
import flixel.addons.effects.FlxTrail;

import flixel.util.FlxTimer;
import flixel.system.scaleModes.FillScaleMode;
import flixel.system.scaleModes.RatioScaleMode;

import G;

using flixel.util.FlxSpriteUtil;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState {
	
	public var aino: Aino;
	public var ainoCore: AinoCore;
	public var zion: Zion;
	public var zionCore: ZionCore;
	public var pila: Pila;
	public var pila_trail: FlxTrail;
	
	public var hp_aino: Int = G.initial_hp;
	public var hp_zion: Int = G.initial_hp;
	public var ended: Bool = false;
	
	public static var bulletPool: BulletPool;
	public static var expPool: ExplosionPool;
	public static var impactPool: ImpactPool;
	public var timer_pushBall: FlxTimer;
	public var timer_reset: FlxTimer;
	
	public static var ui: UI;
	
	public static var text_aino: FlxText;
	public static var text_zion: FlxText;
	
	public static var str_win: String = "WON";
	public static var str_lose: String = "LOST";
	
	public static var fillScale: FillScaleMode;
	public static var ratioScale: RatioScaleMode;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void {
		super.create();
		
		this.bgColor = 0xFF202020;
		
		ratioScale = new RatioScaleMode();
		fillScale = new FillScaleMode();
#if mobile
		FlxG.scaleMode = fillScale;
#else
		FlxG.scaleMode = ratioScale;
#end
		// System
		bulletPool = new BulletPool();
		expPool = new ExplosionPool();
		impactPool = new ImpactPool();
		
		//Entities
		aino = new Aino();
		ainoCore = new AinoCore();
		zion = new Zion();
		zionCore = new ZionCore();
		pila = new Pila();
		pila_trail = new FlxTrail(pila);
		ui = new UI();
		
		add(ui);
		add(bulletPool);
		add(aino);
		add(ainoCore);
		add(zion);
		add(zionCore);
		add(pila);
		add(pila_trail);
		add(expPool);
		add(impactPool);
		
		//var exp:Impact = new Impact();
		//add(exp);
		//exp.initiate();
		
		//for (i in 0...10) {
			//impactPool.spawnSingleEntity(i * 100, i * 50);
		//}
		
		
		//UI
		ui.redraw(hp_aino, hp_zion);
		
		// Setting time to initiate the first round
		timer_pushBall = new FlxTimer(1.5, pila.push);
		
		FlxG.watch.add(this, "hp_aino");
		FlxG.watch.add(this, "hp_zion");
		FlxG.watch.add(pila, "speed");
		//FlxG.debugger.track(expPool);
		//FlxG.debugger.track(aino);
		//FlxG.debugger.track(ainoCore);
	}

	override public function update():Void {
		super.update();
		
		ainoCore.sync(aino);
		zionCore.sync(zion);
		
		FlxG.collide(aino, pila, collideAino);
		FlxG.collide(zion, pila, collideZion);
		
		FlxG.collide(bulletPool, aino, hitShake);
		FlxG.collide(bulletPool, zion, hitShake);
		
		FlxG.overlap(bulletPool, bulletPool, killAllHit);
		
		// Check if any player fails to paddle
		if (pila.y < 0) {
			impactPool.spawnSingleEntity(pila.x + pila.width/2, pila.y + pila.height/2, G.impact_scale_large);
			pila.kill();
			pila.reposition();
			timer_reset = new FlxTimer(1, resetGame);
			hp_zion -= 1;
			FlxG.camera.shake(0.01, 0.5);
		}
		
		if (pila.y > FlxG.height - pila.height) {
			impactPool.spawnSingleEntity(pila.x + pila.width/2, pila.y + pila.height/2, G.impact_scale_large);
			pila.kill();
			pila.reposition();
			timer_reset = new FlxTimer(1, resetGame);
			hp_aino -= 1;
			FlxG.camera.shake(0.01, 0.5);
		}
		
		//Spawn impacts and resolve collision
		if (pila.x < 0) {
			pila.x = 0;
			impactPool.spawnSingleEntity(pila.x, pila.y + pila.height / 2, G.impact_scale_small);
		}
		if (pila.x > FlxG.width - pila.width) {
			pila.x = FlxG.width - pila.width;
			impactPool.spawnSingleEntity(pila.x + pila.height, pila.y + pila.height / 2, G.impact_scale_small);
		}
		
		// Reset the game upon ending
		if (this.ended == true) {		
#if (web || flash || desktop)
			if (FlxG.keys.anyJustPressed(["ENTER", "ESCAPE", "SPACE"])) {
				FlxG.switchState(new MenuState());
			}
#end

#if mobile
			//Don't know why FlxG.touches crashes the game
			//Current workaround, and it works.
			//if (FlxG.touches.getFirst().justPressed == true) {
			if (FlxG.mouse.justPressed == true) {
				FlxG.switchState(new MenuState());
			}
#end
		}
	}	
	
	private function collideAino(pad: FlxSprite, pila: Pila):Void {
		pila.collideBottom();
		impactPool.spawnSingleEntity(pila.x + pila.width/2, pila.y + pila.height/2, G.impact_scale_small);
		
	}
	
	private function collideZion(pad: FlxSprite, pila: Pila):Void {
		pila.collideTop();
		impactPool.spawnSingleEntity(pila.x + pila.width/2, pila.y, G.impact_scale_small);
		
	}
	
	//private function pushObjects(Obj1: FlxSprite, Obj2:FlxSprite):Void {
		////Obj1.kill();
		////Obj2.kill();
	//}
	
	private function killAllHit(Obj1: FlxSprite, Obj2:FlxSprite):Void {
		expPool.explode(Obj1.x, Obj1.y);
		expPool.explode(Obj2.x, Obj2.y);
		Obj1.kill();
		Obj2.kill();
	}
	
	private function hitShake(Obj1: FlxSprite, Obj2:FlxSprite):Void {
		expPool.explode(Obj1.x, Obj1.y);
		expPool.explode(Obj2.x, Obj2.y);
		FlxG.camera.shake(0.01, 0.5);
		Obj1.kill();
		Obj2.kill();
	}
	
	
	function resetGame(timer:FlxTimer):Void {
		
			ui.fill(FlxColor.TRANSPARENT);
			ui.redraw(hp_aino, hp_zion);
			bulletPool.killAll();
			expPool.killAll();
			impactPool.killAll();
		
#if mobile
			aino.resetTouch();
			zion.resetTouch();
			FlxG.touches.reset();
#end

		if (hp_aino > 0 && hp_zion > 0) {
			pila.revive();
			//pila.reposition();
			pila_trail.resetTrail();
			aino.initiate();
			zion.initiate();

			timer_pushBall.reset();
		} else {
			remove(zion);
			remove(zionCore);
			remove(aino);
			remove(ainoCore);
			setupResultText();
			
			if (hp_aino == 0) {
				text_aino.text = str_lose;
			}
			
			if (hp_zion == 0) {
				text_zion.text = str_lose;
			}
			
			add(text_zion);
			add(text_aino);
			
			ended = true;
		}
	}
	
	function setupResultText():Void {
		text_aino = new FlxText(FlxG.width/2 - 100, FlxG.height/2 + 100, 200);
		text_aino.text = str_win;
		text_aino.setFormat("assets/fonts/quer.ttf", 40, FlxColor.WHITE, "center");
		
		text_zion = new FlxText(FlxG.width/2 - 100, FlxG.height/2 - 180, 200);
		text_zion.text = str_win;
		text_zion.setFormat("assets/fonts/quer.ttf", 40, FlxColor.WHITE, "center");
		text_zion.angle = -180;
	}
	
	override public function destroy():Void {
		aino.destroy();
		aino = null;
		ainoCore.destroy();
		ainoCore = null;
		zion.destroy();
		zion = null;
		zionCore.destroy();
		zionCore = null;
		pila.destroy();
		pila = null;
		//pila_trail.destroy();
		pila_trail = null;
		
		bulletPool.destroy();
		bulletPool = null;
		expPool.destroy();
		expPool = null;		
		impactPool.destroy();
		impactPool = null;
		ui.destroy();
		ui = null;
		
		text_aino.destroy();
		text_aino = null;
		text_zion.destroy();
		text_zion = null;
		
		timer_pushBall = null;
		timer_reset = null;
		
		super.destroy();
	}
}