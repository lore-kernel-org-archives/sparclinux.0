From: David Miller <davem@davemloft.net>
Date: Fri, 26 Sep 2014 04:07:43 +0000
Subject: Re: [PATCH 2/6] sparc64: Fix physical memory management regressions with large max_phys_bits.
Message-Id: <20140926.000743.67182598946375978.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20140925.154104.1236814936247080657.davem@davemloft.net>
In-Reply-To: <20140925.154104.1236814936247080657.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


While re-auditing this patch, I noticed that page_offset_shift_patch
becomes completely unused by this change.  So I'm going to kill that
patching section from vmlinux.lds.S and the code that processes it in
init_64.c

Just FYI...
