From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 13 Apr 2010 07:48:58 +0000
Subject: Re: [PATCH 0/4]: Respin local_irq_*_nmi() stuff.
Message-Id: <1271144938.4807.925.camel@twins>
List-Id: <sparclinux.vger.kernel.org>
References: <20100409.160132.216116766.davem@davemloft.net>
	 <20100412.220838.132238558.davem@davemloft.net>
In-Reply-To: <20100412.220838.132238558.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org

On Mon, 2010-04-12 at 22:08 -0700, David Miller wrote:
> I'm rescinding these patches for now, for two reasons:
> 
> 1) The NMI annotations necessary to get everything working really gets
>    out of control.
> 
> 2) I think I found a cheap way to do this in sparc64 specific code.

Ah, ok..

Care to enlighten the curious amongst us as to what exactly you're doing
in the sparc code?
