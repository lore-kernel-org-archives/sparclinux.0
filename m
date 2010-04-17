From: David Miller <davem@davemloft.net>
Date: Sat, 17 Apr 2010 21:29:06 +0000
Subject: Re: [PATCH 7/7] sparc64: Add function graph tracer support.
Message-Id: <20100417.142906.24235257.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100412.234300.212396783.davem@davemloft.net>
In-Reply-To: <20100412.234300.212396783.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frederic Weisbecker <fweisbec@gmail.com>
Date: Sat, 17 Apr 2010 19:22:21 +0200

> I tested the following patch and it fixes the issue after several
> manual loops of:

Wait, this is completely normal.

NMIs can come in at any time and nmi_enter() emits a trace via the
rcu_nmi_enter().

This happens on x86 too.
