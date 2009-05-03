From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 03 May 2009 11:41:40 +0000
Subject: Re: debian unusable on niagara
Message-Id: <20090503114140.GA8582@orion.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20090423.070943.158757350.davem@davemloft.net>
In-Reply-To: <20090423.070943.158757350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, May 02, 2009 at 05:06:04PM -0700, David Miller wrote:
> From: Josip Rodin <joy@entuzijast.net>
> Date: Sun, 3 May 2009 00:54:15 +0200
> 
> > So I suggest that we get some simple diffing done between the two
> > pieces of software as a basis for documenting any differences, or
> > making modifications so that they converge.
> 
> If I had just once seen a "Dave, can you test this image out to make
> sure this Niagara bug is fixed?", I would have been happy with any
> result whatsoever.
> 
> But because that did not happen, I'm understandably irked that things
> are broken the way that they are.
> 
> I have tons of machines to test on, and the knowledge to fix just
> about anything, I just have to be asked.

OK, but each distribution lives in a little (or large) ecosystem of their
own, and even in the case of Debian where the system is open for everyone to
enter, the actual act of entering the system is necessary in order for
anyone to participate.

In this case, where you want to be informed when there's new stuff in
Debian's sparc kernel, you might want to subscribe yourself to the
debian-sparc list[1] which is the only Debian sparc port mailing list and
the place where e.g. calls for testing new kernel images are sent to,
and maybe to the linux-2.6 package tracking system[2] where you can read
Debian's Linux kernel package changelogs, which will have references to
any sparc patches.

These are fairly general forums, so you will probably want to filter them
locally and scan the contents for sparc kernel-specific information.
(I guess you have the same problem with LKML already...)

[1] http://lists.debian.org/debian-sparc/
[2] http://packages.qa.debian.org/l/linux-2.6.html

-- 
     2. That which causes joy or happiness.
