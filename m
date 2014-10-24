From: David Miller <davem@davemloft.net>
Date: Fri, 24 Oct 2014 16:45:15 +0000
Subject: Re: unaligned accesses in SLAB etc.
Message-Id: <20141024.124515.201736092509249490.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141023.130258.548864295965807596.davem@davemloft.net>
	<20141023.172258.1371479087269518956.davem@davemloft.net>
	<alpine.LRH.2.11.1410241048290.15464@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410241048290.15464@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Fri, 24 Oct 2014 10:49:12 +0300 (EEST)

>> > I can reproduce and I know what the problem is, fixed patch coming up
>> > shortly.
>> 
>> Ok, please test this patch below.
> 
> Thank you, it works fine on my V210, V440 and newly added V245.

Thanks so much for testing.

I'll clean this up based upon Sam's feedback, add your Tested-by:,
and push it around.

Thanks again!
