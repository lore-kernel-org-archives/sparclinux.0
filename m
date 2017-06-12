From: David Miller <davem@davemloft.net>
Date: Mon, 12 Jun 2017 20:01:47 +0000
Subject: Re: [v2 4/8] sparc64: optimize loads in clock_sched()
Message-Id: <20170612.160147.1388489065444968967.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1497286107-974183-5-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497286107-974183-5-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Mon, 12 Jun 2017 15:55:44 -0400

> Thank you for your comments:
> 
> When I use __cacheline_aligned instead of __aligned(64) I am getting
> the following error:
> 
> error: section of 'tick_operations' conflicts with previous
> declaration
> 
> The __section__ difference causes the issue:
> 
> __cacheline_aligned= __attribute__((__aligned__((1 << 6)),
> __section__(".data..cacheline_aligned")))
> 
> vs
> 
> __aligned(64) = __attribute__((aligned(64)))

Perhaps get rid of the __read_mostly.
