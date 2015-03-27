package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.FlxG;

import flixel.util.FlxTimer;

/**
 * ...
 * @author Juno Nguyen
 */
class Pila extends FlxSprite {
	
	private var dir_x: Int = 0;
	private var dir_y: Int = 0;

	public function new() {
		super();
		makeGraphic(8, 8, FlxColor.CYAN);
		
		this.x = FlxG.width / 2 - this.width/2;
		this.y = FlxG.height / 2 - this.height/2;
		
		//push();
	}
	
	override public function update() {
		super.update();
		
		this.velocity.x = dir_x * G.pilaSpeed;
		this.velocity.y = dir_y * G.pilaSpeed;
		
		if (this.x < 0) collideLeft();
		if (this.x > FlxG.width - this.width) collideRight();
		if (this.y < 0) collideTop();
		if (this.y > FlxG.height - this.height) collideBottom();
	}
	
	public function push(timer:FlxTimer) {
		if (FlxRandom.chanceRoll()) {
			dir_x = 1;
		} else dir_x = -1;
		
		if (FlxRandom.chanceRoll()) {
			dir_y = 1;
		} else dir_y = -1;
	}
	
	public function collideTop(): Void {
		dir_y = 1;
	}
	
	public function collideBottom(): Void {
		dir_y = -1;
	}
	
	public function collideRight(): Void {
		dir_x = -1;
	}
	
	public function collideLeft(): Void {
		dir_x = 1;
	}
}