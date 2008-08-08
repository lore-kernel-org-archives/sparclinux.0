From: David Miller <davem@davemloft.net>
Date: Fri, 08 Aug 2008 23:17:28 +0000
Subject: Re: 2.6.26-rc: SPARC: Sun Ultra 10 can not boot
Message-Id: <20080808.161728.186692077.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670808080356r6573102am8a1eb9dcc83910c8@mail.gmail.com>
	<20080808.041814.41687650.davem@davemloft.net>
	<a4423d670808080452u2833418agc8027dfc33c9bb18@mail.gmail.com>
In-Reply-To: <a4423d670808080452u2833418agc8027dfc33c9bb18@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: a.beregalov@gmail.com
Cc: mikpe@it.uu.se, kernel-testers@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander Beregalov" <a.beregalov@gmail.com>
Date: Fri, 8 Aug 2008 15:52:53 +0400

> Now I see call trace:
> __free_pages_ok
> __free_pages
> __free_pages_bootmem
> free_all_bootmem_core
> free_all_bootmem
> mem_init
> start_kernel
> tlb_fixup_done
> 
> Can it be helpful?

This is probably a different bug than the one I fixed, we'll have
to analyze this somehow.

I'll cook up a patch that will let you see the crash without it
scrolling off the screen.
