From: Jan Engelhardt <jengelh@computergmbh.de>
Date: Sun, 26 Aug 2007 18:43:06 +0000
Subject: Re: [parisc-linux] errno codes intertwined
Message-Id: <Pine.LNX.4.64.0708262038170.12920@fbirervta.pbzchgretzou.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0708241815540.28540@fbirervta.pbzchgretzou.qr>
 <200708261345.43165.vapier@gentoo.org>
In-Reply-To: <200708261345.43165.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: parisc-linux@lists.parisc-linux.org, sparclinux@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, parisc-linux@parisc-linux.org


On Aug 26 2007 13:45, Mike Frysinger wrote:
>> can I rely on the same errno across Linuxes?
>
>nope
>
>> And should the errno values be fixed up?
>
>i guess that depends on whether you think it's even broken :)
>
>no spec requires any errno symbol have an exact numeric value ... i'm guessing 
>your FUSE is only cross-Linux and you're not planning on dipping into any 
>other OS ?

If the errnos are not the same in the Linux world, it's not even
cross-Linux ;-) - but it's always translated to fixed numbers now anyway.

I have not really thought about putting it in use on other systems yet. I
don't have macosx to test, and Windows generally lacks some fuses. :^)
You are free to spin it if you like, http://freshmeat.net/p/ccgfs/


	Jan
-- 
