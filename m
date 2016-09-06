From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 06 Sep 2016 14:47:56 +0000
Subject: Re: sparc: bpf_jit: Rename jump labels in bpf_jit_compile()
Message-Id: <20160906144756.GF2794@worktop>
List-Id: <sparclinux.vger.kernel.org>
References: <20160903.230607.1667562673788737377.davem@davemloft.net>
 <1365a588-c7c7-717c-1e3d-ceabd71e8479@users.sourceforge.net>
 <20160903.235916.1892276070318494855.davem@davemloft.net>
 <deecaab4-011b-b8d5-a3c7-6e34abef60e5@users.sourceforge.net>
 <57CBEFEA.3080007@iogearbox.net>
 <20160905130737.74f63abe@endymion>
 <20160905113704.GA10153@twins.programming.kicks-ass.net>
 <20160905135445.501814a1@endymion>
 <20160905115838.GC10153@twins.programming.kicks-ass.net>
 <20160906163413.470f37d4@endymion>
In-Reply-To: <20160906163413.470f37d4@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Jonathan Corbet <corbet@lwn.net>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Adam Buchbinder <adam.buchbinder@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Rabin Vincent <rabin@rab.in>, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, Paolo Bonzini <pbonzini@redhat.com>, linux-doc@vger.kernel.org

On Tue, Sep 06, 2016 at 04:34:13PM +0200, Jean Delvare wrote:
> > [diff "default"]
> >         xfuncname = "^[[:alpha:]$_].*[^:]$"
> 
> OK, I see. As mentioned somewhere else, it fails for labels which have
> comments. 

Heh, There's labels that have comments?

> My worry is that you recommending it to contributors on a individual
> and opportunity basis, doesn't scale. Basing coding style
> recommendations on a personal quirk doesn't strike me as the best idea
> ever in the long run.

Don't care too much, I simply will not take any patch that adds stupid
spaces :-)

> While looking at the syntax of your example, I have found something
> which looks more promising. git already has predefined xfuncname
> definitions for various languages, including C. These can be enabled
> based on file name patterns via gitattributes. The
> following .gitattribute file placed at the root of the kernel source
> tree achieves what you want:
> 
> *.c   diff=cpp
> *.h   diff=cpp
> 
> The major difference between git config and gitattributes is that the
> latter can be part of the project itself, just like gitignore. So we
> could just push that .gitattribute file upstream, and then labels
> without leading spaces would no longer be a problem, at least within
> git.

Works for me, and last time this came up Linus agreed with the
"whitespace before labels is stupid" thing. Although I cannot find a
link to that just now.

> It would still be a problem for me as an inveterate quilt user,

Add the below to your .quiltrc or environment:

QUILT_DIFF_OPTS="-F ^[[:alpha:]\$_].*[^:]\$"

Same caveat about labels with comments, but then I'd not take a patch
doing that in the first place.
