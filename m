From: David Miller <davem@davemloft.net>
Date: Fri, 02 May 2014 05:15:51 +0000
Subject: Re: [PATCH] sparc64: Make itc_sync_lock raw
Message-Id: <20140502.011551.1886985569912924230.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 17 Apr 2014 00:45:24 +0400

> One more place where we must not be able
> to be preempted or to be interrupted in RT.
> 
> Always actually disable interrupts during
> synchronization cycle.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied, thanks Kirill.
