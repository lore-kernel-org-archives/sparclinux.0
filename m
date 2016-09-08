From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 08 Sep 2016 18:19:05 +0000
Subject: Re: [PATCH] atomic64: No need for CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
Message-Id: <20160908181905.GY10153@twins.programming.kicks-ass.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
In-Reply-To: <1473352098-5822-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-mips@linux-mips.org, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "James  E.J. Bottomley" <jejb@parisc-linux.org>, Paul Mackerras <paulus@samba.org>, "H.  Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Matthew Wilcox <willy@linux.intel.com>, Matt Turner <mattst88@gmail.com>, Borislav Petkov <bp@suse.de>, Ming Lin <ming.l@ssi.samsung.com>, Chris

On Thu, Sep 08, 2016 at 09:28:18AM -0700, Vineet Gupta wrote:
> This came to light when implementing native 64-bit atomics for ARCv2.
> 
> The atomic64 self-test code uses CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
> to check whether atomic64_dec_if_positive() is available.
> It seems it was needed when not every arch defined it.
> However as of current code the Kconfig option seems needless
> 
> - for CONFIG_GENERIC_ATOMIC64 it is auto-enabled in lib/Kconfig and a
>   generic definition of API is present lib/atomic64.c
> - arches with native 64-bit atomics select it in arch/*/Kconfig and
>   define the API in their headers
> 
> So I see no point in keeping the Kconfig option
> 
> Compile tested for 2 representatives:
>  - blackfin (CONFIG_GENERIC_ATOMIC64)
>  - x86 (!CONFIG_GENERIC_ATOMIC64)
> 
> Also logistics wise it seemed simpler to just do this in 1 patch vs.
> splitting per arch - but I can break it up if maintainer feel that
> is better to avoid conflicts.

Works for me; you want me to take this, or do you need it for you ARCv2
patches?
