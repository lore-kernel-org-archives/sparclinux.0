From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Mon, 27 Apr 2015 17:36:44 +0000
Subject: Re: Build regressions/improvements in v4.1-rc1
Message-Id: <20150427173644.GA595@fuloong-minipc.musicnaut.iki.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
In-Reply-To: <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Rusty Russell <rusty@rustcorp.com.au>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, sparclinux <sparclinux@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Matthew Wilcox <willy@linux.intel.com>

Hi,

On Mon, Apr 27, 2015 at 12:03:32PM +0200, Geert Uytterhoeven wrote:
> > *** ERRORS ***
> >
> > 34 regressions:
> 
> The quiet days are over...
> 
> >   + /home/kisskb/slave/src/arch/mips/cavium-octeon/smp.c: error: passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 242:2
> >   + /home/kisskb/slave/src/arch/mips/kernel/process.c: error: passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 52:2
> >   + /home/kisskb/slave/src/arch/mips/kernel/smp.c: error: passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 149:2, 211:2

For these there is a fix proposal: http://patchwork.linux-mips.org/patch/9828/

A.
