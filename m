From: Bob Picco <bpicco@meloft.net>
Date: Tue, 30 Sep 2014 10:36:32 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140930103632.GA24640@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Mon Sep 29 2014, 09:56:10PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Mon, 29 Sep 2014 21:52:54 -0400 (EDT)
> 
> > From: Bob Picco <bpicco@meloft.net>
> > Date: Mon, 29 Sep 2014 18:35:22 -0400
> > 
> >> PERCPU: max_distance=0x380001c10000 too large for vmalloc space 0xff00000000
> >> . So just subtract 0xffff800000000000UL from "ptr".
> > 
> > Bob you're not running my current patches.
> > 
> > The vmalloc space is enlarged by the current patch set and should
> > no longer run into this issue, and it's specifically what I was
> > interested in seeing work or not.
> 
> Ignore me, I see you were just trying to explain how memory is layed
> out on this T5 machines and why (which I understood already :-)
Ah no problem, I feared being called away and the potential remains today.
