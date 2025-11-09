Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18932F549E
	for <sparclinux@vger.kernel.org>; Sun,  9 Nov 2025 17:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762707875; cv=none; b=uP0lp7K7ooHvfKqs63f3WHPNTxilCimiyFDPJYShTUYfmhEF9vxFUxCPyPtiUEzFLWWuieF8cS3l8z+xzkgOBBgm9tBwDqE1XTUGHKozSIh1fyAegUZJXX7bZkL82MngAZV4sIRC5aw/Qisshh4sCwPIz2pTTWNxNSDce7QI+KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762707875; c=relaxed/simple;
	bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q7PLJZ+oPha02sG+mENEuY4yU1wl2c5+UlYZLamT70pIbbhr2HTclAyy/mmxrvaBiDN5qqNT3ErfYUCoxoXTtLRG/L2PuHitQ9u2KMleUcjBhsRxLtr7RUtpS7WpeaeLG+X3DJ/HJ7a6hjaVtROQ1xaEbdQ34VKi7+9ZgFWtsUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUWscdTu; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUWscdTu"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ba4874edb5dso1229422a12.0
        for <sparclinux@vger.kernel.org>; Sun, 09 Nov 2025 09:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762707872; x=1763312672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
        b=SUWscdTuz6E8COB4RFi3ARO92QxTVYh+eM1xKZGjF6toaMhbiUpmk8leK7DKEWdVmL
         T1n7eWLAgZR17BgtucZln5haaFIwIlzBsalpycpO9AxPOEgjT11nWQKYzgTk0Z9K30Kr
         rFye/XM/FEOlo1TZuOg1+8wKc4EhvaPGuuwf7bsd2id6U4ZThUmIyUTSgvVorWd3erHW
         mGWG0yFvj5HsGIavX1MJ6qyQVNruD0wj8Ku4SWPkAODcbDrsuB4gTHSFD73zHzYvw9Xh
         Z/AAbxMNYwNciKd7J61O/9qa17+e9u5qDL/ZsKQWqs+i2yi7vmHiqCc3mSXqFsLZjskb
         DLoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762707872; x=1763312672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4K+T0yvpGk3Q2IrzYuDGX8XEZi6W9MmpXSWX8qogLWs=;
        b=BK2coz1s7/orRM4sORZXMJX/7Z5M7UCKjDcYnmWdfHjcfsW4S99fI3RDeClR+cFm0w
         7ve//ik747nM/thv4e5FhTBNSesok3EYQxgrK8L4F/UBqEObmGgzVnoJkZTqsynMNPwr
         DcER6dbYqoEMWuOX1y+8+vOC3TVEM0pBkLbsWgJGjqTe4okNt1HpAVScZZ7+61yeRCEZ
         rOuC1sZHPkJ22loHtP4Mys+3YqHatZFR5m+bCyojVkQGdC6MEGKxc3sgOtiH7OROG9jO
         if20U7Bh0O4wqJG8DGs7G8uFPtehTs87VKW2K8MztTMpiLnpC03olc+/3k60zN0FUnC+
         LMbg==
X-Forwarded-Encrypted: i=1; AJvYcCVCCTVlPBVfc5y5hRRkMa2qJhJxBUWxm0C2Lt4WT4lfY4VKGyzA8nqsUmBNETvj6Lj2pRV9oE2mJbCn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+FgIPSxeAa6S8fkrJI/NQejIs6VwODLgNtxznF6rHetIQ3Auw
	x6+QjV78cllxUCXFjsDjsTFAqCGs6+elO02flrMYxkWRqt6yQ1bAw0ev
X-Gm-Gg: ASbGnctRWzvobO67eIO+Y5WBW6oERmysPXSkSJXEqrTyM7rhnjSXbniZvy1NVSe0PAd
	AyxseBtY2uAbi9T5g5mS1ukOAhGd0YpIn1qyW8o8OwDHQIgFCAzq9d5SVPxOd9p7cu2svjoERaq
	D5/4XaTUo0xrID4USppMnFz/3NIn3ORW5ZNPs/EgvBEgwBrq2unSvYonlMNa7A13N3x33E/dc/1
	G4upgW045/3oRIJcTpahCX5q8+098mZkvj25I7Zxk5X2RZCRddxwXyxtsnbJWWfs2L71Gq4gO3Y
	BS56ow0RlhdHdBS05gpxHX1vqt0c1V8rwWJkj1CVs9Mth0M6NQwCPYZ0w1BZT8VSreqSdWEy86S
	mDJ2alf4/NXXKbjzRIturq5a9vLk9INCiyMu64MczIsxpXgoqXHFDX7NI+51ojjAFMyJ1zbRARI
	TLkBBNFRR3LXD1FkBV2untg4GFte8GI6Rtwuk=
X-Google-Smtp-Source: AGHT+IEO5xU3ShKvIQJG0EYcsf90e1JVTbxU34yk/YUYIZqWcpmJ8G9BchXReIw1drUaTkP5NUMmRg==
X-Received: by 2002:a17:903:2f86:b0:297:c71d:851c with SMTP id d9443c01a7336-297e56be50emr71705165ad.36.1762707871570;
        Sun, 09 Nov 2025 09:04:31 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650968253sm117879105ad.20.2025.11.09.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 09:04:29 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org,
	david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: Re: [PATCH v2 3/4] Provide the always inline version of some functions
Date: Mon, 10 Nov 2025 01:04:02 +0800
Message-ID: <20251109170402.145012-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
References: <20251109113152.GA2545891@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 9 Nov 2025 12:31:52 +0100, Peter Zijlstra wrote:
> There isn't a single function in the entire kernel with an _ainline
> suffix, while there are a ton of _inline suffixed functions.
>
> On top of that, this function was already marked inline, and your
> compiler just chose to not inline them for raisins. Just make the thing
> __always_inline and forget, dont make thing extra ugly for no reason.

Simple test: "Make the original functions as __always_inline" VS
"Add the always inline version of these functions (with _ainline suffix)"

compile as OPTIMIZE_FOR_SIZE: the size of bzImage is same
compile as OPTIMIZE_FOR_PERFORMANCE: disassembly of vmlinux is same

Adding the always-inline version of these functions can provide better
guidance for compiler optimization, but it does indeed lead to more
complex code.
The best solution may be to prompt the compiler to always inline at a
specific calling point through some keyword.
I noticed that there are also people discussing this issue on stackerflow
, but it seems that the current compiler does not have such a feature.
Link: https://stackoverflow.com/questions/14571593

I have no objection to either option; it depends on the opinion of the
community maintainers.

Xie Yuanbin
