From: Clemens Ladisch <clemens@ladisch.de>
Date: Mon, 03 Nov 2014 09:44:40 +0000
Subject: Re: [PATCH] sparc64: Add preprocessor symbols for PAGE_* pgprot_t values.
Message-Id: <54574E88.8080509@ladisch.de>
List-Id: <sparclinux.vger.kernel.org>
References: <545690D0.5040904@ladisch.de>
	<20141102.182430.2172669108987505623.davem@davemloft.net>
In-Reply-To: <20141102.182430.2172669108987505623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

David Miller wrote:
>> Kernel code assumes that the PAGE_* values are preprocessor symbols, and
>> that therefore arch support can be checked for with #ifdef.
>>
>> At the moment, sparc64 does not implement any of the symbols checked
>> for, so these checks happen to work.
>>
>> To prevent potential breakage when another #ifdef check is added or when
>> sparc64 implements another PAGE_ value, make such #ifdef checks work by
>> adding preprocessor symbols on top of the PAGE_* variables.
>>
>> Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
>
> "This change actually doesn't have any effect, and doesn't matter,
>  so let's make this change."
>
> I really don't buy this.

At the moment, sparc64 does not support symbols such as PAGE_KERNEL_RO,
and has no mechanism for arch-independent code to detect this.
Some code tries anyway:

$ git grep '#ifn\?def PAGE_KERNEL_'
drivers/base/firmware_class.c:#ifndef PAGE_KERNEL_RO
drivers/staging/comedi/comedi_buf.c:#ifdef PAGE_KERNEL_NOCACHE
mm/nommu.c:#ifndef PAGE_KERNEL_EXEC
mm/vmalloc.c:#ifndef PAGE_KERNEL_EXEC

I don't want to add more such code to the kernel without a guarantee
that it actually works, or without replacing it with some other kind
of check that does work.

> I'd also rather the kernel use Kconfig based symbols to detect for
> arch availability of feature X or Y, assuming things are CPP symbols
> is very fragile at best.

It is certainly possible to use Kconfig-based symbols.  However, this
would have its own fragility: adding, e.g., PAGE_KERNEL_SO to an arch
requires that one remembers to update Kconfig, and if one forgets,
a check like this:

#ifndef CONFIG_ARCH_HAS_PAGE_KERNEL_RO
#define PAGE_KERNEL_RO PAGE_KERNEL /* fallback for this code */
#endif

will not detect the error on sparc64 (if PAGE_KERNEL_RO were a CPP
symbol, the compiler would complain about the redefinition).

So even if PAGE_KERNEL_RO is a variable, making it into a CPP symbol
is beneficial.  And once it is a CPP symbol, introducing a separate
Kconfig-based symbol is not necessary and just increases the chances
of an error.


Regards,
Clemens
