From: David Miller <davem@davemloft.net>
Date: Sun, 19 Oct 2014 17:27:37 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141019.132737.1392053813844289431.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141018.135907.356113264227709132.davem@davemloft.net>
	<20141018.142335.1935310766779155342.davem@davemloft.net>
	<20141019153219.GA10644@ravnborg.org>
In-Reply-To: <20141019153219.GA10644@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: mroos@linux.ee, iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 19 Oct 2014 17:32:20 +0200

> This part:
> 
>> +		__attribute__ ((aligned(64)));
> 
> Could be written as __aligned(64)

I'll try to remember to sweep this up in sparc-next, thanks Sam.

We probably use this long-hand form in a lot of other places in
the sparc code too, so I'll try to do a full sweep.

Thanks again.

