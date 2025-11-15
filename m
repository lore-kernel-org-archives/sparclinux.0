Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E318F29BDB5
	for <sparclinux@vger.kernel.org>; Sat, 15 Nov 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763215316; cv=none; b=RzI4ie59YuS8b9H3X6/TCYcqnTBEEVcTTfkSPexb2VhvUss6GzM78va5WdvjuVqDfBBcITSgQzM7q5ug6T6mO7/j/nLE95fTR3nJ1M9Jn6nKPKcsTpmCcwYfgFBgSqABWLNtHMm1wLyh5L9CEaOeVu+xjhI+K0H/Uh0V5+5rfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763215316; c=relaxed/simple;
	bh=olQBQzbLF3fdlc7j5Y7W4kleJFMfa0UsHIk6o2GsAbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzxfQvy6KCJ1ixUK42z45/Gmz/Idz+vGQ1/uN/gm1ifH7L+0ZyA8vKUdMCy1rLk0av1OO27yi2urq0wzIgILbUrvaYhPDWOqJj3B3sLufhQWtjBrig+wbWo6v/GGHPBilU8qqjnvxJWcQIidl3SI8YT94PpJSZAwNJVheVBX4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPPlpPN8; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPPlpPN8"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34372216275so3296377a91.2
        for <sparclinux@vger.kernel.org>; Sat, 15 Nov 2025 06:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763215314; x=1763820114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=olQBQzbLF3fdlc7j5Y7W4kleJFMfa0UsHIk6o2GsAbQ=;
        b=WPPlpPN87Ut1s2/7ePShZv+unovnrmjl++p2y0sOrL6ijb2W3eLmkY5dbhUJwBiZoj
         049wrgkwzXlsr6qr//qLRiIh0aplcRrEvxwr367byGGwURdHE32MdNmGt7iISbGnYC/F
         X0MxzIjDTE4Lg/5hVTa8bYpHHbf58X9x0s/09kS8MKBagRfZrcfl4pzWYOGveaukOTNp
         +vZoSdiXBIF0qIzMj+zUhOxFHPHYUvAEBfuGuxKhzERqLfQMGCu4rZJ9QK5+KcUhg6cX
         9uu2+kly+2QoIeRxr6AEcnpDwW+7YVkkv2FfnozxEmHVEBu9eni8+j8ug2gQLRtpKv3f
         FK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763215314; x=1763820114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=olQBQzbLF3fdlc7j5Y7W4kleJFMfa0UsHIk6o2GsAbQ=;
        b=JieK4JCq9Z3V4bnM50Y0KeTP5D5OZWCvd3ldKjozsDZt0LJMYWZrHVckb6QQ8GhpRf
         WSGEuNwHZ3770WlOdRi36EtEDi2dUyItlQHXiFyiqNRCWMZMFCNlrdlTwKccDFW11379
         IOXFRuOYGKoBcqIsC9nRsTaduySyoyVG40ScQeTng7cW2vpm0Z+1tWAFCbGdRv65zu3N
         CE5+W8pL9ZJlvw2REqmIXfj/R6638iN3UpmIb84eQ8QB29X36MMllAoK5izdVWUdMQvA
         f2aamHz1qslZzSfgsfqE0/fgQLIpsJVQCePWJGXArySRWLFSbxXYKztikibM+O7iwwR4
         yS8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJmBgjSCAhB09y0GxhwtuQM7H49zKsDACrO6fKL+MtPxQ216/+saj3S7uF0QtdwNdrM5xChkbU8oNe@vger.kernel.org
X-Gm-Message-State: AOJu0YyzLMnghT2+7Ykvm/K1goCQqYFb3DtqlDWgMf/P0cHn2lkwKVQF
	9qfcSkTxOaR+Gn63Kfaij2LqCebqMgbNA8HyFOGtCNFpunBT+BF6l7vP
X-Gm-Gg: ASbGncswk9uAdyPX9e9hQv0zgCKnUjd+SGIATrKsBgyCKy+SD4aLT+Qx2jNQeHgzwpg
	O9AsxGkRJNgfGsbu7UmiV6DoPrW2rYE//5oVimVpR32XzXHvAG4BOMlx+r1TG8CdNHVgeZe1T6C
	lHBKN4AUtahCyOPG9LN7ts5VfMZ3gjQC/T0ceKXRXSSaa7Acj/DuISS9WSoJvivE+e9TLBRANHM
	cAfpiPJIqCUgStdncTpxZnnFvfV0qHUQICYnCszhF6y+nw/cftP4QIv7WdApAX8F51uyjC81JBo
	kK/IeyY05SifuyLwdIfpIn2+03aWHIV4Kaa3q8pFnRCvkBVLmYWZD3q/uDnTCgmVujEZP7oJUe8
	9LNb3In6WX14wiPHRs1l+QD8tNwDQaAsVJ8BVmfTgupxp4Ngz3uoz/XMTj2jksFJLuJgt+sEu1Z
	2WOmp+QPNL6E1qefEPNI2dpro2bxoo4403hqw=
X-Google-Smtp-Source: AGHT+IG/TnOO0qzjxK2iaqcK1w8zb7Sll+uP2m9bSS0pCypnuHepcTcVoR++oPZWg3RSEvlIe1E8yg==
X-Received: by 2002:a17:90b:1dce:b0:33b:d74b:179 with SMTP id 98e67ed59e1d1-343fa74c2f3mr7051205a91.27.1763215313855;
        Sat, 15 Nov 2025 06:01:53 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc37526d91fsm7478366a12.22.2025.11.15.06.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 06:01:52 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de
Cc: aalbersh@redhat.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	andrii@kernel.org,
	anna-maria@linutronix.de,
	aou@eecs.berkeley.edu,
	arnd@arndb.de,
	baolin.wang@linux.alibaba.com,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	brauner@kernel.org,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	david@kernel.org,
	david@redhat.com,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jlayton@kernel.org,
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
	mhiramat@kernel.org,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	oleg@redhat.com,
	osalvador@suse.de,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	peterz@infradead.org,
	pjw@kernel.org,
	qq570070308@gmail.com,
	riel@surriel.com,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	segher@kernel.crashing.org,
	sforshee@kernel.org,
	sparclinux@vger.kernel.org,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	will@kernel.org,
	x86@kernel.org
Subject: Re: [PATCH v3 2/3] Make raw_spin_rq_unlock inline
Date: Sat, 15 Nov 2025 22:01:08 +0800
Message-ID: <20251115140108.543-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <875xbcbdrm.ffs@tglx>
References: <875xbcbdrm.ffs@tglx>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 14 Nov 2025 20:44:13 +0100, Thomas Gleixner wrote:
> That inline does not guarantee that the compiler actually inlines
> it. clang is obnoxiously bad at that.

Yes, I know it. I modified it to __always_inline in patch 3.
This patch making it as inline to make the context look more harmonious.
Thanks!

Xie Yuanbin
