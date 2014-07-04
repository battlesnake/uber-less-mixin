Uber mixins
===========

	Mark K Cowan

	mark@battlesnake.co.uk

	github.com/battlesnake


generate-rems
-------------
	bash script which generates the rems.less file


generator.awk
-------------

	awk script used by generate-rems


rems.less
---------

	A set of mixins for handling lengths (e.g. width, height, border-radius),
	which generates CSS directives in both pixels and in rems.  It assumes that
	1rem = 16px by default (so no hacky "html { font-size: 62.5% }" needed),
	although this unit conversion can be changed in the generate-rems file.

	For example, where 2000s CSS authors may write "max-width: 20px", we modern
	authors who don't hate people with accessible font settings can now write
	".max-width(20)" which generates:

	```css
		max-width: 20px;
		max-width: 1.25rem;
	```

	So the size is specified in rems for browsers which support it, and also a
	fallback in pixels is written for browsers which do not support rems.

	The size parameter for all of these rems mixins is specified in the pixels
	value that would be used on a browser with the default font/scale/zoom
	settings.


mixins.less
-----------

	A set of mixins to workaround repetition introduced by vendor prefixes, and
	syntax differences between *certain* browsers and the standard.

	Where one might hope to write "transition: opacity 400ms ease" without fear
	of cross-browser issues, you can use ".transition(opacity 400ms ease)" which
	generates a set of browser-prefixed instructions in addition to the
	unprefixed version:

	```css
		-webkit-transition: opacity 400ms ease;  
		-moz-transition: opacity 400ms ease;
		-ms-transition: opacity 400ms ease; 
		-o-transition: opacity 400ms ease;  
		transition: opacity 400ms ease;  
	```

