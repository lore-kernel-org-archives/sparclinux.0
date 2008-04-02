From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 02 Apr 2008 16:30:36 +0000
Subject: Re: 2.6.25-rc8-mm1 sparc64 build problem: size of array 'type name'
Message-Id: <20080402093036.5dfdf56f.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080401213214.8fbb6d6b.akpm@linux-foundation.org>
	<200804021820.13260.m.kozlowski@tuxland.pl>
In-Reply-To: <200804021820.13260.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

On Wed, 2 Apr 2008 18:20:13 +0200 Mariusz Kozlowski <m.kozlowski@tuxland.pl> wrote:

> Hello,
> 
> 	sparc64 box, gcc 4.1.2
> 
>   CC      arch/sparc64/mm/init.o
> arch/sparc64/mm/init.c: In function 'paging_init':
> arch/sparc64/mm/init.c:1303: error: size of array 'type name' is negative
> 
> and this is 
> 
> BUILD_BUG_ON(BITS_PER_LONG - NR_PAGEFLAGS != 32);

yup, thanks.  That's due to some page-flag rework in the memory management
queue.  The patches which broke mips as well.  I'm pushing cross-compilers
in Christoph's direction and hoping stuff gets fixed...
