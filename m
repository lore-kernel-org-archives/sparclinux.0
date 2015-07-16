From: David Miller <davem@davemloft.net>
Date: Thu, 16 Jul 2015 18:13:20 +0000
Subject: Re: [PATCH 17/23] sparc/time: Migrate to new 'set-state' interface
Message-Id: <20150716.111320.2166392647435701190.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1437044517.git.viresh.kumar@linaro.org>
	<cover.1437044517.git.viresh.kumar@linaro.org>
	<6ec789f9988fac66caedf10f065072ed0047dd38.1437044518.git.viresh.kumar@linaro.org>
In-Reply-To: <6ec789f9988fac66caedf10f065072ed0047dd38.1437044518.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viresh.kumar@linaro.org
Cc: tglx@linutronix.de, daniel.lezcano@linaro.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, alexandre.belloni@free-electrons.com, cl@linux.com, mingo@kernel.org, john.stultz@linaro.org, rusty@rustcorp.com.au, tj@kernel.org, wsa@the-dreams.de, pang.xunlei@linaro.org

From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 16 Jul 2015 16:56:29 +0530

> Migrate sparc drivers to the new 'set-state' interface provided by
> clockevents core, the earlier 'set-mode' interface is marked obsolete
> now.
> 
> This also enables us to implement callbacks for new states of clockevent
> devices, for example: ONESHOT_STOPPED.
> 
> We weren't doing anything which switching to few clockevent modes and so
> their callbacks aren't implemented.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: David S. Miller <davem@davemloft.net>
