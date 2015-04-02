package;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import flixel.util.FlxRandom;
import flixel.FlxG;

import flixel.util.FlxTimer;

using flixel.util.FlxSpriteUtil;
import flixel.util.FlxPoint;

/**
 * ...
 * @author Juno Nguyen
 */
class Pila extends FlxSprite {
	
	private var dir_x: Int = 0;
	private var dir_y: Int = 0;
	
	public var menu_mode: Bool = false;
	
	private var speed = G.pilaSpeed_initial;
	
	public var sfx_collide1: FlxSound;

	public function new() {
		super();
		
		sfx_collide1 = FlxG.sound.load("assets/sounds/collide1.ogg");
		
		//Origintal prototype graphic
		//makeGraphic(8, 8, FlxColor.CRIMSON);
		
		//Alternate circle shape
		//makeGraphic(16, 16, FlxColor.TRANSPARENT, true );
		//drawCircle(x + width / 2, y + height / 2, width / 2, FlxColor.CRIMSON);

		//An equaliteral rhombus
		makeGraphic(16, 16, FlxColor.TRANSPARENT, true );
				
		var vertices = new Array<FlxPoint>();
		vertices[0] = new FlxPoint(width/2, 0);
		vertices[1] = new FlxPoint(width, height/2);
		vertices[2] = new FlxPoint(width/2, height);
		vertices[3] = new FlxPoint(0, height/2);		
		
		drawPolygon(vertices, FlxColor.CRIMSON);
		
		reposition();
		
		//push();
	}
	
	override public function update() {
		super.update();
		
		this.velocity.x = dir_x * speed;
		this.velocity.y = dir_y * speed;
		
		if (this.x < 0) {
			collideLeft();
			if (!menu_mode) sfx_collide1.play();
		}
		if (this.x > FlxG.width - this.width) {
			collideRight();
			if (!menu_mode) sfx_collide1.play();
		}
		
		if (menu_mode) {
			if (this.y < 0) {
				collideTop();
				//sfx_collide1.play();
			}
			if (this.y > FlxG.height - this.height) {
				collideBottom();
				//sfx_collide1.play();
			}
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
		if (!menu_mode) this.speed += G.pilaSpeed_upRate;
	}
	
	public function collideBottom(): Void {
		dir_y = -1;
		if (!menu_mode) this.speed += G.pilaSpeed_upRate;
		
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