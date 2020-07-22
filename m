From: David Miller <davem@davemloft.net>
Date: Wed, 22 Jul 2020 01:29:30 +0000
Subject: Re: [PATCH 1/2] sparc64: Deselect IRQ_PREFLOW_FASTEOI
Message-Id: <20200721.182930.2286555697760796633.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20200703155645.29703-1-valentin.schneider@arm.com>
        <20200703155645.29703-2-valentin.schneider@arm.com>
In-Reply-To: <20200703155645.29703-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: valentin.schneider@arm.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org

From: Valentin Schneider <valentin.schneider@arm.com>
Date: Fri,  3 Jul 2020 16:56:44 +0100

> sparc64 hasn't needed to select this since commit:
> 
>   ee6a9333fa58 ("sparc64: sparse irq")
> 
> which got rid of the calls to __irq_set_preflow_handler() first installed
> by commit:
> 
>   fcd8d4f49869 ("sparc: Use the new genirq functionality")
> 
> Deselect this option.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>
