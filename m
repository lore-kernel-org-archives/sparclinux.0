Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377812D5925
	for <sparclinux@vger.kernel.org>; Thu,  9 Jul 2026 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614229; cv=none; b=JAaFm88soGKgyK2ZYLZIqU6x+hMAUwscUi92hzp9r+cp9UjMTj01O+iNC13aNBlyazSypPbwpvBVOkwxTd6Ti5a65K2tT+yL2j1NQdVMWdT+JIYmePGHN0zdGr6f9vcFVlbRz/KCWw0a34WJFPAyZUYjJmx5cv6GhQPk1+SbDqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614229; c=relaxed/simple;
	bh=PYgbxg9gRqFkI+16o1eOO4t2hXv+bYRFkiZ971QQZko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tn34AiouGwwj9hPyUxs/zP5ShJmj/EMRfCsf7YAFxY9g+Cf1Sslrl29Bnj/Lxyj3wyzMlvcDLkuW5hO/SHvw6JqXRvHo6xLt8h12NsC4yX2r1B8JJGf7mH/QbS5NrJCaz5A9XoOHhmkW3WN1MRqOtv2dWuSPMCx029TkaJS6488=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTtKQlVI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTtKQlVI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E801F000E9;
	Thu,  9 Jul 2026 16:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783614227;
	bh=PVNPrFU1PGB9ZkQlUfz3ePnrtlBWmUW1vci7gbMc020=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kTtKQlVI2aH1amHksEa7rfow7dWVS+iS2z4YE+Iqh/T8+Ez5emEdqU1kdTkaojuWs
	 OKJk7lW+oT4uvf04ob+D3ohM9aoF8ZJD479QfbEOC0R1m57bfYtZLQA6geu/uz6b0K
	 /lSg2t46nMG+6NTk82rnjRKlnXyNfa0QcvcA+vIC8NDBI3i7Ah7K0vfnkJ4IiosS81
	 dGiM7S9+9FvucYQjofrQJWnr41v3kbEpvt6ntqA8Lf1UqpsGYGYif6fGK72sB8cQBU
	 oe++fLwVLSnhkAy9AkoHjEauWHassFGXYqo/RAuzcpteROSfe16KP1+JnaDRJDSjvX
	 /r0+r0Y0kf48A==
Date: Thu, 9 Jul 2026 09:23:47 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org, Huacai Chen <chenhuacai@kernel.org>,
	loongarch@lists.linux.dev, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org,
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
	x86@kernel.org, Mark Rutland <mark.rutland@arm.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Helge Deller <deller@gmx.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Richard Weinberger <richard@nod.at>,
	Chris Zankel <chris@zankel.net>,
	linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, Brian Cain <bcain@kernel.org>,
	Michal Simek <monstr@monstr.eu>, Dinh Nguyen <dinguyen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	linux-snps-arc@lists.infradead.org, linux-hexagon@vger.kernel.org,
	linux-openrisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [patch 02/18] randomize_kstack: Provide
 add_random_kstack_offset_irqsoff()
Message-ID: <202607090922.4ECAE32C07@keescook>
References: <20260707181957.433213175@kernel.org>
 <20260707190253.768842729@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707190253.768842729@kernel.org>

On Tue, Jul 07, 2026 at 09:06:02PM +0200, Thomas Gleixner wrote:
> add_random_kstack_offset() uses get/put_cpu_var() which is pointless
> overhead when it is invoked from low level entry code with interrupts
> disabled.
> 
> Provide a irqsoff() variant, which avoids that.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>

Seems good. I don't think macro'izing the interior is worth it since
both cases are very short, with only the lockdep and raw bits changed.

Reviewed-by: Kees Cook <kees@kernel.org>

-Kees

-- 
Kees Cook
