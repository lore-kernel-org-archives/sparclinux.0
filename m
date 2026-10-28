Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793183401;
	b=RFqj6KUDRjZOUpu+I0k+cLVWSa8iHkoTwBCZdMypoG9FGRm+QBPnway/bsNtwk3wAxB/
	 ctws9WIAH4SHie2+J/+wqJEcwM6rXMVwNc5OA2dmAwxZg5kN90xy6wmqTd1hEJZUPT3uR
	 zZgDqaUzE9OpKecA9kC6URcGhFAxJTcs0+4e12+pyJsQ02nFwj50bxO64KumP8nNNIDcI
	 pK8VuK2f6MktUaLpv5UJizZ5KLDLBHxQhZ1jSc0xvghKVqchZiwml7FOO9gAUypCWiTnq
	 9/OPR//gMV/uQVtd4tc5T6jd8suBUUQn5oCyCEpc+JrqfV1GpPX7SsqtlNWtSZZCJlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793183401;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=CSBu1FdN1ihKmfip7S0Rtb0F+Hrxq5UCynvgk5H0WYs=;
	b=GVZk5t6aAodpX0ns12Wpu2q61OxrGZ/nNij6cy62cdNVsJtMwz8/o4x/YnelSwfZhfqe
	 /qhqLZL+3071ZUj4rmuof347cqY6vdVBS6kvWKLAm3DnQfp0WLWeMgM7k2oIX/H6AYSzh
	 vQ9Rasb0ibnvUbkg9ietZouRGQZkBPNky1S4CYIagPobIWm+c+mdXGO4hf17CMg+gNNh3
	 PWQD0/fKF4ojWNJ+5/JtTjDrwofxT3xAx8YnOqG2t2OU/9C4RgZmfAiz30DzcpVRgMfNZ
	 mM2MB3uTwEkiuTVvadITcv3xCjUj+siS2NQ4nkg9HLXAKlDkK8AXbkk4UORI/waLlLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=kQs9tfcp;
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3023606A31A
	for <sparclinux@vger.kernel.org>; Wed, 28 Oct 2026 10:29:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3023606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=kQs9tfcp
Message-ID: <fb5d3f4177c2fd33f72833ef84e093826d6bff6e.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1793183397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSBu1FdN1ihKmfip7S0Rtb0F+Hrxq5UCynvgk5H0WYs=;
	b=kQs9tfcpH/LvZ9XC9S0I5jWaQLdcKpaowrcjip7O5F2C36o34utrdKE2HPpK+Oqm1P3wHk
	ugRcGdD7TEx/PuuvEoD+xhn3VvBj1F3J3fWMjP6ZDCrAxfXdxMgf9KyVWARB+AcVi3JqEL
	I090Vem3vdq4oeRo677vbDUTO/DqJKg=
Subject: Re: [PATCH v3] sparc: populate sysfs cache topology information on
 sun4v
From: Stian Halseth <stian@itx.no>
To: Jan Engelhardt <jengelh@inai.de>, andreas@gaisler.com
Cc: sparclinux@vger.kernel.org, unixpro1970@gmail.com, 
	glaubitz@physik.fu-berlin.de
Date: Wed, 28 Oct 2026 11:29:56 +0100
In-Reply-To: <20261028010100.24792-1-jengelh@inai.de>
References: <20261028010100.24792-1-jengelh@inai.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-rMmpzQThUtHcESiNvv63"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-rMmpzQThUtHcESiNvv63
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Thanks for the updated patch!

I see Sashiko is already making your day great, so I won't add too much on =
top
of that, but one thing that Sashiko didn't mention.

With fw_token cleared and no CACHE_ID, last_level_cache_is_valid() is false
for every CPU, so the scheduler's LLC size and the page allocator's per-cpu
sizing still don't see the L3; only sysfs gets it.=A0

Setting CACHE_ID with a stable id (say the lowest cpu id behind the cache,
like x86 does with the APIC id) and leaving shared_cpu_map to the generic c=
ode
would fix that, and also gets rid of the hotplug issue and the fw_token
clearing.

/Stian

On Wed, 2026-10-28 at 02:00 +0100, Jan Engelhardt wrote:
> The SPARC port (arch/sparc/) originally invented its own way of
> reporting cache sizes for Linux version 2.6.22, by providing e.g.
> /sys/devices/system/cpu/cpu0/l1_icache_size. lscpu (util-linux 2.37)
> gained code just to read these SPARC-specific sysfs files.
>=20
> The Linux kernel gained a generic cacheinfo reporting mechanism
> (drivers/base/cacheinfo.c) in v3.19, but arch/sparc's sysfs files
> were not unified into it, unfortunately.
>=20
> Because the SPARC sysfs files convey no information about the shared
> nature of caches, lscpu (util-linux 2.42) overreports cache numbers.
> For example, on a T5240 machine:
>=20
> ```
> Model name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 UltraSparc T2 (Niagara2)
> =A0 Thread(s) per core:=A0 4
> =A0 Core(s) per socket:=A0 16
> =A0 Socket(s):=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
> =A0 Flags:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sun4v
> Caches (sum of all):
> =A0 L1d:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 MiB (128 insta=
nces)
> =A0 L1i:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2 MiB (128 insta=
nces)
> =A0 L2:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 512 MiB (128 i=
nstances)
> ```
>=20
> The SPARC port also lacked reporting L3 caches, present in the
> Oracle S3 and Fujitsu SPARC64 XII cores (machines: Oracle T4
> onwards and Fujitsu M12, respectively.)
>=20
> On a SPARC S7-2:
>=20
> ```
> Model name:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SPARC-S7 (Sonoma)
> =A0 Thread(s) per core:=A0 8
> =A0 Core(s) per socket:=A0 8
> =A0 Socket(s):=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2
> =A0 Flags:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 sun4v
> Caches (sum of all):
> =A0 L1d:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 256 KiB (16 inst=
ances)
> =A0 L1i:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 256 KiB (16 inst=
ances)
> =A0 L2:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2 MiB (8 insta=
nces)
> ```
>=20
> This patch implements population of the sysfs cacheinfo structures
> for sun4v. The proper amount is now reflected in lscpu's output:
>=20
> ```
> <<T5240>>
> Caches (sum of all):
> =A0 L1d:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 128 KiB (16 inst=
ances)
> =A0 L1i:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 256 KiB (16 inst=
ances)
> =A0 L2:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 8 MiB (2 insta=
nces)
>=20
> <<S7-2>>
> =A0 L1d:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 256 KiB (16 inst=
ances)
> =A0 L1i:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 256 KiB (16 inst=
ances)
> =A0 L2d:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 2 MiB (8 instanc=
es)
> =A0 L2i:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 MiB (4 instanc=
es)
> =A0 L3:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 32 MiB (4 inst=
ances)
> ```
>=20
> ---
> v3:
> //current
> * Resolved the issue that only the first cache of any integer unit
> =A0 was looked at.
> * Resolved the issue that only the first integer unit of any strand
> =A0 was looked at.
> * Resolved the issue that only integer units were considered for caches.
> * No more duplicated cache entries under
> =A0 /sys/devices/system/cpu/cpu0/cache/indexN.
> * No longer keep unstable MDESC node ids around past their lifetime.
>=20
> v2:
> //Message-ID: <20261026193421.20404-1-jengelh@inai.de>
> * Rewalk MDESC rather than sourcing cache info from struct cpuinfo_sparc.
> * Support L3 caches found on SPARC T4 and later machine models.
>=20
> v1:
> //Message-ID: <20261018222723.43442-1-jengelh@inai.de>
>=20
> =A0arch/sparc/include/asm/cpudata_64.h |=A0=A0 1 +
> =A0arch/sparc/include/asm/mdesc.h=A0=A0=A0=A0=A0 |=A0=A0 2 +
> =A0arch/sparc/kernel/mdesc.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 215 ++++++++=
++++++++++++++++++++
> =A0arch/sparc/kernel/prom_common.c=A0=A0=A0=A0 |=A0 53 +++++++
> =A04 files changed, 271 insertions(+)
>=20
> diff --git a/arch/sparc/include/asm/cpudata_64.h
> b/arch/sparc/include/asm/cpudata_64.h
> index 056b3c0e7ef9..57b020ba93e0 100644
> --- a/arch/sparc/include/asm/cpudata_64.h
> +++ b/arch/sparc/include/asm/cpudata_64.h
> @@ -29,6 +29,7 @@ typedef struct {
> =A0	unsigned short	core_id;
> =A0	unsigned short=A0 max_cache_id;	/* groupings of highest shared
> cache */
> =A0	signed short	proc_id;	/* strand (aka HW thread) id */
> +	u64=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mdesc_node;
> =A0} cpuinfo_sparc;
> =A0
> =A0DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
> diff --git a/arch/sparc/include/asm/mdesc.h b/arch/sparc/include/asm/mdes=
c.h
> index ec31a06d04cc..71e77641f158 100644
> --- a/arch/sparc/include/asm/mdesc.h
> +++ b/arch/sparc/include/asm/mdesc.h
> @@ -90,6 +90,8 @@ u64 mdesc_get_node(struct mdesc_handle *hp, const char
> *node_name,
> =A0int mdesc_get_node_info(struct mdesc_handle *hp, u64 node,
> =A0			const char *node_name, union md_node_info
> *node_info);
> =A0
> +int mdesc_cache_walk(unsigned int cpuid, bool fill_it);
> +
> =A0void mdesc_fill_in_cpu_data(cpumask_t *mask);
> =A0void mdesc_populate_present_mask(cpumask_t *mask);
> =A0void mdesc_get_page_sizes(cpumask_t *mask, unsigned long *pgsz_mask);
> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index ecd6c8ae49c7..0e400b451b4b 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c
> @@ -11,6 +11,7 @@
> =A0#include <linux/mm.h>
> =A0#include <linux/miscdevice.h>
> =A0#include <linux/memblock.h>
> +#include <linux/cacheinfo.h>
> =A0#include <linux/export.h>
> =A0#include <linux/refcount.h>
> =A0
> @@ -1242,6 +1243,220 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
> =A0	smp_fill_in_sib_core_maps();
> =A0}
> =A0
> +/**
> + * Return the MDESC node for a "cpu" object whose "id" property
> + * matches @cpuid.
> + */
> +static u64 mdesc_find_cpu(struct mdesc_handle *mdh, int cpuid)
> +{
> +	u64 iter;
> +	mdesc_for_each_node_by_name(mdh, iter, "cpu") {
> +		const u64 *id =3D mdesc_get_property(mdh, iter, "id", NULL);
> +		if (id !=3D NULL && *id =3D=3D cpuid)
> +			return iter;
> +	}
> +	return MDESC_NODE_NULL;
> +}
> +
> +/**
> + * Obtain the properties of a given MDESC cache object node and fill in =
the
> + * Linux representation (struct cacheinfo) for it.
> + */
> +static void mdesc_cache_fill(struct mdesc_handle *mdh, u64 cache_node,
> +			=A0=A0=A0=A0 struct cacheinfo *leaf)
> +{
> +	int type_len;
> +	const u64 *level=A0=A0=A0=A0=A0 =3D mdesc_get_property(mdh, cache_node,
> "level", NULL);
> +	const u64 *size=A0=A0=A0=A0=A0=A0 =3D mdesc_get_property(mdh, cache_nod=
e, "size",
> NULL);
> +	const u64 *line_size=A0 =3D mdesc_get_property(mdh, cache_node, "line-
> size", NULL);
> +	const u64 *assoc=A0=A0=A0=A0=A0 =3D mdesc_get_property(mdh, cache_node,
> "associativity", NULL);
> +	const char *type_list =3D mdesc_get_property(mdh, cache_node, "type",
> &type_len);
> +
> +	/*
> +	 * fw_token is only temporary. It will be cleared again before the
> +	 * MDESC is unpinned.
> +	 */
> +	leaf->fw_token =3D (void *)(uintptr_t)cache_node;
> +	leaf->level =3D *level;
> +	if (type_list !=3D NULL) {
> +		bool i =3D of_find_in_proplist(type_list, "instn", type_len);
> +		bool d =3D of_find_in_proplist(type_list, "data", type_len);
> +		if (i && d)
> +			leaf->type =3D CACHE_TYPE_UNIFIED;
> +		else if (i)
> +			leaf->type =3D CACHE_TYPE_INST;
> +		else if (d)
> +			leaf->type =3D CACHE_TYPE_DATA;
> +	}
> +	if (size !=3D NULL)
> +		leaf->size =3D *size;
> +	if (line_size !=3D NULL)
> +		leaf->coherency_line_size =3D *line_size;
> +	if (assoc !=3D NULL)
> +		leaf->ways_of_associativity =3D *assoc;
> +	if (leaf->coherency_line_size !=3D 0 && leaf->ways_of_associativity
> !=3D 0)
> +		leaf->number_of_sets =3D leaf->size / leaf-
> >coherency_line_size /
> +				=A0=A0=A0=A0=A0=A0 leaf->ways_of_associativity;
> +}
> +
> +/**
> + * Populate the sharedness bitmap of a given struct cacheinfo by walking=
 up
> the
> + * cache chain again and finding all CPUs.
> + */
> +static void mdesc_cache_set_shared(struct mdesc_handle *mdh, u64
> cache_node,
> +				=A0=A0 struct cacheinfo *leaf)
> +{
> +	unsigned int maxcpus =3D num_possible_cpus();
> +	u64 sup_iter, cpu_iter;
> +
> +	mdesc_for_each_arc(sup_iter, mdh, cache_node, MDESC_ARC_TYPE_BACK)
> {
> +		u64 sup_node =3D mdesc_arc_target(mdh, sup_iter);
> +		const char *tg_name =3D mdesc_node_name(mdh, sup_node);
> +
> +		if (strcmp(tg_name, "cache") =3D=3D 0)
> +			mdesc_cache_set_shared(mdh, sup_node, leaf);
> +		if (strcmp(tg_name, "exec-unit") !=3D 0)
> +			continue;
> +
> +		mdesc_for_each_arc(cpu_iter, mdh, sup_node,
> MDESC_ARC_TYPE_BACK) {
> +			u64 cpu_node =3D mdesc_arc_target(mdh, cpu_iter);
> +			tg_name =3D mdesc_node_name(mdh, cpu_node);
> +
> +			if (strcmp(tg_name, "cpu") !=3D 0)
> +				continue;
> +			const u64 *id =3D mdesc_get_property(mdh, cpu_node,
> "id", NULL);
> +			if (id =3D=3D NULL)
> +				continue;
> +			if (id !=3D NULL && *id < maxcpus)
> +				cpumask_set_cpu(*id, &leaf-
> >shared_cpu_map);
> +		}
> +	}
> +}
> +
> +static bool seen_cache(const struct cacheinfo *leaf, size_t n, u64 node)
> +{
> +	while (n-- > 0)
> +		if ((uintptr_t)leaf[n].fw_token =3D=3D node)
> +			return true;
> +	return false;
> +}
> +
> +/**
> + * For a given MDESC "cache" object node, copy properties, and recursive=
ly
> + * search for lower-level caches.
> + */
> +static int mdesc_cache_record(struct mdesc_handle *mdh, u64 cache_node,
> +			=A0=A0=A0=A0=A0 unsigned int cpuid, unsigned int *leaf_count,
> +			=A0=A0=A0=A0=A0 bool fill_it)
> +{
> +	const u64 *level =3D mdesc_get_property(mdh, cache_node, "level",
> NULL);
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
> +			pr_err("%s: tried to populate more cacheinfos than
> "
> +			=A0=A0=A0=A0=A0=A0 "allocated.\n", __func__);
> +			return -ELOOP;
> +		}
> +		if (!seen_cache(cc->info_list, *leaf_count, cache_node)) {
> +			struct cacheinfo *ci =3D &cc-
> >info_list[(*leaf_count)++];
> +			mdesc_cache_fill(mdh, cache_node, ci);
> +			mdesc_cache_set_shared(mdh, cache_node, ci);
> +			cc->cpu_map_populated =3D true;
> +		}
> +	} else {
> +		++cc->num_leaves;
> +		if (cc->num_levels < *level)
> +			cc->num_levels =3D *level;
> +	}
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
> +/**
> + * For a given Linux CPU @cpuid (hardware strand), find the correspondin=
g
> "cpu"
> + * object node in the MDESC, and from there follow pointers to "exec-uni=
t"
> + * object nodes and, subsequently, "cache" object nodes.
> + */
> +int mdesc_cache_walk(unsigned int cpuid, bool fill_it)
> +{
> +	unsigned int leaf_count =3D 0;
> +	struct mdesc_handle *mdh =3D mdesc_grab();
> +	u64 cpu_node, eu_arc;
> +	int ret =3D 0;
> +
> +	if (mdh =3D=3D NULL)
> +		return -ENOENT;
> +
> +#ifndef CONFIG_SMP
> +	/*
> +	 * On UP, cpu_data() has just one entry with index 0, but we want
> +	 * the values from the real physical cpu the kernel booted on.
> +	 */
> +	cpuid =3D real_hard_smp_processor_id();
> +#endif
> +
> +	cpu_node =3D mdesc_find_cpu(mdh, cpuid);
> +	if (cpu_node =3D=3D MDESC_NODE_NULL) {
> +		mdesc_release(mdh);
> +		return -ENOENT;
> +	}
> +
> +	mdesc_for_each_arc(eu_arc, mdh, cpu_node, MDESC_ARC_TYPE_FWD) {
> +		u64 cache_arc;
> +		u64 eu_node =3D mdesc_arc_target(mdh, eu_arc);
> +		const char *node_name =3D mdesc_node_name(mdh, eu_node);
> +
> +		if (strcmp(node_name, "exec-unit") !=3D 0)
> +			continue;
> +
> +		mdesc_for_each_arc(cache_arc, mdh, eu_node,
> MDESC_ARC_TYPE_FWD) {
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
> +
> +	if (fill_it) {
> +		/* Reduce count to actually populated slots. */
> +		struct cpu_cacheinfo *cc =3D get_cpu_cacheinfo(cpuid);
> +		cc->num_leaves =3D leaf_count;
> +
> +		/* We have the sharedness bitmaps and don't need fw_token.
> */
> +		for (size_t i =3D 0; i < cc->num_leaves; ++i)
> +			cc->info_list[i].fw_token =3D NULL;
> +	}
> + out:
> +	mdesc_release(mdh);
> +	return ret;
> +}
> +
> =A0/* mdesc_open() - Grab a reference to mdesc_handle when /dev/mdesc is
> =A0 * opened. Hold this reference until /dev/mdesc is closed to ensure
> =A0 * mdesc data structure is not released underneath us. Store the
> diff --git a/arch/sparc/kernel/prom_common.c
> b/arch/sparc/kernel/prom_common.c
> index d258fd10db01..808dc044514f 100644
> --- a/arch/sparc/kernel/prom_common.c
> +++ b/arch/sparc/kernel/prom_common.c
> @@ -11,12 +11,15 @@
> =A0 */
> =A0
> =A0#include <linux/kernel.h>
> +#include <linux/cacheinfo.h>
> =A0#include <linux/export.h>
> =A0#include <linux/errno.h>
> =A0#include <linux/mutex.h>
> =A0#include <linux/slab.h>
> =A0#include <linux/of.h>
> =A0#include <linux/of_pdt.h>
> +#include <linux/sort.h>
> +#include <asm/mdesc.h>
> =A0#include <asm/prom.h>
> =A0#include <asm/oplib.h>
> =A0
> @@ -112,6 +115,56 @@ int of_find_in_proplist(const char *list, const char
> *match, int len)
> =A0}
> =A0EXPORT_SYMBOL(of_find_in_proplist);
> =A0
> +/**
> + * Called from from drivers/base/cacheinfo.c meant to set
> + * cpu_cacheinfo::num_leaves for allocation purposes.
> + */
> +int init_cache_level(unsigned int cpuid)
> +{
> +#ifdef CONFIG_SPARC64
> +	if (tlb_type =3D=3D hypervisor)
> +		return mdesc_cache_walk(cpuid, false);
> +#endif
> +	return -ENOENT;
> +}
> +
> +static int cache_leaf_compare(const void *va, const void *vb)
> +{
> +	const struct cacheinfo *a =3D va, *b =3D vb;
> +	int r =3D cmp_int(a->level, b->level);
> +	return r !=3D 0 ? r : cmp_int(a->type, b->type);
> +}
> +
> +static void cache_leaf_swap(void *va, void *vb, int size)
> +{
> +	struct cacheinfo c;
> +	memcpy(&c, va, size);
> +	memcpy(va, vb, size);
> +	memcpy(vb, &c, size);
> +}
> +
> +int populate_cache_leaves(unsigned int cpuid)
> +{
> +	int ret;
> +#ifdef CONFIG_SPARC64
> +	if (tlb_type =3D=3D hypervisor) {
> +		ret =3D mdesc_cache_walk(cpuid, true);
> +	}
> +	else
> +#endif
> +	{
> +		/* Room to put the call for an OF-based cache walk here */
> +		ret =3D -ENOENT;
> +	}
> +	if (ret =3D=3D 0) {
> +		/* cacheinfo.c wants the last item to be the farthest cache
> */
> +		struct cpu_cacheinfo *ci =3D get_cpu_cacheinfo(cpuid);
> +		sort(ci->info_list, ci->num_leaves, sizeof(struct
> cacheinfo),
> +		=A0=A0=A0=A0 cache_leaf_compare, cache_leaf_swap);
> +	}
> +	return ret;
> +}
> +
> =A0/*
> =A0 * SPARC32 and SPARC64's prom_nextprop() do things differently
> =A0 * here, despite sharing the same interface.=A0 SPARC32 doesn't fill i=
n
> 'buf',

--=-rMmpzQThUtHcESiNvv63
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCauHOpAAKCRDoeAEuJe36
VowgAP0d1D6E8DpqZoOHUUNVuA2DyvwLPn/1/wwfT53HmDyc7gEAm7xC/5uzLFa6
dQkTtdoUnCVXCUE4piI8lx0/8IOK6Aw=
=ErhS
-----END PGP SIGNATURE-----

--=-rMmpzQThUtHcESiNvv63--
