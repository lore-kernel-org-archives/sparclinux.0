Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793044530;
	b=0g0V9eulwomi0/49P2l6zwvErXkKogPLBD3bid6oJp0mA29lstUTBJ6fJ5lih67mT2DY
	 SB4vUaQLR67gh2UxmilBdLBG31iY+cdhBjH6BTIZUGAmcdzTlLnOISOH8MadEH7dPXYGQ
	 gbj0bYFaLaqiYh9ICvwAEkMrHxcQs+zDDS97X9aMGW0TfuRi1NWjTgi6ddUMeleUcra0/
	 /ScpZlWpXasr9wVJaIdXhxCVXr3Ag08v4Vz/YZCBiaCTZA2QYfh7oTUdfEjGpMPSMjMXM
	 /c7Prn0INfkusTtNGi8/oxJwzu38/ugnWOWmpoiTbtzryYECtfe/VFNY1Mm6LeYHr/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793044530;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rHKoPgAyise/ky2BxPodsv1NwYVm5pXYb1FFMspPdZA=;
	b=0Y/LYIXWiOJzdGBRmsDIZEEfyvB6sYcBMt2YNn8NNAtolOCD/+sXUFlz5qMKySZ8Cu7n
	 sPujdkrsbwYeAT2xzc20R1bcjmPwiRM0/X2SHMzbFNyFKdVmbqX4xWBuNCGcImAOQMMOj
	 fFXzZsNx7CqgwZGip9+zLkDWcqVrv/HzY1HXtAVeAjEBSOiWYZbYxGlX0qOdL/kZ76Uxw
	 U4bPnGPoii6UozVPl2ny40LVfzn/rABdGCnSKPcVZFNkwouIsW3L+q3VGC81TqccBn6/m
	 YcvYX2OrqQ0iG9ec0V/+DfQGmetJME5C4u1tF0gPDcjeftN7z09dTrQq8ooWWGum7eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3q2jsOt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1893A606A31A
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L3q2jsOt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E181F01825;
	Mon, 26 Oct 2026 19:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793044529;
	bh=rHKoPgAyise/ky2BxPodsv1NwYVm5pXYb1FFMspPdZA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=L3q2jsOtAKvNTLSYJHd6POhto3pkMhELguNX8vTRDOzr/LFPs4lFQEryUjt/xfN9K
	 lSNPQr8YIixV0T1skYaATPTvWyh96aVQENjcE6nUuIsZS/W6qjSZhpyLPJQw+J5Cwv
	 hEczJWac80lK6BCW7lLkiSKZM/MGlSc3/w81skhXSIoQRD6YJFYRXPw/xVWGNubpc4
	 66LWBzhtBEyS9RkasvmvfIDhhoNeLbE6eQof7fFjyoeKktTw4vzHGZFXBcivRPWXC8
	 INylKd0yXpf7HovUgeRNm7//ZXikIeP6rbQgkgsZqFKIlYg9lTBkYQEjHH27V1xzqr
	 4RlOmjOTHWgnw==
Message-ID: <sashiko-outbox-185691@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on
 sun4v
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jan Engelhardt" <jengelh@inai.de>, sparclinux@vger.kernel.org
In-Reply-To: <20261026193421.20404-1-jengelh@inai.de>
References: <20261026193421.20404-1-jengelh@inai.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 19:55:29 +0000
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
- [Critical] sparc: unreset num_leaves in mdesc_cache_walk() causes OOB on =
CPU hotplug
- [High] sparc: non-pointer fw_token in mdesc_cache_fill() passed to of_nod=
e_put()
- [High] sparc: NULL dereference and uninitialized len in mdesc_find_subobj=
ect()
- [High] sparc: depth-first walk in mdesc_cache_record() duplicates and mis=
orders leaves
- [High] sparc: mdesc: stale raw mdesc node indices cached in cpu_data and =
fw_token
- [Medium] sparc: mdesc_cache_walk() misses direct cache arcs and exec_unit=
 nodes
- [Low] sparc: missing linux/cacheinfo.h include in arch/sparc/kernel/mdesc=
.c
- [Low] sparc: unguarded tlb_type in populate_cache_leaves() breaks build
--

commit 6af74801a44f46a9a2d5477d269ec4c8488504e6
Author: Jan Engelhardt <jengelh@inai.de>

sparc: populate sysfs cache topology information on sun4v

This commit populates generic sysfs cacheinfo structures on sun4v systems by
walking the hypervisor Machine Description (MDESC) cache hierarchy from
init_cache_level() and populate_cache_leaves().

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

[Severity: High]
Can caching raw MDESC node indices in cpu_data(cpuid).mdesc_node and
leaf->fw_token become stale across runtime Machine Description updates?

In arch/sparc/kernel/mdesc.c, node identifiers are raw array indices into
node_block(&hp->mdesc). When the hypervisor updates the Machine Description=
 at
runtime via md_update_data() -> mdesc_update(), cur_mdesc is replaced and r=
aw
node indices can shift, as noted in arch/sparc/kernel/vio.c:vio_vdev_node():

    /* Node numbers arevesion-specific and cannot be cached across
     * mdesc_update() calls...
     */

However, mdesc_update() does not refresh cpu_data(cpuid).mdesc_node for
existing CPUs, and dr_cpu_configure() only calls mdesc_fill_in_cpu_data() f=
or
newly configured CPUs.

If an existing CPU is offlined and re-onlined after mdesc_update(),
cacheinfo_cpu_online() -> detect_cache_attributes() -> mdesc_cache_walk()
grabs the new cur_mdesc and passes the stale cpu_data(cpuid).mdesc_node into
mdesc_find_subobject() -> mdesc_next_arc():

    if (from =3D=3D MDESC_NODE_NULL || from >=3D last_node)
        return MDESC_NODE_NULL;

    ep =3D base + from;

    ep++;
    for (; ep->tag !=3D MD_NODE_END; ep++) {

Because mdesc_next_arc() does not check that base[from].tag =3D=3D MD_NODE =
before
advancing ep and scanning until MD_NODE_END, a stale index can walk the wro=
ng
node or scan past node_block if from lands on the final MD_NODE_END or
MD_LIST_END element.

Similarly, mdesc_cache_fill() stores the raw cache_node index in
leaf->fw_token. If CPUs are hot-added via dr_cpu_configure() -> add_cpu()
after mdesc_update(), newly added CPUs get leaf->fw_token values from the n=
ew
MDESC while already-online CPUs retain sib_leaf->fw_token values from the o=
ld
MDESC. When cache_shared_cpu_map_setup() calls cache_leaves_are_shared(),
could comparing those raw indices across different MDESC generations corrupt
shared_cpu_map?

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
What happens in mdesc_find_subobject() if a matching sub_node does not have=
 a
"type" property?

When mdesc_get_property(mdh, sub_node, "type", &len) returns NULL, len is l=
eft
uninitialized (or retains its value from the previous loop iteration). Pass=
ing
type_list =3D=3D NULL and an uninitialized len to of_find_in_proplist() will
dereference NULL in strcmp(list, match) whenever len > 0:

arch/sparc/kernel/prom_common.c:of_find_in_proplist() {
    while (len > 0) {
        int l;

        if (!strcmp(list, match))
            return 1;
        ...
    }
}

Should mdesc_find_subobject() check that type_list !=3D NULL before calling
of_find_in_proplist(), similar to mdesc_cache_fill()?

> +	}
> +	return -1;
> +}
> +
> +static void mdesc_cache_fill(struct mdesc_handle *mdh, u64 cache_node,
> +			     struct cacheinfo *leaf)
> +{

[Severity: Low]
Does arch/sparc/kernel/mdesc.c build without including linux/cacheinfo.h?

mdesc_cache_fill() and mdesc_cache_record() dereference struct cacheinfo and
struct cpu_cacheinfo, use CACHE_TYPE_UNIFIED, CACHE_TYPE_INST, and
CACHE_TYPE_DATA, and call get_cpu_cacheinfo(), which are all defined in
linux/cacheinfo.h. The patch adds linux/cacheinfo.h to
arch/sparc/kernel/prom_common.c, but not to arch/sparc/kernel/mdesc.c or
arch/sparc/include/asm/mdesc.h, causing compilation of mdesc.c to fail on
CONFIG_SPARC64.

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
Is it safe to store a non-pointer MDESC node index in leaf->fw_token when
of_have_populated_dt() is true?

On SPARC (including sun4v), CONFIG_OF is enabled and prom_build_devicetree()
populates of_root at boot, so of_have_populated_dt() returns true.

In drivers/base/cacheinfo.c, cache_shared_cpu_map_remove() assumes that
whenever of_have_populated_dt() is true, this_leaf->fw_token is a struct
device_node pointer and passes it to of_node_put():

drivers/base/cacheinfo.c:cache_shared_cpu_map_remove() {
    ...
        if (of_have_populated_dt())
            of_node_put(this_leaf->fw_token);
    ...
}

When a CPU is offlined (cacheinfo_cpu_pre_down() -> free_cache_attributes()=
 ->
cache_shared_cpu_map_remove()) or cacheinfo setup fails and cleans up,
of_node_put() is called with the small integer cache_node cast to a pointer.
If CONFIG_OF_DYNAMIC is enabled, of_node_put() calls kobject_put(&node->kob=
j)
and dereferences the small integer as a pointer.

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

[Severity: Critical]
Will incrementing ci->num_leaves in place without resetting it to zero cause
out-of-bounds slab accesses across CPU hotplug?

When a CPU is offlined, free_cache_attributes() in drivers/base/cacheinfo.c
frees per_cpu_cacheinfo(cpu) (ci->info_list), but does not clear
ci->num_leaves or ci->num_levels:

drivers/base/cacheinfo.c:free_cache_attributes() {
    if (!per_cpu_cacheinfo(cpu))
        return;

    cache_shared_cpu_map_remove(cpu);

    kfree(per_cpu_cacheinfo(cpu));
    per_cpu_cacheinfo(cpu) =3D NULL;
}

When that CPU is brought back online, detect_cache_attributes() calls
init_cache_level(cpuid) -> mdesc_cache_walk(cpuid, false) ->
mdesc_cache_record(), which adds to the existing ci->num_leaves value inste=
ad
of starting from 0.

For a CPU with N cache leaves, re-onlining it inflates ci->num_leaves to 2*N
(and by another N on each subsequent offline/online cycle).
detect_cache_attributes() then allocates ci->info_list with 2*N entries, wh=
ile
populate_cache_leaves() only fills the first N entries, leaving entries N..=
2*N-1
zeroed.

Next, cache_shared_cpu_map_setup() loops index from 0 to cache_leaves(cpu) =
- 1
(which is 2*N - 1) and indexes directly into every other online sibling CPU=
's
info_list (which only has N entries):

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

For index >=3D N, sib_leaf points past the end of sib_cpu_ci->info_list, re=
ading
out-of-bounds heap memory in cache_leaves_are_shared() and corrupting adjac=
ent
slab memory via cpumask_set_cpu(cpu, &sib_leaf->shared_cpu_map) whenever the
out-of-bounds fw_token word happens to be NULL (matching the unpopulated
this_leaf->fw_token =3D=3D NULL).

Should ci->num_leaves and ci->num_levels be reset to 0 before walking the
MDESC in init_cache_level() / mdesc_cache_walk(cpuid, false)?

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

[Severity: High]
Does this recursive depth-first walk in mdesc_cache_record() duplicate shar=
ed
unified caches and populate leaves out of level order?

In the sun4v MDESC DAG, both the instruction cache chain (under "ifetch") a=
nd
the data cache chain (under "integer"/"int") have forward "cache" arcs that
converge on unified higher-level caches (such as unified L2 on T5240 or
unified L3 on S7-2).

Because mdesc_cache_walk() walks the entire forward "cache" chain from each
unit_kinds[] entry in depth-first order without tracking already-visited ca=
che
nodes for cpuid:

1. Any unified L2 or L3 cache reachable from both the instruction and data
   cache paths (or from an exec-unit matching both "integer" and "int") is
   counted and populated multiple times in ci->info_list[] for the same CPU.

2. All higher-level caches reachable from "ifetch" (e.g. L2i and L3, or
   unified L2) are recorded before L1d under "integer", leaving ci->info_li=
st
   unsorted by cache level despite drivers/base/cacheinfo expecting leaves =
to
   be ordered by level.

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

[Severity: Medium]
Could mdesc_cache_walk() miss caches on sun4v machines that use "exec_unit"
nodes or link "cpu" nodes directly to "cache" nodes?

Earlier in arch/sparc/kernel/mdesc.c, set_proc_ids() checks both "exec_unit"
and "exec-unit":

    static void set_proc_ids(struct mdesc_handle *hp)
    {
        __set_proc_ids(hp, "exec_unit");
        __set_proc_ids(hp, "exec-unit");
    }

And fill_in_one_cpu() checks both direct cpu -> cache forward arcs and 2-hop
cpu -> child -> cache forward arcs:

    mdesc_for_each_arc(a, hp, mp, MDESC_ARC_TYPE_FWD) {
        u64 j, t =3D mdesc_arc_target(hp, a);
        const char *t_name;

        t_name =3D mdesc_node_name(hp, t);
        if (!strcmp(t_name, "cache")) {
            fill_in_one_cache(c, hp, t);
            continue;
        }
        ...
    }

Because mdesc_cache_walk() only looks for "exec-unit" subobjects, sun4v
systems whose MDESC uses "exec_unit" or direct cpu -> cache arcs (such as
UltraSPARC T1) will not have any cache leaves populated.

[ ... ]

> diff --git a/arch/sparc/kernel/prom_common.c b/arch/sparc/kernel/prom_com=
mon.c
> index c9ec70888a394..f3f655606cc6b 100644
> --- a/arch/sparc/kernel/prom_common.c
> +++ b/arch/sparc/kernel/prom_common.c

[ ... ]

> @@ -112,6 +114,38 @@ int of_find_in_proplist(const char *list, const char=
 *match, int len)
>  }
>  EXPORT_SYMBOL(of_find_in_proplist);
> =20
> +int init_cache_level(unsigned int cpuid)
> +{
> +#ifdef CONFIG_SPARC64
> +	if (tlb_type =3D=3D hypervisor)
> +		return mdesc_cache_walk(cpuid, false);
> +#endif
> +	return -ENOENT;
> +}
> +
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
Does switch (tlb_type) in populate_cache_leaves() break the build on
CONFIG_SPARC32 or CONFIG_SPARC64 && !CONFIG_SMP?

arch/sparc/kernel/prom_common.c is built for both 32-bit and 64-bit SPARC, =
but
tlb_type and the hypervisor enumerator are only declared in
arch/sparc/include/asm/spitfire.h under #ifdef CONFIG_SPARC64.

In init_cache_level(), the tlb_type check is inside #ifdef CONFIG_SPARC64,
whereas in populate_cache_leaves(), switch (tlb_type) is outside the #ifdef,
causing an undeclared identifier error on CONFIG_SPARC32.

Additionally, arch/sparc/kernel/prom_common.c does not include asm/spitfire=
.h
directly, so on CONFIG_SPARC64 && !CONFIG_SMP where linux/smp.h does not pu=
ll
in asm/smp.h -> asm/spitfire.h, tlb_type and hypervisor are undeclared in b=
oth
functions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026193421.2040=
4-1-jengelh@inai.de?part=3D1
