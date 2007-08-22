From: David Miller <davem@davemloft.net>
Date: Wed, 22 Aug 2007 03:47:59 +0000
Subject: Re: Problems of PREFETCH instruction on UltraSparc T1
Message-Id: <20070821.204759.118949902.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708211701j47e6246eu57147ab1ab55e397@mail.gmail.com>
In-Reply-To: <a8e8903d0708211701j47e6246eu57147ab1ab55e397@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Wed, 22 Aug 2007 12:01:19 +1200

> I don't really know if it is proper to post this topic here.
> 
> In order to accelerate our applications, I adopted the PREFETCH
> instruction of UltraSparc. However, the results are not expected: the
> one with prefetch works even a little bit slower. The whole program is
> listed below.

Different processors can only have so many prefetches in flight at a
time.  If you perform too many, they will only consume cpu cycles.

UltraSPARC-I does not implement prefetch at all, and it just takes up
an instruction issue slot.

UltraSPARC-II, IIi and IIe implement prefetch, with up to 3 in flight,
but they has several limitations and the prefetches are not as
effective as they could be.

UltraSPARC-III and IIIi can have up to 5 prefetches in flight and
implements it very well.

Niagara 1 and 2 can have up to about 3 prefetches in flight and it
implements this reasonable well.

Also, prefetches only help if there is a large amount of
time between the prefetch and the actual access of the
data.

So what a loop will usually do is queue up a few prefetches
before the loop, perhaps forward about 2 or 3 cachelines,
and then the loop will end with a single prefetch that same
number of cachelines forward.  See my suggested loop below.

==========
                        for(j=0;j<100;j++) foo+=j; //do some trivial
things to pass time
==========

Since you don't really use foo or bar, the compiler can see that
this loop does nothing, so it will be eliminated, at least by
more recent versions of gcc.

Also you are doing worthless prefetches, as the cacheline size
is 64 bytes, so doing 16-byte offset prefetches accomplishes
nothing.

Reconstruct your loop as follows:

	prefetch	buffer + (0 * 64)
	prefetch	buffer + (1 * 64)
	prefetch	buffer + (2 * 64)
	while (buf < lastone) {
		*buf = i;
		*(buf+16)=i;
                *(buf+32)=i;
                *(buf+48)=i;
		buf += 64;
		prefetch	buffer + (2 * 64);
	}

This should work significantly better than what your code
is doing right now.
