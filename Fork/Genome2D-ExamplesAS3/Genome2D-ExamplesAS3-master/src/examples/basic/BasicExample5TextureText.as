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
import com.genome2d.components.renderable.text.GText;
import com.genome2d.context.GContextConfig;
import com.genome2d.Genome2D;
import com.genome2d.node.GNode;
import com.genome2d.text.GFontManager;
import com.genome2d.textures.GTextureManager;
import com.genome2d.utils.GHAlignType;
import com.genome2d.utils.GVAlignType;
import flash.display.Sprite;
import flash.events.Event;


[SWF(width="800", height="600", backgroundColor="#000000", frameRate="60")]
public class BasicExample5TextureText extends Sprite
{
    /**
        Genome2D singleton instance
     **/
    private var genome:Genome2D;

    public function BasicExample5TextureText() {
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
		GAssetManager.addFromUrl("font.png");
        GAssetManager.addFromUrl("font.fnt");
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
		GTextureManager.createTexture("font.png", GAssetManager.getImageAssetById("font.png"));
		
		GFontManager.createTextureFont("font", GTextureManager.getTexture("font.png"), GAssetManager.getXmlAssetById("font.fnt").xml);
		
		createText(250, 150, "Hello world.", GVAlignType.MIDDLE, GHAlignType.CENTER);
    }
	
    private function createText(p_x:Number, p_y:Number, p_text:String, p_vAlign:int, p_hAlign:int, p_tracking:int = 0, p_lineSpace:int = 0):GText {
        var text:GText = GNode.createWithComponent(GText) as GText;
		
        text.renderer.textureFont = GFontManager.getFont("font");
        text.width = 300;
        text.height = 300;
        text.text = p_text;
        text.tracking = p_tracking;
        text.lineSpace = p_lineSpace;
        text.vAlign = p_vAlign;
        text.hAlign = p_hAlign;
        text.node.setPosition(p_x, p_y);
		
        genome.root.addChild(text.node);

        return text;
    }
}
}
