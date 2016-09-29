From: David Miller <davem@davemloft.net>
Date: Thu, 29 Sep 2016 00:43:12 +0000
Subject: Re: [PATCH v2 0/2] Fixes nr_cpus bug along with irq stack bootmem allocation.
Message-Id: <20160928.204312.1907983401064189852.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1475092880-85252-1-git-send-email-atish.patra@oracle.com>
In-Reply-To: <1475092880-85252-1-git-send-email-atish.patra@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Atish Patra <atish.patra@oracle.com>
Date: Wed, 28 Sep 2016 13:01:18 -0700

> The first patch fixes a panic caused by nr_cpus boot parameter.
> In addition to that, irq stack boot memory is allocated before 
> cpu_possible_mask is modified. This can lead to wastage of boot
> memory if nr_cpus is set to a lower value. The second patch
> addresses this issue.
> 
> v1->v2:
>     Fixed compilation error in the v2 1/2 when CONFIG_SMP is not set.

Sorry, it doesn't work this way.

I've already applied your patches so you would have to send me
a relative fixup.

But I'll take care of this.
