From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Thu, 06 Oct 2005 21:19:33 +0000
Subject: [PATCH RESEND] Fix p9100 framebuffer in 2.6
Message-Id: <1128633573.6766.1.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-3rGqBJ7wShyCg4GfTm2h"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-3rGqBJ7wShyCg4GfTm2h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

RESEND:

The attached patch fixes the p9100 framebuffer so that text is viewable
(not black on black, like it was before the patch). The linux logo
displays for a very short period of time, then is replaced by a grey
box. This leads me to believe that this framebuffer would have problems
in X, but since there hasn't been a weitek driver for X in several
millennia, this isn't something that I can confirm or deny.

But this patch does get color console working on my SPARCbook 3TX.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
-- 
Tom "spot" Callaway: Red Hat Senior Sales Engineer || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-3rGqBJ7wShyCg4GfTm2h
Content-Disposition: attachment; filename=linux-2.6.11-sparc-p9100fix.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-p9100fix.patch; charset=us-ascii
Content-Transfer-Encoding: 7bit


--=-3rGqBJ7wShyCg4GfTm2h--

