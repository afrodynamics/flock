package ;

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
	
}