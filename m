From: David Miller <davem@davemloft.net>
Date: Sat, 22 Oct 2016 01:07:26 +0000
Subject: Re: Regression with 4.7.2 on sun4u
Message-Id: <20161021.210726.821281083772601370.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
In-Reply-To: <3fc12066-505b-5f87-cbbe-88593a736162@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: James Clarke <jrtc27@jrtc27.com>
Date: Fri, 21 Oct 2016 22:52:45 +0100

> This indeed was the case. The attached patch fixes the problem for me,
> generating 0x106ffff2, which gdb can verify is sensible (of course, the
> addresses have shifted slightly):

Please don't use attachments for patch submissions.

Patches must be inline so that they can be commented upon properly
using simply email quoting mechanisms.

Thank you.
