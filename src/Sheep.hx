package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.tweens.misc.Alarm;
import openfl.geom.Point;

/**
 * Sheep AI.
 */
class Sheep extends Entity
{
	private var target:Point = new Point(0, 0);
	private var velocity:Point = new Point(0, 0);
	private static var speed:Float = 1;
	private static var radius = 20;
	var count:Int = 0;
	
	private var sprite:Spritemap;

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		graphic = sprite = new Spritemap("graphics/sheep.png", 24, 24);
		type = "sheep";
		setHitbox(24, 18, 0, -6);
	}
	
	override public function update():Void
	{
		if (MainScene.dayState == "night")
		{
			//sprite.index = 2;
			return;
		}
		
		count += 1;
		target.x = MainScene.player.x;
		target.y = MainScene.player.y;
		if (FlockUtil.pointDistance(x, y, target.x, target.y) < 2)
		{
			target.x = x;
			target.y = y;
		}
		velocity.x = target.x - x;
		velocity.y = target.y - y;
		velocity.normalize(speed);
		for (e in HXP.scene.entitiesForType("sheep"))
		{
			var radius:Float = radius;
			if (e == MainScene.player) radius = 40;
			var dist:Float = FlockUtil.pointDistance(e.x, e.y, x, y);
			if (dist < radius)
			{
				var toAdd:Point = new Point(x - e.x, y - e.y);
				toAdd.normalize((1 - dist / radius) * 3);
				velocity = velocity.add(toAdd);
			}
		}
		if (velocity.length < 0.3) velocity = new Point(0, 0);
		if (MainScene.player.x < x && velocity.length > 0) sprite.flipped = true;
		if (MainScene.player.x > x && velocity.length > 0) sprite.flipped = false;
		moveBy(velocity.x, velocity.y, "walls");
	}
}