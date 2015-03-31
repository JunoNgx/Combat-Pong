package;

import Explosion;
import flixel.group.FlxTypedSpriteGroup;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Juno Nguyen
 */
class ExplosionPool extends FlxTypedSpriteGroup<Explosion> {

	public function new() {
		super();
		
		this.maxSize = 200;
		
		for (i in 1...50) {
			var entity = new Explosion();
			entity.kill();
			this.add(entity);
		}
	}
	
	override function update() {
		super.update();
	}
	
	public function spawnEntity(X: Float, Y: Float) {
		var entity = this.getFirstDead();
			
		//entity.spawn(X, Y);
		//entity.x = X - width / 2;
		//entity.y = Y - height / 2;		
		
		entity.x = X - entity.width/2;
		entity.y = Y - entity.height/2;
		entity.initiate();
	}
	
	public function explode(X: Float, Y: Float) {
		FlxRandom.resetGlobalSeed();
		var numOfExp:Int = FlxRandom.intRanged(G.exp_number_min, G.exp_number_max);
		
		//for (i in 0...numOfExp) {
			//singleExplosion(new FlxTimer(1), X, Y);
		//}
		var timer = new FlxTimer (FlxRandom.floatRanged(G.exp_timediff_min, G.exp_timediff_max),
		
			function(timer:FlxTimer) {
				FlxRandom.resetGlobalSeed();
				var variance_x:Float = FlxRandom.floatRanged( -G.exp_max_pos_vari, G.exp_max_pos_vari);
			
				FlxRandom.resetGlobalSeed();
				var variance_y:Float = FlxRandom.floatRanged( -G.exp_max_pos_vari, G.exp_max_pos_vari);
			
				spawnEntity(X + variance_x, Y + variance_y);
			},
			
			numOfExp);
	}
	
	//public function singleExplosion(timer:FlxTimer, X: Float, Y: Float) {
		//FlxRandom.resetGlobalSeed();
		//var variance_x:Float = FlxRandom.floatRanged( -G.exp_max_pos_vari, G.exp_max_pos_vari);
			//
		//FlxRandom.resetGlobalSeed();
		//var variance_y:Float = FlxRandom.floatRanged( -G.exp_max_pos_vari, G.exp_max_pos_vari);
			//
		//spawnEntity(X + variance_x, Y + variance_y);
	//}
	
	//public function createEntity() {
		//var entity:Explosion = new Explosion();
		//this.add(entity);
		//return entity;
	//}
	
	public function killAll(): Void {
		this.forEachAlive(function(entity:Explosion):Void {
			entity.kill();
		});
	}
	
}