Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BE7353A7E;
	Sun, 27 Sep 2026 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542226; cv=none; b=t3F7qbXcVbKslxQLr3K+8pyvO53X+1vIS3XF4F8nx3or8bp0z5V9GvCqdG10IKfrcV4KmEsRp+yc16ZWZT00mX8pfm/NyaA9jSHLhKu8vXHn5vUIINJxBGrW0itH11ZVrhby4kB4SKsdrDAEEqTjAC/nv+JIKC/O+yJHXiwGrhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542226; c=relaxed/simple;
	bh=/UO0Yrx00RwqGJDAxRaqo4wE4cvMn11VYJceOL6Mr6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAEeFgAhuypBqZ4Efhyam574RwDmxOW0kTDneSV+eP2LPT/tahw3xaa0lpBFKVwPMncV/HLq0WDOSynkL0vj4SzCTPUWAuqLoRwJQyy9VESTP3++TG7WO1H0tBTEeWv7CIs7hESgDiklL/DpJ/gg7R2WbJPHBtyAlf89vWs3TbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h66/aerf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h66/aerf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D441F000FF;
	Sun, 27 Sep 2026 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790542225;
	bh=/UO0Yrx00RwqGJDAxRaqo4wE4cvMn11VYJceOL6Mr6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h66/aerfnKxBUbQCK63a+4OE43QNWLpIkHlbvHAUgBJGcbpsoB28Q8Ay4XoEjW9MU
	 gc5aJpfHLHcYppznVDcVD24qmMJ4qlyLbPdqgol252PACzgb+EAIvyGoF7AANcHXiW
	 L/6s8vhgg47ZQwvMK1e4mTrXlPmHdfHz7rCqsQCIDzioAPQia8I088Lt2lRt752Twq
	 kmJOiapMGSetZ5xGYY0flG/OItqClbCUMIHcIDrlpHOEcg+Hgc0mXyW+PUqZrl8b8y
	 3rlwqNP9fPM6LoSVEMY+dMyLKAm53hXVf2f1CHnM4jEiTn7dtd+5jyE5dMv1heHlDZ
	 2SRwUn/bR+baQ==
From: Imre Kaloz <kaloz@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc64: vdso: Flush the D-cache after updating the time data
Date: Sun, 27 Sep 2026 22:49:22 +0200
Message-ID: <20260927204922.3783-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917082547.223729-1-stian@itx.no>
References: <20260917082547.223729-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 17 Sep 2026 10:25:47 +0200
Stian Halseth <stian@itx.no> wrote:

> On a Sun Fire V240 (UltraSPARC IIIi, clocksource stick) this makes
> clock_gettime(CLOCK_MONOTONIC) via the vDSO wrong for most calls on
> the tick CPU, by multiples of the 10 ms tick and up to a second, in
> about half of all processes: those that drew the other colour at
> exec.

Hi Stian,

Confirmed on a Sun Ultra 45 (UltraSPARC IIIi, SMP). The unpatched
kernel's vDSO clock_gettime() went stale on 3 out of 3 boots, up to
85% of CLOCK_MONOTONIC/CLOCK_REALTIME reads on the affected CPU, with
a lag up to 1492 ms. A kernel carrying this patch showed 0% stale
reads on 3 out of 3 boots.

Tested-by: Imre Kaloz <kaloz@kernel.org>


Best,
Imre
