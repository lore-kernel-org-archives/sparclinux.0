From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Date: Mon, 30 Jul 2007 16:34:07 +0000
Subject: Re: [3/3] 2.6.23-rc1: known regressions v3
Message-Id: <46AE12FF.3030805@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <46AE0F5D.3000500@googlemail.com>
In-Reply-To: <46AE0F5D.3000500@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-usb-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>, Alan Stern <stern@rowland.harvard.edu>, Oliver Neukum <oliver@neukum.org>, Mark Hindley <mark@hindley.org.uk>, Jeremy Fitzhardinge <jeremy@goop.org>, Adrian Bunk <bunk@stusta.de>, sparclinux@vger.kernel.org, "William L. Irwin" <wli@holomorphy.com>, Mark Fortescue <mark@mtfhpc.demon.co.uk>, Ollie Wild <aaw@google.com>, David Miller <davem@davemloft.net>

Hi all,

Here is a list of some known regressions in 2.6.23-rc1.

Feel free to add new regressions/remove fixed etc.
http://kernelnewbies.org/known_regressions

List of Aces

Name                    Regressions fixed since 21-Jun-2007
Adrian Bunk                            6
Andi Kleen                             4
Andrew Morton                          4
Linus Torvalds                         4
Al Viro                                3
Jens Axboe                             3
Tejun Heo                              3
David Woodhouse                        2
Hugh Dickins                           2



USB

Subject         : 2.6.23-rc1: uhci_hcd. irq 4: nobody cared
References      : http://lkml.org/lkml/2007/7/29/75
Last known good : ?
Submitter       : Mark Hindley <mark@hindley.org.uk>
Caused-By       : ?
Handled-By      : Alan Stern <stern@rowland.harvard.edu>
Status          : unknown



Virtualization

Subject         : drivers/net/xen-netfront.c: bogus code
References      : http://lkml.org/lkml/2007/7/22/256
Last known good : ?
Submitter       : Adrian Bunk <bunk@stusta.de>
Caused-By       : ?
Handled-By      : Jeremy Fitzhardinge <jeremy@goop.org>
Status          : unknown



Sparc32

Subject         : NULL pointer derefference
References      : http://lkml.org/lkml/2007/7/29/224
                  http://lkml.org/lkml/2007/7/29/349
Last known good : ?
Submitter       : Mark Fortescue <mark@mtfhpc.demon.co.uk>
Caused-By       : Ollie Wild <aaw@google.com>
                  commit b6a2fea39318e43fee84fa7b0b90d68bed92d2ba
Handled-By      : ?
Status          : unknown



Regards,
Michal

--
LOG
http://www.stardust.webpages.pl/log/
