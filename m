From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 11 May 2006 18:07:32 +0000
Subject: [PATCH] sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060511180731.GB16957@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 09, 2006 at 03:00:00PM -0700, David S. Miller wrote:
> From: Martin Habets <errandir_news@mph.eclipse.co.uk>
> Date: Tue, 9 May 2006 22:27:22 +0100
> 
> > Sadly, no. I can try to do some of the easier things, but fixing
> > something like the esp driver without the esp&dma datasheets is
> > beyond me I'm afraid :).
> 
> http://en.wikipedia.org/wiki/NCR_53C9x
> 
> The DMA programming manual is really not that necessary to
> understand the chip.

Thanks! I'm studying that now and will continue pokin around in there.

> > Yes, these actually fail to load. Maybe it's a memory corruption in module.c
> > somehow: if I make too many debugging changes in apply_relocate_add() the
> > problem disappears.
> > I'm trying different things now to make it show me the failing section and
> > symbol when it fails. I'll post again once I have more details.
> 
> Are you using Debian's gcc-4.1 compiler to build kernels?

I found it. A stupid mistake by me set things off all wrong :(.
The original error
	Unknown relocation: 17
actually means 0x17, which is R_SPARC_UA32. Sure enough the objdump output
showed that all along, and module.c has no support for it.
Since this is related binutils, I'm on version 2.16.1 of that.
Got the issue with gcc-3.3.5 and gcc-3.4.4.

The patch below add support for this type, considering that the documentation
has:
	"Resembles R_SPARC_32, except that it refers to an unaligned word.
	The word to be relocated must be treated as four separate bytes with 
	arbitrary alignment, not as a word aligned according to the 
	architecture requirements."
It also has a debugging change of mine, not sure if that is suitable for
the mainstream kernel. If not I can supply a patch without that part.

Thanks again for all the help!
-- 
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

--- 2.6.17-rc3/arch/sparc/kernel/module.c.orig	2006-05-11 17:21:02.000000000 +0100
+++ 2.6.17-rc3/arch/sparc/kernel/module.c	2006-05-11 18:30:09.000000000 +0100
@@ -100,6 +100,7 @@
 
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		Elf32_Addr v;
+		u8 *uv;
 
 		/* This is where to make the change */
 		location = (u8 *)sechdrs[sechdrs[relsec].sh_info].sh_addr
@@ -140,10 +141,19 @@
 				((v >> 10) & 0x3fffff);
 			break;
 
+		case R_SPARC_UA32:	/* Like R_SPARC_32 but unaligned */
+			uv = (u8 *) v;
+			location[0] = uv[0];
+			location[1] = uv[1];
+			location[2] = uv[2];
+			location[3] = uv[3];
+			break;
+
 		default:
-			printk(KERN_ERR "module %s: Unknown relocation: %x",
+			printk(KERN_ERR "module %s: Unknown relocation: %x relsec=%d i=%d\n",
 			       me->name,
-			       (int) (ELF32_R_TYPE(rel[i].r_info)));
+			       (int) (ELF32_R_TYPE(rel[i].r_info)),
+			       relsec, i);
 			return -ENOEXEC;
 		};
 	}
