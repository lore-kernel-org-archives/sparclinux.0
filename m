From: David Miller <davem@davemloft.net>
Date: Fri, 19 Dec 2008 03:15:16 +0000
Subject: Re: replace incorrect memcpy_user_stub code
Message-Id: <20081218.191516.142019548.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200812190208.mBJ28vn13713@elf.torek.net>
In-Reply-To: <200812190208.mBJ28vn13713@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Chris Torek <chris.torek@windriver.com>
Date: Thu, 18 Dec 2008 20:11:26 -0700

> >This is going to perform really bad ...
> 
> Yes, I went for space on the theory that it was not common...
> 
> >and it's common for
> >syscalls invoked by the kernel to trigger this case.
> 
> ... but so much for that theory. :-)

At least it used to be the case, it may not matter today and
I'll do some investigation.  If it doesn't matter, your patch
is fine and I'll apply it directly.

> >I'll have to think about this, thanks for pointing out the
> >issue.
> 
> The other obvious thing is to have a bunch of userlike memcpy
> variants, one for each *memcpy.S file.  The macros you have
> should make this straightforward.  I was mostly worried about
> breaking stuff.

I'm trending away from that because it's unnecessary bloat.

I wish memcpy() returned void, that would make so many things like
this easy to handle.  I could just add the annotations to the real
memcpy, always return the same return values as the user copies do,
and the memcpy() callers would just ignore the return value.

But things are what they are :-)
