From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 05 Oct 2005 22:10:54 +0000
Subject: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1128550254.2140.103.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-J2mIktikSVFG+3Sq03Qf"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-J2mIktikSVFG+3Sq03Qf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Built 2.6.14-rc3-git4 today for sparc32 and I got pages of this from
depmod -aeF /boot/System.map-2.6.13-1.1594sp1 2.6.13-1.1594sp1:

WARNING: /lib/modules/2.6.13-1.1594sp1/kernel/sound/sparc/snd-sun-dbri.ko needs unknown symbol udiv
WARNING: /lib/modules/2.6.13-1.1594sp1/kernel/sound/sparc/snd-sun-dbri.ko needs unknown symbol div
WARNING: /lib/modules/2.6.13-1.1594sp1/kernel/sound/sparc/snd-sun-dbri.ko needs unknown symbol urem
WARNING: /lib/modules/2.6.13-1.1594sp1/kernel/sound/sparc/snd-sun-dbri.ko needs unknown symbol rem
WARNING: /lib/modules/2.6.13-1.1594sp1/kernel/sound/sparc/snd-sun-dbri.ko needs unknown symbol umul

Not just for dbri, but for pretty much everything built as a module. I
tested the latest revision of module-utils to see if it made any
difference, and it did not.

This looks like it tracks to:
http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7caaeabb17758295edff9703c18a840073c5b8f4

Unfortunately, depmod had a workaround case for .* symbols, and it is
now seems to be broken for these sparc symbols. I worked up the attached
patch to resolve the issue, but I'm not sure if it is the most correct
way to fix it.

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-J2mIktikSVFG+3Sq03Qf
Content-Disposition: attachment; filename=module-init-tools-3.2-sparc.patch
Content-Type: text/x-patch; name=module-init-tools-3.2-sparc.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- module-init-tools-3.2-pre9/depmod.c.BAD	2005-10-05 17:10:39.026053905 -0400
+++ module-init-tools-3.2-pre9/depmod.c	2005-10-05 18:09:11.354098881 -0400
@@ -103,10 +103,24 @@ void add_symbol(const char *name, struct
 
 static int print_unknown;
 
-struct module *find_symbol(const char *name, const char *modname, int weak)
+struct module *find_symbol(char *name, const char *modname, int weak)
 {
 	struct symbol *s;
 
+	/* Handle the wacky sparc cases */
+	if (strcmp(name, ".div") == 0)
+		strncpy(name, "_Div", sizeof(name));
+	if (strcmp(name, ".udiv") == 0)
+		strncpy(name, "_Udiv", sizeof(name));
+	if (strcmp(name, ".mul") == 0)
+		strncpy(name, "_Mul", sizeof(name));
+	if (strcmp(name, ".umul") == 0)
+		strncpy(name, "_Umul", sizeof(name));
+	if (strcmp(name, ".rem") == 0)
+		strncpy(name, "_Rem", sizeof(name));
+	if (strcmp(name, ".urem") == 0)
+		strncpy(name, "_Urem", sizeof(name));
+
 	/* For our purposes, .foo matches foo.  PPC64 needs this. */
 	if (name[0] == '.')
 		name++;
--- module-init-tools-3.2-pre9/moduleops_core.c.BAD	2005-10-05 18:10:18.321918225 -0400
+++ module-init-tools-3.2-pre9/moduleops_core.c	2005-10-05 18:10:12.533798153 -0400
@@ -118,7 +118,7 @@ static void PERBIT(calculate_deps)(struc
 	for (i = 1; i < size / sizeof(syms[0]); i++) {
 		if (END(syms[i].st_shndx, module->conv) == SHN_UNDEF) {
 			/* Look for symbol */
-			const char *name;
+			char *name;
 			struct module *owner;
 			int weak;
 

--=-J2mIktikSVFG+3Sq03Qf--

