From: "Art Haas" <ahaas@airmail.net>
Date: Thu, 25 Mar 2004 17:46:45 +0000
Subject: Other GCC-3.5 compilation errors
Message-Id: <20040325174645.GD11895@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

I've got a SparcStation20 running Debian, and I'm in the process of
upgrading it to run using Debian's 'unstable' branch, and I'd also
like to get it running the 2.6 kernel. I've just sent a couple of
patches to the list fixing two small problems in regards to using
the GCC-3.5 compiler and the current BK kernel, and there are
at least three more files needing fixing:

arch/sparc/kernel/signal.c: line 1133: Invalid lvalue in assignment
arch/sparc/kernel/sun4m_smp.c: line 99: Too few arguments in init_idle()
arch/sparc/kernel/sun4d_smp.c: line 103: Too few arguments in init_idle()

The signal.c error looks like something in the get_user() macro
needs tweaking. I haven't looked too much at the init_idle() problem,
though I guess just stuffing in some arguments would help, and even
better solution would be using correct and valid arguments as well. :-)
There could also be a kernel configuration problem that has tripped
me up here as well, as these results are coming from my first kernel
build on Sparc.

A bit of searching on Debian's mailing list suggests that the SMP stuff
doesn't yet work, and my own experience shows that GCC-3.5 compilation
needs some help. I'm guessing that people are sticking with GCC-3.3
for kernel compilation, or is the common suggestion using an older
compiler like gcc-2.95? Any other tips, tricks, or suggestions
regarding compilers that people care to pass along?

Thanks in advance.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
