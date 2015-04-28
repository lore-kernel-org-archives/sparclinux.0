From: Rusty Russell <rusty@rustcorp.com.au>
Date: Tue, 28 Apr 2015 12:36:15 +0000
Subject: Re: Build regressions/improvements in v4.1-rc1
Message-Id: <87pp6osaog.fsf@rustcorp.com.au>
List-Id: <sparclinux.vger.kernel.org>
References: <1430128286-8952-1-git-send-email-geert@linux-m68k.org> <CAMuHMdWoUPZ92GX9fe8eq87buLQOT9GMb6Ru3_bQJpkZTFph0g@mail.gmail.com> <871tj4uara.fsf@rustcorp.com.au> <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWj=khxL5dw=O3ymdTE+kBfxa0-gFKZ-ngQ-x4Fzzav1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, sparclinux <sparclinux@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Matthew Wilcox <willy@linux.intel.com>

Geert Uytterhoeven <geert@linux-m68k.org> writes:
>> Can't see that one with a simple grep: can you post warning?
>
> /home/kisskb/slave/src/arch/tile/kernel/setup.c: In function 'zone_sizes_init':
> /home/kisskb/slave/src/arch/tile/kernel/setup.c:777:3: warning:
> passing argument 2 of 'cpumask_test_cpu' from incompatible pointer
> type [enabled by default]
> /home/kisskb/slave/src/include/linux/cpumask.h:294:19: note: expected
> 'const struct cpumask *' but argument is of type 'struct nodemask_t *'

Um, I turned the cpu_isset() into cpumask_test_cpu(), but that just
showed this bug up.  The tile maintainers need to fix this one.

Thanks,
Rusty.
