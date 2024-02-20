Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C1564AAA
	for <sparclinux@vger.kernel.org>; Tue, 20 Feb 2024 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419387; cv=none; b=UBatvxyIAFjxB9SKeeU5eJu+xcb4c7j86x1IsR8rBUmuDft9/fk90mDBOCioz3/gz0pvL7oLVfmIKbU7rtt3Ok5wihJMIXTDNh8ZesVy8NnFqX8irpdlMaJAfe+l5fiOMRAtmY711Wsd2Boczbo/PJAkjjpx77G3P+GFSVXgOLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419387; c=relaxed/simple;
	bh=XxS2PiR8TvPD6PooYcEaHBnRrtlm5KfcjvweKguWnMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giMdH0DcitI0hQWQWwz4AuS68034hTaowyphlDzaajZddd1LnGZobsJBCihX5CVTrf80jQgbNEiDYvoXm8OOYNbaCxd0gAHKMTRH5PtFUOuiyrbiUjTsAANzIzv7ZBinrv/iYx2QVsvisHvbplyyFtkY2/LOPg4J2p0xmtBuK18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com; spf=none smtp.mailfrom=anyfinetworks.com; dkim=pass (2048-bit key) header.d=anyfinetworks-com.20230601.gappssmtp.com header.i=@anyfinetworks-com.20230601.gappssmtp.com header.b=h0GLh4RQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anyfinetworks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anyfinetworks-com.20230601.gappssmtp.com header.i=@anyfinetworks-com.20230601.gappssmtp.com header.b="h0GLh4RQ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-29041136f73so3767501a91.0
        for <sparclinux@vger.kernel.org>; Tue, 20 Feb 2024 00:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20230601.gappssmtp.com; s=20230601; t=1708419384; x=1709024184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dchRxoxVGKioFcq/L4EKVcfcET3Jr75StrPrjuqQjL0=;
        b=h0GLh4RQIVLzVLbe8bp+bnwWfCCl8/am1azMVG8j9x/pf7WzYHYHqrdPyClK6ldiVt
         RVgydbd581CGpeqebpB8wUsuydpAbR9W8qxBbrNvHITYCwMzGiVtIHoeWIOdea3jJXLW
         BK4Rko4LsKB4/W0Yjo8eQ9QGAGGG1FABugsJDm6e0LtBV+XIlIu7YaGGiRZmgEviLbHj
         m8ioux5EFen4Y6eMkO6DjL0809cTtD05/5/z8uOLyi7kaurzT4AG55ErqCpDyZGDEsdt
         KmtCD5kmTU9JzJTI7xd/B53T32FQXpslVn25zUtK3oiF2zfZT8ieYnl8vRQs14v1qrKi
         6tSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708419384; x=1709024184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dchRxoxVGKioFcq/L4EKVcfcET3Jr75StrPrjuqQjL0=;
        b=H9nY7e8JIIp8Z4VZqjiYLIszE+gPNCV6xBTbkWoN8b4ZpiDd1Z94dH7+ugvYgPLdQN
         /bzSKbGey1slNyLthASfhaSfTRcDf9/O37BQ4k4pdA1CUOrW2XmwIzaTY8WrE7AEW89p
         k34jWWWUX1BTgcOq9je6GVXGyohntxq2fdqCev2Fl35mF9zpQ1QnhPHpHPK32p2dAG0O
         s74q+7KnJBxGlLnoAjUWhVBB0QoAYa9NXWZtP47M3EzoevrkNcU/8NOcp7PVum9rHemm
         g2CCfgIQ/Z1iJIjtUgJgZnHZjolYd+EgEkk3PZue5lQCLBKCVDpEkRs4Vhla2LtfwKAP
         qEBg==
X-Forwarded-Encrypted: i=1; AJvYcCXeGNX7TJzXT1ZcBDYNnvYLs3QWHIdvBYGb2G0BVcoOBYyEa4+tsOSNiTk57MiW+hFM/M/3okzCa06IpFVIw/lzxQShM1nuX2tUuw==
X-Gm-Message-State: AOJu0YyxDpaSfo9Q0F7AdJ2uJ8RIt5oU2umldD6uQVKV3szdou3Nqv32
	99vMI4N29SlkHV+vsl9a7w1+4I0+fwEI3nIaN84QbdtsEIyQQjPeRtB4LVfPMqWOZ/qqnizNxxX
	nrwa04JPl63z70Xl3RSdRgOBWMlSF6Nf7xy43mA==
X-Google-Smtp-Source: AGHT+IHl7TYiCYsEXMrh4VmDGMZtMQoKh4DXw10jPMT7TOqjy20gTUqscrvJKqfiSDRCNiwo83Vx2RGvwz2GtNa0WA4=
X-Received: by 2002:a17:90a:34cf:b0:299:5b95:cd7d with SMTP id
 m15-20020a17090a34cf00b002995b95cd7dmr4504419pjf.45.1708419384629; Tue, 20
 Feb 2024 00:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <135feeafe6fe8d412e90865622e9601403c42be5.1708253445.git.christophe.leroy@csgroup.eu>
 <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ec35e06dbe8672a36415ebe2b9273277c2921977.1708253445.git.christophe.leroy@csgroup.eu>
From: Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date: Tue, 20 Feb 2024 09:56:13 +0100
Message-ID: <CAM1=_QTF1amgOZUWJ4BA872RW3DE_papO5yi7ak+-WCkBfvC5g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Take return from set_memory_rox() into
 account with bpf_jit_binary_lock_ro()
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Puranjay Mohan <puranjay12@gmail.com>, Zi Shen Lim <zlim.lnx@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Paul Burton <paulburton@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Wang YanQing <udknight@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	netdev@vger.kernel.org, Kees Cook <keescook@chromium.org>, 
	"linux-hardening @ vger . kernel . org" <linux-hardening@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 11:55=E2=80=AFAM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> set_memory_rox() can fail, leaving memory unprotected.
>
> Check return and bail out when bpf_jit_binary_lock_ro() returns
> and error.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> Previous patch introduces a dependency on this patch because it modifies =
bpf_prog_lock_ro(), but they are independant.
> It is possible to apply this patch as standalone by handling trivial conf=
lict with unmodified bpf_prog_lock_ro().
> ---
>  arch/arm/net/bpf_jit_32.c        | 25 ++++++++++++-------------
>  arch/arm64/net/bpf_jit_comp.c    | 21 +++++++++++++++------
>  arch/loongarch/net/bpf_jit.c     | 21 +++++++++++++++------
>  arch/mips/net/bpf_jit_comp.c     |  3 ++-
>  arch/parisc/net/bpf_jit_core.c   |  8 +++++++-
>  arch/s390/net/bpf_jit_comp.c     |  6 +++++-
>  arch/sparc/net/bpf_jit_comp_64.c |  6 +++++-
>  arch/x86/net/bpf_jit_comp32.c    |  3 +--
>  include/linux/filter.h           |  4 ++--
>  9 files changed, 64 insertions(+), 33 deletions(-)

For the MIPS part:
Reviewed-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>

Thanks,
Johan
