From: Chris Torek <chris.torek@windriver.com>
Date: Fri, 19 Dec 2008 03:11:26 +0000
Subject: Re: replace incorrect memcpy_user_stub code
Message-Id: <200812190311.mBJ3BQn13860@elf.torek.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200812190208.mBJ28vn13713@elf.torek.net>
In-Reply-To: <200812190208.mBJ28vn13713@elf.torek.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>This is going to perform really bad ...

Yes, I went for space on the theory that it was not common...

>and it's common for
>syscalls invoked by the kernel to trigger this case.

... but so much for that theory. :-)

>I'll have to think about this, thanks for pointing out the
>issue.

The other obvious thing is to have a bunch of userlike memcpy
variants, one for each *memcpy.S file.  The macros you have
should make this straightforward.  I was mostly worried about
breaking stuff.

Chris
