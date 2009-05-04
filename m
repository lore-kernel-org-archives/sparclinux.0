From: Brian Thompson <brian@eng.wayne.edu>
Date: Mon, 04 May 2009 19:26:56 +0000
Subject: sparc/debian/linux procedures
Message-Id: <49FF4180.9000407@eng.wayne.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


All,

First I have to say this email isn't targeted at any specific people by
name but rather to all of those who are interested in seeing further
linux sparc development (and especially Debian sparc development).

I've been trying to follow the current debate regarding niagara testing/
bug fixes and I have to admit that the bureaucracy is a bit intimidating
at best.

I've recently (over the past year or so) started focusing on Debian now
that Canonical no longer officially supports sparc on Ubuntu, figuring that
although most of our hardware here is older hardware, moving towards
Debian directly will at least give the OS a chance at remaining up to
date.

It's my understanding that there are a team of people who are focused
on the sparc kernel itself (which is used by Debian as well as some of
the other distributions - Aurora, etc).

It's also my understanding that there are a team of people who are
focused on making sure that the sparc port of Debian works properly
as a complete Debian OS distribution for sparc.

In addition, I understand that there's also a team of people who are
focused on making sure that the Debian distribution as whole
(non-arch specific) functions properly and that changes on one port
don't end up inadvertently causing problems for other Debian ports.

Likewise I understand that there's a team of people who are focused
on making sure that the linux kernel as a whole functions properly and
that changes specific to one arch don't end up inadvertently causing
problems for other linux kernel archs.

My question is - when I find things that worked in Ubuntu sparc
but not on Debian, what is the proper procedure for resolving the
issue? Is there a checklist or flowchart anywhere public that should
be followed when issues are found?

I'm guessing the first step is probably to determine whether it's a
kernel issue or an issue external to the kernel so that a bug report can
be filed with the correct team (while also checking to see if the issue
has already been reported), but again that's just a guess.

And, I'm by no means asking for professional assistance or intending to
criticize anyone's prior efforts. I really would like to understand the big
picture though so that I know all of the steps starting with discovering a
new issue to the issue being resolved in the next Debian release. That
way I can follow through and assist where I can while at the same time
not stepping on anyones toes.

Any guidance would be greatly appreciated.

Thanks,
Brian

