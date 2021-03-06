/*
 * 	Genome2D - 2D GPU Framework
 * 	http://www.genome2d.com
 *
 *	Copyright 2011-2014 Peter Stefcek. All rights reserved.
 *
 *	License:: ./doc/LICENSE.md (https://github.com/pshtif/Genome2D/blob/master/LICENSE.md)
 */
package examples.basic {

import com.genome2d.Genome2D;
import com.genome2d.context.GContextConfig;

import flash.display.Sprite;
import flash.events.Event;

[SWF(width="800", height="600", backgroundColor="#000000", frameRate="60")]
public class BasicExample1Initialization extends Sprite
{
    /**
        Genome2D singleton instance
     **/
    private var genome:Genome2D;

    public function BasicExample1Initialization() {
        if (stage != null) addedToStage_handler(null);
        else addEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);
    }

    private function addedToStage_handler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);

        initGenome();
    }

    /**
        Initialize Genome2D
     **/
    private function initGenome():void {
        // Get the Genome2D instance
        genome = Genome2D.getInstance();
		// Add a callback for Genome2D fail
		genome.onFailed.addOnce(genomeFailed_handler);
        // Add a callback for Genome2D initialization
        genome.onInitialized.addOnce(genomeInitialized_handler);
        // Initialize Genome2D
        genome.init(new GContextConfig(stage));
    }

	/**
        Genome2D failed handler
     **/
    private function genomeFailed_handler(p_msg:String):Void {
        // Here we can check why Genome2D initialization failed
    }
	
    /**
        Genome2D initialized handler
     **/
    private function genomeInitialized_handler():void {
        // Here we can do any Genome2D related code as its initialized)
    }
	}
}
