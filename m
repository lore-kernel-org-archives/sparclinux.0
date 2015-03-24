From: David Ahern <david.ahern@oracle.com>
Date: Tue, 24 Mar 2015 01:01:55 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <5510B783.4050809@oracle.com>
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

The T5-8 is having problems; has to be unrelated to this commit. T5-2 
(256 cpus) boots fine, and make -j 256 on an allyesconfig builds fine.
