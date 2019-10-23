From: David Miller <davem@davemloft.net>
Date: Wed, 23 Oct 2019 21:21:33 +0000
Subject: Re: [PATCH v2 09/12] sparc32: use pgtable-nopud instead of 4level-fixup
Message-Id: <20191023.142133.1980049426362664052.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1571822941-29776-1-git-send-email-rppt@kernel.org>
        <1571822941-29776-10-git-send-email-rppt@kernel.org>
        <20191023195859.GA24394@rapoport-lnx>
In-Reply-To: <20191023195859.GA24394@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rppt@kernel.org
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, anton.ivanov@cambridgegreys.com, arnd@arndb.de, geert@linux-m68k.org, green.hu@gmail.com, gerg@linux-m68k.org, deller@gmx.de, James.Bottomley@HansenPartnership.com, jdike@addtoit.com, kirill@shutemov.name, torvalds@linux-foundation.org, msalter@redhat.com, mattst88@gmail.com, monstr@monstr.eu, richard@nod.at, linux@armlinux.org.uk, sammy@sammy.net, deanbo422@gmail.com, Vineet.Gupta1@synopsys.com, linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org, linux-um@lists.infradead.org, sparclinux@vger.kernel.org, rppt@linux.ibm.com

From: Mike Rapoport <rppt@kernel.org>
Date: Wed, 23 Oct 2019 22:59:00 +0300

> I've just discovered that I've booted qemu-sparc with the wrong kernel and
> this patch crashes miserably :(
> 
> The better version that does allow qemu-sparc to boot with folded page
> tables is below:
> 
> 
> From a90e1d157b7f8786a4276ffc8553f2167c8bc0e7 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.ibm.com>
> Date: Tue, 1 Oct 2019 17:14:38 +0300
> Subject: [PATCH v2] sparc32: use pgtable-nopud instead of 4level-fixup
> 
> 32-bit version of sparc has three-level page tables and can use
> pgtable-nopud and folding of the upper layers.
> 
> Replace usage of include/asm-generic/4level-fixup.h with
> include/asm-generic/pgtable-nopud.h and adjust page table manipulation
> macros and functions accordingly.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David S. Miller <davem@davemloft.net>
