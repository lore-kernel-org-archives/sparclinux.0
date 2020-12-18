From: Jan Engelhardt <jengelh@inai.de>
Date: Fri, 18 Dec 2020 18:52:08 +0000
Subject: Re: [PATCH v1 01/13] sparc32: Drop sun4m/sun4d support from head_32.S
Message-Id: <sq2nqr43-21s-21sn-219r-9o83o310r5s9@vanv.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org> <20201218184347.2180772-2-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-2-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org, gentoo-sparc@l.g.o


On Friday 2020-12-18 19:43, Sam Ravnborg wrote:
> notsup:
>-	.asciz	"Sparc-Linux sun4/sun4c or MMU-less not supported\n\n"
>-	.align 4
>-
>-sun4e_notsup:
>-        .asciz  "Sparc-Linux sun4e support does not exist\n\n"
>+	.asciz	"Sparc-Linux sun4* or MMU-less not supported\n\n"
> 	.align 4

The asterisk may lead to a moment of bewilderment; sun4u/sun4v are still 
supported.
