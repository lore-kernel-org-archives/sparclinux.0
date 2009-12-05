From: David Miller <davem@davemloft.net>
Date: Sat, 05 Dec 2009 22:26:13 +0000
Subject: Re: No MC sched domains
Message-Id: <20091205.142613.102451556.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912021934420.18813@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Sat, 5 Dec 2009 19:41:59 +0100 (CET)

> Where did the NODE domain actually go, or are sched-domains limited to a 
> depth of 3?

It depends upon what config options you have enabled.

MT, SMT, and NUMA all contribute to what scheduling domain
layers get built.
