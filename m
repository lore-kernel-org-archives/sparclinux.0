From: Arnd Bergmann <arnd@kernel.org>
Date: Fri, 18 Dec 2020 20:57:47 +0000
Subject: Re: [PATCH v1 02/13] sparc32: Drop floppy support
Message-Id: <CAK8P3a1Q1EvvyuPNn7V7tysCDubeyYQe+Z-9dM9iu-CM3XJM8A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201218184347.2180772-3-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-3-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David S Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, Andreas Larsson <andreas@gaisler.com>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, debian-sparc@lists.debian.org

On Fri, Dec 18, 2020 at 7:43 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> LEON do not have floppy support so we can drop it
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Denis Efremov <efremov@linux.com>
> Cc: Willy Tarreau <w@1wt.eu>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: sparclinux@vger.kernel.org
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> ---
>  arch/sparc/Kconfig                 |   2 +-
>  arch/sparc/include/asm/floppy.h    | 786 ++++++++++++++++++++++++++++-
>  arch/sparc/include/asm/floppy_32.h | 393 ---------------
>  arch/sparc/include/asm/floppy_64.h | 779 ----------------------------

Rather than renaming the floppy_64.h to floppy.h, it might be easier to just
remove the #else from floppy.h, similar to what asm/adi.h does.

This might be helpful in the (unlikely) case that someone has patches for
this file and wants to rebase them.

       Arnd
