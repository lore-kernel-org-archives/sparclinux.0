From: Mathieu Chouquet-Stringer <mchouque@online.fr>
Date: Wed, 12 May 2004 19:13:48 +0000
Subject: [PATCH] Fix endianess in modpost when cross-compiling for sparc on i386
Message-Id: <20040512191348.GA14674@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: torvalds@osdl.org

	Hi,

this simple patch makes the following code work again:

#ifdef STT_REGISTER
                if (info->hdr->e_machine = EM_SPARC ||
                    info->hdr->e_machine = EM_SPARCV9) {
                        /* Ignore register directives. */
                        if (ELF_ST_TYPE(sym->st_info) = STT_REGISTER)
                                break;
                }
#endif

This portion of code is sparc specific and nothing else in modpost.c uses
e_machine meaning cross-compiling for sparc on i386 (or any little endian
machine) is the only way to experience the bug.

Without it, e_machine has the wrong value and modpost then generates a lot
of "*** Warning: \"symbol\" [filename.ko] undefined" messages.

--- scripts/modpost.c.orig	2004-05-12 13:58:58.000000000 -0400
+++ scripts/modpost.c	2004-05-12 14:05:20.000000000 -0400
@@ -267,6 +267,7 @@
 	hdr->e_shoff    = TO_NATIVE(hdr->e_shoff);
 	hdr->e_shstrndx = TO_NATIVE(hdr->e_shstrndx);
 	hdr->e_shnum    = TO_NATIVE(hdr->e_shnum);
+	hdr->e_machine  = TO_NATIVE(hdr->e_machine);
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	info->sechdrs = sechdrs;
 


-- 
Mathieu Chouquet-Stringer                 E-Mail: mchouque@online.fr
       Never attribute to malice that which can be adequately
                    explained by stupidity.
                     -- Hanlon's Razor --
