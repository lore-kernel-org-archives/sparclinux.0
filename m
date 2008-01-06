From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 06 Jan 2008 10:15:54 +0000
Subject: Re: 2.6.24-rc6-mm1: sparc64: undefined reference to `vmemmap_table'
Message-Id: <20080106021554.752dc4b8.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20071222233056.d652743e.akpm@linux-foundation.org>
	<200801061103.04999.m.kozlowski@tuxland.pl>
In-Reply-To: <200801061103.04999.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

On Sun, 6 Jan 2008 11:03:02 +0100 Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> 	This is from allnoconfig on sparc64:
> 
>   LD      .tmp_vmlinux1
> arch/sparc64/kernel/head.o: In function `kvmap_vmemmap':
> (.text+0x34ec): undefined reference to `vmemmap_table'
> arch/sparc64/kernel/head.o: In function `kvmap_vmemmap':
> (.text+0x34f4): undefined reference to `vmemmap_table'

Happens in mainline too.  Maybe arch/sparc64/kernel/ktlb.S needs to be
taught about CONFIG_SPARSEMEM_VMEMMAP=n.  
