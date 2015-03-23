From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2015 02:00:24 +0000
Subject: Re: 4.0.0-rc4: panic in free_block
Message-Id: <20150322.220024.1171832215344978787.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <550F51D5.2010804@oracle.com>
	<20150322.195403.1653355516554747742.davem@davemloft.net>
	<550F5852.5020405@oracle.com>
In-Reply-To: <550F5852.5020405@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: david.ahern@oracle.com
Cc: torvalds@linux-foundation.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpicco@meloft.net

From: David Ahern <david.ahern@oracle.com>
Date: Sun, 22 Mar 2015 18:03:30 -0600

> On 3/22/15 5:54 PM, David Miller wrote:
>>> I just put it on 4.0.0-rc4 and ditto -- problem goes away, so it
>>> clearly suggests the memcpy or memmove are the root cause.
>>
>> Thanks, didn't notice that.
>>
>> So, something is amuck.
> 
> to continue to refine the problem ... I modified only the memmove
> lines (not the memcpy) and it works fine. So its the memmove.
> 
> I'm sure this will get whitespaced damaged on the copy and paste but
> to be clear this is the patch I am currently running and system is
> stable. On Friday it failed on every single; with this patch I have
> allyesconfig builds with -j 128 in a loop (clean in between) and
> nothing -- no panics.

Can you just try calling memcpy(), that should work because
I think we agree that if the memcpy() implementation copies
from low to high it should work.

I wonder if the triggering factor is configuring for a high
number of cpus.  I always have NR_CPUS8 since that's the
largest machine I have.  I'll give NR_CPUS24 a spin.

