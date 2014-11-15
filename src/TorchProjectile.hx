import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Circle;
import openfl.geom.Point;
import com.haxepunk.HXP;
import com.haxepunk.utils.Input;

class TorchProjectile extends FlockEntity {

	var image:Image;
	var moveSpeed:Float = 6;
	var radius:Int = 6;
	var velocity:Point;

	public override function new(x:Float, y:Float) {
		super(x,y);
		image = new Image("graphics/fire-projectile.png");
		graphic = image;
		originX = Std.int( width / 2 );
		originY = Std.int( height / 2 );
		mask = new Circle( radius, 0, 0 ); // Circular objects have circular collision masks

		// Calculate the direction to where this bullet needs to go
		// MouseX/Y coordinates are in viewport coordinates, so we need to offset them by the
		// camera position to ensure our vector is accurate no matter where this bullet starts
		velocity = new Point( HXP.camera.x + Input.mouseX - x, HXP.camera.y + Input.mouseY - y );
		velocity.normalize( moveSpeed );
		type = "projectile";
	}

	public override function update() {
		moveBy( velocity.x, velocity.y );
		if ( collideTypes( "walls", x, y ) != null ) {
			// If we hit a wall, remove this Entity from the scene
			HXP.scene.remove( this );
		}

		// TODO: Optimize by deleting this bullet when we are far away from
		// and likely to be outside of the camera

		super.update();
	}

}