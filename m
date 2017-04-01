From: David Miller <davem@davemloft.net>
Date: Sat, 01 Apr 2017 19:18:50 +0000
Subject: Re: [PATCH] sparc/time: set ->min_delta_ticks and ->max_delta_ticks
Message-Id: <20170401.121850.1228750723867716615.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170326134403.16226-1-nicstange@gmail.com>
        <20170330195647.7668-1-nicstange@gmail.com>
In-Reply-To: <20170330195647.7668-1-nicstange@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: nicstange@gmail.com
Cc: john.stultz@linaro.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, sparclinux@vger.kernel.org

From: Nicolai Stange <nicstange@gmail.com>
Date: Thu, 30 Mar 2017 21:56:47 +0200

> In preparation for making the clockevents core NTP correction aware,
> all clockevent device drivers must set ->min_delta_ticks and
> ->max_delta_ticks rather than ->min_delta_ns and ->max_delta_ns: a
> clockevent device's rate is going to change dynamically and thus, the
> ratio of ns to ticks ceases to stay invariant.
> 
> Make the sparc arch's clockevent drivers initialize these fields properly.
> 
> This patch alone doesn't introduce any change in functionality as the
> clockevents core still looks exclusively at the (untouched) ->min_delta_ns
> and ->max_delta_ns. As soon as this has changed, a followup patch will
> purge the initialization of ->min_delta_ns and ->max_delta_ns from these
> drivers.
> 
> Signed-off-by: Nicolai Stange <nicstange@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
