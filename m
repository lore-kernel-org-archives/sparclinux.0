From: David Miller <davem@davemloft.net>
Date: Tue, 15 May 2012 19:52:43 +0000
Subject: Re: [RFC PATCH 3/3] sparc: introduce arch/sparc/Kbuild
Message-Id: <20120515.155243.1334861875661910601.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515193651.GC17309@merkur.ravnborg.org>
In-Reply-To: <20120515193651.GC17309@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 21:36:51 +0200

>>From 850652644b60709d7eae7d421fa6e18630f2bac8 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 15 May 2012 21:27:15 +0200
> Subject: [PATCH 3/3] sparc: introduce arch/sparc/Kbuild
> 
> This allows us to do:
> 
>     make arch/sparc/
> 
> to build the core part of the sparc kernel.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> 
> This will conflict with the BFP work you have in netdev,
> but the resolution is trivial.
> The assignment to core-y shall be moved
> to Kbuild and the "arch/sparc/" part dropped.
> 
> RFC due to this known conflict.

I'll most likely apply this, especially since, as you say, the
conflict is trivial to resolve.
