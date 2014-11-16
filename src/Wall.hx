import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import flash.geom.Rectangle;

class Wall extends FlockEntity
{

	// Basic wall entity of the base cell size
	// could make things prettier later
	
	var image:Image;
	public static var dayImage:Image;
	public static var nightImage:Image;
	
	public override function new(x:Float, y:Float, rect:Rectangle) {
		super(x,y);
		if (dayImage == null) dayImage = new Image("graphics/tileset.png", rect);
		if (nightImage == null) nightImage = new Image("graphics/tileset2.png", rect);
		image = dayImage;
		setHitbox( image.width, image.height, 0, 0 );
		graphic = image;
		type = "walls"; // So we know what to call them in collision
	}
	
	public function setDayImage():Void
	{
		graphic = image = dayImage;
	}
	
	public function setNightImage():Void
	{
		graphic = image = nightImage;
	}

}