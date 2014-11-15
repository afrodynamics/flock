import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Player extends Entity
{

	var image:Image;

	public override function new(x:Float = 0, y:Float = 0) {

		super(x,y);
		image = Image.createRect(Globals.cellX, Globals.cellY, 0xFFCC00, 1);
		graphic = image;

	}

	public override function update() {
		
	}

}