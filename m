From: David Miller <davem@davemloft.net>
Date: Sat, 03 Aug 2013 00:29:56 +0000
Subject: Re: [PATCH 1/2]sparc64: Fix ITLB handler of null page
Message-Id: <20130802.172956.13504305460016680.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1329021375456998@web27d.yandex.ru>
In-Reply-To: <1329021375456998@web27d.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 02 Aug 2013 19:23:18 +0400

> 1)Use kvmap_itlb_longpath instead of kvmap_dtlb_longpath.
> 
> 2)Handle page #0 only, don't handle page #1: bleu -> blu
> 
>  (KERNBASE is 0x400000, so #1 does not exist too. But everything
>   is possible in the future. Fix to not to have problems later.)
> 
> 3)Remove unused kvmap_itlb_nonlinear.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Looks good, applied, thanks.
