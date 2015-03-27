package;

import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.FlxG;

/**
 * ...
 * @author Juno Nguyen
 */
class ZionCtrl extends FlxSprite {
	
	var input_lt: Bool;
	var input_rt: Bool;
	
	public var isFiring: Bool;
	
	private static var SPEED: Int = 300;

	//var 
	
	public function new() {
		super();
		makeGraphic(196, 32, FlxColor.FOREST_GREEN);
		
		this.x = FlxG.width / 2;
		this.y = FlxG.height * 0.1;
	}
	
	override public function update(): Void {
		super.update();
		
		//input_lt = FlxG.inputs.anyPressed(["LEFT"]);
		
		if (FlxG.keys.anyPressed(["A"])) {
			this.velocity.x = -SPEED;
		} else if (FlxG.keys.anyPressed(["D"])) {
			this.velocity.x = SPEED;
		} else this.velocity.x = 0;
		
		if (FlxG.keys.anyPressed(["S"])) {
			//fire();
			isFiring = true;
		} else isFiring = false;
	}
	
	public function fire(): Void {
		
	}
	
	//override public function destroy():Void {
		//super.destroy();
	//}
}