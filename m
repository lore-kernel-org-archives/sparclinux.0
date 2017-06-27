From: David Miller <davem@davemloft.net>
Date: Tue, 27 Jun 2017 03:30:24 +0000
Subject: Re: [PATCH] vDSO for sparc
Message-Id: <20170626.233024.1395641613998149816.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498495167-773325-1-git-send-email-nagarathnam.muthusamy@oracle.com>
In-Reply-To: <1498495167-773325-1-git-send-email-nagarathnam.muthusamy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Mon, 26 Jun 2017 12:39:27 -0400

> +static notrace inline u64
> +vgetsns(struct vvar_data *vvar)
> +{
> +	u64 v;
> +	u64 cycles;
> +
> +	switch (vvar->vclock_mode) {
> +	case VCLOCK_TICK:
> +		cycles = vread_tick();
> +		break;
> +	case VCLOCK_STICK:
> +		cycles = vread_stick();
> +		break;
> +	default:
> +		return 0;
> +	}
> +	v = (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
> +	return v * vvar->clock.mult;
> +}

If you're going to go through all of this trouble to make a vdso,
it should be assembler code patched at boot time for the tick
access etc.

It is wasteful to run this switch statement when on a given
machine it will evaluate to the same value always.
