From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jun 2017 19:06:32 +0000
Subject: Re: [v2 4/8] sparc64: optimize loads in clock_sched()
Message-Id: <20170612.150632.730435040885064479.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497286107-974183-5-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497286107-974183-5-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 12:48:23 -0400

> @@ -164,7 +164,7 @@ static unsigned long tick_add_tick(unsigned long adj)
>  	return new_tick;
>  }
>  
> -static struct sparc64_tick_ops tick_operations __read_mostly = {
> +static struct sparc64_tick_ops tick_operations __aligned(64) __read_mostly = {

Please use __cacheline_aligned instead of "__aligned(64)"
