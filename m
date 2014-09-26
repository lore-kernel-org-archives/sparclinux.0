From: Bob Picco <bpicco@meloft.net>
Date: Fri, 26 Sep 2014 15:17:03 +0000
Subject: Re: [PATCH 2/6] sparc64: Fix physical memory management regressions with large max_phys_bits.
Message-Id: <20140926151703.GJ4211@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140925.154104.1236814936247080657.davem@davemloft.net>
In-Reply-To: <20140925.154104.1236814936247080657.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Fri Sep 26 2014, 12:07:43AM EDT]
> 
> While re-auditing this patch, I noticed that page_offset_shift_patch
> becomes completely unused by this change.  So I'm going to kill that
> patching section from vmlinux.lds.S and the code that processes it in
> init_64.c
> 
> Just FYI...
Yes, sorry I saw this on first version but didn't comment because of expected
changes.
