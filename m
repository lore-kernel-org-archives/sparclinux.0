From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 18:39:44 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <20090106.103944.99651976.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <49631BF0.76E4.0078.0@novell.com>
	<20090106113543.GS28946@ZenIV.linux.org.uk>
	<20090106133442.GA14780@uranus.ravnborg.org>
In-Reply-To: <20090106133442.GA14780@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: viro@ZenIV.linux.org.uk, jbeulich@novell.com, mingo@elte.hu, rostedt@goodmis.org, srostedt@redhat.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 6 Jan 2009 14:34:42 +0100

> But I never managed to really understand what the btfixup thing is all
> about and has then been sidetracked by funnier stuff.

It's recording relocations that get fixed up at boot time.

The way it works is that each btfixup emits a reference to a symbol
that will be unresolved.

The btfixup tool under arch/sparc/boot/ scans the unlinked kernel
image, generates dummy symbol definitions into a foo.s file so that
the kernel can be linked, and builds the btfixup tables so the kernel
can patch up these relocations at boot time.
