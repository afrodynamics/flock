import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;

class MainScene extends Scene
{
	public override function begin()
	{
		add(new Entity(0, 0, new Backdrop("graphics/tile.png")));
	}
}