Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D487F27510B
	for <sparclinux@vger.kernel.org>; Tue,  4 Nov 2025 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762246170; cv=none; b=Zr1Sm5XdKv3LNw12Muxp3Yl7UlyKqqSzQlkwm19whvR7gWu52T0VgqKrVBFOWHZd6gYJgtyWqm3e5fXuyH7w70zQUplu6RGhM2spp80X5hNyUTy9abQBhvEFkXpDOeKllmqGaQ7ahmYA2m3TzrpX06QbMbC4egWnvEwAc+BryBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762246170; c=relaxed/simple;
	bh=bwGYumF3/kIIW+zzveEhCKzNJ0ATBCRDR2j8OQO/23Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhzmW261LiFxhVQSeLd0zPFg4In+cc88Ld0Mv1j3A4aw73zpXzwBI07lr/Aie8ctQqIjn70ovsWnb5BpVpvRB1UBniOO2y9gNcADrS51SQS8YqSnNBTWD1F5u+LYf+O/PJo/lkFQYuR/nlsZ7WWSiEExdx5EzogGLVgAnVHdEM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8C3XyMb; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8C3XyMb"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b99bfb451e5so1509143a12.2
        for <sparclinux@vger.kernel.org>; Tue, 04 Nov 2025 00:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762246168; x=1762850968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZzjlCCT3j9j2Nd7pQrTgnxvKhulGcz35Gruny6M5Bw=;
        b=B8C3XyMb9sztvNGcLQuH6oELUi82MwvYPXNmWWwVZIXfJq8n/xMbwV71TvTKuLCkJZ
         xhN1jiesHsMzW3f5vJ5e/b/BdlT36STvsi2Pz9VXlkWjzW28wHdkMaGfdW4prBvnhyDS
         MnBB0MWpzyg0WAbTKOcRL0HEqKKGGILWd1tYLmmM9mltkl2NNjAMKWQQu+5GQ4dZkI/v
         LFfZUOu3NcG6JQhKzcrj4R1hnhUnY1lN9PJLWHKdhJY97SOZQKbSJg/lRiPjkrecRkot
         Uqpm7EI7EdWWIfftAaBZjndccgCh+JhKr1Zy6PsTyIwKgLM4nLR67MZ8H00wsYwfKZIe
         Jqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762246168; x=1762850968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZzjlCCT3j9j2Nd7pQrTgnxvKhulGcz35Gruny6M5Bw=;
        b=ovln/IWkTQxHNgnbyT4ADNAwPtw73o2rKGf7fv4v36ebA65JeVreGwSfUccHsG9dwt
         9hQa/v2IIUwatRKLfoWO86WAaXTEHjCAijChKij8ynwr6DpRxrdvLoTJBhmziHXMA21r
         fFUpwIyBoBh2WhHKkAcVMHYOBGWYNuTkOyoPBFDHA07IF2B+rp+cgzkIzMeSh9hsj/z1
         eNMsvQAm8k9eecLEvfIyudXN+t4f7JzF8gxdzvB8fe+nLWMsZAUKu41h2ATAF4yEhC4p
         5Ae/NUJ3myXQ3FxL13OByygKDcBQWfyAvszyC9+ghZIonyzdfs88FW0+mOLGWAJrKNRM
         2uCg==
X-Forwarded-Encrypted: i=1; AJvYcCUM/9ueg7H4TdGJDLQBXQXSXAry1GNi3Lnp4WqfS93Mp9UpBraUb72HGa3ORVsWrJedvu8PNSsaJGIF@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8OS5ijSljwOxtqC/k3+xgWxubPA+Im8Mwpd140zC4GY6NCVPe
	InPUDzd7/akzWAGaaBmjZvggRn14SHPTEcrPLXI0Ee9N46q2V1Z0GRhy
X-Gm-Gg: ASbGncv2m6MdvFEAD5lvkIBGyMHWW7Fs/Wb1K8B0c+HhDLjzFP+6Nlc79yiWKDf3xXh
	Lpo/2SLjdU2AO1sB49hw94P3JIe8k//9iU5d9nHQvHPd3pWyTzEVqbi98ol+Pd4/+IKuLR45idK
	4pMH3ozFwsbibJlsbO0hUrvjPfswMPv5P/OvkP8IGQ5aVgYrCCORi698Y5+OEn9ThO/ZH3G6Nkw
	cO9UpcZlXBvRcTun3gADQIOW8CH+Vl1UakXWIWB5sLYBVSJwpmhFnOe81fdb9EfnQAeSUwRJ1Rb
	1U5nqta+m682wdPeF5dPgklr5b3gcOMLKWIlGQWgHbA+aidJWTObWvBP1gRek1IhKLB1FUBNgt+
	e0QdKhmwotB3ukO0b1rj1vQh8sK6UYH8okaooF3A60ewBCzr5Soj4fkvOL2e+pmKChhEFAUE0NY
	KhP+N84Gh+Izi+SKOrX876Qw==
X-Google-Smtp-Source: AGHT+IEjMIiSe0x3JjyWJftYAjRTnLk4yj1+5guJH64mFdGd5LprT3gQcg1E9FYpKQf1UnNjUVPGcA==
X-Received: by 2002:a17:902:e801:b0:295:7f3f:b943 with SMTP id d9443c01a7336-2957f3fd4d1mr114855785ad.28.1762246167913;
        Tue, 04 Nov 2025 00:49:27 -0800 (PST)
Received: from iku.. ([2401:4900:1c06:600d:d663:3d9f:b9aa:53e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cc1sm3692393a91.18.2025.11.04.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:49:27 -0800 (PST)
From: Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: thomas.weissschuh@linutronix.de
Cc: Jason@zx2c4.com,
	agordeev@linux.ibm.com,
	andreas@gaisler.com,
	arnd@arndb.de,
	borntraeger@linux.ibm.com,
	catalin.marinas@arm.com,
	chenhuacai@kernel.org,
	christophe.leroy@csgroup.eu,
	davem@davemloft.net,
	glaubitz@physik.fu-berlin.de,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	jstultz@google.com,
	kernel@xen0n.name,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	luto@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	nagarathnam.muthusamy@oracle.com,
	nick.alcock@oracle.com,
	npiggin@gmail.com,
	sboyd@kernel.org,
	shuah@kernel.org,
	sln@onemain.com,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	tsbogend@alpha.franken.de,
	tytso@mit.edu,
	vincenzo.frascino@arm.com,
	will@kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [tip: timers/vdso] vdso/datastore: Allocate data pages dynamically
Date: Tue,  4 Nov 2025 08:49:11 +0000
Message-ID: <20251104084911.6961-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-24-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit breaks boot on Renesas arm64 RZ/V2H and RZ/V2N platforms.

The boot process doesn't complete anymore with no obvious error logs to
indicate the cause of the failure.

Reverting the following two commits fixes the boot issue:
  10d91dac2ea5 ("vdso/datastore: Allocate data pages dynamically")
  6a011a228293 ("vdso/datastore: Map pages through struct page")

Cheers,
Prabhakar
