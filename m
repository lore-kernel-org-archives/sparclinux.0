From: David Miller <davem@davemloft.net>
Date: Thu, 05 Feb 2009 09:21:23 +0000
Subject: Re: HOLES_IN_ZONE...
Message-Id: <20090205.012123.141238531.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090204.222651.26527737.davem@davemloft.net>
	<20090205180617.8ee3dfb5.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20090205180617.8ee3dfb5.kamezawa.hiroyu@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kamezawa.hiroyu@jp.fujitsu.com
Cc: mel@csn.ul.ie, heiko.carstens@de.ibm.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Date: Thu, 5 Feb 2009 18:06:17 +0900

> @@ -2632,7 +2633,8 @@ void __meminit memmap_init_zone(unsigned
>  		if (context = MEMMAP_EARLY) {
>  			if (!early_pfn_valid(pfn))
>  				continue;
> -			if (!early_pfn_in_nid(pfn, nid))
> +			tmp = early_pfn_in_nid(pfn, nid);
> +			if (tmp > -1 && tmp != nid)

early_pfn_in_nid() returns true or false, not the found nid

I think you meant to change this to call early_pfn_to_nid()

I'll make that correction and test your patch.

BTW, if you make that conversion there is no need for
early_pfn_in_nid() since there will be no other users.
