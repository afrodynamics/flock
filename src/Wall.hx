import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;

class Wall extends Entity
{

	// Basic wall entity of the base cell size
	// could make things prettier later
	
	var image:Image;
	
	public override function new(x:Float, y:Float) {
		super(x,y);
		image = Image.createRect(Globals.cellX, Globals.cellY, 0x0);
		setHitbox( image.width, image.height, 0, 0 );
		graphic = image;
		type = "walls"; // So we know what to call them in collision
	}

}