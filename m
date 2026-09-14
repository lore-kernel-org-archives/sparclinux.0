Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD449B1E6
	for <sparclinux@vger.kernel.org>; Mon, 14 Sep 2026 19:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789415866; cv=pass; b=fVgPpKeQ3Z2MKfoRLUG2SFUlsUP0U/Cdu8erHuDmFBv6jbEzLwpwHJ2UZWl9w7U5SWItwj75ax3EfoHLBl7Poy25udOJax7EfS95OXnYhqDz1Wq40Cl4CxlYDsw5FqnPOh2U10YJFzt4NMNlqPAkrG9E1sniwaXnapdGK7op1zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789415866; c=relaxed/simple;
	bh=rm+zdLu0LlzNfMP/vZrBYvi966p9ISS8d4XEb3JQ094=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJYxE+CeJ/lrnN9LmoH5JGuzOC6USakewcpubd5Sba+34NAcirxEHkiVWrOwrzH6CRE5A0uwidDQ2pOXZYTxOxZaJ7rwsYlXBGpOEo56n2xsdro2lO/0advitG/wedT8wQKEBV/DG1heAngk9JUJv4+63Ssqkth4lekC7lanDso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VBYIS+ru; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VBYIS+ru"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25187so1854652b3a.2
        for <sparclinux@vger.kernel.org>; Mon, 14 Sep 2026 12:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789415862; cv=none;
        d=google.com; s=arc-20260327;
        b=PLBmVWHf/vlMMFya7eFtVjRkhuWDXuCKt9BNcdPM4PdM96eeqJzPv1bllUBXE46MSo
         csR9ht8CoXW9BHVt6oOsaEEjAB2CLJV+4y0l2WqfDHaNJVCxDvqzGyZ3bjfp1S+u0RRW
         R8WdDSSPkF+dxut6c1SE9kAIGRdJSY1kla8FwH/Qw162QDtTuZvmWj4XQEz0IsyHHgcL
         uap6syEa0VjFReQKPvzxlqX0xTWWIjIQfrwB0+VXc6BoWiPtqVUngEE/WMCIutWMXCF8
         bRqMIQI/DcajSKFu94lyv8siN29I4JT++RX12PYDurmle6uevFvkybt0+u6T6/mt3KHU
         iYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
        fh=8DBe8qOjU0bX9it8JcQMe1jr8V8mZHla0/TPC2e+5+w=;
        b=HNVYBHf+LGCjWEpVB2r3sEhQgVCeN7em8qSnGXk4ccvdGurObx8SjOfIxhtQEXYJS4
         wWiTbAoQomTtpZdwJiFbffxJ5Oa6Uumq2D9uqe7cfZqouhn4r9rHtnIh7y9F5Gkm8WJ4
         rkS99nagB+qBwx1mMWoZgH2QtbCDTbm33WXGwdukv4OwRlC4w/dz+cO1eYiazMb5gtw7
         golC0fT6O+3QPqPjLTzSTK9lTnKODU8St7AIdNx31glCoza2XMT1KRvvxthsrOc6+dEc
         H9opEy9Apz2tT0cATGTHRhoRhQYYw61/YnVHtcWV+55ZmPCHgs280FuLAqURCnWZC2Fo
         2S/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789415862; x=1790020662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
        b=VBYIS+ruvec/YQ7NPDSavrBqZkup3jtMUSf2x9fg2vR4Q/ZYGnptCqM7UF9GBEk6Kb
         pwYbAK2sJEZFDjRFht2ALhGnWfzEgxLd1W4Nqjf3iOyc3C9CQVwNzR9p52/m8eg00t3y
         i3INHp65zySvAJlrkN0SKQiamBOPK/2OeoXHbM/ieIzmZObIDK9PzOChSRrcM8YAyS56
         Wpk2JsgEsfietAppzsrHDi7c7Qi8vepD85wgaha++Drvrzfs42k7ryFVO4ohzIir1SFu
         Dz5Af79neP1/ODat12UTHwq79Ug1vrjKu97+aj6V0fudJlIrOVtfB5xkOELTreMhvqOw
         VVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789415862; x=1790020662;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEa5EIpxI31VfZhRCWTdUVuFxMmPcLfnD5/j1cH2Le4=;
        b=BSg1XJpK68Jkt/KROkx8I2IKLelPE1rySJHJnawTm28TObAPOPbP+Sil393KDHkBWp
         WglofQUtWt+D2IMGnf09paIRUnJghpOFOBl+2OjizCXRDURK1BP/krN9fS1yhtCe6EfS
         VtofkOlv9tRkwI1q5/iFuSFVB0HnetZbX7Ydhuv3XJ4FdoKEILPiQPoKHLVM4q/bftWY
         pnRfs4aPe+LasWFk9OCw0l7/mJcmr+72xB74AH7e7lAM8kaYyXdVPV6WbjrnAX/bU+32
         TX6eROQJoF1Ps0huGslLOv2z3gISE8NXGo9HHguy99F04xl2VRQBfKezIoksQj7ZZvg8
         xCQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwInUra8tUq1NybvKBxcArt2o7bFCn1UEV+XZsbVmPxhs1hCyiTczLpddsq/tmiH4LXDTbEWpRXIjYN@vger.kernel.org
X-Gm-Message-State: AFuF++k1Qp1y7LWuvqBGHMeU0RDGRQPu/zxGdFWQcSCt3MUMFaGl+PkI
	F6twSoxQrTbbNJEcK2ZY4CTuhvaE+AUXa8YmgOZR+DhSjviACZlNzbbYvk0HkjYLtB4mXGpZZl4
	V3iLEHpTx55PcbjwpP8X23PrqSxLVFZ/pqEzTgs2d
X-Gm-Gg: AYBFou1CKmdP68s73v7rbgghmi/l03gSbCTcpQbO4Qtpi4Sq1Y2Qb3pIc86GpWpLrAD
	DJoWPK0b5u8TitOteUYU2RvfARvxa9r0NCz2QEaFAU7jC3gQIcz2ZmHGRtaRODm0xSAkut1BkzG
	j8bQLU8Imy/kaEWVXIt6o/1ADOQgABZNnmDK4lTJox8nXXigfE/Od+HjGQJ56FVM7uhwWiNQGwZ
	PUrb9+U6nPVXm+XA8l7ebH6fjib4rtKJmZdU1Z+jNmJOF3QGMoDXXGwyul65aD3zjU53Ldb1h+H
	/yhNnA2irV9bdwnzSo+nXdPOFsTSRUgVH0cZRjY6nmfq+vIGls6DSpIG8dZZo+B2oqf7vrbj1yR
	QqLDGJHx8jEo=
X-Received: by 2002:a05:6a00:18a9:b0:858:b809:6ec0 with SMTP id
 d2e1a72fcca58-86f869a920dmr8896742b3a.23.1789415862342; Mon, 14 Sep 2026
 12:57:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-0-7d9781ed5361@kernel.org>
 <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
In-Reply-To: <20260914-b4-mmap-prepare-vma-flag-sanify-v2-12-7d9781ed5361@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 14 Sep 2026 15:57:29 -0400
X-Gm-Features: AcwNN1XaLRK0KaZAmfcRvdaBSkZOdh14LF1fb-xWULoFVhBfqyRklsdKoWBmLag
Message-ID: <CAHC9VhQ3TwdGGH6YtVyMqJX4avJwsadcRvRhAoUhCvJEHk=i=g@mail.gmail.com>
Subject: Re: [PATCH v2 12/40] selinux: reject writable opens of policy file,
 drop mmap shared/write check
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Doug Gilbert <dgilbert@interlog.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Jaya Kumar <jayalk@intworks.biz>, Simona Vetter <simona@ffwll.ch>, 
	Helge Deller <deller@gmx.de>, Sebastian Reichel <sre@kernel.org>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
	Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Xu Xin <xu.xin@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-rdma@vger.kernel.org, 
	selinux@vger.kernel.org, linux-sound@vger.kernel.org, bpf@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 11:05=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.=
org> wrote:
>
> The policy file has no write method and is exposed read-only (S_IRUGO in
> selinux_files[]), yet sel_open_policy() performs no open mode check, so a
> CAP_DAC_OVERRIDE caller can open it O_RDWR. Reject FMODE_WRITE at open, a=
s
> kernfs does.
>
> The file can then never be mapped with FMODE_WRITE, so do_mmap() always
> clears VM_MAYWRITE and VM_SHARED for MAP_SHARED mappings and the VM_SHARE=
D
> check in sel_mmap_policy() cannot be reached. Remove it.
>
> This also stops sel_mmap_policy() clearing VM_MAYWRITE on a mapping that =
is
> neither a PFN map nor a mixed map, ahead of the core enforcing that only
> such mappings may do so.
>
> Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
