From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 21:13:17 +0000
Subject: Re: Export reg.h to userspace
Message-Id: <20090103.131317.139628336.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090103123341.GB18259@uranus.ravnborg.org>
In-Reply-To: <20090103123341.GB18259@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 3 Jan 2009 13:33:41 +0100

> I did not check glibc/gdb if they use ths file - I did
> not feel brave enough to dive into these as it is new
> territory for me.

GDB used to, a long long time ago, but that didn't turn
out to be tenable so gdb does things by hand these days
to get the ptrace layouts it wants to grok.

There might be some stray userland references still, I'll
try to do some research on this.
