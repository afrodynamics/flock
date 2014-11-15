package ;

import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;

class MainScene extends Scene
{
	var player:Player;

	public override function begin()
	{
		player = new Player( 32, 32 );
		add(new Entity(0, 0, new Backdrop("graphics/tile.png")));
		var i:Int;
		for (i in 0...10)
		{
			add(new Sheep(10 + Math.random() * 5, 10 + Math.random() * 5));
		}
		add(player);
	}
}