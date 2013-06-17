From: David Miller <davem@davemloft.net>
Date: Mon, 17 Jun 2013 06:53:19 +0000
Subject: Re: [PATCH] sparc32, leon: Enable interrupts before going idle to avoid getting stuck
Message-Id: <20130616.235319.1183232347206820359.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1370847401-766-1-git-send-email-andreas@gaisler.com>
In-Reply-To: <1370847401-766-1-git-send-email-andreas@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 17 Jun 2013 08:13:41 +0200

> On 2013-06-10 08:56, Andreas Larsson wrote:
>> This enables interrupts for Leon before having the CPU enter
>> power-down mode.
>>
>> Commit 87fa05aeb3a5e8e21b1a5510eef6983650eff092, "sparc: Use generic
>> idle loop",
>> gets the CPU stuck on idle for Leon systems. On Leon, disabling
>> interrupts and
>> powering down the processor will get the processor stuck waiting for
>> an
>> interrupt that will never be reacted to.
> 
> Anything stopping this from going into v3.10-rc7? The issue is
> critical. Commit 87fa05aeb3a5e8e21b1a5510eef6983650eff092 outright
> breaks the kernel for Leon systems.

I'm just backlogged, I'll take care of this tomorrow.

Thanks.
