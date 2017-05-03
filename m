From: David Miller <davem@davemloft.net>
Date: Wed, 03 May 2017 14:49:17 +0000
Subject: Re: [PATCH 4/5] sparc64: skip control packet while processing LDC RX queue
Message-Id: <20170503.104917.2288751474596504266.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jag Raman <jag.raman@oracle.com>
Date: Wed, 29 Mar 2017 17:51:45 -0400

> Skip the control-only packet while processing the RX queue, for LDC
> channels in UNRELIABLE mode.
> 
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Reviewed-by: Aaron Young <aaron.young@oracle.com>
> Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

This changes the semantics of read_nonraw().

The idea is that the caller only wants us to return if there is an
error, or actual data arrives (soon).

This is why the loop processes control packets and continues the loop.

Now, the routine can return without an error condition even if no
data is available.

I think you need to justify and explain more thoroughly this semantic
change in behavior.

