From: David Miller <davem@davemloft.net>
Date: Thu, 17 Nov 2016 18:39:12 +0000
Subject: Re: [PATCH 17/20] sparc/sysfs: Convert to hotplug state machine
Message-Id: <20161117.133912.2297219337116639987.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
        <20161117183541.8588-18-bigeasy@linutronix.de>
In-Reply-To: <20161117183541.8588-18-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bigeasy@linutronix.de
Cc: linux-kernel@vger.kernel.org, rt@linuxtronix.de, sparclinux@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Thu, 17 Nov 2016 19:35:38 +0100

> Install the callbacks via the state machine and let the core invoke
> the callbacks on the already online CPUs.
> 
> The previous convention of keeping the files around until the CPU is dead
> has not been preserved as there is no point to keep them available when the
> cpu is going down. This makes the hotplug call symmetric.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
