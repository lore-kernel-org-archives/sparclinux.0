From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Date: Tue, 05 Jun 2007 14:54:35 +0000
Subject: Re: [2/2] 2.6.22-rc4: known regressions with patches
Message-Id: <4665792B.8030005@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46657866.7000108@googlemail.com>
In-Reply-To: <46657866.7000108@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@atrey.karlin.mff.cuni.cz, Greg KH <greg@kroah.com>, "Mike Miller (OS Dev)" <mikem@beardog.cca.cpqcorp.net>, Tom Long Nguyen <tom.l.nguyen@intel.com>, linux-ide@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>, Alan Cox <alan@redhat.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, "Horst H. von Brand" <vonbrand@inf.utfsm.cl>

Hi all,

Here is a list of some known regressions in 2.6.22-rc4
with patches available.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions



PCI

Subject    : Oops on 2.6.22-rc2 when unloading the cciss driver
References : http://lkml.org/lkml/2007/5/24/172
Submitter  : Mike Miller (OS Dev) <mikem@beardog.cca.cpqcorp.net>
Patch      : http://lkml.org/lkml/2007/5/31/387
Status     : patch available



SATA/PATA

Subject    : libata reset-seq merge broke sata_sil on sh
References : http://lkml.org/lkml/2007/5/10/63
Submitter  : Paul Mundt <lethal@linux-sh.org>
Handled-By : Tejun Heo <htejun@gmail.com>
Caused-By  : commit 4750def52cb2c21732dda9aa1d43a07db37b0186
Patch      : http://lkml.org/lkml/2007/5/19/161
Status     : patch available



Sparc64

Subject    : arch/sparc64/time.c doesn't compile on Ultra 1 (no PCI)
References : http://bugzilla.kernel.org/show_bug.cgi?id=8540
Submitter  : Horst H. von Brand <vonbrand@inf.utfsm.cl>
Status     : patch available



Regards,
Michal

--
"Najbardziej brakowa=B3o mi twojego milczenia."
-- Andrzej Sapkowski "Co=B6 wi=EAcej"
