package ;
import com.haxepunk.Entity;
import com.haxepunk.HXP;

/**
 * fff
 */
class FlockEntity extends Entity
{

	override public function update():Void
	{
		if (MainScene.moveDown) y += Level.levelheight * Level.tilesize;
		if (y >= Level.levelheight * Level.tilesize * 2) HXP.scene.remove(this);
	}
	
}