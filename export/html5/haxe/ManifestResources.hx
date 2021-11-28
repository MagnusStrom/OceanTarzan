package;


import haxe.io.Bytes;
import lime.utils.AssetBundle;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import lime.utils.Assets;

#if sys
import sys.FileSystem;
#end

@:access(lime.utils.Assets)


@:keep @:dox(hide) class ManifestResources {


	public static var preloadLibraries:Array<AssetLibrary>;
	public static var preloadLibraryNames:Array<String>;
	public static var rootPath:String;


	public static function init (config:Dynamic):Void {

		preloadLibraries = new Array ();
		preloadLibraryNames = new Array ();

		rootPath = null;

		if (config != null && Reflect.hasField (config, "rootPath")) {

			rootPath = Reflect.field (config, "rootPath");

		}

		if (rootPath == null) {

			#if (ios || tvos || emscripten)
			rootPath = "assets/";
			#elseif android
			rootPath = "";
			#elseif console
			rootPath = lime.system.System.applicationDirectory;
			#else
			rootPath = "./";
			#end

		}

		#if (openfl && !flash && !display)
		openfl.text.Font.registerFont (__ASSET__OPENFL__assets_data_baby_elephant_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf);
		openfl.text.Font.registerFont (__ASSET__OPENFL__flixel_fonts_monsterrat_ttf);
		
		#end

		var data, manifest, library, bundle;

		#if kha

		null
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("null", library);

		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("null");

		#else

		data = '{"name":null,"assets":"aoy4:sizei33624y4:typey4:FONTy9:classNamey38:__ASSET__assets_data_baby_elephant_ttfy2:idy33:assets%2Fdata%2FBaby_Elephant.ttfy7:preloadtgoy4:pathy22:assets%2Fdata%2FBakcupR0i695R1y4:TEXTR5R9R7tgoR8y29:assets%2Fdata%2FBakcup%20copyR0i297R1R10R5R11R7tgoR8y34:assets%2Fdata%2Fdata-goes-here.txtR0zR1R10R5R12R7tgoR8y26:assets%2Fimages%2FBoat.pngR0i444R1y5:IMAGER5R13R7tgoR8y26:assets%2Fimages%2FFISH.pngR0i2409R1R14R5R15R7tgoR8y36:assets%2Fimages%2Fimages-go-here.txtR0zR1R10R5R16R7tgoR8y28:assets%2Fimages%2FNinjah.pngR0i342R1R14R5R17R7tgoR8y29:assets%2Fimages%2FNinjah2.pngR0i657R1R14R5R18R7tgoR8y30:assets%2Fimages%2FPlatform.pngR0i834R1R14R5R19R7tgoR8y25:assets%2Fimages%2FSEA.pngR0i17586R1R14R5R20R7tgoR8y32:assets%2Fimages%2FStartingBG.pngR0i384R1R14R5R21R7tgoR8y27:assets%2Fimages%2FTrash.pngR0i504R1R14R5R22R7tgoR8y36:assets%2Fmusic%2Fmusic-goes-here.txtR0zR1R10R5R23R7tgoR0i13944R1y5:SOUNDR5y26:assets%2Fsounds%2FDead.wavy9:pathGroupaR25hR7tgoR0i8232R1R24R5y30:assets%2Fsounds%2FDIALOUGE.wavR26aR27hR7tgoR0i917056R1R24R5y28:assets%2Fsounds%2FEnding.wavR26aR28hR7tgoR0i17770R1R24R5y29:assets%2Fsounds%2FGrapple.wavR26aR29hR7tgoR0i17638R1R24R5y26:assets%2Fsounds%2FJump.wavR26aR30hR7tgoR0i1407064R1R24R5y30:assets%2Fsounds%2FMainMenu.wavR26aR31hR7tgoR8y36:assets%2Fsounds%2Fsounds-go-here.txtR0zR1R10R5R32R7tgoR0i31290R1R24R5y34:assets%2Fsounds%2FTrashCollect.wavR26aR33hR7tgoR0i68105R1y5:MUSICR5y27:assets%2Fsounds%2FVroom.mp3R26aR35hR7tgoR0i2114R1R34R5y26:flixel%2Fsounds%2Fbeep.mp3R26aR36y26:flixel%2Fsounds%2Fbeep.ogghR7tgoR0i39706R1R34R5y28:flixel%2Fsounds%2Fflixel.mp3R26aR38y28:flixel%2Fsounds%2Fflixel.ogghR7tgoR0i5794R1R24R5R37R26aR36R37hgoR0i33629R1R24R5R39R26aR38R39hgoR0i15744R1R2R3y35:__ASSET__flixel_fonts_nokiafc22_ttfR5y30:flixel%2Ffonts%2Fnokiafc22.ttfR7tgoR0i29724R1R2R3y36:__ASSET__flixel_fonts_monsterrat_ttfR5y31:flixel%2Ffonts%2Fmonsterrat.ttfR7tgoR8y33:flixel%2Fimages%2Fui%2Fbutton.pngR0i519R1R14R5R44R7tgoR8y36:flixel%2Fimages%2Flogo%2Fdefault.pngR0i3280R1R14R5R45R7tgh","rootPath":null,"version":2,"libraryArgs":[],"libraryType":null}';
		manifest = AssetManifest.parse (data, rootPath);
		library = AssetLibrary.fromManifest (manifest);
		Assets.registerLibrary ("default", library);
		

		library = Assets.getLibrary ("default");
		if (library != null) preloadLibraries.push (library);
		else preloadLibraryNames.push ("default");
		

		#end

	}


}


#if kha

null

#else

#if !display
#if flash

@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_baby_elephant_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bakcup extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_bakcup_copy extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_boat_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_fish_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ninjah_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_ninjah2_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_platform_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_sea_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_startingbg_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_images_trash_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_dead_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_dialouge_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_ending_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_grapple_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_mainmenu_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_trashcollect_wav extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__assets_sounds_vroom_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends null { }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends flash.display.BitmapData { public function new () { super (0, 0, true, 0); } }
@:keep @:bind @:noCompletion #if display private #end class __ASSET__manifest_default_json extends null { }


#elseif (desktop || cpp)

@:keep @:font("export/html5/obj/webfont/Baby_Elephant.ttf") @:noCompletion #if display private #end class __ASSET__assets_data_baby_elephant_ttf extends lime.text.Font {}
@:keep @:file("assets/data/Bakcup") @:noCompletion #if display private #end class __ASSET__assets_data_bakcup extends haxe.io.Bytes {}
@:keep @:file("assets/data/Bakcup copy") @:noCompletion #if display private #end class __ASSET__assets_data_bakcup_copy extends haxe.io.Bytes {}
@:keep @:file("assets/data/data-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_data_data_goes_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/Boat.png") @:noCompletion #if display private #end class __ASSET__assets_images_boat_png extends lime.graphics.Image {}
@:keep @:image("assets/images/FISH.png") @:noCompletion #if display private #end class __ASSET__assets_images_fish_png extends lime.graphics.Image {}
@:keep @:file("assets/images/images-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_images_images_go_here_txt extends haxe.io.Bytes {}
@:keep @:image("assets/images/Ninjah.png") @:noCompletion #if display private #end class __ASSET__assets_images_ninjah_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Ninjah2.png") @:noCompletion #if display private #end class __ASSET__assets_images_ninjah2_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Platform.png") @:noCompletion #if display private #end class __ASSET__assets_images_platform_png extends lime.graphics.Image {}
@:keep @:image("assets/images/SEA.png") @:noCompletion #if display private #end class __ASSET__assets_images_sea_png extends lime.graphics.Image {}
@:keep @:image("assets/images/StartingBG.png") @:noCompletion #if display private #end class __ASSET__assets_images_startingbg_png extends lime.graphics.Image {}
@:keep @:image("assets/images/Trash.png") @:noCompletion #if display private #end class __ASSET__assets_images_trash_png extends lime.graphics.Image {}
@:keep @:file("assets/music/music-goes-here.txt") @:noCompletion #if display private #end class __ASSET__assets_music_music_goes_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/Dead.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_dead_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/DIALOUGE.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_dialouge_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/Ending.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_ending_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/Grapple.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_grapple_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/Jump.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_jump_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/MainMenu.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_mainmenu_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/sounds-go-here.txt") @:noCompletion #if display private #end class __ASSET__assets_sounds_sounds_go_here_txt extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/TrashCollect.wav") @:noCompletion #if display private #end class __ASSET__assets_sounds_trashcollect_wav extends haxe.io.Bytes {}
@:keep @:file("assets/sounds/Vroom.mp3") @:noCompletion #if display private #end class __ASSET__assets_sounds_vroom_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/sounds/beep.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/sounds/flixel.mp3") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_mp3 extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/sounds/beep.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_beep_ogg extends haxe.io.Bytes {}
@:keep @:file("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/sounds/flixel.ogg") @:noCompletion #if display private #end class __ASSET__flixel_sounds_flixel_ogg extends haxe.io.Bytes {}
@:keep @:font("export/html5/obj/webfont/nokiafc22.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font {}
@:keep @:font("export/html5/obj/webfont/monsterrat.ttf") @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/images/ui/button.png") @:noCompletion #if display private #end class __ASSET__flixel_images_ui_button_png extends lime.graphics.Image {}
@:keep @:image("C:/HaxeToolkit/haxe/lib/flixel/4,10,0/assets/images/logo/default.png") @:noCompletion #if display private #end class __ASSET__flixel_images_logo_default_png extends lime.graphics.Image {}
@:keep @:file("") @:noCompletion #if display private #end class __ASSET__manifest_default_json extends haxe.io.Bytes {}



#else

@:keep @:expose('__ASSET__assets_data_baby_elephant_ttf') @:noCompletion #if display private #end class __ASSET__assets_data_baby_elephant_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "assets/data/Baby_Elephant"; #else ascender = 2098; descender = -418; height = 2516; numGlyphs = 229; underlinePosition = -292; underlineThickness = 150; unitsPerEM = 2048; #end name = "Baby Elephant"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_nokiafc22_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/nokiafc22"; #else ascender = 2048; descender = -512; height = 2816; numGlyphs = 172; underlinePosition = -640; underlineThickness = 256; unitsPerEM = 2048; #end name = "Nokia Cellphone FC Small"; super (); }}
@:keep @:expose('__ASSET__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__flixel_fonts_monsterrat_ttf extends lime.text.Font { public function new () { #if !html5 __fontPath = "flixel/fonts/monsterrat"; #else ascender = 968; descender = -251; height = 1219; numGlyphs = 263; underlinePosition = -150; underlineThickness = 50; unitsPerEM = 1000; #end name = "Monsterrat"; super (); }}


#end

#if (openfl && !flash)

#if html5
@:keep @:expose('__ASSET__OPENFL__assets_data_baby_elephant_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_data_baby_elephant_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_data_baby_elephant_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#else
@:keep @:expose('__ASSET__OPENFL__assets_data_baby_elephant_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__assets_data_baby_elephant_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__assets_data_baby_elephant_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_nokiafc22_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_nokiafc22_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_nokiafc22_ttf ()); super (); }}
@:keep @:expose('__ASSET__OPENFL__flixel_fonts_monsterrat_ttf') @:noCompletion #if display private #end class __ASSET__OPENFL__flixel_fonts_monsterrat_ttf extends openfl.text.Font { public function new () { __fromLimeFont (new __ASSET__flixel_fonts_monsterrat_ttf ()); super (); }}

#end

#end
#end

#end
