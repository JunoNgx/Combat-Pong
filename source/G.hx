package;

/**
 * ...
 * @author Juno Nguyen
 */
class G {
	public static var gameColor:Int = 0xFFFFE135;
	
	public static var margin_x: Int = 60;
	
	public static var numOfPad: Int = 5;
	public static var padThickness: Int = 8;
	public static var padLength: Int = 24;
	public static var padSpacing: Int = 7;
	
	public static var playerSpeed:Float = 500;
	public static var player_core_multiplier:Float = 5;
	
	public static var forceRate_min: Float = 0.3;
	public static var forceRate_multiplier: Float = 2;
	
	public static var bulletSpeed = 300;
	public static var pilaSpeed_initial = 300;
	public static var pilaSpeed_upRate = 10;
	
	//explosion
	public static var exp_number_min = 1;
	public static var exp_number_max = 3;
	public static var exp_default_size = 48;
	public static var exp_scale_min = 0.7;
	public static var exp_scale_max = 1.2;
	public static var exp_max_pos_vari = 20;
	public static var exp_timediff_min = 0.02;
	public static var exp_timediff_max = 0.05;
	
	public static var bullet_width = 12;
	public static var bullet_height = 24;
	
	public static var impact_lifetime = 0.7;
	public static var impact_scale_small = 0.5;
	public static var impact_scale_large = 1;
}