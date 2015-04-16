From: David Miller <davem@davemloft.net>
Date: Thu, 16 Apr 2015 19:35:25 +0000
Subject: Re: [PATCH] sparc: perf: Add support M7 processor
Message-Id: <20150416.153525.1558206081182644508.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
In-Reply-To: <1426795597-135713-1-git-send-email-david.ahern@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Ahern <david.ahern@oracle.com>
Date: Mon, 13 Apr 2015 11:53:03 -0600

> T7-4 showed no problems with the patch that was accepted. Through
> several 'perf record -- make -j 1024' sessions (make clean in between)
> and with a perf-top running in a separate window for a long period of
> time, all sessions continued to see samples.
> 
> I changed the T4 write_pmc handler to use the m7 variant:
> 
> +static void sparc_m7_write_pmc(int idx, u64 val);
> 
>  static const struct sparc_pmu niagara4_pmu = {
>         .event_map      = niagara4_event_map,
>         .cache_map      = &niagara4_cache_map,
>         .max_events     = ARRAY_SIZE(niagara4_perfmon_event_map),
>         .read_pmc       = sparc_vt_read_pmc,
> -       .write_pmc      = sparc_vt_write_pmc,
> +       .write_pmc      = sparc_m7_write_pmc,
>         .upper_shift    = 5,
>         .lower_shift    = 5,
>         .event_mask     = 0x7ff,
> 
> and a T4-1 showed no problems either (-j 64 for this one).

Fair enough.  I'll run the same test and if I can't replicate the
problems I ran into way-back-when, let's just use the same routine
for all of these chips.

Thanks.
