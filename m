From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 19:01:14 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <20090106.110114.103656110.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.DEB.1.10.0901051458460.25066@gandalf.stny.rr.com>
	<20090106.103234.163615537.davem@davemloft.net>
	<alpine.DEB.1.10.0901061342570.10871@gandalf.stny.rr.com>
In-Reply-To: <alpine.DEB.1.10.0901061342570.10871@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rostedt@goodmis.org
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org, srostedt@redhat.com, mingo@elte.hu, sparclinux@vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 6 Jan 2009 13:52:36 -0500 (EST)

> I would hate to black list archs just because it gives warnings.

At the very least arch/sparc should build cleanly now because
I took your ldc.c change
