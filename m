From: David Miller <davem@davemloft.net>
Date: Tue, 07 Oct 2014 19:03:12 +0000
Subject: Re: [PATCH] sparc64: use COMMAND_LINE_SIZE for boot string
Message-Id: <20141007.150312.77590309182088365.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <5432BE03.10405@oracle.com>
In-Reply-To: <5432BE03.10405@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Tue, 07 Oct 2014 13:49:37 -0500

> I never realized that, but that's really not a problem since the
> destination will have the space. The original patch shouldn't be
> problematic, although it may make the string longer than it practically
> needs to be. I'll let davem make the call which version he likes better.
> Maybe the comment in the second patch can be improved.

If you make the boot string 2048 bytes, and the firmware provides
a string longer than 1024 bytes to SILO, it will read past the end
of barg_buf.

So I think we still need to limit it to 1024.

In the long term, we can 'fix' SILO in some backwards compatible way.
I think the thing to do is keep putting 1024 into bootstr_len and then
bump the HdrS version (currently 0x0301) and make that new version
mean "ignore bootstr_len, command line buffer is 2048 bytes".
