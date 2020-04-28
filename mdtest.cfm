

<cfscript>

local.md = "## heading
This is ~~*Sparta*~~

The `<article>` tag is a http://www.google.com good example of [semantic HTML](http://en.wikipedia.org/wiki/Semantic_HTML).

| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |
";

local.jars = directoryList(expandPath("java"), false, "name");
local.jars = arrayMap(local.jars, function(jar){
	return "java/" & jar;
});
//writeDump(local.jars);

// extensions
local.ext = [];
arrayAppend(local.ext, createObject("java", "org.commonmark.ext.autolink.AutolinkExtension", local.jars).create());
arrayAppend(local.ext, createObject("java", "org.commonmark.ext.gfm.strikethrough.StrikethroughExtension", local.jars).create());
arrayAppend(local.ext, createObject("java", "org.commonmark.ext.gfm.tables.TablesExtension", local.jars).create());
arrayAppend(local.ext, createObject("java", "org.commonmark.ext.heading.anchor.HeadingAnchorExtension", local.jars).create());
arrayAppend(local.ext, createObject("java", "org.commonmark.ext.ins.InsExtension", local.jars).create());

//linkTypes = createObject("java", "org.commonmark.ext.autolink.LinkType", local.jars).URL;

parser = createObject("java", "org.commonmark.parser.Parser", local.jars).builder().extensions(local.ext).build();

document = parser.parse(local.md);

renderer = createObject("java", "org.commonmark.renderer.html.HtmlRenderer", local.jars).builder().extensions(local.ext).build();
out = renderer.render(document);

writeOutput(out);


local.markdown = new markdown();
t = getTickCount();
writeOutput(local.markdown.parse(local.md));
writeOutput(getTickCount()-t & "ms");
</cfscript>