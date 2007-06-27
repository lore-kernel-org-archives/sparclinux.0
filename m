From: David Miller <davem@davemloft.net>
Date: Wed, 27 Jun 2007 23:51:44 +0000
Subject: Linux support for Sun LDOMs
Message-Id: <20070627.165144.55834213.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Over the past few weeks I've coded up preliminary support
for Linux to boot as a guest under Sun Logical Domains on
Niagara systems.  Details at my blog:

	http://vger.kernel.org/~davem/cgi-bin/blog.cgi/index.html

There are test install images, and links to my GIT tree with all
the current kernel changes.

It's a big rough, but the basic functionality is there, and it works
well enough that people actually do an install and tinker with it.
Don't use it for anything mission critical just yet, but we'll knock
out the worst of the bugs and issues eventually.

The folks at Sun were real helpful, and I'd like to thank them for all
of their terrific help with bringing this stuff up.

I'm glad I could finally announce this so that people know why
I've been more quiet than usual over the past 3 weeks :-)

