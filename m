From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Date: Tue, 03 Jul 2007 16:45:08 +0000
Subject: [1/2] 2.6.22-rc7: known regressions
Message-Id: <468A7D14.1050505@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, David Chinner <dgc@sgi.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, Mark Fortescue <mark@mtfhpc.demon.co.uk>, William Lee Irwin III <wli@holomorphy.com>

Hi all,

Here is a list of some known regressions in 2.6.22-rc7.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Hugh Dickins                           2
Andi Kleen                             1
Andrew Morton                          1
Benjamin Herrenschmidt                 1
Bj=F6rn Steinbrink                       1
Bjorn Helgaas                          1
Jean Delvare                           1
Olaf Hering                            1
Siddha, Suresh B                       1
Trent Piepho                           1
Ville Syrj=E4l=E4                          1



FS

Subject    : 2.6.22-rc4-git5 reiserfs: null ptr deref.
References : http://lkml.org/lkml/2007/6/13/322
Submitter  : Randy Dunlap <randy.dunlap@oracle.com>
Handled-By : Vladimir V. Saveliev <vs@namesys.com>
Status     : problem is being debugged



IDE

Subject    : 2.6.22-rcX: hda: lost interrupt
References : http://lkml.org/lkml/2007/6/29/121
Submitter  : David Chinner <dgc@sgi.com>
Status     : unknown



Sparc64

Subject    : random invalid instruction occourances on sparc32 (sun4c)
References : http://lkml.org/lkml/2007/6/17/111
Submitter  : Mark Fortescue <mark@mtfhpc.demon.co.uk>
Status     : problem is being debugged

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Handled-By : David Miller <davem@davemloft.net>
Status     : problem is being debugged



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
