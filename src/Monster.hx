package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import flash.geom.Point;

/**
 * Monster
 */
class Monster extends Entity
{
	private var target:Sheep;
	private var velocity:Point = new Point();
	private var speed:Float = 1.5;

	public function new() 
	{
		super();
		chooseRandomSheep();
		graphic = Image.createRect(24, 24);
		type = "monster";
		setHitbox(16, 16, -4, -4);
		
		if (Math.random() < 0.5)
		{
			x = HXP.width / 2 + FlockUtil.randomSign() * (HXP.width / 2 + 24) + HXP.camera.x - 12;
			y = Math.random() * (HXP.height) + HXP.camera.y;
		}
		else
		{
			x = Math.random() * (HXP.width) + HXP.camera.x;
			y = HXP.height / 2 + FlockUtil.randomSign() * (HXP.height / 2 + 24) + HXP.camera.y - 12;
		}
	}
	
	override public function update():Void
	{
		if (target == null)
		{
			HXP.scene.remove(this);
			return;
		}
		
		if (target.killed)
		{
			chooseRandomSheep();
			return;
		}
		
		velocity.x = target.centerX - centerX;
		velocity.y = target.centerY - centerY;
		velocity.normalize(speed);
		moveBy(velocity.x, velocity.y);
		
		var collide:Entity = collideTypes("sheep", x, y);
		if (collide != null && collide != MainScene.player)
		{
			HXP.scene.remove(this);
			HXP.scene.remove(collide);
			cast(collide, Sheep).killed = true;
		}
	}
	
	private function chooseRandomSheep():Void
	{
		target = null;
		var sheep:List<Entity> = HXP.scene.entitiesForType("sheep");
		var sheeparray:Array<Entity> = new Array<Entity>();
		for (s in sheep)
		{
			if (s.onCamera && s != MainScene.player && cast(s, Sheep).found) sheeparray.push(s);
		}
		if (sheeparray.length == 0)
		{
			HXP.scene.remove(this);
			return;
		}
		target = cast(sheeparray[Std.int(Math.random() * sheeparray.length)], Sheep);
	}
	
}