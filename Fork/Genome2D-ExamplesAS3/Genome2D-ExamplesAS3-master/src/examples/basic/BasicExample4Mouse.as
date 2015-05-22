/*
 * 	Genome2D - 2D GPU Framework
 * 	http://www.genome2d.com
 *
 *	Copyright 2011-2014 Peter Stefcek. All rights reserved.
 *
 *	License:: ./doc/LICENSE.md (https://github.com/pshtif/Genome2D/blob/master/LICENSE.md)
 */
package examples.basic {
import com.genome2d.assets.GAsset;
import com.genome2d.assets.GAssetManager;
import com.genome2d.components.renderable.GSprite;
import com.genome2d.context.GContextConfig;
import com.genome2d.Genome2D;
import com.genome2d.input.GMouseInput;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTextureManager;
import flash.display.MovieClip;
import flash.events.Event;

[SWF(width="800", height="600", backgroundColor="#000000", frameRate="60")]
public class BasicExample4Mouse extends MovieClip
{
    /**
        Genome2D singleton instance
     **/
    private var genome:Genome2D;
	
    public function BasicExample4Mouse() {
        if (stage != null) addedToStage_handler(null);
        else addEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);
    }
	
    private function addedToStage_handler(event:Event):void {
        removeEventListener(Event.ADDED_TO_STAGE, addedToStage_handler);

        initGenome();
    }
	
    /**
        Initialize Genome2D
     **/
    private function initGenome():void {
        genome = Genome2D.getInstance();
		genome.onFailed.addOnce(genomeFailed_handler);
        genome.onInitialized.addOnce(genomeInitialized_handler);
        genome.init(new GContextConfig(stage));
    }

	/**
        Genome2D failed handler
     **/
    private function genomeFailed_handler(p_msg:String):void {
        // Here we can check why Genome2D initialization failed
    }
	
    /**
        Genome2D initialized handler
     **/
    private function genomeInitialized_handler():void {
        loadAssets();
    }
	
	/**	
	 * 	Asset loading
	 */
	private function loadAssets():void {
		GAssetManager.addFromUrl("atlas.png");
        GAssetManager.addFromUrl("atlas.xml");
		GAssetManager.addFromUrl("texture.png");
		GAssetManager.onQueueFailed.add(assetsFailed_handler);
        GAssetManager.onQueueLoaded.addOnce(assetsLoaded_handler);
        GAssetManager.loadQueue();
	}
	
	/**
	 * 	Asset loading failed
	 */
	private function assetsFailed_handler(p_asset:GAsset):void {
		// Asset loading failed at p_asset
	}
	
	/**
	 * 	Asset loading completed
	 */
	private function assetsLoaded_handler():void {
		initExample();
	}

    /**
        Initialize Example code
     **/
    private function initExample():void {
		// Generate textures from all assets, their IDs will be the same as their asset ID
        GAssetManager.generateTextures();

        var sprite:GSprite = createAnimatedSprite(400, 300);

        sprite.node.mouseEnabled = true;
        sprite.node.onMouseClick.add(mouseClickHandler);
        sprite.node.onMouseOver.add(mouseOverHandler);
        sprite.node.onMouseOut.add(mouseOutHandler);
        sprite.node.onMouseDown.add(mouseDownHandler);
        sprite.node.onMouseUp.add(mouseUpHandler);

        genome.root.addChild(sprite.node);
    }
	
    /**
        Mouse click handler
     **/
    private function mouseClickHandler(signal:GMouseInput):void {
        trace("CLICK");
    }

    /**
        Mouse over handler
     **/
    private function mouseOverHandler(signal:GMouseInput):void {
        trace("OVER");
    }

    /**
        Mouse out handler
     **/
    private function mouseOutHandler(signal:GMouseInput):void {
        trace("OUT");
    }

    /**
        Mouse down handler
     **/
    private function mouseDownHandler(signal:GMouseInput):void {
        trace("DOWN");
    }

    /**
        Mouse up handler
     **/
    private function mouseUpHandler(signal:GMouseInput):void {
        trace("UP");
    }
	
	/**
        Create a sprite helper function
     **/
    private function createAnimatedSprite(p_x:int, p_y:int):GSprite {
        var sprite:GSprite = GNode.createWithComponent(GSprite) as GSprite;
        sprite.texture = GTextureManager.getTexture("atlas_0");
        sprite.node.setPosition(p_x, p_y);
        genome.root.addChild(sprite.node);

        return sprite;
    }
}
}
