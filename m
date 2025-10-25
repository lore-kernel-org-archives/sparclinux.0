Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4D62DCF71
	for <sparclinux@vger.kernel.org>; Sat, 25 Oct 2025 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418307; cv=none; b=Sh+94qdW6h4kwM+mVOhKx7BMuHsmOsf6MEcdBxURlL60p4W9zR+DomoFIn5BEYsOOSDbbJQ6U01vsJdbVOjKAQgrhcrsWV31+Xz+4GrEJa0vOcTon+yPixWlnutakFzNaJx835yKJFPJYxhINt4ICYRgvTZZG8Jk+2o8W5RgdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418307; c=relaxed/simple;
	bh=bIE1dNWJNDWO8or3nwiGA7qbCcPQuWvlUWlsOjJvHas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iXQ4sqmDlqqZH8essSMpIR0BhaLggVDFD/1JSsxZLYWNo4U8Nlir1dPCjG5Hpt1eKs61N2cKuxn6MhEWt5NZnkE+OHxlTE6yNBrYWY19SCwJl5pih4PiDwyvXYBNmUL1nnm3iQXzTfelCrZeke78fdqparNt9owl6XTTYWG5+vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OumiIAd5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OumiIAd5"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a27ab05a2dso2700347b3a.2
        for <sparclinux@vger.kernel.org>; Sat, 25 Oct 2025 11:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418305; x=1762023105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIE1dNWJNDWO8or3nwiGA7qbCcPQuWvlUWlsOjJvHas=;
        b=OumiIAd52mCDIWxBvkc4sx/mY6AGD1qdzpMd8pl1TUTxhYEX5q84GEg6bGFuQuBRln
         2F5uoUpsW4Dk2owigJC4esen5PDF20+UtY3w44OTaSxbR/ZW3ikNiRpYwgYaLYqxH9b0
         0nXq4VbZkjlFeSVk9oSEu87qNaSnImr0drPZjptdrWhtKCNi7B7FtLg14CXHilZNypOJ
         LR6Orvv4VaCltv+tlfryTjYRsJauLuFwvAtRmYuRlmPEhFs2y6eBHfCmq0/1bjcNm7iD
         X+zqhWDc5Z06RSIzzS1HmotZKI9zHjn5Yy7fOo3lgGe9gG92JLDssTY9XZLdK2Ms6NwQ
         sztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418305; x=1762023105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIE1dNWJNDWO8or3nwiGA7qbCcPQuWvlUWlsOjJvHas=;
        b=kee/uQzoqiEruXEG43rZYX/ul+x+fc8j3SGVsrFQR+yIo8rlf9awEoQ3pHXmcPXhcH
         w+SualBWiiIFvHNXM4UkVDodYSZOQCV/NFXWo90ay8yjRXsBk+CrfOj1sFBUIVu9xJ+r
         RoViC1PUGUnl/z/UdzqTYuWWUnysGVN9LJPTsFe30+TAYVvuvC0u7/mGBv61e9vfzz3y
         mFdxezWVZqm3M0WfiY3Kp1GePMgdWhhh5PNjc4e3vfjYWDbbPEu/ifwhQvV+Pm8q5ZIE
         7Ht/5hojLfP8vEBBed9kClvOlDBLaHKLQTWhgmDgq5BlIoj8j8P9S0XY/y2STyICVDzu
         CYpg==
X-Forwarded-Encrypted: i=1; AJvYcCW/U5+ZLQzvrKZRHRwdUT4ohUVSJum8NyJrofGVj2hCZWbemh9yjr6yc0giDKiGwkLNSaPUnB7YPk2H@vger.kernel.org
X-Gm-Message-State: AOJu0YyaFdqC+ctQ2OLVWCBbUX8vDPVsAFG807/V/ZoRuMFYwRxwAub9
	zg1ScWOf6aCfKKGQNyqAil9YOhKN6mN8pGkCpZ5XKfhIi+nK7D6OCQ36
X-Gm-Gg: ASbGncvPu+0e69m9zjfOXPG+LGIfa3Bf5RhI2HLO27qR0C0Aolcx2N5FKGCRqDVZXOM
	ZT/ZUHhALSDdW62if3eiR1wZ75feXBIQ+uZj3lijm25ZwX6dHzIhjyY6N+JW+1AOsQzSdIzlpim
	3Bj7I5W63DRe4/gyaSVzQTU5MsZZHm89oiVUQAj1jBOePybRyc6D27SHxfybuxwbFkJst7b/v29
	99ECv/+C4jyg+/EwTMN13qoBFsYAP21OkUe9+ag3uulrt5JMfuIpcUDm51QVuM+Od2f4IzpqRdS
	lA2lAW+3aCfVNkIUlnSNjhWeNYkfigCw0tl95chC6epyB8tiPOk9tqeKSQ7AfrKOqN/36SS7hau
	grDx7ri/g1GZUjCoiIF9/ND0DwQFBhUsXyhuaaaHstijkPxykHCPf6Zg/YWkgmg4+9MDT79GIZT
	tryZNd4z4An6dabyj5kQm/
X-Google-Smtp-Source: AGHT+IFA/PpMad08k18p5dz1XblACJuseYn3XTA1biqGFVkwzh9uXMt+aH7CWADiafyloVKa8I/K9Q==
X-Received: by 2002:a05:6a00:94e3:b0:7a2:8343:1b1 with SMTP id d2e1a72fcca58-7a283430981mr9276736b3a.17.1761418304909;
        Sat, 25 Oct 2025 11:51:44 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41402e554sm2897425b3a.18.2025.10.25.11.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 11:51:44 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	namhyung@kernel.org,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH 3/3] Set the subfunctions called by finish_task_switch to be inline
Date: Sun, 26 Oct 2025 02:51:20 +0800
Message-ID: <20251025185120.6760-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87placw0dx.ffs@tglx>
References: <87placw0dx.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 24 Oct 2025 21:44:10 +0200, Thomas Gleixner wrote:
> What is exactly the point of this indirection. Why can't you just mark
> finish_arch_post_lock_switch() __always_inline and be done with it?

In this patch, I've added an always inline version of the function,
finish_arch_post_lock_switch_ainline. The original function,
finish_arch_post_lock_switch, retains its original inline attribute.

The reason for this is that this function is called not only during
context switches but also from other code, and I don't want to affect
those parts. In fact, with Os/Oz-level optimizations, if this function
is called multiple times within one .c file, it will most likely not be
inlined, even if it's marked as inline.

Context switching is a hot code, I hope it will be always inlined here to
improve performance. In other places, if it is not a performance-critical
function, then it can be not inlined to gain codesize benefits.

Look at your opinions. I have no objection to setting
finish_arch_post_lock_switch directly to __always_inline.

Xie Yuanbin
