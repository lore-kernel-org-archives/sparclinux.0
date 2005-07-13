From: fabbione@fabbione.net (Fabio Massimo Di Nitto)
Date: Wed, 13 Jul 2005 06:25:49 +0000
Subject: [PATCH] modpost needs to cope with new glibc elf header on sparc (resend - my MTA did eat the previo
Message-Id: <20050713062549.1ED325032@trider-g7.fabbione.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050713062134.AD0E35031@trider-g7.fabbione.net>
In-Reply-To: <20050713062134.AD0E35031@trider-g7.fabbione.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Hi everybody,
  recently a change in the glibc elf.h header has been introduced causing
modpost to spawn tons of warnings (like the one below) building the kernel on sparc:

[SNIP]
*** Warning: "current_thread_info_reg" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
*** Warning: "" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
*** Warning: "" [net/sunrpc/auth_gss/auth_rpcgss.ko] undefined!
[SNIP]

Ben Collins discovered that the STT_REGISTERED did change and that this change
needs to be propagated to modpost.

-#define STT_REGISTER   13              /* Global register reserved to app. */
+#define STT_SPARC_REGISTER     13      /* Global register reserved to app. */

I did and tested this simple patch to maintain compatibility with newer (>= 2.3.4)
and older (<= 2.3.2) glibc.

Please apply.

Signed-off-by: Fabio M. Di Nitto <fabbione@fabbione.net>

Cheers
Fabio

diff -urNad --exclude=CVS --exclude=.svn ./scripts/mod/modpost.c /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c
--- ./scripts/mod/modpost.c	2005-06-17 21:48:29.000000000 +0200
+++ /usr/src/dpatchtemp/dpep-work.EcxGXN/linux-source-2.6.12-2.6.12/scripts/mod/modpost.c	2005-06-30 09:29:54.000000000 +0200
@@ -359,11 +359,16 @@
 		/* ignore __this_module, it will be resolved shortly */
 		if (strcmp(symname, MODULE_SYMBOL_PREFIX "__this_module") = 0)
 			break;
-#ifdef STT_REGISTER
+/* cope with newer glibc (2.3.4 or higher) STT_ definition in elf.h */
+#if defined(STT_REGISTER) || defined(STT_SPARC_REGISTER)
+/* add compatibility with older glibc */
+#ifndef STT_SPARC_REGISTER
+#define STT_SPARC_REGISTER STT_REGISTER
+#endif
 		if (info->hdr->e_machine = EM_SPARC ||
 		    info->hdr->e_machine = EM_SPARCV9) {
 			/* Ignore register directives. */
-			if (ELF_ST_TYPE(sym->st_info) = STT_REGISTER)
+			if (ELF_ST_TYPE(sym->st_info) = STT_SPARC_REGISTER)
 				break;
 		}
 #endif
