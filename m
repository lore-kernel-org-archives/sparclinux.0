From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 05 Feb 2005 05:41:42 +0000
Subject: Re: fix cg14 with serial console
Message-Id: <20050204214142.0822dbda.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <41FF079C.7070007@mc.net>
In-Reply-To: <41FF079C.7070007@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 04 Feb 2005 22:04:38 -0600
Bob Breuer <breuerr@mc.net> wrote:

> I suppose the idea of creating stubs for the missing prom
> functions on sparc64 has already been considered and rejected.

Actually, this sounds like a nice cleanup idea.  It just hasn't
been done.

> Anyway, for this bug with the cg14, the return value of
> prom_getproperty() was not checked.  A quick check of 2.6.10 shows
> that the return value of prom_getproperty() is not used in 25 out
> of 111 cases for sparc32.  Would it make sense to mark this
> function with __must_check?  I suppose the cleanups would be too
> much effort for too little gain.

That would be a great idea.  In particular, things like
tree.c:prom_nodematch() should check (and return "0" when
error occurs).

> And for good measure, I have appended a revised patch.

Thanks Bob, I'll integrate.
