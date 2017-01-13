From: David Miller <davem@davemloft.net>
Date: Fri, 13 Jan 2017 17:31:53 +0000
Subject: Re: [PATCH v2] tcp: fix tcp_fastopen unaligned access complaints on sparc
Message-Id: <20170113.123153.1102439896232313596.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1484259898-30719-1-git-send-email-shannon.nelson@oracle.com>
In-Reply-To: <1484259898-30719-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: shannon.nelson@oracle.com
Cc: netdev@vger.kernel.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, eric.dumazet@gmail.com, rob.gardner@oracle.com

From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 12 Jan 2017 14:24:58 -0800

> Fix up a data alignment issue on sparc by swapping the order
> of the cookie byte array field with the length field in
> struct tcp_fastopen_cookie, and making it a proper union
> to clean up the typecasting.
> 
> This addresses log complaints like these:
>     log_unaligned: 113 callbacks suppressed
>     Kernel unaligned access at TPC[976490] tcp_try_fastopen+0x2d0/0x360
>     Kernel unaligned access at TPC[9764ac] tcp_try_fastopen+0x2ec/0x360
>     Kernel unaligned access at TPC[9764c8] tcp_try_fastopen+0x308/0x360
>     Kernel unaligned access at TPC[9764e4] tcp_try_fastopen+0x324/0x360
>     Kernel unaligned access at TPC[976490] tcp_try_fastopen+0x2d0/0x360
> 
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
> v2: Use Eric's suggestion for a union in the struct

Applied and queued up for -stable, thanks.
