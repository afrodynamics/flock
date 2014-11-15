import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.*;
import openfl.geom.Point;

class Player extends FlockEntity
{

	var moveSpeed:Float = 2;
	var canShoot:Bool = true;
	var shootTimer:Int = 0;
	var shootCooldown:Int = 5;
	private var sprite:Spritemap;

	public override function new(x:Float = 0, y:Float = 0) {

		super(x,y);
		graphic = sprite = new Spritemap("graphics/player.png", 24, 48);
		setHitbox(20, 12, -2, -40);
		type = "sheep";
		
		sprite.add("down", [0]);
		sprite.add("side", [1]);
		sprite.add("up", [2]);

		// Map key controls
		Input.define("left", [Key.A, Key.LEFT]);
		Input.define("right", [Key.D, Key.RIGHT]);
		Input.define("up", [Key.W, Key.UP]);
		Input.define("down", [Key.S, Key.DOWN]);

	}

	public override function update()
	{
		super.update();
		
		// Movement (auto collision detection with walls)

		if ( Input.check("left") && Input.check("right") ) {
			// Do nothing
		}
		else if ( Input.check("left") ) {
			this.moveTowards( x - moveSpeed, y, moveSpeed, "walls" );
			sprite.play("side");
			sprite.flipped = true;
		}
		else if ( Input.check("right") ) {
			this.moveTowards( x + moveSpeed, y, moveSpeed, "walls" );
			sprite.play("side");
			sprite.flipped = false;
		}

		if ( Input.check("up") && Input.check("down") ) {
			// Do nothing
		}
		else if ( Input.check("up") ) {
			this.moveTowards( x, y - moveSpeed, moveSpeed, "walls" );
			sprite.play("up");
			sprite.flipped = false;
		}
		else if ( Input.check("down") ) {
			this.moveTowards( x, y + moveSpeed, moveSpeed, "walls" );
			sprite.play("down");
			sprite.flipped = false;
		}

		// Shoot
		
		if ( canShoot == false ) {
			shootTimer--;
			if ( shootTimer < 0 ) {
				shootTimer = 0;
				canShoot = true;
			}
		}
		else if ( Input.mouseDown ) {
			canShoot = false;
			shootTimer = shootCooldown;

			// Add bullet to the scene
			HXP.scene.add( new TorchProjectile(x + width/2, y + height/2) );

		}
		
		HXP.setCamera(HXP.clamp(0, Level.levelwidth * Level.tilesize - HXP.width, centerX - HXP.width / 2),
					  HXP.clamp(0, Level.levelheight * Level.tilesize * 2 - HXP.height, centerY - 24 - HXP.height / 2));

	}

}