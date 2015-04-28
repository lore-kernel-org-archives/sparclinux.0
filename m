From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2015 07:12:38 +0000
Subject: Re: Build regressions/improvements in v4.1-rc1
Message-Id: <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com>
 <871tj4uara.fsf@rustcorp.com.au>
In-Reply-To: <871tj4uara.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Mark Brown <broonie@kernel.org>, sparclinux <sparclinux@vger.kernel.org>, Matthew Wilcox <willy@linux.intel.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

On Tue, Apr 28, 2015 at 6:39 AM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>>>   + /home/kisskb/slave/src/arch/mips/cavium-octeon/smp.c: error: passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 242:2
>>>   + /home/kisskb/slave/src/arch/mips/kernel/process.c: error: passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 52:2
>>>   + /home/kisskb/slave/src/arch/mips/kernel/smp.c: error: passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 149:2, 211:2
>>>   + /home/kisskb/slave/src/arch/mips/kernel/smp.c: error: passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier from pointer target type [-Werror]:  => 221:2

> and related warnings due to lack of -Werror on

>> tilegx_defconfig
>
> Can't see that one with a simple grep: can you post warning?

/home/kisskb/slave/src/arch/tile/kernel/setup.c: In function 'zone_sizes_init':
/home/kisskb/slave/src/arch/tile/kernel/setup.c:777:3: warning:
passing argument 2 of 'cpumask_test_cpu' from incompatible pointer
type [enabled by default]
/home/kisskb/slave/src/include/linux/cpumask.h:294:19: note: expected
'const struct cpumask *' but argument is of type 'struct nodemask_t *'

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
