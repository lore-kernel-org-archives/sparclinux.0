From: David Miller <davem@davemloft.net>
Date: Sun, 05 Jan 2014 02:06:09 +0000
Subject: Re: [PATCH] sparc64: smp_callin: Enable irqs after preemption is disabled
Message-Id: <20140104.210609.1757163756992312674.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Thu, 12 Dec 2013 18:09:50 +0400

> Most of other architectures have below suggested order.
> So lets do the same to fit generic idle loop scheme better.
> 
> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>

Applied.
