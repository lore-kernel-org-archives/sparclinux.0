From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 12 Jan 2017 21:58:10 +0000
Subject: Re: [PATCH] tcp: fix tcp_fastopen unaligned access complaints on sparc
Message-Id: <a24f1f0e-457b-0316-b545-fe1362bd7dbe@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <131ec7b7-5b74-2545-8bf7-92812443a876@oracle.com>
 <20170112.161852.1469407145449781531.davem@davemloft.net>
 <1484256990.13165.6.camel@edumazet-glaptop3.roam.corp.google.com>
 <20170112.164731.720625943370044951.davem@davemloft.net>
In-Reply-To: <20170112.164731.720625943370044951.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, eric.dumazet@gmail.com
Cc: rob.gardner@oracle.com, netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org



On 1/12/2017 1:47 PM, David Miller wrote:
> From: Eric Dumazet <eric.dumazet@gmail.com>
> Date: Thu, 12 Jan 2017 13:36:30 -0800
>
>> val should be an union, so that proper alignment is enforced by one
>> member.
>
> Sure, annotating the type so that it is aligned correctly makes
> sense.
>

... and we should change the offending pointer assignment as well.  I 
can use this and respin a v2 if we're happy with this solution.

sln
