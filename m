From: David Miller <davem@davemloft.net>
Date: Wed, 07 May 2014 18:21:16 +0000
Subject: Re: [PATCH V2 0/11] sparc64 MM fixes
Message-Id: <20140507.142116.2023428171433533073.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140506.000802.1283819541274253321.davem@davemloft.net>
In-Reply-To: <20140506.000802.1283819541274253321.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 7 May 2014 21:19:03 +0300 (EEST)

>> > How should I continue debugging it - find the conf differences with 
>> > Debian kernel?
>> > 
>> > Or do you want my .config for U2, X1, V100?
>> 
>> I think the pattern is that the UltraSPARC-III based machines have
>> no problems, whereas the UltraSPARC-I and UltraSPARC-II based ones
>> tend to crash and hang.
> 
> With THP on, V440 survived, U5 did not survive - that matches.
> 
> E220R survived for many hours with THP off and died on first try with 
> THP on - this also matches.

Great datapoints, the bug I found is really bad as it maps both TSB
hash tables to the same exact virtual address and TLB behavior is
undefined in such situations.

> Just got the new patch, will try soon.

Thanks in advance.
