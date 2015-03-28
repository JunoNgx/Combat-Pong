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
	
	public var menu_mode: Bool = false;
	
	private var speed = G.pilaSpeed_initial;

	public function new() {
		super();
		makeGraphic(8, 8, FlxColor.CRIMSON);
		
		reposition();
		
		//push();
	}
	
	override public function update() {
		super.update();
		
		this.velocity.x = dir_x * speed;
		this.velocity.y = dir_y * speed;
		
		if (this.x < 0) collideLeft();
		if (this.x > FlxG.width - this.width) collideRight();
		
		if (menu_mode) {
			if (this.y < 0) collideTop();
			if (this.y > FlxG.height - this.height) collideBottom();
		}
	}
	
	public function push(timer:FlxTimer) {
		if (FlxRandom.chanceRoll()) {
			dir_x = 1;
		} else dir_x = -1;
		
		if (FlxRandom.chanceRoll()) {
			dir_y = 1;
		} else dir_y = -1;
	}
	
	// Due to usage of overlapping, speed will be upped
	// several times for each collision
	// As of now, observed to be 4 times
	public function collideTop(): Void {
		dir_y = 1;
		this.speed += G.pilaSpeed_upRate;
	}
	
	public function collideBottom(): Void {
		dir_y = -1;
		this.speed += G.pilaSpeed_upRate;
	}
	
	public function collideRight(): Void {
		dir_x = -1;
	}
	
	public function collideLeft(): Void {
		dir_x = 1;
	}
	
	public function reposition():Void {
		this.x = FlxG.width / 2 - this.width/2;
		this.y = FlxG.height / 2 - this.height / 2;
		
		dir_x = 0;
		dir_y = 0;
		
		speed = G.pilaSpeed_initial;
	}
}