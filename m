From: David Miller <davem@davemloft.net>
Date: Fri, 20 Mar 2015 01:56:40 +0000
Subject: Re: [PATCH] sparc: Touch NMI watchdog when walking cpus and calling printk
Message-Id: <20150319.215640.317286230696815483.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795613-135746-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795613-135746-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Thu, 19 Mar 2015 16:06:53 -0400

> With the increase in number of CPUs calls to functions that dump
> output to console (e.g., arch_trigger_all_cpu_backtrace) can take
> a long time to complete. If IRQs are disabled eventually the NMI
> watchdog kicks in and creates more havoc. Avoid by telling the NMI
> watchdog everything is ok.
> 
> Signed-off-by: David Ahern <david.ahern@oracle.com>

Applied, thanks.
