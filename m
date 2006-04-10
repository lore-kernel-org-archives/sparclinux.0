From: Christophe Jacquet <jacquetc@free.fr>
Date: Mon, 10 Apr 2006 15:36:48 +0000
Subject: Re: Parallel port problems on Sun Ultra10
Message-Id: <1144683408.443a7b90eabaa@imp5-g19.free.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <1144596830.4439295e52873@imp1-g19.free.fr>
In-Reply-To: <1144596830.4439295e52873@imp1-g19.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

> I have an Ubuntu distribution running on a Sun Ultra10, with kernel 2.6.15.
> Printing causes the workstation to crash.

I have a few updates on the problem.

1) Here is a rough "stack trace" of the crash:
It happens in the function parport_write()
Called from lp.c, function lp_write(), line 343.

2) Setting CONFIG_PARPORT_1284 to false solves the issue.

Regards,

Christophe Jacquet.
