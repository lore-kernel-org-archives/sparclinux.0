From: "C.Newport" <crn@netunix.com>
Date: Tue, 03 Feb 2004 15:53:43 +0000
Subject: Was:  Problems with bridging on Sparc64
Message-Id: <200402031553.44155.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 03 February 2004 12:37 pm, Small, Jim wrote:
> David,
>
> Please excuse my ignorance, but is there an easy way to build the bridging
> tools/library as 64bit binaries or are you saying that the dependence on
> SIOCDEVPRIVATE makes it extremely difficult without redesigning the
> bridging software?

As a slight aside, do we have any standards in place for the migration
to 64 bit ?. So far we have :-

a) 64 bit kernel should be standard for Ultras by now in all distributions.
b) A small number of applications such as the above NEED to be
    compiled for 32 or 64 bit.
c) Most 32 bit applications are OK on 64 bit kernels and there is no
    advantage in compiling as 64 bit.
d) Some applications would benefit from having a 64 bit version.

With more systems (especially X86) becoming 64 bit capable we
could be heading for a horrid mess with each distribution doing
incompatible things.

My suggestion if no standards exist :-
The installer should put 64 bit apps in /bin64 and make a symlink
from /bin or /sbin only if the machine supports 64 bit.
It is probably a bad idea to have such applications under /usr 
because /usr should be capable of being NFS shared RO by multiple
machines.

What does the team think ?

