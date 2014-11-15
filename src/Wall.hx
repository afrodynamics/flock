import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import flash.geom.Rectangle;

class Wall extends Entity
{

	// Basic wall entity of the base cell size
	// could make things prettier later
	
	var image:Image;
	
	public override function new(x:Float, y:Float, rect:Rectangle) {
		super(x,y);
		image = new Image("graphics/tileset.png", rect);
		setHitbox( image.width, image.height, 0, 0 );
		graphic = image;
		type = "walls"; // So we know what to call them in collision
	}

}