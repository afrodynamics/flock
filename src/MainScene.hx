package ;

import com.haxepunk.HXP;
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

		for ( i in 0...Std.int(HXP.screen.width / (Globals.cellX * HXP.screen.scale) )) {
			add(new Wall(24 * i, 0));
		}
		
		for (i in 0...10)
		{
			add(new Sheep(HXP.screen.width / (2 * HXP.screen.scale) + Math.random() * 5, HXP.screen.height / (2 * HXP.screen.scale) + Math.random() * 5));
		}

		add(player);
	}
}