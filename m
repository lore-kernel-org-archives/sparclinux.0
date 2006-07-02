From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 02 Jul 2006 19:13:50 +0000
Subject: Re: Oops in tcp_sendmsg on T1000
Message-Id: <Pine.LNX.4.63.0607021208120.2810@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <200607011421.56811.rene@exactcode.de>
In-Reply-To: <200607011421.56811.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2 Jul 2006, David Miller wrote:

> 2.6.17.x should be extremely stable and there is nothing
> in the current tree that ought to fix this.
>
> Please retry with gcc-4.0.x, I really want to eliminate
> gcc-4.1.x because that compiler has caused problems for
> other folks.  In fact I'm almost hoping it's a gcc-4.1.x
> problem so we can investigate it using this test case and
> fix it :)

FWIW, I have experienced exactly the opposite while preparing the 2.6.17 
for Debian: the SMP kernel built with gcc-4.0 was hanging randomly 
during boot, but works fine when built with gcc-4.1.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
