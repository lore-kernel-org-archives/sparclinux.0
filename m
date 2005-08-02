From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 02 Aug 2005 23:06:34 +0000
Subject: strange issues with JFS on sparc64
Message-Id: <a728f9f90508021606e3cf975@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Dave Kleikamp <shaggy@austin.ibm.com>, ag@m-cam.com

I have a 7 TB JFS volume on a sparc64 box (sun enterprise 220R)
running 2.6.12.2 on debian sparc.   When copying large numbers of
files, files start to dissappear, but they are not actually gone they
just stop showing up.  when you delete enough files from the
directory, all of a sudden all of the remaining files show up.  If I
try and run an fsck on the volume I get a bus error.  It seems to be
an issue with JFS on sparc64 as I have the same setup on AMD64 with no
problems.  I talked to some of the IBM engineers and it seems like it
may be an alignment problem on SPARC64.  I was hoping someone with
more experience with SPARC hardware may have some input that could
help us solve the problem.
The full thread is here:
http://sourceforge.net/mailarchive/forum.php?thread_idx52301&forum_idC911

Any insight is much appreciated.

Thanks,

Alex
