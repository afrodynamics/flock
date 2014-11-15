package ;
import flash.geom.Rectangle;
import openfl.Assets;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;

/**
 * Generates the world.
 */
class Level
{
	public static var tilesize:Int = 24;
	public static var levelwidth:Int;
	public static var levelheight:Int;

	public static function load(): Void
	{
		var xml:Xml = Xml.parse(Assets.getText("level/level1.oel")).firstElement();
		levelwidth = cast(Std.parseInt(xml.get("width")) / tilesize, Int);
		levelheight = cast(Std.parseInt(xml.get("height")) / tilesize, Int);
		var rect:Rectangle = new Rectangle(0, 0, tilesize, tilesize);
		
		for (layer in xml.elementsNamed("tiles"))
		{
			for (tile in layer.elementsNamed("tile"))
			{
				var tx:Int = Std.parseInt(tile.get("tx"));
				var ty:Int = Std.parseInt(tile.get("ty"));
				var x:Int = Std.parseInt(tile.get("x"));
				var y:Int = Std.parseInt(tile.get("y"));
				
				rect.x = tx * tilesize;
				rect.y = ty * tilesize;
				HXP.scene.add(new Wall(x * tilesize, y * tilesize, rect));
			}
		}
		
		HXP.scene.add(new Sheep(72, 96));
		HXP.scene.add(new Sheep(480, 144));
		HXP.scene.add(new Sheep(456, 336));
	}
}