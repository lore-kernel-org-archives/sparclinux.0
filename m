From: David Miller <davem@davemloft.net>
Date: Thu, 13 Apr 2017 01:52:06 +0000
Subject: Re: [patch 06/13] sparc/sysfs: Replace racy task affinity logic
Message-Id: <20170412.215206.1568460664651298892.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170412200726.941336635@linutronix.de>
        <20170412201042.612462984@linutronix.de>
In-Reply-To: <20170412201042.612462984@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@kernel.org, bigeasy@linutronix.de, benh@kernel.crashing.org, fenghua.yu@intel.com, herbert@gondor.apana.org.au, jiangshanlai@gmail.com, lenb@kernel.org, mpe@ellerman.id.au, rjw@rjwysocki.net, tj@kernel.org, tony.luck@intel.com, viresh.kumar@linaro.org, sparclinux@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 12 Apr 2017 22:07:32 +0200

> @@ -142,7 +122,8 @@ static unsigned long write_mmustat_enabl
>  static ssize_t show_mmustat_enable(struct device *s,
>  				struct device_attribute *attr, char *buf)
>  {
> -	unsigned long val = run_on_cpu(s->id, read_mmustat_enable, 0);
> +	long val = work_on_cpu(s->id, read_mmustat_enable, 0);

Last argument to work_on_cpu() should be NULL since it's a pointer
I guess.

But otherwise I have no problems with this:

Acked-by: David S. Miller <davem@davemloft.net>
