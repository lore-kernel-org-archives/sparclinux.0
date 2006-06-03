From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 03 Jun 2006 19:01:24 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap()
Message-Id: <Pine.LNX.4.63.0606031159160.4066@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 2 Jun 2006, David Miller wrote:

> Great, please watch for any dpkg database file corruption.  That's the
> reason all of this started :)

I've finally got to reinstalling my machine and re-run the same 
upgrade/install which triggered the bug last time. With patched up kernel 
everything worked fine. Thanks a lot for taking care of it so fast, Dave.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
