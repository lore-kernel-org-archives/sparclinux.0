From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 20:02:30 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <20090106.120230.105229393.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.DEB.1.10.0901061342570.10871@gandalf.stny.rr.com>
	<20090106.110114.103656110.davem@davemloft.net>
	<20090106195206.GA16880@uranus.ravnborg.org>
In-Reply-To: <20090106195206.GA16880@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, srostedt@redhat.com, mingo@elte.hu, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 6 Jan 2009 20:52:06 +0100

> The patch to unaligned_64.c is just an ugly hack.
> The patch in viohs.c makes it easier to read IMO.
> The patch to init_64.c is likewise a nice cleanup.
> 
> I will re-review and submit the latter two as proper patches.
> I see no way to refactor unaligned_64.c so it keep
> current behaviour and is equal readable.

Ok.
