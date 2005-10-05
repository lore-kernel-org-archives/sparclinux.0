From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 05 Oct 2005 22:17:40 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1128550660.2140.105.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-el5hPJ/L9i2Gw22/FqVQ"
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
To: sparclinux@vger.kernel.org


--=-el5hPJ/L9i2Gw22/FqVQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


I accidentally sent a broken version of this patch, the attached version works.

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-el5hPJ/L9i2Gw22/FqVQ
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
 
--- module-init-tools-3.2-pre9/depmod.h.BAD	2005-10-05 18:19:53.451485241 -0400
+++ module-init-tools-3.2-pre9/depmod.h	2005-10-05 18:19:58.472721897 -0400
@@ -12,7 +12,7 @@ void *do_nofail(void *ptr, const char *f
 #define NOFAIL(ptr)	do_nofail((ptr), __FILE__, __LINE__, #ptr)
 
 void add_symbol(const char *name, struct module *owner);
-struct module *find_symbol(const char *name, const char *modname, int weak);
+struct module *find_symbol(char *name, const char *modname, int weak);
 void add_dep(struct module *mod, struct module *depends_on);
 
 /* I hate strcmp. */

--=-el5hPJ/L9i2Gw22/FqVQ--

