package ;

import com.haxepunk.Graphic;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;

class MainScene extends Scene
{
	var player:Player;
	private static var dayLength:Int = 600;
	private static var nightLength:Int = 600;
	private var tickcount:Int = dayLength;
	private var dayState:String = "day";
	private var backdrop:Entity;

	public override function begin()
	{
		player = new Player( 32, 32 );
		backdrop = new Entity(0, 0, new Backdrop("graphics/tile.png"));
		add(backdrop);
		var i:Int;
		for (i in 0...10)
		{
			add(new Sheep(10 + Math.random() * 5, 10 + Math.random() * 5));
		}
		add(player);
	}
	
	override public function update():Void
	{
		super.update();
		tickcount--;
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