From: "David S. Miller" <davem@davemloft.net>
Date: Sat, 15 Apr 2006 02:56:36 +0000
Subject: Re: More on the Sun Disk Label Issue
Message-Id: <20060414.195636.100023372.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <443AE0BA.8070706@jg555.com>
In-Reply-To: <443AE0BA.8070706@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 14 Apr 2006 19:44:44 -0700 (PDT)

> From: Jim Gifford <maillist@jg555.com>
> Date: Fri, 14 Apr 2006 17:47:47 -0700
> 
> > http://www.linuxfromscratch.org/patches/downloads/util-linux/util-linux-2.12r-gcc41_sun_disklabel_fixes-1.patch
> 
> Looks like you're simply working around a bug in the compiler.
> That code has been in the kernel and util-linux for 10+ years.
> 
> Submit a bug report for gcc and get that bug fixed instead of papering
> around the problem.

When I see stuff like this, I literally want to cry....

I seriously question the correctness of your change:

-	for (csum = 0; ush >= (unsigned short *)sunlabel;) csum ^= *ush--;
+	while (ush < (unsigned short *)sunlabel) csum ^= *ush--;

That's can't be correct, we're _DECREMENTING_ the pointer from the top
of the structure (minus one "unsigned short") _DOWN_ to the base at
"sunlabel", yet you've changed the pointer test into "less-than".  "ush"
will _NEVER_ be less-than sunlabel, so the loop will exit immediately
and we won't compute a checksum at all.

If anything it should be:

+	while (ush >= (unsigned short *)sunlabel) csum ^= *ush--;

Look at how we initialize "ush":

 	ush = ((unsigned short *) (sunlabel + 1)) - 1;

That's "sunlabel + sizeof(struct sunlabel)" minus "sizeof(unsigned
short)" and then we march down from the top computing the checksum one
unsigned short at a time.

But even my "correct version" is wrong fundamentally because the code
is correct as-is so you're likely triggering some gcc bug that needs
to be investigated and fixed.

You really need to properly figure out what the bug is in gcc's loop
optimizer that the existing code is triggering, instead of papering
around it with incorrect patches to the source.

Patching this correct code is not the way to fix this problem.
Why do people do stuff like this without thinking? :-/
