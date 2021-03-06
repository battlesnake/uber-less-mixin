#!/usr/bin/awk -f

BEGIN {
	print "/* Generated by Mark's REM script, mark@battlesnake.co.uk, github:battlesnake */";
	print "";
	p = 0;
	for (i = 1; i < ARGC; i++) {
		p++;
		split(ARGV[i], arg, ":");
		units[p] = arg[1];
		scales[p] = arg[2];
	}
	nunits = p;
	ARGC = 1;
	for (i = 1; i <= nunits; i++) {
		for (j = 1; j <= nunits; j++) {
			if (i == j) {
				continue;
			}
			const = sprintf("@%s-in-%s", units[i], units[j]);
			printf("%s: (%s) / (%s) + 0%s;\n", const, scales[j], scales[i], units[j]);
		}
	}
	printf "\n";
}

{
	name = $1;
	prop = $2;
	printf(".%s (", name);
	template = "";
	p = 0;
	for (i = 3; i <= NF; i++) {
		p++;
		var = $i;
		fixed = 0;
		if (var ~ /^\=/) {
			var = substr(var, 2);
			fixed = 1;
		}
		if (p > 1) {
			printf("; ");
		}
		printf("@%s", var);
		if (fixed > 0) {
			template = sprintf("%s @%s", template, var);
		}
		else {
			template = sprintf("%s unit(@%s{SCALE}, {UNIT})", template, var);
		}
	}
	printf ") {\n";
	for (i = 1; i <= nunits; i++) {
		unit = units[i];
		scale = scales[i];
		line = template;
		gsub("{UNIT}", unit, line);
		if (scale == "1") {
			scale = "";
		}
		else {
			scale = sprintf(" * (%s)", scale);
		}
		gsub("{SCALE}", scale, line);
		printf("\t%s:%s;\n", prop, line);
	}
	printf "}\n\n";
}
