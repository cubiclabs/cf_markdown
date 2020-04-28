component{
	variables._jars = [];

	/**
	* @hint constructor
	*/
	public any function init(){
		readJars();
		return this;
	}

	/**
	* @hint lists jars in our java directory
	*/
	public void function readJars(){
		local.jars = directoryList(expandPath("java"), false, "name");
		local.jars = arrayMap(local.jars, function(jar){
			return "java/" & jar;
		});
		variables._jars = local.jars;
	}

	public struct function defaultExtConfig(){
		return {
			autolink: false,
			strikethrough: true,
			tables: true,
			headingAnchor: true,
			ins: true
		};
	}

	/**
	* @hint lists jars in our java directory
	*/
	public string function parse(string markdown, struct config={}){

		local.extConfig = defaultExtConfig();
		structAppend(local.extConfig, arguments.config, true);

		// get extensions
		local.ext = getExtensions(local.extConfig);

		// get our parser
		local.parser = createObject("java", "org.commonmark.parser.Parser", variables._jars).builder().extensions(local.ext).build();
		// parse our markdown string
		local.document = parser.parse(arguments.markdown);

		// get our HTML renderer
		local.renderer = createObject("java", "org.commonmark.renderer.html.HtmlRenderer", variables._jars).builder().extensions(local.ext).build();
		// return our HTML render
		return local.renderer.render(local.document);
	}


	/**
	* @hint returns an array of commonmark extentions
	*/
	public array function getExtensions(struct config=defaultExtConfig()){
		local.ext = [];
		if(arguments.config.autolink){
			arrayAppend(local.ext, createObject("java", "org.commonmark.ext.autolink.AutolinkExtension", variables._jars).create());
		}
		if(arguments.config.strikethrough){
			arrayAppend(local.ext, createObject("java", "org.commonmark.ext.gfm.strikethrough.StrikethroughExtension", variables._jars).create());
		}
		if(arguments.config.tables){
			arrayAppend(local.ext, createObject("java", "org.commonmark.ext.gfm.tables.TablesExtension", variables._jars).create());
		}
		if(arguments.config.headingAnchor){
			arrayAppend(local.ext, createObject("java", "org.commonmark.ext.heading.anchor.HeadingAnchorExtension", variables._jars).create());
		}
		if(arguments.config.ins){
			arrayAppend(local.ext, createObject("java", "org.commonmark.ext.ins.InsExtension", variables._jars).create());
		}
		return local.ext;
	}

}