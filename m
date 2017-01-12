From: David Miller <davem@davemloft.net>
Date: Thu, 12 Jan 2017 20:39:29 +0000
Subject: Re: [PATCH] tcp: fix tcp_fastopen unaligned access complaints on sparc
Message-Id: <20170112.153929.270105303415628819.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1484252011.13165.0.camel@edumazet-glaptop3.roam.corp.google.com>
        <cd152a9f-4855-a552-2b45-bd619436a628@oracle.com>
        <1484252733.13165.1.camel@edumazet-glaptop3.roam.corp.google.com>
In-Reply-To: <1484252733.13165.1.camel@edumazet-glaptop3.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.dumazet@gmail.com
Cc: rob.gardner@oracle.com, shannon.nelson@oracle.com, netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 12 Jan 2017 12:25:33 -0800

> On Thu, 2017-01-12 at 13:15 -0700, Rob Gardner wrote:
> 
>> 
>> I suspect that someplace, somebody is casting val to an int * or 
>> something like that.
> 
> Then that would be the bug. Can we root cause this please ?

The three accesses to foc->val are via function calls, at least when I
try to build it, one via memcmp(), one via memcpy() (for the structure
assignment at the end of the function) and one via a call into the
crypto layer when we do tcp_fastopen_cookie_gen).

So if the PC is inside of tcp_try_fastopen() it has to be something
else, or something specific to your gcc and build.

