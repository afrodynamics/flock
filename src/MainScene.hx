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
		for ( i in 1...24) {
			add(new Wall(24 * i, 0));
		}
		
		add(player);
	}
}