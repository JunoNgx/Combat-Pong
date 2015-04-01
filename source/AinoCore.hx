package;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;

using flixel.util.FlxSpriteUtil;
/**
 * ...
 * @author Juno Nguyen
 */
class AinoCore extends FlxSprite {

	public function new() {
		super();
		// G.bullet_height as width is intentional
		makeGraphic(G.bullet_height, G.bullet_height, FlxColor.TRANSPARENT, true);
		
		var vertices = new Array<FlxPoint>();
		vertices[0] = new FlxPoint(width/2, 0);
		vertices[1] = new FlxPoint(width, height/2);
		vertices[2] = new FlxPoint(width/2, height);
		vertices[3] = new FlxPoint(0, height/2);		
		
		drawPolygon(vertices, FlxColor.CRIMSON);
		//alpha = 0.3;
	}
	
	public function sync(aino: Aino) {
		this.x = aino.x - this.width/2;
		this.y = aino.y - this.height/2;
		
		scale.x = aino.forceRate / G.forceRate_max;
		
		if (aino.forceRate < G.forceRate_min) { this.visible = false; }
			else { this.visible = true; };
	}
	
}