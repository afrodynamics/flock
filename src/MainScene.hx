package ;

import com.haxepunk.Graphic;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

class MainScene extends Scene
{
	public static var player:Player;
	private static var dayLength:Int = 600;
	private static var nightLength:Int = 600;
	private var tickcount:Int = dayLength;
	public static var dayState:String = "day";
	private var backdrop:Entity;

	public override function begin()
	{
		player = new Player( 32, 32 );
		backdrop = new Entity(0, 0, new Backdrop("graphics/tile.png"));
		add(backdrop);

		for ( i in 0...Std.int(HXP.screen.width / (Globals.cellX * HXP.screen.scale) )) {
			add(new Wall(24 * i, 0));
		}
		
		for (i in 0...10)
		{
			add(new Sheep(HXP.screen.width / (2 * HXP.screen.scale) + Math.random() * 5, HXP.screen.height / (2 * HXP.screen.scale) + Math.random() * 5));
		}
		
		add(player);
	}
	
	override public function update():Void
	{
		super.update();
		
		tickcount--;
		if (Input.pressed(Key.H))
		{
			tickcount = 0;
		}
		if (tickcount == 0) switch (dayState)
		{
			case "day":
			{
				dayState = "night";
				tickcount = nightLength;
				backdrop.graphic = new Backdrop("graphics/tile2.png");
			}
			case "night":
			{
				dayState = "day";
				tickcount = dayLength;
				backdrop.graphic = new Backdrop("graphics/tile.png");
			}
		}
	}
}