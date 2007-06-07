From: Frank Lichtenheld <frank@lichtenheld.de>
Date: Thu, 07 Jun 2007 19:53:07 +0000
Subject: Unkillable dpkg-query processes on Debian
Message-Id: <20070607195306.GB31707@planck.djpig.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

I'm seeing the same problem (unkillable dpkg-query processes
appearing during building Debian packages) here on two U10. Both
run sparc64-smp kernels. The error occoured both with the 2.6.18
kernel from Debian etch and 2.6.21 from Debian unstable. All
builds happened in a Debian unstable chroot.

As said, an strace attached to the process once it is out of control
(indicated by the high VIRT size) shows nothing. I tried to use
a wrapper script for dpkg-query which runs it under strace. The error
still occoured but *after* the real dpkg-query already completed.
The process getting out of control was the wrapper in this case.

I've never seen the problem with anything else than dpkg-query.

I've never seen the problem when running dpkg-query interactively,
and it does happen very infrequently and with no ovious pattern.
But I've never needed more than a few hours to hit it.

I would happily provide more information if someone has an idea
what would be useful and how to retrieve it.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
