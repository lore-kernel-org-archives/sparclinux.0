From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 11 Apr 2006 02:01:08 +0000
Subject: Re: Parallel port problems on Sun Ultra10
Message-Id: <Pine.LNX.4.63.0604101900490.3757@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <1144596830.4439295e52873@imp1-g19.free.fr>
In-Reply-To: <1144596830.4439295e52873@imp1-g19.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 10 Apr 2006, David S. Miller wrote:

> From: Christophe Jacquet <jacquetc@free.fr>
> Date: Mon, 10 Apr 2006 17:36:48 +0200
>
>> I have a few updates on the problem.
>>
>> 1) Here is a rough "stack trace" of the crash:
>> It happens in the function parport_write()
>> Called from lp.c, function lp_write(), line 343.
>>
>> 2) Setting CONFIG_PARPORT_1284 to false solves the issue.
>
> Thanks for tracking this down so far, I'll try to figure out
> what's going wrong.

We have "solved" this problem in Debian by disabling the
CONFIG_PARPORT_PC_FIFO option in kernel. There is some relevant
information in the thread starting at

http://lists.debian.org/debian-sparc/2006/03/msg00026.html

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
