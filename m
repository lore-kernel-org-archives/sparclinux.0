From: David Miller <davem@davemloft.net>
Date: Wed, 10 Feb 2010 20:12:17 +0000
Subject: Re: [PATCH] sparc: Align clone and signal stacks to 16 bytes.
Message-Id: <20100210.121217.83298044.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100209.165006.142022647.davem@davemloft.net>
In-Reply-To: <20100209.165006.142022647.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Wed, 10 Feb 2010 13:59:00 -0600

> http://sources.redhat.com/bugzilla/show_bug.cgi?id855

As the patch in this bug does, it should be fixed in glibc.

GCC had the same exact issues when creating precompiled headers in
c++.

> http://sources.redhat.com/bugzilla/show_bug.cgi?id283

Hey, Ulrich Drepper unreasonably flames someone for trying to fix a
bug, I've never seen that before! :-)

His comment about "all of userland expects page-size alignment to be
sufficient" is completely wrong, you only need look at the precompiled
header support code in GCC to see but one example.

Simple sys_errlist versioning build fixes for Sparc from mid-January
still have not been applied, and I supposed STT_GNU_IFUNC support for
sparc last week to the glibc lists and that hasn't gotten looked at
either.

So the lack of any real looking into this issue is no surprise.

This is not a kernel bug, shared mappings have stringent, architecture
specific requirement wrt. mmap() area alignment in order to handle
cache aliasing issues properly.

MAP_SHARED mappings are special, you have to be aware of the issues if
you're going to use them.  You can't just map them wherever you like.



