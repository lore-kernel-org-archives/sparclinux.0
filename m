From: Nick Alcock <nick.alcock@oracle.com>
Date: Tue, 27 Jun 2017 11:27:32 +0000
Subject: Re: [PATCH] vDSO for sparc
Message-Id: <87wp7xy8kb.fsf@esperi.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1498495167-773325-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1498495167-773325-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 27 Jun 2017, David Miller told this:

> From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
> Date: Mon, 26 Jun 2017 12:39:27 -0400
>
>> +static notrace inline u64
>> +vgetsns(struct vvar_data *vvar)
>> +{
>> +	u64 v;
>> +	u64 cycles;
>> +
>> +	switch (vvar->vclock_mode) {
>> +	case VCLOCK_TICK:
>> +		cycles = vread_tick();
>> +		break;
>> +	case VCLOCK_STICK:
>> +		cycles = vread_stick();
>> +		break;
>> +	default:
>> +		return 0;
>> +	}
>> +	v = (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
>> +	return v * vvar->clock.mult;
>> +}
>
> If you're going to go through all of this trouble to make a vdso,
> it should be assembler code patched at boot time for the tick
> access etc.

Yeah, I thought of doing that and came to the conclusion that I was too
stupid to make it work, particularly given that all machines I know of
that don't support %stick are museum pieces so it would be very hard to
test the result (I spent some time hunting for one and couldn't find
any, and the last machine I owned that didn't support %stick went on the
landfill in about 2002). I mean this is userspace code so the
alternatives system won't do it: the patching would have to be manual...
and compared to *that* the vDSO was *easy*.

I certainly don't *object* to doing it that way: it's clearly preferable
if you don't mind the significantly increased maintenance complexity.

> It is wasteful to run this switch statement when on a given
> machine it will evaluate to the same value always.

Agreed!

-- 
NULL && (void)
