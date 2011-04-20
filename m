From: crn@post.netunix.com
Date: Wed, 20 Apr 2011 08:46:43 +0000
Subject: Re: [PATCH 6/7] sparc32,leon: operate on boot-cpu IRQ controller
Message-Id: <alpine.LNX.2.00.1104200939260.20838@post.netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
In-Reply-To: <1303229239-21551-6-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Wed, 20 Apr 2011, Daniel Hellstrom wrote:
> crn@post.netunix.com wrote:
>> On Wed, 20 Apr 2011, Daniel Hellstrom wrote:
>>>> 
>>> I agree that it would be nicer, however I think the SUNs will never be 
>>> booted on CPU1 anyway? Anyways, I think this should go into another patch 
>>> series.
>> 
>> You cannot assume this, sun4d and AFAIK all 64bit systems will boot on
>> the first non-blacklisted CPU found.
>> For example, it is perfectly OK to have no CPU present on board0 slot0
>> in which case the SS1000 will boot using CPU1.
>
> Sorry I meant the UP 32-bit SUNs, some if not all SMP 32-bit SUNs apparently 
> use the boot_cpu_id Sam is talking about. Have you tried booting on CPU1 with 
> a UP Linux kernel on the SS1000 machine?
>
> I still believe that the changes should go into a separate patch series 
> though.

It is legal hardware and OBP wise to have only one CPU fitted in any
random slot and the OBP will report this.
We should support this (slightly unusual but valid) configuration.
In the case of the ss1000 the kernel has a bad case of bit rot and
it would be a very good idea to get a UP kernel working before
trying to fix SMP.
