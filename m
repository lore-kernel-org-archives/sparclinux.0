From: David Miller <davem@davemloft.net>
Date: Thu, 27 Dec 2007 03:05:04 +0000
Subject: Re: 2.6.24-rc6-mm1: some section mismatches on sparc64
Message-Id: <20071226.190504.20990618.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071222233056.d652743e.akpm@linux-foundation.org>
	<200712261329.08313.m.kozlowski@tuxland.pl>
In-Reply-To: <200712261329.08313.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: m.kozlowski@tuxland.pl
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Date: Wed, 26 Dec 2007 13:29:07 +0100

> WARNING: vmlinux.o(.text+0x46b04): Section mismatch: reference to .init.text:sun4v_ktsb_register (between 'smp_callin' and 'smp_fill_in_sib_core_maps')

Well known and I see them every build and so does everyone
else on sparc64.

They are harmless and as time allows I try to find ways
to get rid of them but it's very low priority.
