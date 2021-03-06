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
import com.genome2d.components.renderable.particles.GSimpleParticleSystem;
import com.genome2d.context.GContextConfig;
import com.genome2d.Genome2D;
import com.genome2d.node.GNode;
import com.genome2d.textures.GTextureManager;
import flash.display.Sprite;
import flash.events.Event;


[SWF(width="800", height="600", backgroundColor="#000000", frameRate="60")]
public class BasicExample6SimpleParticles extends Sprite
{
    /**
        Genome2D singleton instance
     **/
    private var genome:Genome2D;

    public function BasicExample6SimpleParticles() {
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
        GAssetManager.generateTextures();

		// Create a node with simple particle system component
        var particleSystem:GSimpleParticleSystem = GNode.createWithComponent(GSimpleParticleSystem) as GSimpleParticleSystem;
        particleSystem.texture = GTextureManager.getTexture("atlas_particle");
        particleSystem.emission = 128;
        particleSystem.emit = true;
        particleSystem.dispersionAngleVariance = Math.PI*2;
        particleSystem.energy = 1;
        particleSystem.initialVelocity = 50;
        particleSystem.initialVelocityVariance = 100;
        particleSystem.initialAngleVariance = 5;
        particleSystem.endAlpha = 0;
        particleSystem.initialScale = 2;
        particleSystem.endScale = .2;
        particleSystem.node.setPosition(400,300);

        Genome2D.getInstance().root.addChild(particleSystem.node);
    }
}
}
