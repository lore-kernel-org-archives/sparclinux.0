Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4011A682B
	for <sparclinux@vger.kernel.org>; Mon, 19 Oct 2026 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792369020; cv=none; b=GOwL/vpsNqNallz0zDGiQ/k3ST7+f/yC1yrqhJGj/ekLjK7U+gr3ISI+8TVsYFxOswtp7IW7Oun1MYSGrNv9yTVsMiBQdforoE4LfLlS1faM3gXy2Iw1RR3FStJEpNHsosq70EVuHXhU5MwRV4QjXk1C3c30JdYDGb3vl7lHQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792369020; c=relaxed/simple;
	bh=to631D+iC3p0ZpGaRKQmwXrxzKkpan16A/M2vDWM2uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X+k6XapKAbM4SH4Yrfu7+BTnx+lJCE1GXSl+ZuSdURF+e6RTiuBkXQVKufqUhuby5OppIMuE7rLXPhk92GpVXWr68RdsnkVzgp4KTbVTXFCAZnIURr+OcPl/m7zdmWJ5/KbhUp6j429+IAqxWucyJu7qJwYyDzEI7fyTHHle1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeLldF6V; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeLldF6V"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3863201eec.1
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 17:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792369017; x=1792973817; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fug6RMrRiclnxhUYxH32vtI9ijVw9bjbxdENwUUfrRU=;
        b=DeLldF6VSypBXU8cWZOea+rTRXEnqW21M3QHvWyt8j43C5nT0i9Mg4lI6ZRQJEy7X4
         /Aa5/EYenMBZ9qzyCbcyn0PsSOpQZnEQmWRCMlBM9pbwodk0t6zL16mF90NUcgsVgFEV
         04fzG8h591FEovH7Pw0nfdG8gjY9JBiVfssnV1PuljEHPk8+WKZdqD0fhMmWV76L3s/W
         s0lbWdWnrwqmdNgLQW5PDEBg5uhFS+uSkSGvb4ijaREu8LaRcrXRuUE2aTQThpBNKrwd
         fyYXaqMrk02E1qC5iGqcByHSoMHcek/ZIkXuPTw0T/fkkfVARemqXPZfdcExIC0Ab4kA
         1OUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792369017; x=1792973817;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fug6RMrRiclnxhUYxH32vtI9ijVw9bjbxdENwUUfrRU=;
        b=GVROUjErpXVwOaRE56SvQPkAvr55QQfriqkvZS6hUYHQ5I3Kpu+w/vu35xg/k0OpVA
         DGTQgwUH93we34bIo92ktI4O0dssoFWl9G32a4FoVd0kX7q1l6ayZhmdmLlipMxKOsgo
         2MvYvdiHdQpYIH8PruPsVYklE4JgVIF8Nt9WmRUZ+MBMZnYrLqJXZFIilABLEzbMpJCd
         f9GvEHf1q28byXVKh4h664rq7sIj9oQFgnQtf1ilEnyunqb4IF/4W/DujHKAAdYlDbYg
         WoTeXmoe+8V30n6uK0wjRLtsGGycY/i9fHnJzkV42ioDebYvM10CZi9b1CfgLbZ5R0iv
         A3Ag==
X-Gm-Message-State: AFq9FYJBPmWfFVgM9BiShq29iGYfUjXAhOvQWJejQ0DS7KqC3yU0pZwc
	4ECBImVDM9k8GJcGqXFTcticdvZ7UbF6ey05f/izKNtKaez+jH2DZ0RhW/kLeEy1
X-Gm-Gg: AYBFou0Fm4YBNY9yL6EpGmiJi/LklOC2dCT1g7WMv3OGJGluL1LJWOnVkqQiBf79n4d
	XPAyCveZ2G56hSVabuaz3oY4khc4Q3yn/ZcoYKtkaJh8CL0srXS3/K4FSwQMAQJff+hLW0ur2po
	3/Kfv/K8p2udJ7k4gK6AAJQQdFqv5WMCqvm1/qrzaaWI7pB9VhH2xfBfZ91SPcKoJMrioAnGFHq
	xr37zC4EE6S4MsbChdNt9gByxCE7YyF7FPRj+1iv+OwI6ODRJQ9bsRyZ3Q8qZgi4hx4NduUk56o
	VP7nvH/PSJ08sfwc7V66M+juMol0KgjUsWYuULeB72Upz1ni3iSJdlWVgen72Vtka4LvtBzJ69m
	pKS6dwFehMMOmDqPrgBXFeKCNj1GtOTDXlsau3ynm97wGWnLaWbwn2Z19yLQdP0gRvvYEy7ehg8
	3dhdKNB8MrrlRoL1QEJgp0pcmegrjmxRr6nK7nSYE7PXSmp0i4uNK5pcd8OWaqs7eBIFMpZnIQ0
	jJwDPdtJrOU7bF9x4jp+Ri8gkisigRFkU27cq+kdeL8iA==
X-Received: by 2002:a05:7023:a4c:b0:144:fdf0:9d91 with SMTP id a92af1059eb24-1851285de14mr8462856c88.24.1792369016958;
        Sun, 18 Oct 2026 17:16:56 -0700 (PDT)
Received: from [192.168.21.192] ([24.18.106.4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm27006904c88.4.2026.10.18.17.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 17:16:56 -0700 (PDT)
Message-ID: <b69a7cd6-7f9d-4c8e-80b9-701a77a6805a@gmail.com>
Date: Sun, 18 Oct 2026 17:16:55 -0700
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on sun4v
Content-Language: en-US
To: Jan Engelhardt <jengelh@inai.de>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Stian Halseth <stian@itx.no>
References: <20261018222723.43442-1-jengelh@inai.de>
From: Tony Rodriguez <unixpro1970@gmail.com>
In-Reply-To: <20261018222723.43442-1-jengelh@inai.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jan,

On 10/18/26 3:27 PM, Jan Engelhardt wrote:
> The SPARC port does not publish any cache topology information. The
> lscpu utility therefore falls back to assuming the published cache
> sizes are for unshared caches, and as a result, reports way more
> cache than there really is present in the system. On a T5240 machine:
>
> ```
> $ lscpu
> Architecture:          sparc64
>    CPU op-mode(s):      32-bit, 64-bit
>    Byte Order:          Big Endian
> CPU(s):                128
>    On-line CPU(s) list: 0-127
> Model name:            UltraSparc T2 (Niagara2)
>    Thread(s) per core:  4
>    Core(s) per socket:  16
>    Socket(s):           2
>    Flags:               sun4v
> Caches (sum of all):
>    L1d:                 1 MiB (128 instances)
>    L1i:                 2 MiB (128 instances)
>    L2:                  512 MiB (128 instances)
> ```
>
> This patch implements population of the sysfs cacheinfo structures
> for sun4v (systems with mdesc). The proper amount is now reflected in
> lscpu's output:
>
> ```
> Caches (sum of all):
>    L1d:                 128 KiB (16 instances)
>    L1i:                 256 KiB (16 instances)
>    L2:                  8 MiB (2 instances)
> ```
>
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>   arch/sparc/include/asm/cpudata_64.h |  8 +++-
>   arch/sparc/kernel/mdesc.c           | 61 +++++++++++++++++++++++++++++
>   2 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm/cpudata_64.h
> index 056b3c0e7ef9..e28b841ffe23 100644
> --- a/arch/sparc/include/asm/cpudata_64.h
> +++ b/arch/sparc/include/asm/cpudata_64.h
> @@ -18,13 +18,19 @@ typedef struct {
>   	unsigned int	irq0_irqs;
>   	unsigned int	__pad2;
>   
> -	/* Dcache line 2, rarely used */
> +	/* Dcache line 2+3, rarely used */
>   	unsigned int	dcache_size;
>   	unsigned int	dcache_line_size;
> +	unsigned int	dcache_assoc;
> +	unsigned int	dcache_id;
>   	unsigned int	icache_size;
>   	unsigned int	icache_line_size;
> +	unsigned int	icache_assoc;
> +	unsigned int	icache_id;
>   	unsigned int	ecache_size;
>   	unsigned int	ecache_line_size;
> +	unsigned int	ecache_assoc;
> +	unsigned int	ecache_id;
>   	unsigned short	sock_id;	/* physical package */
>   	unsigned short	core_id;
>   	unsigned short  max_cache_id;	/* groupings of highest shared cache */
> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index 23b51a32e96e..029d9d812074 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c
> @@ -818,6 +818,7 @@ static void fill_in_one_cache(cpuinfo_sparc *c, struct mdesc_handle *hp, u64 mp)
>   	const u64 *level = mdesc_get_property(hp, mp, "level", NULL);
>   	const u64 *size = mdesc_get_property(hp, mp, "size", NULL);
>   	const u64 *line_size = mdesc_get_property(hp, mp, "line-size", NULL);
> +	const u64 *assoc = mdesc_get_property(hp, mp, "associativity", NULL);
>   	const char *type;
>   	int type_len;
>   
> @@ -828,15 +829,21 @@ static void fill_in_one_cache(cpuinfo_sparc *c, struct mdesc_handle *hp, u64 mp)
>   		if (of_find_in_proplist(type, "instn", type_len)) {
>   			c->icache_size = *size;
>   			c->icache_line_size = *line_size;
> +			c->icache_assoc = assoc ? *assoc : 0;
> +			c->icache_id = mp;
>   		} else if (of_find_in_proplist(type, "data", type_len)) {
>   			c->dcache_size = *size;
>   			c->dcache_line_size = *line_size;
> +			c->dcache_assoc = assoc ? *assoc : 0;
> +			c->dcache_id = mp;
>   		}
>   		break;
>   
>   	case 2:
>   		c->ecache_size = *size;
>   		c->ecache_line_size = *line_size;
> +		c->ecache_assoc = assoc ? *assoc : 0;
> +		c->ecache_id = mp;
>   		break;
>   
>   	default:
> @@ -1251,6 +1258,60 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
>   	smp_fill_in_sib_core_maps();
>   }
>   
> +int init_cache_level(unsigned int cpu)
> +{
> +	struct cpu_cacheinfo *i = get_cpu_cacheinfo(cpu);
> +	i->num_levels = 2;
> +	i->num_leaves = 3;
> +	return 0;
> +}
> +
> +int populate_cache_leaves(unsigned int cpu)
> +{
> +	struct cacheinfo *leaf = get_cpu_cacheinfo(cpu)->info_list;
> +	cpuinfo_sparc *cs = &cpu_data(cpu);
> +
> +	leaf->id                    = cs->icache_id;
> +	leaf->attributes            = CACHE_ID;
> +	leaf->level                 = 1;
> +	leaf->type                  = CACHE_TYPE_INST;
> +	leaf->coherency_line_size   = cs->icache_line_size;
> +	leaf->ways_of_associativity = cs->icache_assoc;
> +	leaf->size                  = cs->icache_size;
> +	leaf->priv                  = cs;
> +	if (cs->icache_line_size > 0 && cs->icache_assoc > 0)
> +		leaf->number_of_sets = cs->icache_size / cs->icache_line_size /
> +		                       cs->icache_assoc;
> +	++leaf;
> +
> +	leaf->id                    = cs->dcache_id;
> +	leaf->attributes            = CACHE_ID;
> +	leaf->level                 = 1;
> +	leaf->type                  = CACHE_TYPE_DATA;
> +	leaf->coherency_line_size   = cs->dcache_line_size;
> +	leaf->ways_of_associativity = cs->dcache_assoc;
> +	leaf->size                  = cs->dcache_size;
> +	leaf->priv                  = cs;
> +	if (cs->dcache_line_size > 0 && cs->dcache_assoc > 0)
> +		leaf->number_of_sets = cs->dcache_size / cs->dcache_line_size /
> +		                       cs->dcache_assoc;
> +	++leaf;
> +
> +	leaf->id                    = cs->ecache_id;
> +	leaf->attributes            = CACHE_ID;
> +	leaf->level                 = 2;
> +	leaf->type                  = CACHE_TYPE_UNIFIED;
> +	leaf->coherency_line_size   = cs->ecache_line_size;
> +	leaf->ways_of_associativity = cs->ecache_assoc;
> +	leaf->size                  = cs->ecache_size;
> +	leaf->priv                  = cs;
> +	if (cs->ecache_line_size > 0 && cs->ecache_assoc > 0)
> +		leaf->number_of_sets = cs->ecache_size / cs->ecache_line_size /
> +		                       cs->ecache_assoc;
> +
> +	return 0;
> +}
> +
>   /* mdesc_open() - Grab a reference to mdesc_handle when /dev/mdesc is
>    * opened. Hold this reference until /dev/mdesc is closed to ensure
>    * mdesc data structure is not released underneath us. Store the

Thanks for working on this — publishing proper SPARC cache topology is 
long overdue, and reading associativity from MDESC plus carrying cache 
IDs through cpuinfo_sparc is a sensible direction.


*Full disclosure: I ran this patch through "DeepSeek AI" out of 
curiosity to sanity-check it and I am interested in learning more.  Deep 
Seek AI flagged a few issues that seem worth mentioning:  You may want 
to double check the "Deep Seek AI" review of this patch.

Main blockers

1)    leaf->attributes = CACHE_ID is invalid. attributes is a bitmask of 
CACHE_WRITE_BACK / CACHE_WRITE_THROUGH / etc.; CACHE_ID isn’t a valid 
attribute. It should be 0 or real attribute bits from MDESC.

  2)   Shared-cache reporting is not actually wired up, so T2-class 
machines still show the wrong cache sizes. The patch sets leaf->id = mp 
and leaf->priv = cs, but never fills leaf->shared_cpu_map, and the 
generic detect_cache_attributes() -> cache_shared_cpu_map_setup() path 
doesn’t appear to be invoked on SPARC. As a result, the generic 
cacheinfo code still treats every leaf as private to one CPU, and lscpu 
still multiplies shared cache size by the number of threads — the exact 
bug being reported.

Concretely: with this patch applied, a T5240 would still report L2: 512 
MiB (128 instances) rather than the correct L2: 8 MiB (2 instances) (4 
MB per socket, shared across 64 threads, 2 sockets). A T5120 would still 
report the 4 MB shared L2 as 4 MB × 64 threads = 256 MiB in 64 instances 
, instead of 4 MiB (1 instance). The patch does not change the outcome 
on T2-class hardware because the leaves are still treated as private to 
each CPU.

3)    MDESC level handling is incomplete and mislabels caches on S7/T7. 
fill_in_one_cache() only handles case 1: (L1I/L1D) and case 2: (ecache); 
everything else falls through to default:. On T2/T5240 that happens to 
work because the shared 4 MB is reported at level 2. But on S7-2/T7-1, 
MDESC reports L2 at level 2 and the shared L3 at level 3 — so the L2 
gets stored as ecache_*, and the real L3 is silently ignored. 
cpuinfo_sparc also has no separate l2_* fields, so the data model can’t 
hold both levels.

4) Hardcoded num_levels = 2 / num_leaves = 3 and ecache labeled level 2 
are wrong across the family. T2/T5240: L1I + L1D + shared L2 (no L3). 
S7-2: L1 + shared L2 + shared L3. T7-1: L1 + private L2 + shared L3. The 
leaf count, levels, and types need to be derived from MDESC, not hardcoded.

5)    The new init_cache_level() / populate_cache_leaves() don’t appear 
to be wired into the generic cacheinfo path , so they may never actually 
be called.

Additional issues

6)    leaf->id is int, but the patch stores a truncated u64 MDESC 
handle. ecache_id/ icache_id/ dcache_id are unsigned int, assigned from 
u64 mp. Beyond truncation, assigning u32 → int id can produce negative 
IDs. An index-based or hashed ID would be cleaner.

7)   Growing cpuinfo_sparc needs an asm-offset audit. The struct has a 
“must be 1st” field and SPARC asm accesses cpu_data at fixed offsets in 
places like rtrap_64.S. The patch adds fields after that, so offset 0 is 
preserved, but it should be confirmed that no asm hardcodes offsets into 
the fields that now shift ( sock_id, core_id, max_cache_id, cache 
fields). It also grows the per-CPU area past the “Dcache line 2” region.

8)    The data model has no separate L2 storage for S7/T7. cpuinfo_sparc 
only has ecache_* for the shared cache. To model S7 (shared L2 per 
cluster + shared L3 per socket) and T7 (private L2 per core + shared 
L3), you need distinct l2_* and l3/ ecache_* fields.

9)    The new *_id scheme duplicates existing infrastructure. 
cpuinfo_sparc already has max_cache_id (“groupings of highest shared 
cache”) and smp_fill_in_sib_core_maps(). It’s worth checking whether 
that mechanism should be extended rather than adding six new fields.

10)    num_leaves may not exist in the target kernel. struct 
cpu_cacheinfo gained num_leaves relatively late (~4.16). If the tree is 
older, init_cache_level() won’t compile or won’t allocate the right 
number of leaves.

11)    Missing validation / NULL checks. fill_in_one_cache() 
dereferences *size and *line_size without NULL checks (pre-existing, but 
adjacent to the new code). assoc is checked, which is good, but there’s 
no power-of-two validation, and when assoc == 0 the leaf still publishes 
a size with number_of_sets = 0, which lscpu may render oddly.

12)    “ecache” naming is platform-dependent. Historically “ecache” 
meant L2 on older SPARC; on S7/T7 the external/shared cache is L3. Using 
ecache_* for both with a hardcoded level 2 is semantically confusing; 
the level should come from MDESC.

13)    Style / linkage. The new functions should probably be static; 
there’s mixed indentation versus the file’s tabs; and a checkpatch.pl 
--strict run would be worthwhile.

14)    Error paths always return 0. init_cache_level() and 
populate_cache_leaves() publish leaves even if all MDESC cache data is 
zero/absent, yielding zero-size cache leaves rather than “unknown.”

15)    leaf->priv = cs is probably harmless, but worth confirming 
nothing in the generic path or arch code expects a particular priv type.

A topology-driven fix — dynamic leaves from MDESC, correct levels, 
separate L2/L3 storage, and a shared_cpu_map keyed on sock_id/cluster — 
would make T2/T5240 report 8 MiB L2 in 2 instances and S7-2/T7-1 report 
their shared L3 correctly instead of 64× inflated.

One clarification on the T5240 lscpu output, since it can look partly 
correct: the L1d: 1 MiB (128 instances) and L1i: 2 MiB (128 instances) 
lines are actually right — L1 really is private per core on T2, so 128 
instances is correct. The L2 line is the giveaway: it reports 512 MiB 
(128 instances), i.e. 128 × 4 MB, when a dual-socket T5240 has only 2 
shared 4 MB L2 caches (one per socket), for 8 MiB total in 2 instances . 
The default “every leaf is private” assumption happens to be true for L1 
and false for L2, which is why only the L2 line is inflated. This patch, 
as written, would leave that L2 line unchanged.

In short: on T2-class hardware (T5120/T5240) this patch produces the 
same incorrect lscpu output as unpatched mainline — it does not resolve 
the reported over-reporting there either.

Regards,

Tony

