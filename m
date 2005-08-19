From: Ben Collins <bcollins@debian.org>
Date: Fri, 19 Aug 2005 19:27:22 +0000
Subject: Re: current_thread_info_reg undefined
Message-Id: <20050819192722.GA6163@swissdisk.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0508181449100.12167@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Aug 19, 2005 at 12:27:39PM -0700, David S. Miller wrote:
> From: Ben Collins <bcollins@debian.org>
> Date: Fri, 19 Aug 2005 04:31:29 -0700
> 
> > The empty symbol warnings atleast are just a bug with
> > scripts/mod/modpost.c (the patch fabbione sent you awhile back Dave, for
> > STT_SPARC_REGISTER changes in glibc's elf.h).
> > 
> > I think the current_thread_info_reg went away with that patch aswell. If
> > it didn't, I have a fix for that one aswell.
> 
> That fix should be in current 2.6.x... Oh I see, it's still checking
> just STT_REGISTER.  Ben, can you resend that patch to me?


--- linux/scripts/mod/modpost.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-source-2.6.12-2.6.12/scripts/mod/modpost.c	2005-06-30 09:29:54.000000000 +0200
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

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/
