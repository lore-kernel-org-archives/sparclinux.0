From: David Miller <davem@davemloft.net>
Date: Fri, 26 Sep 2014 23:18:03 +0000
Subject: Re: [PATCH 0/6] sparc64: MM/IRQ patch queue.
Message-Id: <20140926.191803.927164780349371155.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140925.154047.2222645314356554322.davem@davemloft.net>
In-Reply-To: <20140925.154047.2222645314356554322.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Fri, 26 Sep 2014 16:41:37 -0400 (EDT)

> From: Bob Picco <bpicco@meloft.net>
> Date: Fri, 26 Sep 2014 16:04:18 -0400
> 
>> This should provide you sufficient data to arrive at an initial vmalloc size
>> for percpu. I'll eventually examine my T5-8 information too. Hm, just did
>> quickly:
>> PERCPU: max_distance=0x380001c10000 too large for vmalloc space 0xff00000000
>> . Note I haven't considered impact of this in quite a bit.
> 
> Thanks, several things certainly are not happy.
> 
> I'll take a look, thanks Bob.

Bob can I see the 'memory' OF node on the machine where this happens?

Thanks.
