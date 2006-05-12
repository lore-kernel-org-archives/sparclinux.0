From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Fri, 12 May 2006 13:02:03 +0000
Subject: Re: [PATCH] sparc: cannot load any modules with 2.6.17-rc3
Message-Id: <20060512130203.GA19553@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20060511180731.GB16957@palantir8>
In-Reply-To: <20060511180731.GB16957@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, May 12, 2006 at 01:33:27PM +0100, Martin Habets wrote:
> > I still wonder where you're getting that relocation from.  It must be
> > emitted by some dwarf2 frame unwind stuff.  It's a shame that such
> > bloat is aparently being emitted into objects by default.
> 
...
> The -fasynchronous-unwind-tables caught my eye. Leaving it out caused the
> '.rela.eh_frame' section not to be generated at all (module loads ok as well).

The -fasynchronous-unwind-tables is turned on because I had
CONFIG_UNWIND_INFO=y
set in my .config. This is in the 'kernel hacking' section, so I don't
expect it to be on by default. I'm rebuilding now with that option turned
off, which will take a while.

Seems to me modules should still load even if this option is on. I also
expect a similar patch is needed for sparc64.

Thanks,
Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>
---
--- 2.6.17-rc3/arch/sparc/kernel/module.c.orig	2006-05-11 17:21:02.000000000 +0100
+++ 2.6.17-rc3/arch/sparc/kernel/module.c	2006-05-12 13:59:25.000000000 +0100
@@ -113,6 +113,7 @@
 
 		switch (ELF32_R_TYPE(rel[i].r_info)) {
 		case R_SPARC_32:
+		case R_SPARC_UA32:	/* Like R_SPARC_32 but unaligned */
 			location[0] = v >> 24;
 			location[1] = v >> 16;
 			location[2] = v >>  8;
