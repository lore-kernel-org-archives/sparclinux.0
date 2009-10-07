From: David Miller <davem@davemloft.net>
Date: Wed, 07 Oct 2009 12:01:45 +0000
Subject: Re: nocache/highmem mapping
Message-Id: <20091007.050145.04854422.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4ACB63BC.90200@gaisler.com>
In-Reply-To: <4ACB63BC.90200@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 06 Oct 2009 17:35:24 +0200

> Here is what we digged out:
> The virtual address regions with 512 MB ram and
> #define SRMMU_MAX_NOCACHE_PAGES	(1280)
> are:
> 
> 0xfc0000000 - 0xfc5000000 : nocache mem
> 0xfc5000000 - 0xfc9000000 : highmem
> 
> however srmmu_nocache_init()->srmmu_early_allocate_ptable_skeleton()
> initializes the the page skelleton in steps of:
>                 ...
> 	while(start < end) {
>                 ...
> 		start = (start + PMD_SIZE) & PMD_MASK;
>         }
>                 ...
> 
> PMD_SIZE is 0x4000000, that means it will will initilize
> 
> 0xfc0000000 - 0xfc4000000 and
> 0xfc4000000 - 0xfc8000000
> before it breaks.

I think you have found a genuine bug and maybe it explains
bugs others have run into over the past few years :-)

I'll do some more research on this tomorrow and apply some
kind of fix.

Thanks!
