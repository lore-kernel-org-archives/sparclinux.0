From: David Miller <davem@davemloft.net>
Date: Tue, 23 Feb 2016 22:59:01 +0000
Subject: Re: Invalid sk_policy[] access
Message-Id: <20160223.175901.15624631458340642.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160223.152045.440181358695767083.davem@davemloft.net>
	<20160223202901.GC4941@oracle.com>
	<alpine.LRH.2.20.1602232250000.30129@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1602232250000.30129@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sowmini.varadhan@oracle.com, sparclinux@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org

From: mroos@linux.ee
Date: Tue, 23 Feb 2016 22:51:01 +0200 (EET)

>> > Indeed, the kernel is 64-bit in both cases.
>> > And the userland bit-arity has no relevance whatsoever for this bug.
>> 
>> hang on; The sizeof (and offsetof) values I listed were obtained either
>> from /usr/bin/crash (on the T5) or from simple printk's of the structures
>> in the case of the v440. And they *are* different, and the numbers
> 
> Since there are no config-dependent difference in the struct, maybe it's 
> a compiler version difference for padding/optimization instead?

Changing the layout of a structure would break ABI, so unlikely.

I've never used crash, so I have no idea where it gets it's
information from nor how it interprets it.

