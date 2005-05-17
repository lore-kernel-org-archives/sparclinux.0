From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 17 May 2005 06:35:01 +0000
Subject: Re: sparc32 2.6 work
Message-Id: <Pine.LNX.4.61.0505170233140.7777@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <4285EE7A.7090200@bellsouth.net>
In-Reply-To: <4285EE7A.7090200@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 16 May 2005, Bob Breuer wrote:
>
> Reverting that change should not be needed for 2.6.11 (but it did cause other 
> problems with 2.6.10).  Mounting an initrd under 2.6.11 works for me on my 
> hypersparc ss20.  I think there was a memcpy fix for the initrd failures. 
> Anyway, if there is still a problem that requires the change, I'm willing to 
> help track it down.
>
> Bob

Hi Bob,

I have now tried building Debian's 2.6.11 kernel with and without this 
change applied, however in both cases it fails to mount the initrd. I'll 
build the vanilla kernel without any extra patches tomorrow and check how 
it will behave.

Thanks and best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
