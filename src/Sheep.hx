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
class Sheep extends FlockEntity
{
	private var target:Point = new Point(0, 0);
	private var velocity:Point = new Point(0, 0);
	private static var speed:Float = 1;
	private static var radius = 23;
	var count:Int = 0;
	public var found:Bool = false;
	private var findDistance:Float = 48;
	public var killed:Bool = false;
	
	private var sprite:Spritemap;

	public function new(x:Float, y:Float, active:Bool = false) 
	{
		super(x, y);
		graphic = sprite = new Spritemap("graphics/sheep.png", 24, 24);
		type = "sheep";
		setHitbox(20, 14, -2, -8);
		this.found = active;
		layer = -10;
	}
	
	override public function update():Void
	{
		super.update();
		if (MainScene.dayState == "night")
		{
			//sprite.index = 2;
			return;
		}
		
		var squaredDistToPlayer:Float = FlockUtil.squaredPointDistance(x, y, MainScene.player.x, MainScene.player.y);
		if (!found)
		{
			if (squaredDistToPlayer < findDistance * findDistance)
			{
				found = true;
			}
			else return;
		}
		
		count += 1;
		target.x = MainScene.player.centerX;
		target.y = MainScene.player.centerY;
		if (FlockUtil.pointDistance(centerX, centerY, target.x, target.y) < 2)
		{
			target.x = centerX;
			target.y = centerY;
		}
		velocity.x = target.x - centerX;
		velocity.y = target.y - centerY;
		velocity.normalize(speed);
		for (e in HXP.scene.entitiesForType("sheep"))
		{
			var radius:Float = radius;
			if (e == MainScene.player) radius = 35;
			var dist:Float = FlockUtil.pointDistance(e.centerX, e.centerY, centerX, centerY);
			if (dist < radius)
			{
				var toAdd:Point = new Point(centerX - e.centerX, centerY - e.centerY);
				toAdd.normalize((1 - dist / radius) * 5);
				velocity = velocity.add(toAdd);
			}
		}
		if (velocity.length < 0.4) velocity = new Point(0, 0);
		moveBy(velocity.x, velocity.y, "walls");
		
		if (MainScene.player.x < x && velocity.length > 0) sprite.flipped = true;
		if (MainScene.player.x > x && velocity.length > 0) sprite.flipped = false;
	}
}