

<cfscript>

local.md = "## heading
This is ~~*Sparta*~~

The `<article>` tag is a http://www.google.com good example of [semantic HTML](http://en.wikipedia.org/wiki/Semantic_HTML).

```
<code in here>
```

| Tables   |      Are      |  Cool |
|----------|:-------------:|------:|
| col 1 is |  left-aligned | $1600 |
| col 2 is |    centered   |   $12 |
| col 3 is | right-aligned |    $1 |
";


local.markdown = new markdown();
tTotal = 0;
for(i=0; i<100; i++){
	t = getTickCount();
	parsed = local.markdown.parse(local.md);
	//writeOutput(parsed);
	tTotal += getTickCount()-t;
	writeOutput(getTickCount()-t & "ms<br />");
}
writeOutput((tTotal/100) & "ms");
</cfscript>