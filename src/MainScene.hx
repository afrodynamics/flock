package ;

import com.haxepunk.Graphic;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Scene;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import flash.geom.Rectangle;

class MainScene extends Scene
{
	
	private static var dayLength:Int = 720;
	private static var nightLength:Int = 720;
	private var numMonsters:Int = 7; // number monsters to spawn during the night
	private var dawnThresh:Int = 180;
	private var tickcount:Int = dayLength;
	private var backdrop:Entity;
	private var loadNext:Bool = true;
	private var days:Int = 0;
	private var dayTextEntity:Entity;
	private var dayText:Text;

	public static var player:Player;
	public static var dayState:String = "day"; // magic string
	public static var moveDown:Bool = true;
	
	private var shiftCount:Int = 0;
	public static var numShifts:Int = 7;
	
	public static var grassColor1:Int = 0x77825A;
	public static var grassColor2:Int = 0x94E354;
	public static var wallColor1:Int = 0x857F75;
	public static var wallColor2:Int = 0xFFFDE6;
	
	public override function begin()
	{
		backdrop = new Entity(0, 0, new Backdrop("graphics/tile.png"));
		add(backdrop);
		Level.load();
		
		player = new Player(288, 1140 - 600);
		dayText = new Text( "Days Survived: " + days );
		dayTextEntity = new Entity();
		dayTextEntity.graphic = dayText;

		for (i in 0...10)
		{
			add(new Sheep(player.x + Math.random() * 5, player.y + Math.random() * 5, true));
		}
		
		add(player);
	}
	
	override public function update():Void
	{
		super.update();

		// Keep text in proper place
		dayTextEntity.x = HXP.camera.x;
		dayTextEntity.y = HXP.camera.y;

		tickcount--;
		if (Input.pressed(Key.H))
		{
			tickcount = 0;
		}
		if (tickcount == 0) {
			switch (dayState)
			{
				case "day":
				{
					dayState = "night";
					days++; // inc days survived counter
					tickcount = nightLength;
					backdrop.graphic = new Backdrop("graphics/tile2.png");
					for (w in entitiesForType("walls")) cast(w, Wall).setNightImage();
				}
				case "night":
				{
					dayState = "day";
					tickcount = dayLength;
					backdrop.graphic = new Backdrop("graphics/tile.png");
					for (w in entitiesForType("walls")) cast(w, Wall).setDayImage();
				}
			}
			dayText.text = "Days Survived: " + days; // Update day text
		}
		
		// spawn monsters
		if (dayState == "night")
		{
			if (tickcount % Std.int((nightLength - dawnThresh) / numMonsters) == 0 && tickcount > dawnThresh)
			{
				add(new Monster());
			}
		}
		
		// generate level
		if (loadNext)
		{
			Level.load();
			loadNext = false;
			moveDown = false;
			for (i in 0...Level.levelwidth)
				add(new Wall(i * Level.tilesize, Level.levelheight * Level.tilesize * 2, new Rectangle(0, 0, Level.tilesize, Level.tilesize)));
			shiftCount++;
		}
		if (player.y < Level.levelheight * Level.tilesize / 2 && dayState == "day")
		{
			loadNext = true;
			moveDown = true;
		}
		
		cast(backdrop.graphic, Backdrop).color = HXP.colorLerp(grassColor1, grassColor2, shiftCount / numShifts);
		cast(Wall.dayImage, Image).color = HXP.colorLerp(wallColor1, wallColor2, shiftCount / numShifts);
	}
}