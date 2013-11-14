From: David Miller <davem@davemloft.net>
Date: Thu, 14 Nov 2013 22:59:19 +0000
Subject: Re: [PATCH 1/2] sparc64: Add self-IPI support for smp_send_reschedule()
Message-Id: <20131114.175919.2281919192963478274.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Sat, 14 Sep 2013 16:00:09 +0400

> CONFIG_NO_HZ_FULL requires possibility of smp_send_reschedule()
> for the calling CPU. Currently, it is used in inc_nr_running()
> scheduler primitive only.
>     
> Nobody calls smp_send_reschedule() from preemptible context
> (furthermore, it looks like it will be save if anybody use it
> another way in the future). But anyway I add WARN_ON() here
> just to return here if anything changes.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied.
