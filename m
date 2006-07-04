From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 04 Jul 2006 02:21:53 +0000
Subject: Re: Oops in tcp_sendmsg on T1000
Message-Id: <Pine.LNX.4.63.0607031921450.3317@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <200607011421.56811.rene@exactcode.de>
In-Reply-To: <200607011421.56811.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 3 Jul 2006, David Miller wrote:

> From: Ben Collins <bcollins@ubuntu.com>
> Date: Mon, 03 Jul 2006 12:16:15 -0400
>
>> Was this an SMP machine/kernel? If so, it sounds like the scheduler
>> tuning bug, fixed in the latest kernel (maybe dave knows git sha).
>
> It is on a T1000, SMP is a given :)

I have to apologize for not making it sufficiently clear (and for not 
starting a different thread, for that matter), but I was talking about my 
experiences with a 2-CPU Ultra60. So, the accurate statement is: a 2.6.17 
kernel built with gcc-4.0 failed to boot on it, while gcc-4.1 worked fine.

Once again, sorry for confusion.

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
