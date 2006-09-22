From: David Miller <davem@davemloft.net>
Date: Fri, 22 Sep 2006 06:30:19 +0000
Subject: Re: AW: Patch 2.4 kernel / allow to read more than 2048 (1821)
Message-Id: <20060921.233019.10304194.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com>
In-Reply-To: <DA6197CAE190A847B662079EF7631C06015692C9@OEKAW2EXVS03.hbi.ad.harman.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Jurzitza, Dieter" <DJurzitza@harmanbecker.com>
Date: Fri, 22 Sep 2006 07:26:41 +0200

> Given this, wouldn't it be sufficient (for safety reasons) to
> include a dummy call to kmalloc and return with an error if a non
> privileged user does the call?

That wouldn't help.

You seem to be very interested in a fix for this problem,
so why don't you work on the one I suggested?  I really
don't have time to help on this any longer as I have more
pressing issues to deal with over the next few weeks but
I'll happily review whatever you write.
