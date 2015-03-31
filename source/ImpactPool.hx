package;

import Impact;
import flixel.group.FlxTypedSpriteGroup;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Juno Nguyen
 */
class ImpactPool extends FlxTypedSpriteGroup<Impact> {

	public function new() {
		super();
		
		this.maxSize = 20;
		
		for (i in 1...20) {
			var entity = new Impact();
			entity.kill();
			this.add(entity);
		}
	}
	
	override function update() {
		super.update();
	}
	
	public function spawnSingleEntity(X: Float, Y: Float) {
		var entity = this.getFirstDead();
			
		entity.x = X - entity.width/2;
		entity.y = Y - entity.height/2;
		entity.initiate();
	}
	
	public function killAll(): Void {
		this.forEachAlive(function(entity:Impact):Void {
			entity.kill();
		});
	}
	
}