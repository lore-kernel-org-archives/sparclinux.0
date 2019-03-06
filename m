From: David Miller <davem@davemloft.net>
Date: Wed, 06 Mar 2019 19:04:36 +0000
Subject: Re: [PATCH v5 2/4] sparc: Advertise gigantic page support
Message-Id: <20190306.110436.1714716608828903522.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190306190005.7036-1-alex@ghiti.fr>
 <20190306190005.7036-3-alex@ghiti.fr>
In-Reply-To: <20190306190005.7036-3-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alex@ghiti.fr
Cc: dalias@libc.org, linux-sh@vger.kernel.org, peterz@infradead.org, benh@kernel.crashing.org, dave.hansen@linux.intel.com, heiko.carstens@de.ibm.com, linux-mm@kvack.org, paulus@samba.org, hpa@zytor.com, sparclinux@vger.kernel.org, linux-s390@vger.kernel.org, ysato@users.sourceforge.jp, mpe@ellerman.id.au, x86@kernel.org, mingo@redhat.com, vbabka@suse.cz, catalin.marinas@arm.com, will.deacon@arm.com, bp@alien8.de, luto@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org, mike.kravetz@oracle.com

From: Alexandre Ghiti <alex@ghiti.fr>
Date: Wed,  6 Mar 2019 14:00:03 -0500

> sparc actually supports gigantic pages and selecting
> ARCH_HAS_GIGANTIC_PAGE allows it to allocate and free
> gigantic pages at runtime.
> 
> sparc allows configuration such as huge pages of 16GB,
> pages of 8KB and MAX_ORDER = 13 (default):
> HPAGE_SHIFT (34) - PAGE_SHIFT (13) = 21 >= MAX_ORDER (13)
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Much better.

Acked-by: David S. Miller <davem@davemloft.net>
