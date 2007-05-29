From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Date: Tue, 29 May 2007 12:56:20 +0000
Subject: Re: [2/4] 2.6.22-rc3: known regressions
Message-Id: <465C22F4.8080505@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <465C188F.9000900@googlemail.com>
In-Reply-To: <465C188F.9000900@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Ruben <nahoo82@terra.es>, Stephen Hemminger <shemminger@osdl.org>, linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>, "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>, tom.l.nguyen@intel.com, linux-pcmcia@lists.infradead.org, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>, Gregor Jasny <gjasny@googlemail.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>

Hi all,

Here is a list of some known regressions in 2.6.22-rc3.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Networking

Subject    : Network card not usable - sky2
References : http://bugzilla.kernel.org/show_bug.cgi?id=8539
Submitter  : Ruben <nahoo82@terra.es>
Status     : Unknown



PCI

Subject    : Oops on 2.6.22-rc2 when unloading the cciss driver
References : http://lkml.org/lkml/2007/5/24/172
Submitter  : Mike Miller (OS Dev) <mikem@beardog.cca.cpqcorp.net>
Status     : Unknown



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



Sparc64

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Status     : Unknown



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"

