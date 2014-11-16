import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;

class TombStone extends FlockEntity {
	
	private var sprite:Spritemap;

	public override function new(x:Float, y:Float) {
		super(x,y);
		sprite = new Spritemap("graphics/tombstone.png", 24, 24);
		graphic = sprite;
		layer = -9;
		sprite.randFrame();  
	}

}