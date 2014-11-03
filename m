From: David Miller <davem@davemloft.net>
Date: Mon, 03 Nov 2014 16:29:47 +0000
Subject: Re: [PATCH] sparc64: Add preprocessor symbols for PAGE_* pgprot_t values.
Message-Id: <20141103.112947.963725164144191898.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <545690D0.5040904@ladisch.de>
	<20141102.182430.2172669108987505623.davem@davemloft.net>
	<54574E88.8080509@ladisch.de>
In-Reply-To: <54574E88.8080509@ladisch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: clemens@ladisch.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Clemens Ladisch <clemens@ladisch.de>
Date: Mon, 03 Nov 2014 10:44:40 +0100

> David Miller wrote:
>> I'd also rather the kernel use Kconfig based symbols to detect for
>> arch availability of feature X or Y, assuming things are CPP symbols
>> is very fragile at best.
> 
> It is certainly possible to use Kconfig-based symbols.  However, this
> would have its own fragility: adding, e.g., PAGE_KERNEL_SO to an arch
> requires that one remembers to update Kconfig, and if one forgets,
> a check like this:
> 
> #ifndef CONFIG_ARCH_HAS_PAGE_KERNEL_RO
> #define PAGE_KERNEL_RO PAGE_KERNEL /* fallback for this code */
> #endif
> 
> will not detect the error on sparc64 (if PAGE_KERNEL_RO were a CPP
> symbol, the compiler would complain about the redefinition).
> 
> So even if PAGE_KERNEL_RO is a variable, making it into a CPP symbol
> is beneficial.  And once it is a CPP symbol, introducing a separate
> Kconfig-based symbol is not necessary and just increases the chances
> of an error.

I'd rather code then use the symbol unconditionally, and we declare that
it's something every architecture must provide in some shape or form.

This CPP check business is fragile as hell and I'm not going to promote
it in the architectures I maintainer by applying patches like your's.

Sorry.
