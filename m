From: David Miller <davem@davemloft.net>
Date: Fri, 21 Dec 2007 03:15:05 +0000
Subject: Re: 2.6.24-rc5-mm1: problems with cat /proc/kpageflags
Message-Id: <20071220.191505.122863242.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200712202047.56745.m.kozlowski@tuxland.pl>
	<20071220.161726.68534356.davem@davemloft.net>
	<20071221010653.GA19691@waste.org>
In-Reply-To: <20071221010653.GA19691@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpm@selenic.com
Cc: m.kozlowski@tuxland.pl, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Matt Mackall <mpm@selenic.com>
Date: Thu, 20 Dec 2007 19:06:55 -0600

> @@ -707,7 +707,10 @@ static ssize_t kpagecount_read(struct fi
>  		return -EIO;
>  
>  	while (count > 0) {
> -		ppage = pfn_to_page(pfn++);
> +		ppage = 0;
> +		if (pfn_valid(pfn))
> +			ppage = pfn_to_page(pfn);
> +		pfn++;
>  		if (!ppage)
>  			pcount = 0;
>  		else

Yes that should work, please use "NULL" in the final
version of the patch instead of "0" so that sparse is
happy.

Thanks.
