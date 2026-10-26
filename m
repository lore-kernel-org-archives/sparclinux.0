Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.189.121.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045776;
	b=1Zk+78yqbrQIcio1gFOnDQnLKo5g8psMFjkdjeGSPcGicvg8Xp/bXVta+YQFUoCWBHfO
	 gkV3ekczHhlWsiTnSXho0B7h8Z7VbiahPjNl7T9P9JgVGg7VhkY3SzbVM52ZKrnquodlO
	 nS2tX7HgKlFOJ6KOhoLhVz5dva8thORYVWA5pQfpzcInphP7CZkIUKr/Wh2qg/FtDWk7o
	 lZbEQItpUVk2sK6dGQCNkyDJchLJ4nUKUxfGIjuKQt3w53j/qPUs7w/6ch4eziLZn70pn
	 B1zVN3/jt7+5fxQstWfO3CC2h2LUtja1K4cN/SfKOM2z3ZkgI+SnvBzTgXr+2e1luZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045776;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Subject:From:To:Date:
	 In-Reply-To:References:Content-Type:MIME-Version;
	bh=SbZb06f08CC59M0Ogvwq3FUrrIQnxN8besJYXt/IrXM=;
	b=DhKpuQOLJ7zI1ymDXYC1HhT7P7sA1d0m/LwKeuallc+Rk2vaQe4knCtkk7+UFILoQ/Xi
	 KWEUzwouTrul1+h1JNgNhugzMk25qFcGMIsBHi+e4lFFN+CcFKWYGkpFNuAKxkvhg4+y4
	 nFhckdLMy2L6vatuL5dHZlyun0N2x31cCVEZGkMdA5e3F4sTkzxmANjewbEG66gJyglso
	 wlu7WIrDQqzZXVA78E7jrEfdB28AD1D4wsMSnXMuRXLNUiSFHP+K630lY4xOQ9M2Tnh89
	 BB9Z1JxS8Faz2+jVInnCtplkdHSSizHQBqGt3IZg95fkGPsN1A8/pHd14oaqanjoP7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=itx.no;
	spf=pass smtp.mailfrom=itx.no;
	dkim=pass header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b="CaA/2OML";
	arc=none smtp.remote-ip=91.189.121.228
Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C7606A323
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 20:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 154C7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=itx.no header.i=@itx.no header.a=rsa-sha256 header.s=mx.itx.no header.b=CaA/2OML
Message-ID: <3c24c1f0a16ed4b2f58c3288ae100b48be005c75.camel@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1793045772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SbZb06f08CC59M0Ogvwq3FUrrIQnxN8besJYXt/IrXM=;
	b=CaA/2OMLUDg9ai6i67payEIZs2aMKb36yQcwQsI5BRrFFHuquQCQkqnXPtequOjr1i7iwE
	zCVqqWsEPRnlr1mpZhzAcfS2m+evKesLeGtRshIUttLZ3XYRy/GsWWx6duxU3LozGABLeC
	0RIKzjlzqnpF+29w1H2c+OjHlfLQsU8=
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on
 sun4v
From: Stian Halseth <stian@itx.no>
To: Jan Engelhardt <jengelh@inai.de>, sparclinux@vger.kernel.org
Date: Mon, 26 Oct 2026 21:16:11 +0100
In-Reply-To: <20261026193421.20404-1-jengelh@inai.de>
References: <20261026193421.20404-1-jengelh@inai.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-6SRzTbnI08yhhFysB+SU"
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0


--=-6SRzTbnI08yhhFysB+SU
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

Thanks for the follow up to v1.

I ran the walk against the MDs on my T4-1 and T7-1, and the shared
caches are reached from both ifetch and integer, so every CPU gets 6
leaves: L1i, L2, L3, L1d, L2, L3.=A0

lscpu hides it, but the index* directories have duplicates and aren't
sorted by level. Collecting the distinct cache nodes first and sorting
them would fix that.

Some smaller things:

- Two exec-units have "integer" in their type, and only the first has
  the L1d arc. Following the cache arcs of any child, like
  fill_in_one_cpu() does, avoids that and the "int" question.
- MD node numbers change on an MD update (see vio_vdev_node()), so
  I'd look up the cpu node by id instead of storing mdesc_node.
- mdesc_find_subobject() passes NULL and an uninitialized len on if
  there is no "type" property.
- switch (tlb_type) breaks sparc32, since prom_common.c is built there
  too. Both functions could just live in mdesc.c.
- Signed-off-by is missing, and a v2 tag with a short changelog would
  help.

The Sashiko num_leaves and of_node_put() findings are based on old
cacheinfo code (5944ce092b97c, 2613cc29c5723), so those can be ignored.

/Stian

On Mon, 2026-10-26 at 20:34 +0100, Jan Engelhardt wrote:
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
> Oracle S3 and Fujitsu SPARC64 XII cores (machines: Oracle T4 and
> Fujitsu M12, respectively.)
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
> ---
> =A0arch/sparc/include/asm/cpudata_64.h |=A0=A0 1 +
> =A0arch/sparc/include/asm/mdesc.h=A0=A0=A0=A0=A0 |=A0=A0 2 +
> =A0arch/sparc/kernel/mdesc.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 136
> ++++++++++++++++++++++++++++
> =A0arch/sparc/kernel/prom_common.c=A0=A0=A0=A0 |=A0 34 +++++++
> =A04 files changed, 173 insertions(+)
>=20
> diff --git a/arch/sparc/include/asm/cpudata_64.h
> b/arch/sparc/include/asm/cpudata_64.h
> index 056b3c0e7ef9..57b020ba93e0 100644
> --- a/arch/sparc/include/asm/cpudata_64.h
> +++ b/arch/sparc/include/asm/cpudata_64.h
> @@ -29,6 +29,7 @@ typedef struct {
> =A0	unsigned short	core_id;
> =A0	unsigned short=A0 max_cache_id;	/* groupings of highest
> shared cache */
> =A0	signed short	proc_id;	/* strand (aka HW thread) id
> */
> +	u64=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 mdesc_node;
> =A0} cpuinfo_sparc;
> =A0
> =A0DECLARE_PER_CPU(cpuinfo_sparc, __cpu_data);
> diff --git a/arch/sparc/include/asm/mdesc.h
> b/arch/sparc/include/asm/mdesc.h
> index ec31a06d04cc..71e77641f158 100644
> --- a/arch/sparc/include/asm/mdesc.h
> +++ b/arch/sparc/include/asm/mdesc.h
> @@ -90,6 +90,8 @@ u64 mdesc_get_node(struct mdesc_handle *hp, const
> char *node_name,
> =A0int mdesc_get_node_info(struct mdesc_handle *hp, u64 node,
> =A0			const char *node_name, union md_node_info
> *node_info);
> =A0
> +int mdesc_cache_walk(unsigned int cpuid, bool fill_it);
> +
> =A0void mdesc_fill_in_cpu_data(cpumask_t *mask);
> =A0void mdesc_populate_present_mask(cpumask_t *mask);
> =A0void mdesc_get_page_sizes(cpumask_t *mask, unsigned long
> *pgsz_mask);
> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index ecd6c8ae49c7..8b982c6fee11 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c
> @@ -1195,6 +1195,12 @@ static void *fill_in_one_cpu(struct
> mdesc_handle *hp, u64 mp, int cpuid,
> =A0
> =A0	c =3D &cpu_data(cpuid);
> =A0	c->clock_tick =3D *cfreq;
> +	/*
> +	 * This will help more quickly finding the mdesc node again
> +	 * (otherwise we would have to iterate over all cpu nodes
> +	 * to locate any one with a given id).
> +	 */
> +	c->mdesc_node =3D mp;
> =A0
> =A0	tb =3D &trap_block[cpuid];
> =A0	get_mondo_data(hp, mp, tb);
> @@ -1242,6 +1248,136 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
> =A0	smp_fill_in_sib_core_maps();
> =A0}
> =A0
> +/**
> + * At MDESC node @node, analyze forward links to find the
> @want_target,
> + * and, if @want_type is not %NULL, that it is of the requested
> type.
> + */
> +static u64 mdesc_find_subobject(struct mdesc_handle *mdh, u64
> iu_node,
> +				const char *want_target, const char
> *want_type)
> +{
> +	u64 iter;
> +
> +	mdesc_for_each_arc(iter, mdh, iu_node, MDESC_ARC_TYPE_FWD) {
> +		u64 sub_node =3D mdesc_arc_target(mdh, iter);
> +		const char *sub_name =3D mdesc_node_name(mdh,
> sub_node);
> +		const char *type_list;
> +		int len;
> +
> +		if (strcmp(sub_name, want_target) !=3D 0)
> +			continue;
> +		if (want_type =3D=3D NULL)
> +			return sub_node;
> +		type_list =3D mdesc_get_property(mdh, sub_node,
> "type", &len);
> +		if (of_find_in_proplist(type_list, want_type, len))
> +			return sub_node;
> +	}
> +	return -1;
> +}
> +
> +static void mdesc_cache_fill(struct mdesc_handle *mdh, u64
> cache_node,
> +			=A0=A0=A0=A0 struct cacheinfo *leaf)
> +{
> +	int type_len;
> +	const u64 *level=A0=A0=A0=A0=A0 =3D mdesc_get_property(mdh, cache_node,
> "level", NULL);
> +	const u64 *size=A0=A0=A0=A0=A0=A0 =3D mdesc_get_property(mdh, cache_nod=
e,
> "size", NULL);
> +	const u64 *line_size=A0 =3D mdesc_get_property(mdh, cache_node,
> "line-size", NULL);
> +	const u64 *assoc=A0=A0=A0=A0=A0 =3D mdesc_get_property(mdh, cache_node,
> "associativity", NULL);
> +	const char *type_list =3D mdesc_get_property(mdh, cache_node,
> "type", &type_len);
> +
> +	leaf->fw_token =3D (void *)(uintptr_t)cache_node;
> +	leaf->level =3D *level;
> +	if (type_list !=3D NULL) {
> +		bool i =3D of_find_in_proplist(type_list, "instn",
> type_len);
> +		bool d =3D of_find_in_proplist(type_list, "data",
> type_len);
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
> +	if (leaf->coherency_line_size !=3D 0 && leaf-
> >ways_of_associativity !=3D 0)
> +		leaf->number_of_sets =3D leaf->size / leaf-
> >coherency_line_size /
> +				=A0=A0=A0=A0=A0=A0 leaf->ways_of_associativity;
> +}
> +
> +static int mdesc_cache_record(struct mdesc_handle *mdh, u64
> cache_node,
> +			=A0=A0=A0=A0=A0 unsigned int cpuid, unsigned int
> *leaf_count,
> +			=A0=A0=A0=A0=A0 bool fill_it)
> +{
> +	struct cpu_cacheinfo *ci;
> +	const u64 *level =3D mdesc_get_property(mdh, cache_node,
> "level", NULL);
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
> +
> +	mdesc_for_each_arc(iter, mdh, cache_node,
> MDESC_ARC_TYPE_FWD) {
> +		u64 sub_node =3D mdesc_arc_target(mdh, iter);
> +		const char *sub_name =3D mdesc_node_name(mdh,
> sub_node);
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
> +	 * The MDESCs of e.g. the SUNW,T5240 and ORCL,SPARC-S7-2
> machines
> +	 * use "integer". Which machines are using "int"?
> +	 */
> +	static const char *const unit_kinds[] =3D {"ifetch",
> "integer", "int"};
> +	unsigned int leaf_count =3D 0;
> +	int ret =3D 0;
> +	struct mdesc_handle *mdh =3D mdesc_grab();
> +
> +	if (mdh =3D=3D NULL)
> +		return -ENOENT;
> +
> +	for (unsigned int i =3D 0; i < ARRAY_SIZE(unit_kinds); ++i) {
> +		u64 node =3D mdesc_find_subobject(mdh,
> cpu_data(cpuid).mdesc_node,
> +						"exec-unit",
> unit_kinds[i]);
> +		if (node =3D=3D -1)
> +			continue;
> +		node =3D mdesc_find_subobject(mdh, node, "cache",
> NULL);
> +		if (node =3D=3D -1)
> +			continue;
> +		ret =3D mdesc_cache_record(mdh, node, cpuid,
> +					 &leaf_count, fill_it);
> +		if (ret !=3D 0)
> +			break;
> +	}
> +	mdesc_release(mdh);
> +	return ret;
> +}
> +
> =A0/* mdesc_open() - Grab a reference to mdesc_handle when /dev/mdesc
> is
> =A0 * opened. Hold this reference until /dev/mdesc is closed to ensure
> =A0 * mdesc data structure is not released underneath us. Store the
> diff --git a/arch/sparc/kernel/prom_common.c
> b/arch/sparc/kernel/prom_common.c
> index d258fd10db01..34f3b2650547 100644
> --- a/arch/sparc/kernel/prom_common.c
> +++ b/arch/sparc/kernel/prom_common.c
> @@ -11,12 +11,14 @@
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
> +#include <asm/mdesc.h>
> =A0#include <asm/prom.h>
> =A0#include <asm/oplib.h>
> =A0
> @@ -112,6 +114,38 @@ int of_find_in_proplist(const char *list, const
> char *match, int len)
> =A0}
> =A0EXPORT_SYMBOL(of_find_in_proplist);
> =A0
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
> +	 * Note that drivers/base/cacheinfo expects leaves to be
> sorted by
> +	 * level, then by index in [inst, data_or_unified]. Code
> should fill
> +	 * in leaves in that order (else, a call to qsort will be
> needed).
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
> +	if (ret =3D=3D -ELOOP)
> +		pr_err("%s: tried to populate too much. "
> +		=A0=A0=A0=A0=A0=A0 "(Programming error, go investigate.)\n",
> __func__);
> +	return ret;
> +}
> +
> =A0/*
> =A0 * SPARC32 and SPARC64's prom_nextprop() do things differently
> =A0 * here, despite sharing the same interface.=A0 SPARC32 doesn't fill
> in 'buf',

--=-6SRzTbnI08yhhFysB+SU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTK1ph9OaYoND1R57zoeAEuJe36VgUCat+1CwAKCRDoeAEuJe36
VoMsAP9vYZjDn99LuAOpOPOh41k4eBuvoMgWp5t7ldM89Ja/uAD+KxITJZ1f/dHo
FagrtEH6UqqBm8HqRd3rAksf+LCV3gQ=
=nN3N
-----END PGP SIGNATURE-----

--=-6SRzTbnI08yhhFysB+SU--
