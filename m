From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Mon, 29 Mar 2004 22:42:34 +0000
Subject: Re: Compiling modules question
Message-Id: <20040329224234.GA29302@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040329201901.GD30251@artsapartment.org>
In-Reply-To: <20040329201901.GD30251@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Mar 29, 2004 at 02:19:01PM -0600, Art Haas wrote:

> Here's another question for the list that I've not been able to
> answer. When I compile a kernel with modules, the modules all have
> problems with undefined symbols like 'udiv', 'urem', etc. As

The problem is with depmod, not with the kernel.  Your modules will
build, load and work fine without any changes.

Rusty, this matches the change to modpost.c from a while back; does it
look OK to you?

--- module-init-tools-3.0-pre9/depmod.c.orig	2004-03-29 14:15:23.760083163 -0800
+++ module-init-tools-3.0-pre9/depmod.c	2004-03-29 14:18:07.074152850 -0800
@@ -106,13 +106,26 @@
 
 static int print_unknown;
 
+#define DOTSYM_PFX "__dot_"
+
 struct module *find_symbol(const char *name, const char *modname, int weak)
 {
 	struct symbol *s;
+	char dotname[64 + sizeof(DOTSYM_PFX)];
 
 	/* For our purposes, .foo matches foo.  PPC64 needs this. */
-	if (name[0] = '.')
+	if (name[0] = '.') {
 		name++;
+		strcpy(dotname, DOTSYM_PFX);
+		strncat(dotname, name, sizeof(dotname) - sizeof(DOTSYM_PFX) - 1);
+		dotname[sizeof(dotname)-1] = 0;
+		/* Sparc32 wants .foo to match __dot_foo, try this first. */
+		for (s = symbolhash[tdb_hash(dotname) % SYMBOL_HASH_SIZE];
+		     s; s=s->next) {
+			if (streq(s->name, dotname))
+				return s->owner;
+		}
+	}
 
 	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s=s->next) {
 		if (streq(s->name, name))


-- 
Keith M Wesolowski
