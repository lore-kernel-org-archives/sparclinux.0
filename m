From: David Ahern <david.ahern@oracle.com>
Date: Mon, 23 Mar 2015 19:58:50 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <5510707A.2090509@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150322.221906.1670737065885267482.davem@davemloft.net>	<20150323.122530.812870422534676208.davem@davemloft.net>	<55104EAA.4060607@oracle.com> <20150323.153537.1167433221134028872.davem@davemloft.net>
In-Reply-To: <20150323.153537.1167433221134028872.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpicco@meloft.net

On 3/23/15 1:35 PM, David Miller wrote:
> From: David Ahern <david.ahern@oracle.com>
> Date: Mon, 23 Mar 2015 11:34:34 -0600
>
>> seems like a formality at this point, but this resolves the panic on
>> the M7-based ldom and baremetal. The T5-8 failed to boot, but it could
>> be a different problem.
>
> Specifically, does the T5-8 boot without my patch applied?
>

I am running around in circles with it... it takes 15 minutes after a 
hard reset to get logged in, and I forgot that the 2.6.39 can't handle 
-j 1024 either (task scheduler problem), and then I wasted time waiting 
for sandwich shop to learn how to use mobile app ordering, ...

I'll respond as soon as I can.
