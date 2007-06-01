From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Date: Fri, 01 Jun 2007 12:20:55 +0000
Subject: Re: [2/3] 2.6.22-rc3: known regressions v2
Message-Id: <46600F27.1090202@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <465FED20.3090206@googlemail.com>
In-Reply-To: <465FED20.3090206@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pcmcia@lists.infradead.org, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Gregor Jasny <gjasny@googlemail.com>, linux-scsi@vger.kernel.org, James Bottomley <James.Bottomley@SteelEye.com>, Mark Salyzyn <aacraid@adaptec.com>, Yinghai Lu <yhlu.kernel@gmail.com>, Vivek Goyal <vgoyal@in.ibm.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>

Hi all,

Here is a list of some known regressions in 2.6.22-rc3.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



PCMCIA

Subject    : libata and legacy ide pcmcia failure
References : http://lkml.org/lkml/2007/5/17/305
Submitter  : Robert de Rooy <robert.de.rooy@gmail.com>
Status     : Unknown



SATA/PATA

Subject    : 22-rc3 broke the CDROM in Dell notebook
References : http://lkml.org/lkml/2007/5/27/63
Submitter  : Gregor Jasny <gjasny@googlemail.com>
Handled-By : Tejun Heo <htejun@gmail.com>
             Jeff Garzik <jeff@garzik.org>
Caused-By  : Tejun Heo <htejun@gmail.com>
             commit d4b2bab4f26345ea1803feb23ea92fbe3f6b77bc
Status     : problem is being debugged



SCSI

Subject    : aacraid: adapter kernel panic'd fffffffd (kexec)
References : http://lkml.org/lkml/2007/5/29/491
Submitter  : Yinghai Lu <yhlu.kernel@gmail.com>
Handled-By : Salyzyn, Mark <mark_salyzyn@adaptec.com>
             Vivek Goyal <vgoyal@in.ibm.com>
Status     : problem is being debugged



Sparc64

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Handled-By : David Miller <davem@davemloft.net>
Status     : problem is being debugged



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"


