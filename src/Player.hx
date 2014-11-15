import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.*;
import openfl.geom.Point;

class Player extends Entity
{

	var image:Image;
	var moveSpeed:Float = 2;

	public override function new(x:Float = 0, y:Float = 0) {

		super(x,y);
		image = Image.createRect(Globals.cellX, Globals.cellY, 0xFFCC00, 1);
		setHitbox( Std.int( Globals.cellX ), Std.int( Globals.cellY ), 0, 0 );
		graphic = image;
		type = "sheep";

		// Map key controls
		Input.define("left", [Key.A, Key.LEFT]);
		Input.define("right", [Key.D, Key.RIGHT]);
		Input.define("up", [Key.W, Key.UP]);
		Input.define("down", [Key.S, Key.DOWN]);

	}

	private function calculateCameraCenter():Point {

		var viewWidth = HXP.screen.width / HXP.screen.scale;
		var viewHeight = HXP.screen.height / HXP.screen.scale;

		var camX = HXP.clamp( 0, HXP.screen.width - viewWidth, x - viewWidth );
		var camY = HXP.clamp( 0, HXP.screen.height - viewHeight, y - viewHeight );

		return new Point(camX,camY);

	}

	public override function update() {

		// Force camera to follow player

		var cam:Point = calculateCameraCenter();
		HXP.setCamera( cam.x, cam.y );

		// Movement (auto collision detection with walls)

		if ( Input.check("left") && Input.check("right") ) {
			// Do nothing
		}
		else if ( Input.check("left") ) {
			this.moveTowards( x - moveSpeed, y, moveSpeed, "walls" );
		}
		else if ( Input.check("right") ) {
			this.moveTowards( x + moveSpeed, y, moveSpeed, "walls" );
		}

		if ( Input.check("up") && Input.check("down") ) {
			// Do nothing
		}
		else if ( Input.check("up") ) {
			this.moveTowards( x, y - moveSpeed, moveSpeed, "walls" );
		}
		else if ( Input.check("down") ) {
			this.moveTowards( x, y + moveSpeed, moveSpeed, "walls" );
		}

		super.update();
	}

}