From: David Miller <davem@davemloft.net>
Date: Wed, 20 Apr 2011 08:15:54 +0000
Subject: Re: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <20110420.011554.71130177.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 20 Apr 2011 10:12:25 +0200

> Sorry I meant the UP 32-bit SUNs, some if not all SMP 32-bit SUNs
> apparently use the boot_cpu_id Sam is talking about. Have you tried
> booting on CPU1 with a UP Linux kernel on the SS1000 machine?

Regardless, we should make it work.

It was terrible when I had to fix this on sparc64.
