From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Wed, 08 Feb 2006 20:51:09 +0000
Subject: Re: div, udiv, mul, umul, rem, urem broken again?!?
Message-Id: <1139431869.2838.34.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-t477jldFX9M0PD9XjKZH"
List-Id: <sparclinux.vger.kernel.org>
References: <1128550254.2140.103.camel@localhost.localdomain>
In-Reply-To: <1128550254.2140.103.camel@localhost.localdomain>
To: sparclinux@vger.kernel.org


--=-t477jldFX9M0PD9XjKZH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2006-02-08 at 20:25 +0000, Martin Habets wrote:
> I tried to build 2.6.16-rc2 today, but got a lot of these
> errors from depmod:
> 
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crypto_null.ko needs unknown symbol urem
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crypto_null.ko needs unknown symbol umul
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol udiv
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol div
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol urem
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/crypto/crc32c.ko needs unknown symbol umul
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol udiv
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol div
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol urem
> WARNING: /lib/modules/2.6.16-rc2-mph2/kernel/arch/sparc/kernel/led.ko needs unknown symbol umul
> 
> There was a long thread regarding this last october, but I did not find
> a resolution.
> 
> My module-init-tools are version 3.2-pre1-2 (Debian).
> 
> Any tips/hints?

There was no consensus about the best way to fix this issue... so it
never got fixed.

The attached hack will get module-init-tools working on sparc (Aurora is
using this in lieu of an actual fix).

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-t477jldFX9M0PD9XjKZH
Content-Disposition: attachment; filename=module-init-tools-3.2-sparc.patch
Content-Type: text/x-patch; name=module-init-tools-3.2-sparc.patch; charset=utf-8
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

--=-t477jldFX9M0PD9XjKZH--

