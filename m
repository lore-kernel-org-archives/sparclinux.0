From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Tue, 07 Dec 2004 23:36:01 +0000
Subject: Re: strace and restartable syscalls
Message-Id: <1102462561.3704.26.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2004-12-06 at 19:15, David S. Miller wrote:
> On Mon, 06 Dec 2004 15:16:07 +0000
> Richard Mortimer <richm@oldelvet.org.uk> wrote:
> 
> > I have been looking at strace for sparc - a number of things seem broken
> > so I'm scratching the itch and looking at fixing things (will report on
> > findings later).
> 
> You want to start at a minimum with the attached patch.
> It allows working sparc64 builds too.

Thanks. The patch makes things look so much better! I haven't got a
sparc64 build completed yet (not sure if I've got the right includes
installed etc.).

Its going to be a few days before I get to look further but I'll report
back when I do.

Richard

-- 
richm@oldelvet.org.uk

