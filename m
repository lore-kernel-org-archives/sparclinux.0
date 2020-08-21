From: Al Viro <viro@zeniv.linux.org.uk>
Date: Fri, 21 Aug 2020 00:00:02 +0000
Subject: Re: [sparc32] userland unaligned access
Message-Id: <20200821000002.GI1236603@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200820193612.GG1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200820193612.GG1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Aug 20, 2020 at 04:47:08PM -0700, David Miller wrote:

> > I don't have sunos toolchain to try and build such a binary and test it on
> > a 2.2 kernel, but I would be rather surprised if that had been it.
> > 
> > Anyway, it really looks like that's dead code these days...
> 
> %100 it is dead code.

	Could you check if you are OK with
git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.sparc?
