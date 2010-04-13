From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 05:08:38 +0000
Subject: Re: [PATCH 0/4]: Respin local_irq_*_nmi() stuff.
Message-Id: <20100412.220838.132238558.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100409.160132.216116766.davem@davemloft.net>
In-Reply-To: <20100409.160132.216116766.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org


I'm rescinding these patches for now, for two reasons:

1) The NMI annotations necessary to get everything working really gets
   out of control.

2) I think I found a cheap way to do this in sparc64 specific code.

Thanks!
