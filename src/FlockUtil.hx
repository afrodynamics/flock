package ;
import com.haxepunk.HXP;

/**
 * Utility class
 */
class FlockUtil
{

	public static function pointDistance(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		return Math.sqrt(squaredPointDistance(x1, y1, x2, y2));
	}
	
	public static function squaredPointDistance(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		return (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
	}
	
	public static function randomSign():Float
	{
		return Std.int(Math.random() * 2) * 2 - 1;
	}
	
	public static function lerpColor(c1:Int, c2:Int, time:Float):Int
	{
		var r1:Int = c1 ^ 0xFF0000 >>> 16;
		var g1:Int = c1 ^ 0x00FF00 >>> 8;
		var b1:Int = c1 ^ 0x0000FF;
		var r2:Int = c2 ^ 0xFF0000 >>> 16;
		var g2:Int = c2 ^ 0x00FF00 >>> 8;
		var b2:Int = c2 ^ 0x0000FF;
		
		return (r1 + Std.int(time * (r2 - r1))) << 16 + (g1 + Std.int(time * (g2 - g1))) << 8 + (b1 + Std.int(time * (b2 - b1)));
	}
	
}