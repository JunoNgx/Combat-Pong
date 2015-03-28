package;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

/**
 * ...
 * @author Juno Nguyen
 */
class UI extends FlxSprite {
	
	public static inline var HP_length: Int = 16;
	public static inline var HP_thickness: Int = 8;
	public static inline var HP_spacing: Int = 32;
	
	public static inline var gameColor: Int = 0xFFFFE135;
	
	public static var lineStyle: LineStyle = { color: 0xFFFFE135, thickness: 2};
	public static var fillStyle: FillStyle = { color: 0xFFFFE135, alpha: 1 };

	public function new() {
		super();
		makeGraphic(FlxG.width, FlxG.height, FlxColor.TRANSPARENT, true);
	}
	
	public function redraw(aino_hp: Int, zion_hp: Int): Void {
		drawMidline();
		drawAinoHP(aino_hp);
		drawZionHP(zion_hp);
	}
	
	public function drawMidline(): Void {
		this.drawLine(0, FlxG.height / 2, FlxG.width, FlxG.height / 2, lineStyle);
	}
	
	public function drawAinoHP(HP: Int) {
		for (i in 0...HP) {
			this.drawRect(HP_spacing + i * (HP_length + HP_spacing), FlxG.height/2 + HP_thickness * 2,
				HP_length, HP_thickness, 0xFFFFE135, lineStyle, fillStyle);
		}
	}
	
	public function drawZionHP(HP: Int) {
		for (i in 0...HP) {
			this.drawRect(FlxG.width - (i+1) * (HP_length + HP_spacing), FlxG.height/2 - HP_thickness * 3,
				HP_length, HP_thickness, 0xFFFFE135, lineStyle, fillStyle);
		}
	}
	
}