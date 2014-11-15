package ;

import com.haxepunk.Scene;

class MainScene extends Scene
{

	var player:Player;

	public override function begin()
	{
		player = new Player( 32, 32 );
		add(player);
	}
}