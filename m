From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 19 Jun 2006 03:43:02 +0000
Subject: Re: [SILO PATCH]: Fix CDROM booting on sparc64
Message-Id: <Pine.LNX.4.63.0606182036340.3866@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <20060618.190752.125899833.davem@davemloft.net>
In-Reply-To: <20060618.190752.125899833.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 18 Jun 2006, David Miller wrote:

>
> This is a fix (finally!) for the infamous CDROM boot failures a lot of
> folks reported.  A good log of the situation exists in Debian bug
> #261824
>
> It's seen mostly on SunBlade1000, V280R, and V240 systems.  But other
> kinds of boxes can see it too.
>
> SILO crashes trying to open the CDROM device, it dies deep in the OBP
> code for openning the device.  You can see this clearly with "ftrace"
> at the "ok" prompt which gives a forth backtrace any time an error
> occurs during OBP execution.

Great news, Dave! Thank you so much for looking into it.

Unfortunately, I don't have any hardware which exhibits this problem. I've 
prepared a tiny Debian installer iso image, which includes the patched 
silo, so that people can test it easily (just burn it to a CD and give it 
a spin). It is available as

http://www.wooyd.org/debian/silo/sparc-mini.iso

This directory also contains an updated Debian silo package.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC

P.S. In case someone will decide to use this iso to actually install 
Debian, note that you need to pass the parameter ramdisk_size 000 to the 
installer, as the default ramdisk size appears to be insufficient.
