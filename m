From: David Miller <davem@davemloft.net>
Date: Sun, 19 Oct 2014 17:18:55 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141019.131855.1429160564158795766.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141018.142335.1935310766779155342.davem@davemloft.net>
	<alpine.LRH.2.11.1410191459210.32417@adalberg.ut.ee>
	<alpine.LRH.2.11.1410192011410.32417@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410192011410.32417@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: iamjoonsoo.kim@lge.com, linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org, rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 19 Oct 2014 20:12:43 +0300 (EEST)

>> > > I don't want to define the array size of the fpregs save area
>> > > explicitly and thereby placing an artificial limit there.
>> > 
>> > Nevermind, it seems we have a hard limit of 7 FPU save areas anyways.
>> > 
>> > Meelis, please try this patch:
>> 
>> Works fine with 3.17.0-09670-g0429fbc + fault patch.
>> 
>> Will try current git next to find any new problems :)
> 
> Works on all 3 machines, with latest git (only had to apply the no-ipv6 
> patch on one of them). Thank you for the good work!

Thanks for testing.

Hopefully we can kill the gcc-4.9 bug next, and then see if that
exit_mmap() crash is still happening.
