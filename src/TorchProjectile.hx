import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Circle;
import openfl.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

class TorchProjectile extends FlockEntity {

	var image:Image;
	var moveSpeed:Float = 2.5;
	var radius:Int = 6;
	var velocity:Point;

	public override function new(x:Float, y:Float) {
		super(x - 8, y - 8);
		image = new Image("graphics/fire-projectile.png");
		graphic = image;
		width = image.width;
		height = image.height;
		setHitbox(12, 12, -2, -2);

		// Calculate the direction to where this bullet needs to go
		// MouseX/Y coordinates are in viewport coordinates, so we need to offset them by the
		// camera position to ensure our vector is accurate no matter where this bullet starts
		velocity = new Point( HXP.camera.x + Input.mouseX - MainScene.player.centerX, HXP.camera.y + Input.mouseY - MainScene.player.centerY );
		velocity.normalize(moveSpeed * 6);
		type = "projectile";
		moveBy(velocity.x, velocity.y);
		velocity.normalize(moveSpeed);
		layer = -10;
	}

	public override function update() {
		moveBy( velocity.x, velocity.y );
		//if (collideTypes( "walls", x, y ) != null) HXP.scene.remove(this);
		var monster:Entity = collideTypes( "monster", x, y);
		if (monster != null)
		{
			HXP.scene.remove(monster);
			HXP.scene.remove(this);
		}

		if (!onCamera) HXP.scene.remove(this);
		super.update();
	}

}