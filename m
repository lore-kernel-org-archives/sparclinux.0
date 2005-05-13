From: Heitzso <heitzso@bellsouth.net>
Date: Fri, 13 May 2005 13:13:09 +0000
Subject: re working on sparc32 2.6 kernel
Message-Id: <4284A7E5.4000303@bellsouth.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Having offered to help work on sparc32 smp w/ 2.6 kernel
I feel foolish asking the following trivial questions, but ...

I'm trying to get basic UP 2.6 sparc32 functioning.
Took current stable 2.6 from kernel.org (11.8 at the time),
compiled as per gentoo sparc setup instructions (also
cross checking w/ my athlon 2.6 kernel config) and configured
UP and, when it boots, nothing displays when the normal
linux text-on-black-w/-logo would normally appear.
Disks clatter as though we're going through a normal startup,
but nada on the display. I try to ssh into it and cannot
get in (though sshd is functioning fine in 2.4 SMP on that
ss20 box).

So, re-downloaded current 2.6 kernel (now 2.6.11.9, above
notes re 2.6.11.8) and downloaded the full patchset for
2.6.12-rc4 and applied the patchset against 2.6.11.9
source tree.  There were some patch hunk failures, though
none in sparc specific areas.

=> should I have applied the 2.6.12-rc4 patch against
the 2.6.11 source tree and not against 2.6.11.9 ???

Anyway, because no problems in sparc specific areas
(though numerous patches applied) I went ahead and compiled
UP and attempted to boot and hit the same problem as noted
above with (then) current stable 2.6.11.8 -- no linux
boot sequence text being displayed.

I noticed on one of the lists a problem with black-on-black
and a patch to fix that problem, but it was not clear that
the patch should be used on sparc32/ss20 turbogx setup.

=> should I grab that patch and apply it to a (correctly
patched) 2.6.12-rc4 tree?

Just hard for me to begin to debug anything when the basic
boot sequence is invisible.  Though I have to admit I'll have
to learn how to do some of this when working in SMP/ross/sparc32
stuff because I'll probably being dealing with some failure-to-boot
problems.

Any suggestions would be appreciated.  I'll also be glad to email
anyone my .config if it is likely I'm missing one of those odd
basic FB/Console setup parameters (though was on the lookout).


Thanks,
Heitzso
