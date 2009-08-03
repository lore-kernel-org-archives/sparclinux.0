From: David Miller <davem@davemloft.net>
Date: Mon, 03 Aug 2009 04:46:38 +0000
Subject: Re: is there still value to references to EXPORT_SYMTAB_STROPS?
Message-Id: <20090802.214638.12490136.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Mon, 6 Jul 2009 05:40:11 -0400 (EDT)

>   during one of my tree cleaning scans, i ran across the following:
> 
> $ grep -rw EXPORT_SYMTAB_STROPS *
> arch/sparc/include/asm/string_64.h:#ifndef EXPORT_SYMTAB_STROPS
> arch/sparc/include/asm/string_64.h:#endif /* !EXPORT_SYMTAB_STROPS */
> arch/sparc/include/asm/string_32.h:#ifndef EXPORT_SYMTAB_STROPS
> arch/sparc/include/asm/string_32.h:#endif /* !EXPORT_SYMTAB_STROPS */
> arch/sparc/lib/ksyms.c:#define EXPORT_SYMTAB_STROPS
> $
> 
>   given that EXPORT_SYMTAB was removed from the kernel tree quite some
> time back, is this related macro still doing anything useful?  just
> asking.

It's only used by sparc so that it can export symbols like
memcpy(), memset() et al. properly

Without this ifdef protection while building ksyms.c, string*.h will
define these functions as macros, and that makes things like:

EXPORT_SYMBOL(memcpy)

and similar not work because memcpy will macro expand and thus
break the build with syntax errors.
