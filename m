Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297992;
	b=AkAYeFHieWsCBzM1hUPKbPtBAKlMBcCqOuvl69Kj89KlALFLSD20549ilUNNXJ+nAwMi
	 qLz8IYtcEDqS6P24aSb6unAz10LQh1lBVh9KvOq6M1Q5Zf1RwbVrpHHgpcAvac/NRVgU5
	 nmKAVVKEjG2VRHjg7a2YmFQouEFUIctTcSo0veaEcrF5DSPt4amwtqABKRke/fi3Rd1JW
	 npKNaWHTr4ZTg3zPnJg8YgB0T9epX7PjB/0xzNfSTSbofDfkqACviBhFcl4Bkjjvxfv7g
	 s2ScTsiuZSbHF1nOgpL+FlCwRU3aR97Xy6c6WNHctML7gvze1iuD/pVkWGcxwPRO7cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297992;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IK7SVDxoKjFhxh8AZRDcXnVXDtfnfCXd4y/pUJqXEfM=;
	b=VokbVk91ydN8rZhw0B0NbYGyMxKq6HXSZDEasxEfjGRHS0UwgpZ0xrL+ApNUjcyJj7RL
	 8lQDk7iOH9fnLzvNOm75ADN/0H8H9cLJ1yJwpIDNngo+RZTzWHwvmhX1q27+E96gM8VWS
	 RBaRqKp3iimqzDH6eQBtdq951lYjWOlGdioIE04sj/7hgBHx9woGO6I6Vjg8cBTWu5eKT
	 XBbf+ff/UPGLhKnVuhSARZpQDzOwpP1tkBko8ye0n5tfQMOLEmTQz+NMGzuuXFKy5BeXN
	 8NSc/N2uOX8iFxARuJ3IsnjIOvb5s7mkJfa69cGT7hhsYKDrzEr5AuTWfdYYn3IyFuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XauCFN3M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A27F606A323
	for <sparclinux@vger.kernel.org>; Thu, 29 Oct 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XauCFN3M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5551F01816;
	Thu, 29 Oct 2026 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793297992;
	bh=IK7SVDxoKjFhxh8AZRDcXnVXDtfnfCXd4y/pUJqXEfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XauCFN3MSluDA5ij+MgXlUCeZNPpvRuX7juM+nXglZlA1ts3JWhhjXeoEPxV9nk8I
	 dLb/7WV9+g9OoemBpZLnqTVkFxwIGOAlL5vhcY1qOHKHTSzcdI9XiUG0lEXLGu2mrG
	 o0AjAwgBRX2d6AmJIgPpW5OP7IJsyrR+hRmTRZZdABh+b9jrtfrzAL09H9qrNvtL45
	 7EpRV+q6hJ8ZHKqv51BsNQcEfpjejJPKYF/IgRPHcy6JlUTnYAyxgE6NEZQPo7tCfc
	 BZY6ElmA+Exb0TiF0B8XacHDAa5VVQrYTnwu2Z7E3il936GnaBrKhuynEz3FdqamYg
	 8l4Oc1D3RkuVw==
Message-ID: <sashiko-outbox-189792@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] sparc: populate sysfs cache topology information on
 sun4v
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jan Engelhardt" <jengelh@inai.de>
Cc: sparclinux@vger.kernel.org
In-Reply-To: <20261026180041.20089-1-jengelh@inai.de>
References: <20261026180041.20089-1-jengelh@inai.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 18:19:51 +0000
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] sparc: duplicate and unsorted cache leaves in mdesc_cache_walk()
- [High] sparc: unreset num_leaves in mdesc_cache_walk() causes hotplug OOB=
 access
- [High] sparc: NULL dereference and uninitialized len in mdesc_find_subobj=
ect()
- [High] sparc: non-pointer fw_token in mdesc_cache_fill() passed to of_nod=
e_put()
- [Medium] sparc: mdesc_cache_walk() misses exec_unit and direct cpu-to-cac=
he links
- [Medium] sparc: caching raw MDESC node indices breaks across mdesc_update=
()
- [Low] sparc: missing linux/cacheinfo.h include in arch/sparc/kernel/mdesc=
.c
- [Low] sparc: unguarded tlb_type in populate_cache_leaves() on SPARC32
--

commit 79d38e38d210e34aa15e627d6b85cc3737f2dc0b
Author: Jan Engelhardt <jengelh@inai.de>

sparc: populate sysfs cache topology information on sun4v

This commit populates generic cacheinfo structures in sysfs on sun4v systems
by recording each CPU's MDESC node offset and walking the MDESC execution-u=
nit
and cache hierarchy from init_cache_level() and populate_cache_leaves().

> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index 8e645ddac58e2..bfc3f422bffaa 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c
> @@ -1196,6 +1196,12 @@ static void *fill_in_one_cpu(struct mdesc_handle *=
hp, u64 mp, int cpuid,
> =20
>  	c =3D &cpu_data(cpuid);
>  	c->clock_tick =3D *cfreq;
> +	/*
> +	 * This will help more quickly finding the mdesc node again
> +	 * (otherwise we would have to iterate over all cpu nodes
> +	 * to locate any one with a given id).
> +	 */
> +	c->mdesc_node =3D mp;

[Severity: Medium]
Is it safe to cache the raw MDESC node index in cpu_data(cpuid).mdesc_node =
and
in leaf->fw_token across runtime Machine Description updates?

In arch/sparc/kernel/mdesc.c, an MDESC node handle (u64 mp) is an element
index into node_block(&hp->mdesc) of a specific struct mdesc_handle. On sun=
4v
LDOMs, when a runtime dynamic reconfiguration occurs, md_update_data() in
arch/sparc/kernel/ds.c calls mdesc_update() in arch/sparc/kernel/mdesc.c,
which replaces cur_mdesc with a newly allocated struct mdesc_handle whose r=
aw
node indices can shift:

arch/sparc/kernel/mdesc.c:mdesc_update() {
	...
	spin_lock_irqsave(&mdesc_lock, flags);
	orig_hp =3D cur_mdesc;
	cur_mdesc =3D hp;
	spin_unlock_irqrestore(&mdesc_lock, flags);
	...
}

Because fill_in_one_cpu() only runs for all CPUs at boot or for newly added
CPUs in dr_cpu_configure(), mdesc_update() does not refresh
cpu_data(cpuid).mdesc_node for already-present CPUs. If an existing CPU is
later taken offline and brought back online via cacheinfo_cpu_online() ->
detect_cache_attributes() -> mdesc_cache_walk(), mdesc_cache_walk() grabs t=
he
new cur_mdesc via mdesc_grab() and passes the stale cpu_data(cpuid).mdesc_n=
ode
into mdesc_find_subobject() -> mdesc_next_arc(), which scans node_block
starting at base + from + 1 without verifying that base + from is the target
CPU node.

Similarly, mdesc_cache_fill() stores the raw cache_node index in
leaf->fw_token, which cache_shared_cpu_map_setup() in drivers/base/cacheinf=
o.c
compares across online CPUs for equality. If a CPU is hotplugged via
dr_cpu_configure() -> add_cpu() or re-onlined after mdesc_update() shifts
cache node offsets, won't comparing fw_token values recorded from different
mdesc_handle generations fail to match shared caches or falsely match
unrelated caches?

> =20
>  	tb =3D &trap_block[cpuid];
>  	get_mondo_data(hp, mp, tb);
> @@ -1243,6 +1249,136 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
>  	smp_fill_in_sib_core_maps();
>  }
> =20
> +/**
> + * At MDESC node @node, analyze forward links to find the @want_target,
> + * and, if @want_type is not %NULL, that it is of the requested type.
> + */
> +static u64 mdesc_find_subobject(struct mdesc_handle *mdh, u64 iu_node,
> +				const char *want_target, const char *want_type)
> +{
> +	u64 iter;
> +
> +	mdesc_for_each_arc(iter, mdh, iu_node, MDESC_ARC_TYPE_FWD) {
> +		u64 sub_node =3D mdesc_arc_target(mdh, iter);
> +		const char *sub_name =3D mdesc_node_name(mdh, sub_node);
> +		const char *type_list;
> +		int len;
> +
> +		if (strcmp(sub_name, want_target) !=3D 0)
> +			continue;
> +		if (want_type =3D=3D NULL)
> +			return sub_node;
> +		type_list =3D mdesc_get_property(mdh, sub_node, "type", &len);
> +		if (of_find_in_proplist(type_list, want_type, len))
> +			return sub_node;

[Severity: High]
Can mdesc_find_subobject() dereference a NULL pointer here when a matching
node does not have a "type" property?

In mdesc_find_subobject(), len is declared uninitialized on the stack. In
arch/sparc/kernel/mdesc.c, mdesc_get_property() only writes to *lenp when t=
he
requested property is found; if sub_node lacks a "type" property,
mdesc_get_property() returns NULL and leaves len untouched (either
uninitialized or holding the length from a previous loop iteration).

mdesc_find_subobject() then passes type_list (which is NULL) and len direct=
ly
to of_find_in_proplist() in arch/sparc/kernel/prom_common.c:

arch/sparc/kernel/prom_common.c:of_find_in_proplist() {
	while (len > 0) {
		int l;

		if (!strcmp(list, match))
			return 1;
		...
	}
}

Whenever len > 0, strcmp(NULL, want_type) will be called and crash with a N=
ULL
pointer dereference. In addition, mdesc_node_name(mdh, sub_node) can return
NULL if sub_node is out of bounds or not an MD_NODE, and sub_name is passed=
 to
strcmp(sub_name, want_target) without a NULL check. Should both sub_name and
type_list be checked for NULL before use?

> +	}
> +	return -1;
> +}
> +
> +static void mdesc_cache_fill(struct mdesc_handle *mdh, u64 cache_node,
> +			     struct cacheinfo *leaf)

[Severity: Low]
Does arch/sparc/kernel/mdesc.c build with this change?

This file uses struct cacheinfo, struct cpu_cacheinfo, get_cpu_cacheinfo(),
and the CACHE_TYPE_UNIFIED, CACHE_TYPE_INST, and CACHE_TYPE_DATA constants =
in
mdesc_cache_fill() and mdesc_cache_record(), but linux/cacheinfo.h is only
included in arch/sparc/kernel/prom_common.c and not in
arch/sparc/kernel/mdesc.c. Should linux/cacheinfo.h be included in
arch/sparc/kernel/mdesc.c as well?

> +{
> +	int type_len;
> +	const u64 *level      =3D mdesc_get_property(mdh, cache_node, "level", =
NULL);
> +	const u64 *size       =3D mdesc_get_property(mdh, cache_node, "size", N=
ULL);
> +	const u64 *line_size  =3D mdesc_get_property(mdh, cache_node, "line-siz=
e", NULL);
> +	const u64 *assoc      =3D mdesc_get_property(mdh, cache_node, "associat=
ivity", NULL);
> +	const char *type_list =3D mdesc_get_property(mdh, cache_node, "type", &=
type_len);
> +
> +	leaf->fw_token =3D (void *)(uintptr_t)cache_node;

[Severity: High]
Won't storing the integer cache_node offset in leaf->fw_token cause an inva=
lid
pointer dereference in of_node_put() during CPU teardown when
CONFIG_OF_DYNAMIC is enabled?

On SPARC, CONFIG_OF is always enabled and paging_init() in
arch/sparc/mm/init_64.c unconditionally calls prom_build_devicetree() before
sun4v_mdesc_init(), which sets of_root so that of_have_populated_dt() always
returns true on sun4v.

When a CPU is taken offline (or if cacheinfo setup fails during
cacheinfo_cpu_online()), free_cache_attributes() in drivers/base/cacheinfo.c
calls cache_shared_cpu_map_remove():

drivers/base/cacheinfo.c:cache_shared_cpu_map_remove() {
	...
		if (of_have_populated_dt())
			of_node_put(this_leaf->fw_token);
	...
}

When CONFIG_OF_DYNAMIC is enabled, of_node_put() in drivers/of/dynamic.c
attempts to dereference this_leaf->fw_token as a struct device_node * via
kobject_put(&node->kobj), which will crash on the non-pointer MDESC node
index stored in leaf->fw_token.

[ ... ]

> +static int mdesc_cache_record(struct mdesc_handle *mdh, u64 cache_node,
> +			      unsigned int cpuid, unsigned int *leaf_count,
> +			      bool fill_it)
> +{
> +	struct cpu_cacheinfo *ci;
> +	const u64 *level =3D mdesc_get_property(mdh, cache_node, "level", NULL);
> +	u64 iter;
> +
> +	if (level =3D=3D NULL)
> +		return -ENOENT;
> +	ci =3D get_cpu_cacheinfo(cpuid);
> +	if (fill_it) {
> +		if (*leaf_count >=3D ci->num_leaves)
> +			return -ELOOP;
> +		mdesc_cache_fill(mdh, cache_node,
> +				 &ci->info_list[(*leaf_count)++]);
> +	} else {
> +		++ci->num_leaves;
> +		if (ci->num_levels < *level)
> +			ci->num_levels =3D *level;
> +	}

[Severity: High]
When a CPU is taken offline and brought back online, does incrementing
ci->num_leaves without resetting it to zero first cause out-of-bounds heap
accesses on sibling CPUs?

In drivers/base/cacheinfo.c, when a CPU goes offline via
cacheinfo_cpu_pre_down() -> free_cache_attributes(), ci->info_list is freed
and set to NULL, but ci->num_leaves and ci->num_levels are not cleared:

drivers/base/cacheinfo.c:free_cache_attributes() {
	if (!per_cpu_cacheinfo(cpu))
		return;

	cache_shared_cpu_map_remove(cpu);

	kfree(per_cpu_cacheinfo(cpu));
	per_cpu_cacheinfo(cpu) =3D NULL;
}

When the CPU is brought back online via cacheinfo_cpu_online() ->
detect_cache_attributes() -> init_cache_level() -> mdesc_cache_walk(cpuid,
false), neither mdesc_cache_walk() nor mdesc_cache_record() resets
ci->num_leaves or ci->num_levels before walking the MDESC. As a result,
++ci->num_leaves adds to the previous count N, inflating ci->num_leaves to
2 * N (and higher on subsequent offline/online cycles).

detect_cache_attributes() then allocates 2 * N leaves in ci->info_list, whi=
le
populate_cache_leaves() -> mdesc_cache_walk(cpuid, true) starts with local
leaf_count =3D 0 and only populates the first N leaves, leaving the remaini=
ng N
leaves zero-initialized. Next, cache_shared_cpu_map_setup() iterates index =
up
to cache_leaves(cpu) (which is 2 * N) and indexes into every other online
CPU's info_list:

drivers/base/cacheinfo.c:cache_shared_cpu_map_setup() {
	for (index =3D 0; index < cache_leaves(cpu); index++) {
		...
		for_each_online_cpu(i) {
			struct cpu_cacheinfo *sib_cpu_ci =3D get_cpu_cacheinfo(i);

			if (i =3D=3D cpu || !sib_cpu_ci->info_list)
				continue;/* skip if itself or no cacheinfo */
			sib_leaf =3D sib_cpu_ci->info_list + index;
			if (cache_leaves_are_shared(this_leaf, sib_leaf)) {
				cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map);
				cpumask_set_cpu(i, &this_leaf->shared_cpu_map);
			}
		}
	}
}

Because the other online CPUs only have N elements allocated in
sib_cpu_ci->info_list, won't sib_cpu_ci->info_list + index for index >=3D N=
 read
past the end of the sibling's slab allocation, and corrupt heap memory via
cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map) if the out-of-bounds fw_tok=
en
happens to be NULL?

> +
> +	mdesc_for_each_arc(iter, mdh, cache_node, MDESC_ARC_TYPE_FWD) {
> +		u64 sub_node =3D mdesc_arc_target(mdh, iter);
> +		const char *sub_name =3D mdesc_node_name(mdh, sub_node);
> +		int ret;
> +
> +		if (strcmp(sub_name, "cache") !=3D 0)
> +			continue;
> +		ret =3D mdesc_cache_record(mdh, sub_node, cpuid,
> +					 leaf_count, fill_it);
> +		if (ret !=3D 0)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +int mdesc_cache_walk(unsigned int cpuid, bool fill_it)
> +{
> +	/*
> +	 * ifetch is where instruction caches are reported under.
> +	 * integer is where data cahes are reported under.
> +	 *
> +	 * The MDESCs of e.g. the SUNW,T5240 and ORCL,SPARC-S7-2 machines
> +	 * use "integer". Which machines are using "int"?
> +	 */
> +	static const char *const unit_kinds[] =3D {"ifetch", "integer", "int"};
> +	unsigned int leaf_count =3D 0;
> +	int ret =3D 0;
> +	struct mdesc_handle *mdh =3D mdesc_grab();
> +
> +	if (mdh =3D=3D NULL)
> +		return -ENOENT;
> +
> +	for (unsigned int i =3D 0; i < ARRAY_SIZE(unit_kinds); ++i) {
> +		u64 node =3D mdesc_find_subobject(mdh, cpu_data(cpuid).mdesc_node,
> +						"exec-unit", unit_kinds[i]);
> +		if (node =3D=3D -1)
> +			continue;
> +		node =3D mdesc_find_subobject(mdh, node, "cache", NULL);
> +		if (node =3D=3D -1)
> +			continue;
> +		ret =3D mdesc_cache_record(mdh, node, cpuid,
> +					 &leaf_count, fill_it);
> +		if (ret !=3D 0)
> +			break;
> +	}

[Severity: High]
Doesn't this depth-first walk across unit_kinds[] record shared unified cac=
hes
multiple times per CPU and populate ci->info_list[] out of cache level orde=
r?

In the sun4v MDESC graph, the instruction cache chain (under "ifetch") and =
the
data cache chain (under "integer" or "int") both link forward to shared
unified higher-level cache nodes (for example, L1i -> L2 and L1d -> L2 on
UltraSPARC T2, or L1i -> L2i -> L3 and L1d -> L2d -> L3 on SPARC S7-2).

Because mdesc_cache_record() recurses depth-first through all forward "cach=
e"
arcs for each execution unit without tracking already-visited cache_node
values for cpuid:

1. Every unified higher-level cache reachable from both the instruction and
   data execution units (or from an exec-unit whose "type" property list
   contains both "integer" and "int") is counted twice in ci->num_leaves and
   populated twice in ci->info_list[], creating duplicate sysfs cache index
   directories (e.g. index0..index5 on S7-2 with two L3 entries per CPU).

2. Leaves are recorded in depth-first branch order (such as L1i, L2i, L3, L=
1d,
   L2d, L3) rather than sorted by cache level (L1i, L1d, L2i, L2d, L3),
   contrary to the comment in populate_cache_leaves() in
   arch/sparc/kernel/prom_common.c noting that drivers/base/cacheinfo expec=
ts
   leaves to be sorted by level.

[Severity: Medium]
Also in mdesc_cache_walk(), what happens on sun4v machines whose MDESC uses
"exec_unit" (with an underscore) or links "cache" nodes directly from "cpu"
nodes?

Earlier in arch/sparc/kernel/mdesc.c, set_proc_ids() checks both "exec_unit"
and "exec-unit", and fill_in_one_cpu() walks both direct cpu -> cache forwa=
rd
arcs and two-hop cpu -> node -> cache forward arcs:

arch/sparc/kernel/mdesc.c:set_proc_ids() {
	__set_proc_ids(hp, "exec_unit");
	__set_proc_ids(hp, "exec-unit");
}

Because mdesc_cache_walk() only looks for "exec-unit" intermediate nodes,
won't it fail to find any caches and return 0 with ci->num_leaves =3D=3D 0 =
on
sun4v platforms that use "exec_unit" or direct cpu-to-cache arcs?

> +	mdesc_release(mdh);
> +	return ret;
> +}
> +
>  /* mdesc_open() - Grab a reference to mdesc_handle when /dev/mdesc is
>   * opened. Hold this reference until /dev/mdesc is closed to ensure
>   * mdesc data structure is not released underneath us. Store the
> diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_com=
mon.c
> index c9ec70888a394..f3f655606cc6b 100644
> --- a/arch/sparc/kernel/prom_common.c
> +++ b/arch/sparc/kernel/prom_common.c

[ ... ]

> +int populate_cache_leaves(unsigned int cpuid)
> +{
> +	/*
> +	 * Note that drivers/base/cacheinfo expects leaves to be sorted by
> +	 * level, then by index in [inst, data_or_unified]. Code should fill
> +	 * in leaves in that order (else, a call to qsort will be needed).
> +	 */
> +	int ret =3D -ENOENT;
> +	switch (tlb_type) {
> +#ifdef CONFIG_SPARC64
> +	case hypervisor:
> +		ret =3D mdesc_cache_walk(cpuid, true);
> +		break;
> +#endif
> +	default:
> +		break;
> +	}

[Severity: Low]
Does populate_cache_leaves() compile on 32-bit SPARC (CONFIG_SPARC32)?

arch/sparc/kernel/prom_common.c is built for both 32-bit and 64-bit SPARC v=
ia
obj-y +=3D prom_common.o in arch/sparc/kernel/Makefile, whereas tlb_type is=
 only
declared inside #ifdef CONFIG_SPARC64 in arch/sparc/include/asm/spitfire.h.
Unlike init_cache_level() above, switch (tlb_type) here is outside the
#ifdef CONFIG_SPARC64 guard. Should the entire switch (or if check, matching
init_cache_level()) be placed inside #ifdef CONFIG_SPARC64?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026180041.2008=
9-1-jengelh@inai.de?part=3D1
