From: David Miller <davem@davemloft.net>
Date: Tue, 25 Nov 2008 08:53:40 +0000
Subject: Re: sparc unification step 3
Message-Id: <20081125.005340.41241398.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081117220200.GA14667@uranus.ravnborg.org>
In-Reply-To: <20081117220200.GA14667@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 25 Nov 2008 09:36:36 +0100

> I'm planning to redo this patchset the coming weekend so catch
> up with sparc-next.
> I may put a bit more effort into the sparc32 Makefile to clean it
> up a bit before the unification if time permits.
> Until then I would like to know if there is any strong desire
> to keep one kernel/ or should we go for kernel32, kernel64 (+ kernel/) two?
> 
> I like to see the unifications and I see benefits in having
> all related files in the same dir - but I'm suprised that sparc32
> and sparc64 differ that much (textual at least). There seems to
> be much more shared code in the x86 case for example.

Sorry I haven't gotten to that stuff yet.

I'd like to unify as much code as possible.  I think there is
more commonality than is obvious currently, and the stuff that
is different is often because sparc32 has rotted and hasn't
been updated to the ongoing changes in the tree as aggressively
as sparc64 has.

So just put it under a single kernel/
