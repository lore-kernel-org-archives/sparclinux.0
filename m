From: David Miller <davem@davemloft.net>
Date: Mon, 03 Jul 2017 09:50:04 +0000
Subject: Re: [PATCH] arch/sparc: Measure receiver forward progress to avoid send mondo timeout
Message-Id: <20170703.025004.1971065890099969455.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
In-Reply-To: <1498683746-623218-1-git-send-email-jane.chu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jane.chu@oracle.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, steven.sistare@oracle.com, rob.gardner@oracle.com, anthony.yznaga@oracle.com

From: Jane Chu <jane.chu@oracle.com>
Date: Wed, 28 Jun 2017 15:02:26 -0600

>  static void hypervisor_xcall_deliver(struct trap_per_cpu *tb, int cnt)
>  {
> -	int retries, this_cpu, prev_sent, i, saw_cpu_error;
> +	int retries, this_cpu, prev_sent, i, rem;
> +	uint16_t first_cpu = 0xffff;
> +	unsigned long xc_rcvd = 0;
> +	int usec_wait = cnt * 2;
>  	unsigned long status;
> +	int ecpuerror_id = 0;
> +	int enocpu_id = 0;
>  	u16 *cpu_list;
> +	uint16_t cpu;

As you can see at the variable declarations around the ones you are
adding, "u16" is the appropriate type to use.  "uint16_t" is not.

So my concern about this patch is that in my mind, getting into a
state where a cpu is looping and doing nothing but handling mondos
is a bug.

That cpu is making no progress in it's execution stream, and that's
problematic.

I'd rather we attack the issue that gets into this situation in the
first place.

It's because we don't optimize large amounts of page TLB flushes
properly.

Firstly, we don't have a way to pass the array of pages to flush.
That would cut down the mondos by orders of magnitude.

We also could have a cutoff where we do a full MM flush instead
of flushing individual pages.

I bet if you implemented these two things, it would not only
make the mondo timeouts go away, it with make cpus actually
make forward progress in their instruction stream rather than
looping like crazy processing mondos.

Thanks.

