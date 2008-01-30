From: Ingo Molnar <mingo@elte.hu>
Date: Wed, 30 Jan 2008 16:10:36 +0000
Subject: Re: x86/non-x86: percpu, node ids, apic ids x86.git fixup
Message-Id: <20080130161036.GA12293@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <200801301414.m0UEEgCC006371@hera.kernel.org>
	<Pine.LNX.4.64.0801301622460.11859@vixen.sonytel.be>
	<47A09F8A.3000309@sgi.com>
In-Reply-To: <47A09F8A.3000309@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Travis <travis@sgi.com>
Cc: sparclinux@vger.kernel.org, linux-ia64@vger.kernel.org, Linux Kernel Development <linux-kernel@vger.kernel.org>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>


* Mike Travis <travis@sgi.com> wrote:

> > This broke powerpc (and presumably ia64 and sparc64) in current 
> > linux-2.6.git:
> 
> I'm generating a "fixup patch" right now...

thanks! Sorry about that: we cross-built on ARM but not on SMP non-x86 
platforms so this dependency/breakage went unnoticed.

	Ingo
