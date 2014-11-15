package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.tweens.misc.Alarm;
import flash.geom.Point;

/**
 * Sheep AI.
 */
class Sheep extends Entity
{
	private var target:Point = new Point(0, 0);
	private var velocity:Point = new Point(0, 0);
	private static var speed:Float = 0.5;
	private static var radius = 20;
	var count:Int = 0;

	public function new(x:Float, y:Float) 
	{
		super(x, y);
		graphic = new Image("graphics/sheep.png");
		type = "sheep";
		setHitbox(24, 18, 0, -6);
	}
	
	override public function update():Void
	{
		count += 1;
		if (count == 180)
		{
			count = 0;
			randomTarget();
		}
		if (FlockUtil.pointDistance(x, y, target.x, target.y) < 2)
		{
			target.x = x;
			target.y = y;
		}
		velocity.x = target.x - x;
		velocity.y = target.y - y;
		//velocity.x = velocity.y = 0;
		velocity.normalize(speed);
		for (e in HXP.scene.entitiesForType("sheep"))
		{
			var dist:Float = FlockUtil.pointDistance(e.x, e.y, x, y);
			if (dist < radius)
			{
				var toAdd:Point = new Point(x - e.x, y - e.y);
				toAdd.normalize((1 - dist / radius) * 2);
				velocity = velocity.add(toAdd);
			}
		}
		//velocity.normalize(speed);
		moveBy(velocity.x, velocity.y, "walls");
	}
	
	private function randomTarget():Void
	{
		target = new Point(Math.random() * 50, Math.random() * 20);
	}
}