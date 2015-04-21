From: David Miller <davem@davemloft.net>
Date: Tue, 21 Apr 2015 18:33:52 +0000
Subject: Re: [PATCH v3] sparc64: Setup sysfs to mark LDOM sockets, cores and threads correctly
Message-Id: <20150421.143352.745548640287588790.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
In-Reply-To: <5526cf9b.DFcVpFfcq8CBXHg7%chris.hyser@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: chris hyser <chris.hyser@oracle.com>
Date: Tue, 21 Apr 2015 14:25:40 -0400

> On 4/16/2015 3:41 PM, David Miller wrote:
>> From: David Miller <davem@davemloft.net>
>> Date: Thu, 09 Apr 2015 19:06:47 -0400 (EDT)
>>> How will this work on T3, T2, and T1 which all neither have the
>>> "socket" mdesc nodes nor level 3 caches?
>>
>> I'm still waiting for you to resolve this Chris.
>>
>> I don't think it's much effort to make this change back down
>> to using the level=2 cache if no level=3 cache is found.  Please
>> implement that and resubmit.
> 
> So that does appear to work. This is not the patch. I will send that
> out shortly but I thought I'd give you a chance to provide feedback
> while I'm getting that ready.
> 
> Here is what I see on a T2.
 ...
> Diff from the prior patch (I also see some cleanup here I will do):

Yeah that should work just as well on T3 too.

BTW, there are mdesc dumps in my prtconfs repo that you can use
for reference when working on things that walk the mdesc graph.
