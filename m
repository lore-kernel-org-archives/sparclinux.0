From: Li Zefan <lizf@cn.fujitsu.com>
Date: Thu, 18 Mar 2010 06:36:28 +0000
Subject: Re: [BUG] percpu misaligned allocation
Message-Id: <4BA1C9EC.2030801@cn.fujitsu.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20100318044930.GC5045@nowhere>	<20100317.232648.59697287.davem@davemloft.net> <20100317.232834.115948373.davem@davemloft.net>
In-Reply-To: <20100317.232834.115948373.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: fweisbec@gmail.com, sparclinux@vger.kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org

David Miller wrote:
> I can't even find kernel/trace/trace_event_perf.c, what tree

It's kernel/trace/trace_event_profile.c in linus' tree.

> are you using?

must be Ingo's -tip tree, or his own tree which is based on -tip tree.
