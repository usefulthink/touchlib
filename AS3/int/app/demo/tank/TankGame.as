﻿//

package app.demo.tank {
	import com.touchlib.TUIO;
	import app.demo.tank.*;	
	import flash.events.*;
	import flash.geom.*;
	import flash.display.*;
	import flash.system.fscommand;
	import flash.system.Capabilities;
	
	dynamic public class TankGame extends MovieClip
	{

		public var arenaWidth:int = 500;
		public var arenaHeight:int = 300;
		
	
		private var playerArray:Array;
		
		function TankGame()
		{
			fscommand("allowscale", "true");
			fscommand("fullscreen", "true");
			
			playerArray =  new Array();
			
			arenaWidth = mcArena.width;
			arenaHeight = mcArena.height;
			
			TUIO.init( this, 'localhost', 3000, '', false );			// www/xml/test2.xml
			
			
			var plyr:PlayerTank;
			plyr = new PlayerTank(this, 1);
			playerArray.push(plyr);			
			plyr.setUIPosition(100, 550, 0);
			plyr.setTankPosition(50, arenaHeight - 50, 45);
			
			plyr = new PlayerTank(this, 2);
			playerArray.push(plyr);
			plyr.setUIPosition(295, 50, 180);
			plyr.setTankPosition(50, 50, 135);	
			
			plyr = new PlayerTank(this, 3);
			playerArray.push(plyr);
			plyr.setUIPosition(510, 550, 0);
			plyr.setTankPosition(arenaWidth-50, arenaHeight - 50, -45);
			
			plyr = new PlayerTank(this, 4);
			playerArray.push(plyr);
			plyr.setUIPosition(700, 50, 180);
			plyr.setTankPosition(arenaWidth-50, 50, 225);	
			
			//player2 = new PlayerTank(this, 2);
			//player2.setUILocation(100, 400, 0);			
			
			
			// FIXME: create a play field for tanks..
			
			//this.addEventListener(Event.ENTER_FRAME, frameUpdate, false, 0, true);		
		}
		
		function frameUpdate(e:Event)
		{

		}
		
		function projectileHandleCollisions(p:TankProjectile)
		{
			for(var i:int = 0; i<playerArray.length; i++)
			{
				if(p.owner != playerArray[i] && playerArray[i].playerState == "normal" && p.hitTestObject(playerArray[i].mcTank))
				{
					p.removeSelf();
					p.owner.addToScore(1);
					playerArray[i].tankHit();
					
					// FIXME: adjust score.. 
				}
			}
		}
		
	}
}