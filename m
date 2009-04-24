From: David Miller <davem@davemloft.net>
Date: Fri, 24 Apr 2009 12:55:47 +0000
Subject: Re: [patch] Niagara1 Perfcounter Accesses
Message-Id: <20090424.055547.169422830.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0904221537190.12401@pianoman.cluster.toy>
In-Reply-To: <Pine.LNX.4.64.0904221537190.12401@pianoman.cluster.toy>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 22 Apr 2009 23:11:03 -0700 (PDT)

> From: Vince Weaver <vince@deater.net>
> Date: Wed, 22 Apr 2009 15:40:42 -0400 (EDT)
> 
>> Add proper Niagara1 perfcounter accesses.
>> 
>> When trying to track down the hang-on-boot NMI problem on my
>> T1 system, I noticed that Niagara2 performance counter accesses
>> were being done, even though I only have a Niagara1 system.
>> This means "undefined" bits were being written to in the
>> performance counter register.

Vince can you describe this problem?

I'm trying to reproduce this on my t1000 with the current
kernel sources and it works just fine.
