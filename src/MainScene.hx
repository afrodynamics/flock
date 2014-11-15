package ;

import com.haxepunk.Graphic;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import flash.geom.Rectangle;

class MainScene extends Scene
{
	public static var player:Player;
	private static var dayLength:Int = 600;
	private static var nightLength:Int = 600;
	private var tickcount:Int = dayLength;
	public static var dayState:String = "day";
	private var backdrop:Entity;
	private var loadNext:Bool = true;
	public static var moveDown:Bool = true;
	
	public override function begin()
	{
		backdrop = new Entity(0, 0, new Backdrop("graphics/tile.png"));
		add(backdrop);
		Level.load();
		
		player = new Player(288, 1140 - 600);
		for (i in 0...10)
		{
			add(new Sheep(player.x + Math.random() * 5, player.y + Math.random() * 5, true));
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
		
		// generate level
		if (loadNext)
		{
			Level.load();
			loadNext = false;
			moveDown = false;
		}
		if (player.y < Level.levelheight * Level.tilesize / 2)
		{
			loadNext = true;
			moveDown = true;
			for (i in 0...Level.levelwidth)
				add(new Wall(i * Level.tilesize, Level.levelheight * Level.tilesize * 2, new Rectangle(0, 0, Level.tilesize, Level.tilesize)));
		}
	}
}