From: "Art Haas" <ahaas@airmail.net>
Date: Mon, 29 Mar 2004 20:19:01 +0000
Subject: Compiling modules question
Message-Id: <20040329201901.GD30251@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

Here's another question for the list that I've not been able to
answer. When I compile a kernel with modules, the modules all have
problems with undefined symbols like 'udiv', 'urem', etc. As
my machine is a 'v8' machine, my solution to resolving this
problem was to edit the makefile and add '-mcpu=v8' in a couple
of places, and things work fine. But, if I had to run my kernel
on a 'v7' machine, things would fail.

In 'arch/sparc/lib' there are routines that provide the missing
functions, so am I missing some step where this library gets linked
into the building of the module? If not, then these missing
functions must get picked up in libc, correct? My ignorance of how
things work in SparcLinux is showing ...

Thanks in advance for any info you can send my way.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
