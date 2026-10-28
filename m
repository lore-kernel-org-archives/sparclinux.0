Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150488;
	b=gHVkAwBzKlLuIaoYjhp7gI/iHW6TigQJ/bAPgSApSS6wAhIXHIdsi8nSGL0YE3v2+l32
	 AGAx9DJQJ5fWP9CxOdCASf2oazk8e0raxA/9jyPb01gX1HVYvel/U+p3fR4uJXeinqX9f
	 id9vE4OepGq+g2CJUCcypwKx8Be7fmUzCV3/9DY55mTzhG2ZvlnPnYJn7ejuYggxIiIk8
	 /Gm3Pn5gMfEsypmKjs6Fy/nB8GegwrNxN8/xdFp76R9ZThWlUxbnbzdO+9TZj2/fqJxYV
	 CSjhcaJ1AwCmSTQzK8wfVk6qNpGHo2+fsY2CgHr2B+4ySXkWgpy94ce5Iysu2aGsesg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150488;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FKp0FKVTm+nijmeVs4MwZwggzfTI49pfUeU9Vc2yJy4=;
	b=Wo/ni/etLq9Q6BzrNGBxdtMcMmUDiX5DGIqnWTgXzjKHHwz80n/6cLW11aEsozTUZYb7
	 wI+aofgVP4MnRyyVmrciGi3BaEVCYYMDR+wiwLYXo3jgb2+yyjBSnV3qHSuRJSjNrnY+W
	 EweBMvaEuiWxXVzU/9UrC2YQrIXKu+9mwIlQFq9fysQI7ywmVX06qEUiD7mddKq1Es/nO
	 /IEsiZSJ5EW8lwiiP3lgkhKMD0KlEcsZvDnP/o6l7mqXPQvYZdLwFFOAPQZoChX+Ah5x1
	 NIVEOLPCNBOUWssB4V2jclvuRR2bIpbqwpMlXUTdiYaDp+5/LZS6SRjxGtgKvpGjplg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpQKAMrV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4171606A31A
	for <sparclinux@vger.kernel.org>; Wed, 28 Oct 2026 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpQKAMrV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F9C1F01825;
	Wed, 28 Oct 2026 01:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150487;
	bh=FKp0FKVTm+nijmeVs4MwZwggzfTI49pfUeU9Vc2yJy4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QpQKAMrVfjsecIOw5BQ1VosJly8CT2/Op7ihhIaUcjZLqalbjqf2ow9qq6p4AAaL9
	 SYypCOOT31XpTr32zJqrX7FMETqhTDmoL9EXszs+9cKu9HN2NHKIW7f6gZCQhhcxe/
	 3A7cwFfwDk2H+Qtz64DwBeCxmCm0Kx4eqII2cuZMMFlK5PQe/MCtR3VgDkhoHvofND
	 G/Jg2oDzJv1gOWGv3A5eNi9A5GVVSENUhbWoEkujEIRCvz63JC6y5/qfFlUU99rFAF
	 rsg+oc5daqoZer31/5k+wk4ljme2+R4/5gGYcyh9mtgyYElWWNbCtrskY60gE+Pff6
	 fjdzawwc3clgw==
Message-ID: <sashiko-outbox-187314@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] sparc: populate sysfs cache topology information on
 sun4v
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jan Engelhardt" <jengelh@inai.de>
Cc: sparclinux@vger.kernel.org
In-Reply-To: <20261028010100.24792-1-jengelh@inai.de>
References: <20261028010100.24792-1-jengelh@inai.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 01:21:27 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] sparc: mdesc_cache_walk() leaves invalid fw_token on error path
- [High] sparc: undeclared cmp_int() and C99 declarations break build
- [Medium] sparc: mdesc_cache_walk() corrupts cacheinfo state across CPU ho=
tplug
- [Medium] sparc: mdesc_cache_walk() misses direct cache arcs and exec_unit=
 nodes
- [Medium] sparc: mdesc_cache_walk() breaks shared_cpu_map on !CONFIG_SMP
- [Low] sparc: unused mdesc_node field added to struct cpuinfo_sparc
--

commit 3b2a900d7b27574052192de660cf52382a5087a9
Author: Jan Engelhardt <jengelh@inai.de>

sparc: populate sysfs cache topology information on sun4v

This patch implements init_cache_level() and populate_cache_leaves() on
sun4v by walking the Machine Description (MDESC) graph to populate generic
sysfs cacheinfo attributes and shared CPU maps.

> diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm=
/cpudata_64.h
> index 9c3fc03abe9ae..3b79fb274f716 100644
> --- a/arch/sparc/include/asm/cpudata_64.h
> +++ b/arch/sparc/include/asm/cpudata_64.h
> @@ -29,6 +29,7 @@ typedef struct {
>  	unsigned short	core_id;
>  	unsigned short  max_cache_id;	/* groupings of highest shared cache */
>  	signed short	proc_id;	/* strand (aka HW thread) id */
> +	u64             mdesc_node;
>  } cpuinfo_sparc;

[Severity: Low]
Is this mdesc_node field in cpuinfo_sparc still needed? Nothing in the
patch reads or writes it, and adding 8 bytes here pushes cpuinfo_sparc
from 64 bytes (two 32-byte L1 D-cache lines) to 72 bytes per CPU.

[ ... ]

> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index 8e645ddac58e2..420ed85856023 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c

[ ... ]

> +static void mdesc_cache_set_shared(struct mdesc_handle *mdh, u64 cache_n=
ode,
> +				   struct cacheinfo *leaf)
> +{
> +	unsigned int maxcpus =3D num_possible_cpus();
> +	u64 sup_iter, cpu_iter;
> +
> +	mdesc_for_each_arc(sup_iter, mdh, cache_node, MDESC_ARC_TYPE_BACK) {
> +		u64 sup_node =3D mdesc_arc_target(mdh, sup_iter);
> +		const char *tg_name =3D mdesc_node_name(mdh, sup_node);
> +
> +		if (strcmp(tg_name, "cache") =3D=3D 0)
> +			mdesc_cache_set_shared(mdh, sup_node, leaf);
> +		if (strcmp(tg_name, "exec-unit") !=3D 0)
> +			continue;
> +
> +		mdesc_for_each_arc(cpu_iter, mdh, sup_node, MDESC_ARC_TYPE_BACK) {
> +			u64 cpu_node =3D mdesc_arc_target(mdh, cpu_iter);
> +			tg_name =3D mdesc_node_name(mdh, cpu_node);
> +
> +			if (strcmp(tg_name, "cpu") !=3D 0)
> +				continue;
> +			const u64 *id =3D mdesc_get_property(mdh, cpu_node, "id", NULL);
> +			if (id =3D=3D NULL)
> +				continue;
> +			if (id !=3D NULL && *id < maxcpus)
> +				cpumask_set_cpu(*id, &leaf->shared_cpu_map);
> +		}
> +	}
> +}

[Severity: Medium]
Can mdesc_cache_set_shared() leave leaf->shared_cpu_map empty on
!CONFIG_SMP kernels when booted on a non-zero physical CPU?

In mdesc_cache_walk(), under #ifndef CONFIG_SMP, cpuid is set to
real_hard_smp_processor_id() so mdesc_find_cpu() locates the physical
boot CPU. However, in mdesc_cache_set_shared(), maxcpus is
num_possible_cpus(), which is 1U on !CONFIG_SMP, and the physical MDESC
CPU id is checked against maxcpus:

	if (id !=3D NULL && *id < maxcpus)
		cpumask_set_cpu(*id, &leaf->shared_cpu_map);

When the physical boot CPU has a hardware strand ID >=3D 1, *id < 1 is
false, so bit 0 is never set in leaf->shared_cpu_map. Because
mdesc_cache_record() sets cc->cpu_map_populated =3D true,
cache_shared_cpu_map_setup() in drivers/base/cacheinfo.c returns early
without setting bit 0 either, hiding shared_cpu_map and shared_cpu_list
in sysfs for any cache not shared with physical strand 0.

[ ... ]

> +static int mdesc_cache_record(struct mdesc_handle *mdh, u64 cache_node,
> +			      unsigned int cpuid, unsigned int *leaf_count,
> +			      bool fill_it)
> +{
> +	const u64 *level =3D mdesc_get_property(mdh, cache_node, "level", NULL);
> +	struct cpu_cacheinfo *cc;
> +	u64 iter;
> +
> +	if (level =3D=3D NULL)
> +		return -ENOENT;
> +	cc =3D get_cpu_cacheinfo(cpuid);
> +	if (fill_it) {
> +		if (*leaf_count >=3D cc->num_leaves) {
> +			/*
> +			 * 1. Sudden MDESC change between init_cache_level
> +			 * and populate_cache_leaves, or 2. programming
> +			 * errors.
> +			 */
> +			pr_err("%s: tried to populate more cacheinfos than "
> +			       "allocated.\n", __func__);
> +			return -ELOOP;
> +		}
> +		if (!seen_cache(cc->info_list, *leaf_count, cache_node)) {
> +			struct cacheinfo *ci =3D &cc->info_list[(*leaf_count)++];
> +			mdesc_cache_fill(mdh, cache_node, ci);
> +			mdesc_cache_set_shared(mdh, cache_node, ci);
> +			cc->cpu_map_populated =3D true;
> +		}
> +	} else {
> +		++cc->num_leaves;
> +		if (cc->num_levels < *level)
> +			cc->num_levels =3D *level;
> +	}

[Severity: Medium]
Does this corrupt cc->num_leaves and sibling shared_cpu_map bitmasks
across CPU offline/online cycles or LDOM dynamic reconfiguration?

When a CPU goes offline:

cacheinfo_cpu_pre_down()
  -> free_cache_attributes()
       -> cache_shared_cpu_map_remove()
       -> kfree(per_cpu_cacheinfo(cpu))

free_cache_attributes() frees info_list, but does not reset
cc->num_leaves or cc->num_levels to 0. When the CPU is brought back
online and init_cache_level() calls mdesc_cache_walk(cpuid, false),
++cc->num_leaves increments on top of the previous value instead of
starting from 0.

In addition, cache_shared_cpu_map_remove() clears the offlined CPU from
each online sibling's sib_leaf->shared_cpu_map:

drivers/base/cacheinfo.c:cache_shared_cpu_map_remove() {
	...
	sib_leaf =3D sib_cpu_ci->info_list + index;
	cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
	cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
	...
}

When the CPU comes back online, mdesc_cache_set_shared() only sets bits
in the current CPU's ci->shared_cpu_map (including offline CPUs present
in the MDESC) without restoring the CPU's bit in online siblings'
sib_leaf->shared_cpu_map, and setting cc->cpu_map_populated =3D true causes
cache_shared_cpu_map_setup() in drivers/base/cacheinfo.c to skip updating
the sibling maps as well.

Also, in the fill_it branch above, *leaf_count >=3D cc->num_leaves is
checked before seen_cache(cc->info_list, *leaf_count, cache_node), and
when seen_cache() returns true the function still recurses through all
forward arcs of that cache node.

[ ... ]

> +	mdesc_for_each_arc(eu_arc, mdh, cpu_node, MDESC_ARC_TYPE_FWD) {
> +		u64 cache_arc;
> +		u64 eu_node =3D mdesc_arc_target(mdh, eu_arc);
> +		const char *node_name =3D mdesc_node_name(mdh, eu_node);
> +
> +		if (strcmp(node_name, "exec-unit") !=3D 0)
> +			continue;
> +
> +		mdesc_for_each_arc(cache_arc, mdh, eu_node, MDESC_ARC_TYPE_FWD) {
> +			u64 cache_node =3D mdesc_arc_target(mdh, cache_arc);
> +			node_name =3D mdesc_node_name(mdh, cache_node);
> +			if (strcmp(node_name, "cache") !=3D 0)
> +				continue;
> +			ret =3D mdesc_cache_record(mdh, cache_node, cpuid,
> +						 &leaf_count, fill_it);
> +			if (ret !=3D 0)
> +				goto out;
> +		}
> +	}

[Severity: Medium]
Will mdesc_cache_walk() and mdesc_cache_set_shared() miss caches on
sun4v machines whose MDESC uses direct cpu-to-cache arcs or names
execution unit nodes "exec_unit"?

Earlier in arch/sparc/kernel/mdesc.c, set_proc_ids() checks for both
spelling variants:

static void set_proc_ids(struct mdesc_handle *hp)
{
	__set_proc_ids(hp, "exec_unit");
	__set_proc_ids(hp, "exec-unit");
}

And fill_in_one_cpu() also handles direct forward arcs from "cpu" to
"cache" nodes (such as on UltraSPARC T1) in addition to going through
execution unit nodes:

	t_name =3D mdesc_node_name(hp, t);
	if (!strcmp(t_name, "cache")) {
		fill_in_one_cache(c, hp, t);
		continue;
	}

Because mdesc_cache_walk() and mdesc_cache_set_shared() only follow
nodes named "exec-unit", platforms using direct "cache" arcs or
"exec_unit" nodes will find 0 cache leaves (failing with -ENOENT in
detect_cache_attributes()) or fail to populate leaf->shared_cpu_map.

> +
> +	if (fill_it) {
> +		/* Reduce count to actually populated slots. */
> +		struct cpu_cacheinfo *cc =3D get_cpu_cacheinfo(cpuid);
> +		cc->num_leaves =3D leaf_count;
> +
> +		/* We have the sharedness bitmaps and don't need fw_token. */
> +		for (size_t i =3D 0; i < cc->num_leaves; ++i)
> +			cc->info_list[i].fw_token =3D NULL;
> +	}
> + out:
> +	mdesc_release(mdh);
> +	return ret;
> +}

[Severity: High]
If mdesc_cache_record() fails partway through when fill_it is true and
jumps to out, can the uncleared fw_token values cause an invalid pointer
dereference in of_node_put()?

During the fill_it pass, mdesc_cache_fill() stores the raw integer MDESC
node index into leaf->fw_token:

	leaf->fw_token =3D (void *)(uintptr_t)cache_node;

If a subsequent call to mdesc_cache_record() returns an error (such as
-ENOENT if a cache node is missing a "level" property, or -ELOOP if the
MDESC changed between init_cache_level() and populate_cache_leaves()),
goto out skips clearing cc->info_list[i].fw_token and skips updating
cc->num_leaves.

When populate_cache_leaves() returns that error to
detect_cache_attributes() in drivers/base/cacheinfo.c, it runs:

detect_cache_attributes()
  -> free_cache_attributes()
       -> cache_shared_cpu_map_remove()

In cache_shared_cpu_map_remove():

		sib_leaf =3D sib_cpu_ci->info_list + index;
		cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
		cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
	}
	if (of_have_populated_dt())
		of_node_put(this_leaf->fw_token);

Because SPARC populates of_root during boot in prom_build_devicetree(),
of_have_populated_dt() is true, so of_node_put() will be called with the
non-NULL integer MDESC node index cast to a pointer. Furthermore, because
cc->num_leaves was not reduced to leaf_count and cc->info_list was not
sorted, cache_shared_cpu_map_remove() can index past the end of
sib_cpu_ci->info_list or clear bits in mismatched cache leaves on online
sibling CPUs.

> diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_com=
mon.c
> index c9ec70888a394..137d84b89e483 100644
> --- a/arch/sparc/kernel/prom_common.c
> +++ b/arch/sparc/kernel/prom_common.c

[ ... ]

> +static int cache_leaf_compare(const void *va, const void *vb)
> +{
> +	const struct cacheinfo *a =3D va, *b =3D vb;
> +	int r =3D cmp_int(a->level, b->level);
> +	return r !=3D 0 ? r : cmp_int(a->type, b->type);
> +}

[Severity: High]
Does this build cleanly?

cmp_int() is not declared or defined in the kernel headers or in this
file, which fails compilation of arch/sparc/kernel/prom_common.c with
-Werror=3Dimplicit-function-declaration.

In addition, arch/sparc/kernel/mdesc.c fails to build under the kernel's
-std=3Dgnu89, -Wdeclaration-after-statement, and arch/sparc/kernel/Makefile
ccflags-y :=3D -Werror flags due to the mixed declaration in
mdesc_cache_set_shared():

	if (strcmp(tg_name, "cpu") !=3D 0)
		continue;
	const u64 *id =3D mdesc_get_property(mdh, cpu_node, "id", NULL);

and the C99 loop variable declaration in mdesc_cache_walk():

	for (size_t i =3D 0; i < cc->num_leaves; ++i)
		cc->info_list[i].fw_token =3D NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028010100.2479=
2-1-jengelh@inai.de?part=3D1
