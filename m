Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793040754;
	b=eGIvMeXWiYoAY5Ls87Oede8BABwbSFztJZCKFNNWEpF8CK1NP477k/hC+HbqojKxH/8w
	 h2rC4/PkGvq4D7udbUHCT36LvUYOpwzrCDH6NXHYTxR/1Lm0dHFzlw//JU7p1XwzyqTka
	 b+lQJBYUtFmXXlWLLQBlXexGTv9mJK1e3KjPrgfMNWRTr0N3fX4gXwNJFBAaUjycLw1VV
	 JQPkcGwI92dgOrToTCVLFSqbAizbOROLECuQIGgxMsQB9hZotFOjESwmdGZtGHKPT0QZ/
	 X1NUc+Cb8PUGYCtIjc7KvNQbWo7OXJCYpKeGQE7YbVgDMkc4KeAMRkApweh4m23QOlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793040754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Uc21FeX9ZqBesmDzXUl4Rt+cHhRkHCCJkS37RvmQiP8=;
	b=2GEhA8YemQRhLmrhFqOSshFlUAisfR2QAyAAsfC2OuqloQbb4zJZfVWxFqejAahE0hRY
	 kFQNs8I/rVlTWW3ce+XoQ97VxnOJINutiuefLhQHJMbF8/vxf4hKEdPfdRJuB8UZKGJkV
	 H5wiX+NvP/dVb5HuEPr0TvQpMmLhFImxMEQNHLa+7kWFzRoFKZROhG5L+a8donJgctJ9+
	 kOu+o/pvXKsZN7FrYZzzX+MM69+yxy/i2uQRL1Rl/s2XydwuAdBe57H5igYrHbIWpb2EB
	 Mqx67jLWfw7kpRxjJcp4xIrzuaVyQ58JO8G17P8LgX5qEtGtTMGlsyw9DWrH6M+795w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ec3QAQ1P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465C606A31D
	for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 18:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4465C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ec3QAQ1P
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ea1e7fad99so17410625ad.1
        for <sparclinux@vger.kernel.org>; Mon, 26 Oct 2026 11:52:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793040752; cv=none;
        d=google.com; s=arc-20260327;
        b=KfFWRCJg1iZs21ByT9mhNx2O60d/xxLkoWokLrF8P5mlIIJInDlJYqFjba/AE8wdbs
         mtojh3qvRkR4MWIxXoLnm1BCc7gw1qfe0iVsKzjq4lxBs1V2Q65Rwj+4F+cWLHfApY0T
         H1/ROUkzW7qA5aWVwys/GDelbYwPjX0lgP/3QxuqRJo4LOhro8ULHkPoVoDldIiwg6C7
         z1szsKuysm0Z1LxShRB3wdykkqZp/sQgH8WSKs/NeSPI2SwGyyHDKEVBWdcg84c1PrWQ
         XjOFAAkPZJyr1CHUdpkzxSdQhCAIIOvybimBSjmgQp9FNswBHEZ5cLuBhlvHL/H1ZOXc
         767A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uc21FeX9ZqBesmDzXUl4Rt+cHhRkHCCJkS37RvmQiP8=;
        fh=R5jeqkeAZd9kuXqWLXcsQNwFYGV4uLpWGAuELlt5U4E=;
        b=VX2n7CM7T3CVEaWpaM4i29IMscSCJBvCmwJz2kIU7kHWyUzHcBYmCcNkQG6PPoTHWC
         tj6SCH3MAMsj5Uk00h/MUK8VW+XYlwmE+SoHmXdBbfQIuTdNTFPyDbYURx7kds1SCtGK
         O0YnvsS7uIQejlXyTNsZjOAICZLP/mX3rHW/+kC6wIKlR7TV3fbJeuszBotkJTO+HuzB
         ZBITJG6zlXmqnEfaqckN4WkJlUJZeLd4CBXGBT9n7pqFnM1MmerdtsHMmzAknFXJsM+z
         kA+GCAw4SH6WPF2f+0EmFfEpgUnK3dF3S3MQ1Mp0iL9vokbVLYRcRyYnFBsyxutsRG19
         zNTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793040752; x=1793645552; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uc21FeX9ZqBesmDzXUl4Rt+cHhRkHCCJkS37RvmQiP8=;
        b=ec3QAQ1PtPrAFLDbaViU82ICbrCK79DS15yWl8q4FB6Jk56EctfritFF4phKpbS26y
         swl4L+T3b5GxN92cW22qkWLfHjaYr/goT5QtflszBuTG5GmM7Y2JJRlJLMeGpvLTLzKU
         MH1xpvz6ZxjhqppNhzzFCuOYna9N0/0Na4FR9FB69Gj3XPcgqteBKM5ZeEm2LJ9BYj1p
         TmoNfuz0TO3Xzbip0+WAP16ZRoVAE0k9g9BD14se8p6O1Em1R6lToa6gAI/0FUbRWwR9
         TB5Ivrjcd2TEsbSPbiHhO0a/SlgU1QUkwpyJTts8BcdoyabJliJSepsY4DKo7YWJHcGb
         Z3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793040752; x=1793645552;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uc21FeX9ZqBesmDzXUl4Rt+cHhRkHCCJkS37RvmQiP8=;
        b=vN0+o54ZhPK8ddgydPmboXggF1Xeu9ZKY2dljO/Q3mqH8Ia/cwLQXh7OgdZz3Jnq6S
         dbAlg+vi+8ej8v+bV6cBS/fpA/tzgYfYeZQZHVoArUFtYJDAsNbiHHa2cMzCcRtG+7bX
         +NTRAzS1cd45DZ6F65KtxKSMW4J1OROdQkxR5ElZYlJ4vMIy4PKhU9Qf6m0vK0ljjI44
         MF4Uqxw3oqQaPXoKfej3MxXtVX4Ca5AUydEDIt3DHATG8NkTPjhReoJWxCsR+T+wdvnf
         GRJYyJqOuWMQVa0jM6enJHgDtDyhidBhwAznQ5c+aJJZSYj87nKlCxcIbtdaKYNX7vDu
         wFcA==
X-Forwarded-Encrypted: i=1; AKwUvBwf3bllBOBaGmlvg8s5m+3tN/LyfhWy0JPnZOcO2SghFdsve/kjKbZscJepSnIgGclxZEL0yMJBYO+9@vger.kernel.org
X-Gm-Message-State: AFq9FYJkeLKC+7CYUMQS4XIahq12euioVdslMl07pVTigKOULdZZBVV3
	DvwcBP52IQjTgdJSzEZGERBP+/5ATWsFBttOxU3V/DH5FL0G1/nOxLoEDq4BgJ/ZKsBLbY84etI
	pd5ttPGwHo5X4uBaB8hf/RopJO5pXQq8=
X-Gm-Gg: AYBFou2d88/KYLxLejPs5IfeMrYhUsiU0SIkeCeLNIzpbS111S6SGjJSjasBGu2630B
	3jKJIrcXtTYYRu2Ubg05HGjCT3aPnmTGUzvK2359GTQcCZmzl6IqPYPz3q4GRMSGdrlFHEHNJuY
	ECyjuPEOPt7Yja4EzLVR5av1AmMnFbiiuJG3QTlUqsbjiRNAg2JkahG9fikgV+clWHDYuK522pr
	WoHGzwhjLwQg7ZSjBlXwBJWaARzp+S8X/FQPbMrvOTSTBkUcUhKyUNOnYUhebqTwJ2LIj+pA+OV
	D5TVYvucVbA1qfMJsvtj3Q0ukgMUQ6/h1qx1KuraSeYCzz/LOJBR/U0bPT0BBLwTtBWTjlnc7tw
	r4CzqUL34IHx9Bg1sNRbZthr/CpeLd12ch1t1LqwascrxokBuSrt899+qEygR/VfDmMaP38BRxS
	f7yWaQg5T55uM=
X-Received: by 2002:a17:903:8cc:b0:2e8:f4f:ad04 with SMTP id
 d9443c01a7336-2ea9c5e46eemr62515315ad.12.1793040752191; Mon, 26 Oct 2026
 11:52:32 -0700 (PDT)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <X-TH#1.20261018222723.43442-1-jengelh@inai.de>
In-Reply-To: <X-TH#1.20261018222723.43442-1-jengelh@inai.de>
From: Tony Rodriguez <unixpro1970@gmail.com>
Date: Mon, 26 Oct 2026 11:52:22 -0700
X-Gm-Features: AclHuK88TVGjuWHanqq9-0CUjSeW2-s8KPRecYqkZ8hv434aCI_euUScKqgqCoA
Message-ID: <CANmkgULrJwKSuwQhZjgL0-zWgMYWgOZLhseDXGtp_XwjcAayow@mail.gmail.com>
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on sun4v
To: Jan Engelhardt <jengelh@inai.de>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Stian Halseth <stian@itx.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Tony Rodriguez <unixpro1970@gmail.com>

Tested on both SPARC T7-1 and S7-2 systems; the lscpu output is correct on =
both.

A) T7-1:
A1) lscpu
Architecture:          sparc64
  CPU op-mode(s):      32-bit, 64-bit
  Byte Order:          Big Endian
CPU(s):                256
  On-line CPU(s) list: 0-255
Model name:            SPARC-M7
  Thread(s) per core:  8
  Core(s) per socket:  32
  Socket(s):           1
  Flags:               sun4v
Caches (sum of all):
  L1d:                 512 KiB (32 instances)
  L1i:                 512 KiB (32 instances)
  L2d:                 4 MiB (16 instances)
  L2i:                 2 MiB (8 instances)
  L3:                  64 MiB (8 instances)
NUMA:
  NUMA node(s):        1
  NUMA node0 CPU(s):   0-255

A2) lscpu --cache
NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERENCY-SIZE
L1d       16K     512K    4 Data            1   128       32
L1i       16K     512K    4 Instruction     1    64       64
L2d      256K       4M    8 Data            2   512       64
L2i      256K       2M    8 Instruction     2   512       64
L3         8M      64M    8 Unified         3 16384       64

B) S7-2:
B1) lscpu
Architecture:          sparc64
  CPU op-mode(s):      32-bit, 64-bit
  Byte Order:          Big Endian
CPU(s):                128
  On-line CPU(s) list: 0-127
Model name:            SPARC-S7 (Sonoma)
  Thread(s) per core:  8
  Core(s) per socket:  8
  Socket(s):           2
  Flags:               sun4v
Caches (sum of all):
  L1d:                 256 KiB (16 instances)
  L1i:                 256 KiB (16 instances)
  L2d:                 2 MiB (8 instances)
  L2i:                 1 MiB (4 instances)
  L3:                  32 MiB (4 instances)
NUMA:
  NUMA node(s):        2
  NUMA node0 CPU(s):   0-63
  NUMA node1 CPU(s):   64-127

B2) lscpu --cache
NAME ONE-SIZE ALL-SIZE WAYS TYPE        LEVEL  SETS PHY-LINE COHERENCY-SIZE
L1d       16K     256K    4 Data            1   128       32
L1i       16K     256K    4 Instruction     1    64       64
L2d      256K       2M    8 Data            2   512       64
L2i      256K       1M    8 Instruction     2   512       64
L3         8M      32M    8 Unified         3 16384       64


On Mon, Oct 26, 2026 at 11:42=E2=80=AFAM Jan Engelhardt <jengelh@inai.de> w=
rote:
>
> The SPARC port does not publish any cache topology information. The
> lscpu utility therefore falls back to assuming the published cache
> sizes are for unshared caches, and as a result, reports way more
> cache than there really is present in the system. On a T5240 machine:
>
> ```
> $ lscpu
> Architecture:          sparc64
>   CPU op-mode(s):      32-bit, 64-bit
>   Byte Order:          Big Endian
> CPU(s):                128
>   On-line CPU(s) list: 0-127
> Model name:            UltraSparc T2 (Niagara2)
>   Thread(s) per core:  4
>   Core(s) per socket:  16
>   Socket(s):           2
>   Flags:               sun4v
> Caches (sum of all):
>   L1d:                 1 MiB (128 instances)
>   L1i:                 2 MiB (128 instances)
>   L2:                  512 MiB (128 instances)
> ```
>
> This patch implements population of the sysfs cacheinfo structures
> for sun4v (systems with mdesc). The proper amount is now reflected in
> lscpu's output:
>
> ```
> Caches (sum of all):
>   L1d:                 128 KiB (16 instances)
>   L1i:                 256 KiB (16 instances)
>   L2:                  8 MiB (2 instances)
> ```
>
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
>  arch/sparc/include/asm/cpudata_64.h |  8 +++-
>  arch/sparc/kernel/mdesc.c           | 61 +++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 1 deletion(-)
>
> diff --git a/arch/sparc/include/asm/cpudata_64.h b/arch/sparc/include/asm=
/cpudata_64.h
> index 056b3c0e7ef9..e28b841ffe23 100644
> --- a/arch/sparc/include/asm/cpudata_64.h
> +++ b/arch/sparc/include/asm/cpudata_64.h
> @@ -18,13 +18,19 @@ typedef struct {
>         unsigned int    irq0_irqs;
>         unsigned int    __pad2;
>
> -       /* Dcache line 2, rarely used */
> +       /* Dcache line 2+3, rarely used */
>         unsigned int    dcache_size;
>         unsigned int    dcache_line_size;
> +       unsigned int    dcache_assoc;
> +       unsigned int    dcache_id;
>         unsigned int    icache_size;
>         unsigned int    icache_line_size;
> +       unsigned int    icache_assoc;
> +       unsigned int    icache_id;
>         unsigned int    ecache_size;
>         unsigned int    ecache_line_size;
> +       unsigned int    ecache_assoc;
> +       unsigned int    ecache_id;
>         unsigned short  sock_id;        /* physical package */
>         unsigned short  core_id;
>         unsigned short  max_cache_id;   /* groupings of highest shared ca=
che */
> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
> index 23b51a32e96e..029d9d812074 100644
> --- a/arch/sparc/kernel/mdesc.c
> +++ b/arch/sparc/kernel/mdesc.c
> @@ -818,6 +818,7 @@ static void fill_in_one_cache(cpuinfo_sparc *c, struc=
t mdesc_handle *hp, u64 mp)
>         const u64 *level =3D mdesc_get_property(hp, mp, "level", NULL);
>         const u64 *size =3D mdesc_get_property(hp, mp, "size", NULL);
>         const u64 *line_size =3D mdesc_get_property(hp, mp, "line-size", =
NULL);
> +       const u64 *assoc =3D mdesc_get_property(hp, mp, "associativity", =
NULL);
>         const char *type;
>         int type_len;
>
> @@ -828,15 +829,21 @@ static void fill_in_one_cache(cpuinfo_sparc *c, str=
uct mdesc_handle *hp, u64 mp)
>                 if (of_find_in_proplist(type, "instn", type_len)) {
>                         c->icache_size =3D *size;
>                         c->icache_line_size =3D *line_size;
> +                       c->icache_assoc =3D assoc ? *assoc : 0;
> +                       c->icache_id =3D mp;
>                 } else if (of_find_in_proplist(type, "data", type_len)) {
>                         c->dcache_size =3D *size;
>                         c->dcache_line_size =3D *line_size;
> +                       c->dcache_assoc =3D assoc ? *assoc : 0;
> +                       c->dcache_id =3D mp;
>                 }
>                 break;
>
>         case 2:
>                 c->ecache_size =3D *size;
>                 c->ecache_line_size =3D *line_size;
> +               c->ecache_assoc =3D assoc ? *assoc : 0;
> +               c->ecache_id =3D mp;
>                 break;
>
>         default:
> @@ -1251,6 +1258,60 @@ void mdesc_fill_in_cpu_data(cpumask_t *mask)
>         smp_fill_in_sib_core_maps();
>  }
>
> +int init_cache_level(unsigned int cpu)
> +{
> +       struct cpu_cacheinfo *i =3D get_cpu_cacheinfo(cpu);
> +       i->num_levels =3D 2;
> +       i->num_leaves =3D 3;
> +       return 0;
> +}
> +
> +int populate_cache_leaves(unsigned int cpu)
> +{
> +       struct cacheinfo *leaf =3D get_cpu_cacheinfo(cpu)->info_list;
> +       cpuinfo_sparc *cs =3D &cpu_data(cpu);
> +
> +       leaf->id                    =3D cs->icache_id;
> +       leaf->attributes            =3D CACHE_ID;
> +       leaf->level                 =3D 1;
> +       leaf->type                  =3D CACHE_TYPE_INST;
> +       leaf->coherency_line_size   =3D cs->icache_line_size;
> +       leaf->ways_of_associativity =3D cs->icache_assoc;
> +       leaf->size                  =3D cs->icache_size;
> +       leaf->priv                  =3D cs;
> +       if (cs->icache_line_size > 0 && cs->icache_assoc > 0)
> +               leaf->number_of_sets =3D cs->icache_size / cs->icache_lin=
e_size /
> +                                      cs->icache_assoc;
> +       ++leaf;
> +
> +       leaf->id                    =3D cs->dcache_id;
> +       leaf->attributes            =3D CACHE_ID;
> +       leaf->level                 =3D 1;
> +       leaf->type                  =3D CACHE_TYPE_DATA;
> +       leaf->coherency_line_size   =3D cs->dcache_line_size;
> +       leaf->ways_of_associativity =3D cs->dcache_assoc;
> +       leaf->size                  =3D cs->dcache_size;
> +       leaf->priv                  =3D cs;
> +       if (cs->dcache_line_size > 0 && cs->dcache_assoc > 0)
> +               leaf->number_of_sets =3D cs->dcache_size / cs->dcache_lin=
e_size /
> +                                      cs->dcache_assoc;
> +       ++leaf;
> +
> +       leaf->id                    =3D cs->ecache_id;
> +       leaf->attributes            =3D CACHE_ID;
> +       leaf->level                 =3D 2;
> +       leaf->type                  =3D CACHE_TYPE_UNIFIED;
> +       leaf->coherency_line_size   =3D cs->ecache_line_size;
> +       leaf->ways_of_associativity =3D cs->ecache_assoc;
> +       leaf->size                  =3D cs->ecache_size;
> +       leaf->priv                  =3D cs;
> +       if (cs->ecache_line_size > 0 && cs->ecache_assoc > 0)
> +               leaf->number_of_sets =3D cs->ecache_size / cs->ecache_lin=
e_size /
> +                                      cs->ecache_assoc;
> +
> +       return 0;
> +}
> +
>  /* mdesc_open() - Grab a reference to mdesc_handle when /dev/mdesc is
>   * opened. Hold this reference until /dev/mdesc is closed to ensure
>   * mdesc data structure is not released underneath us. Store the
> --
> 2.56.0
>
>
