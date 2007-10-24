From: Josip Rodin <joy@entuzijast.net>
Date: Wed, 24 Oct 2007 22:33:32 +0000
Subject: unkillable dpkg-query processes
Message-Id: <20071024223332.GA24557@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

(I forgot to send this before...)

We've been having grave issues with a few of our sparc build daemon machines
in Debian. Something causes dpkg-query(8) processes, otherwise harmless, to
run amok and allocate too much memory, but keep running and become resilient
to killing. They eventually push the machine to the point where you can only
ping it, but all the userland and the console is dead.

I'm the admin of one of those machines, lebrun.debian.org, and all the
details I noticed so far are at http://bugs.debian.org/433187

I'm certainly no expert on the kernel, but I'd be happy to help by providing
debug information about the issue. Any suggestions will be most welcome,
because at this point that machine lives a sorry life of
reboot->buildd runs for a few hours->machine goes dead->reboot...

-- 
     2. That which causes joy or happiness.
