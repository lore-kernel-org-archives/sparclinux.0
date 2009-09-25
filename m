From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 25 Sep 2009 21:40:09 +0000
Subject: Re: [patch 1/1] sparc32: convert to asm-generic/hardirq.h
Message-Id: <20090925144009.85ebd328.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
In-Reply-To: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 25 Sep 2009 14:36:23 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> akpm:/usr/src/25> grep SPARC .config 
> CONFIG_SPARC=y
> # CONFIG_SPARC32 is not set
> CONFIG_SPARC64=y
> CONFIG_SPARC64_SMP=y
> CONFIG_SPARC64_PAGE_SIZE_8KB=y
> # CONFIG_SPARC64_PAGE_SIZE_64KB is not set
> CONFIG_SPARC64_PCI=y
> CONFIG_INPUT_SPARCSPKR=m
> CONFIG_SND_SPARC=y
> # Misc Linux/SPARC drivers
> 
> wtf?  How'd sparc64 get set?

hm, OK, allmodconfig sets SPARC64.  That seems wrong.

allnoconfig does not set SPARC64:

akpm:/usr/src/25> make allnoconfig
scripts/kconfig/conf -n arch/sparc/Kconfig
#
# configuration written to .config
#
akpm:/usr/src/25> grep SPARC .config 
CONFIG_SPARC=y
CONFIG_SPARC32=y
# CONFIG_SPARC64 is not set
# CONFIG_SPARC_LED is not set
# CONFIG_SPARC_LEON is not set
# Misc Linux/SPARC drivers


But with that config, init/main.o compiles OK.

