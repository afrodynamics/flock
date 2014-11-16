package ;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import flash.geom.Point;

/**
 * Monster
 */
class Monster extends Entity
{
	private var target:Sheep;
	private var velocity:Point = new Point();
	private var sprite:Spritemap;
	private var speed:Float = 0.8;
 
	public function new() 
	{
		super();
		chooseRandomSheep();
		sprite = new Spritemap("graphics/eye-critter-flying.png", 24, 24 );
		sprite.add("down", [0]);
		sprite.add("side", [1]);
		sprite.add("up", [2]);
		graphic = sprite;
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

		// Choose which sprite to use
		if ( velocity.y < 0 ) {
			sprite.play("up");
		}
		else {
			sprite.play("down");
		}
		
		var collide:Entity = collideTypes("sheep", x, y);
		if (collide != null && collide != MainScene.player)
		{
			HXP.scene.remove(this);
			HXP.scene.remove(collide);
			var sheep:Sheep = cast(collide, Sheep);
			sheep.killed = true;
			HXP.scene.add( new TombStone( sheep.x, sheep.y ));
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