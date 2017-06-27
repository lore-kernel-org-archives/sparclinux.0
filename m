From: David Miller <davem@davemloft.net>
Date: Tue, 27 Jun 2017 17:24:11 +0000
Subject: Re: [PATCH] vDSO for sparc
Message-Id: <20170627.132411.1713223287761684771.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498495167-773325-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1498495167-773325-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nick Alcock <nick.alcock@oracle.com>
Date: Tue, 27 Jun 2017 12:29:16 +0100

> On 27 Jun 2017, David Miller stated:
> 
>> From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
>> Date: Mon, 26 Jun 2017 12:39:27 -0400
>>
>>> +static notrace inline u64
>>> +vgetsns(struct vvar_data *vvar)
>>> +{
>>> +	u64 v;
>>> +	u64 cycles;
>>> +
>>> +	switch (vvar->vclock_mode) {
>>> +	case VCLOCK_TICK:
>>> +		cycles = vread_tick();
>>> +		break;
>>> +	case VCLOCK_STICK:
>>> +		cycles = vread_stick();
>>> +		break;
>>> +	default:
>>> +		return 0;
>>> +	}
>>> +	v = (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
>>> +	return v * vvar->clock.mult;
>>> +}
>>
>> If you're going to go through all of this trouble to make a vdso,
>> it should be assembler code patched at boot time for the tick
>> access etc.
> 
> Oh wait I see what you're getting at: it just needs to be a single jump,
> doesn't it, with the target patched, and an asm label pointing at the
> jump instruction? I was assuming something much more complex, analyzing
> the compiler-generated instruction stream for vgetsns(), but you can
> of course call something one instruction long that just jumps, and then
> there's no analysis at all...

You have to write this function in assembler, and patch it just like
we patch any other code for cpu specific things in the kernel.

We recently had this done for the kernel time keeping to get sched_clock()
as efficient as possible, so you have something to use as a guide.
