From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Date: Thu, 24 May 2007 14:04:04 +0000
Subject: Re: [2/3] 2.6.22-rc2: known regressions v2
Message-Id: <46559B54.80106@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46558708.2040803@googlemail.com>
In-Reply-To: <46558708.2040803@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Cherwin R. Nooitmeer" <cherwin@gmail.com>, Christoph Lameter <clameter@sgi.com>, linux-pcmcia@lists.infradead.org, Robert de Rooy <robert.de.rooy@gmail.com>, Alan Cox <alan@redhat.com>, Tejun Heo <htejun@gmail.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, linux1394-devel@lists.sourceforge.net, Stefan Richter <stefanr@s5r6.in-berlin.de>, =?UTF-8?B?S3Jpc3RpYW4gSMO4Z3NiZXJn?= <krh@bitplanet.net>, linux-pm@lists.linux-foundation.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>, Marcus Better <marcus@better.se>, Andrey Borzenkov <arvidjaar@mail.ru>, linux-usb-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>

Hi all,

Here is a list of some known regressions in 2.6.22-rc2.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



Memory management

Subject    : kernel BUG at include/linux/slub_def.h:88 kmalloc_index()
References : http://bugzilla.kernel.org/show_bug.cgi?id=8476
Submitter  : Cherwin R. Nooitmeer <cherwin@gmail.com>
Status     : Unknown



PCMCIA

Subject    : libata and legacy ide pcmcia failure
References : http://lkml.org/lkml/2007/5/17/305
Submitter  : Robert de Rooy <robert.de.rooy@gmail.com>
Status     : Unknown



Sparc64

Subject    : 2.6.22-rc broke X on Ultra5
References : http://lkml.org/lkml/2007/5/22/78
Submitter  : Mikael Pettersson <mikpe@it.uu.se>
Status     : Unknown



Suspend

Subject    : STD fails with pci_device_suspend(): usb_hcd_pci_suspend+0x0/0=
x160 [usbcore]() returns -16
References : http://lkml.org/lkml/2007/5/19/66
Submitter  : Andrey Borzenkov <arvidjaar@mail.ru>
Status     : Unknown

Subject    : 2.6.22-rc1 suspend to RAM problem
References : http://permalink.gmane.org/gmane.linux.power-management.genera=
l/5819
Submitter  : Marcus Better <marcus@better.se>
Handled-By : Stefan Richter <stefanr@s5r6.in-berlin.de>
             Kristian H=C3=B8gsberg <krh@bitplanet.net>
Status     : caused by fw-ohci module



Regards,
Michal

--=20
"Najbardziej brakowa=C5=82o mi twojego milczenia."
-- Andrzej Sapkowski "Co=C5=9B wi=C4=99cej"


