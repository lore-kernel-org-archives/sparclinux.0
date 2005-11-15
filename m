From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 15 Nov 2005 22:07:55 +0000
Subject: Re: [PATCH]: IRQ stacks for sparc64
Message-Id: <20051115.140755.48263640.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051110.210234.59468958.davem@davemloft.net>
In-Reply-To: <20051110.210234.59468958.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Sat, 12 Nov 2005 13:39:05 -0700

> On Sat, 12 Nov 2005 11:45:28 -0800 (PST)
> "David S. Miller" <davem@davemloft.net> wrote:
> 
> > And without the IRQ stack patch applied the "kernel BUG at
> > kernel/fork.c:731" problem does not occur?
> 
> Correct, an unpatched 2.6.14, 2.6.14-git14 or 2.6.15-rc1 does not show
> this problem.  All 3 of those kernels when patched, do.

Do you happen to have CONFIG_PREEMPT enabled by chance?
