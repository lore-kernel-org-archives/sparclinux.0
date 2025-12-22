Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6339D2C2364
	for <sparclinux@vger.kernel.org>; Mon, 22 Dec 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422174; cv=none; b=bRDVymYg3glkVwGEaQWS9Wdcg0fs/zKbLStWPfriHii3tddpVtNb2qct3JjYj42SqVCUxD4XpMm/1fj3uw8tUCMiXeeW3Ae5j7eaAPi+fDPOqfN6fICVLZesaT1LeBX2hKqM2FIZr8RZJ6jWcFboSqUJFnVLitgQduvLGfxxSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422174; c=relaxed/simple;
	bh=uHCtXyk+QeDYWx6FYrKpt8TBQA4HduB+6BbofOvZbwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHpC0VJAS6jg9JliLmjuTMbpOejq5RapOZVbTTVcoWXjQAq0Xu9dDTZ/jWtg4dd76AdImb3Pcn3O7OcT9Wu2+UT6os7Ll1iR0PsMeWQvSFit5ORQJT7NpJSAtzwZKuNcMntY9MfgPotWRrTEdCurMDMwXNsezfBcA1fJO66rll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh/pfhpO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh/pfhpO"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7b9387df58cso6735026b3a.3
        for <sparclinux@vger.kernel.org>; Mon, 22 Dec 2025 08:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766422173; x=1767026973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHCtXyk+QeDYWx6FYrKpt8TBQA4HduB+6BbofOvZbwo=;
        b=Dh/pfhpOQBQV6NbIpX9Al2Vme3mwxRKsR3UgJhR+1Xt6oHQPDPul7ClQiN3EkIzdkk
         IZYU693JwRK/8/BFaX61lkC4VQFOey3J15sozZJywKtXZqaro47lfQapI72B0CWPrVIl
         vVR9BD9Uy+gpDyGrFu2XQTD590ZYrgkmgi5gxyN5ee9V0xCYiYezcI0pIuqsmLZGtBVx
         M4SwkAe/PRyBZLoJUGuX4NDwyKzxKgiqlpsVXrhfDL1hOgpnTwf7jdG7Og+ioHXi8TlT
         va36CgFYndlmaNZ2IBmqL8L2kWwzCGjgn327ESMfeU0+Jy5wQHnBC+1wPsY+mLxdx4v1
         npug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422173; x=1767026973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uHCtXyk+QeDYWx6FYrKpt8TBQA4HduB+6BbofOvZbwo=;
        b=QXMzwiKtpb5IObHJ74PbdPPomAvtXIITfCXTvw4CzvC+4abc8OMCFDB3AEJM8NbD6n
         pFX1Ej/GX0MBRxPneugg7V69dWpI6Nc6aT3EG8FcLb9PtFMA9RB6LyR7gXIaKlxF8vgt
         Gen7cnQQD60FJgtkMgyySMtih+lMfAyu4ON0cU6xC5vIMavpSXIMc0xb1n4B3ptbeq0D
         ra0EX8fXPcPb8/ET214IJJYDXAbIsh7UZrjiHbKox+cDpuLpVd/jQHFvCUQZ5DSk26fb
         FbP+XtjlnqnveBBET9s1nMgxEbEcgznV5Aj389rvNWVQGl98+ApS5gMzmFVzacG3XoYJ
         2Y9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUSNjeIKXii9voO7x5tRNHEiNIYAgXWvlzZcfbqMEsoa8MD5UtZfZ56aO9sKZjtiFEr1eP/DS3tAr2S@vger.kernel.org
X-Gm-Message-State: AOJu0YxUq94aEbDsOO70GHI8DID39d9mDcAvHq0g8uxsi+nXd8cn322/
	QS+umjNXKQlk4qMuc+P0DyVhxR+8TfVKqNH+tBpDoNbsrjAEC0Sj5A+o
X-Gm-Gg: AY/fxX4PZaLpMydLLn4/bizZ8z/t4+ezohZMGFsC8w/BTpcKms9QyMTNCQAkWBjfKcV
	wt7UHnVB6erFx0Fnpup3MIFwlENvEQI9BzTgXJPOxRvJOJB2fAWX/+deA3PPJNeX2ffdYmKWWnD
	p/s8NDrrWsDzYnv0Nc+eEOgEROaW3HKlId9Th2LIpfByTPT1gGz2QEZLdUlahteqnWqP/GUmLcx
	/M8RVrMP6xkdZy4b1uGba3vshMFXoi2NCBQJMN1g4Clw/6oX2m6EcVVMeb9HXPakY7m5otTdtPm
	44XXuhpoGsyhouCLvtFJlAUEsN9pSKBvaj7/Jvvu9WVBJj1RhxOCGyCq8+Xa9Vhiq04pkrH3sYX
	GAQ0vP0smgQnVng2tUUhOX+bTRgqzkn6m6Iaw8u3FwTRbpKsy7RV0BjJrcQvF6DOK3rhtqVJi0G
	FakhEe+JXUsEfmRxoPu4huVE4dFvkaHN/CN7JUGMEsqw==
X-Google-Smtp-Source: AGHT+IE1kSobyivF21U2b11KGtxcCjvRi7p3rr+R+RS7uDCxpPw8QK+rjeZvOZXB1HHavY3ezNQDyA==
X-Received: by 2002:a05:6a00:600c:b0:7e8:450c:618d with SMTP id d2e1a72fcca58-7ff664806c2mr10273618b3a.36.1766422172494;
        Mon, 22 Dec 2025 08:49:32 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a93b441sm10813272b3a.9.2025.12.22.08.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 08:49:32 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anshuman.khandual@arm.com,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux@armlinux.org.uk,
	llvm@lists.linux.dev,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	tglx@linutronix.de,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	x86@kernel.org
Subject: Re: [PATCH v5 3/3] sched/core: Make finish_task_switch() and its subfunctions always inline
Date: Tue, 23 Dec 2025 00:48:15 +0800
Message-ID: <20251222164815.485-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214191307.184897-1-qq570070308@gmail.com>
References: <20251214191307.184897-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, Peter Zijlstra!

Could you please help review this patch? The content and testing of the
patch should be sufficient now.
Link: https://lore.kernel.org/20251214191307.184897-1-qq570070308@gmail.com

Thanks very much!
