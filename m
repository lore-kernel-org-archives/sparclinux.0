From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Fri, 27 Apr 2007 20:18:45 +0000
Subject: Re: Dropping sparc32 for lenny
Message-Id: <Pine.LNX.4.61.0704272211260.506@yvahk01.tjqt.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <462E1F8E.3070406@systella.fr>
In-Reply-To: <462E1F8E.3070406@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Apr 27 2007 19:15, Michelle Konzack wrote:
>
>Tried to run OpenOffice on a sparc32 with maximum of 512 MByte of memory?
>[...]
>I was not saying to DROP sparc32, but exclude some heavy applications
>which make definitivly no sens on such Computers...
>[...]
>So, I think, some $ARCH should loss weight.

If you already ask that way, I suppose the answer would be "you
should not". These applications should be fixed. Something _ought_ to
be wrong (no advertising intended although I can't help it if it
does) if Softmaker Office, directly after start with a blank new
document, uses less than 10 MB of RSS (i386) when OpenOffice is
already at no less than 80 (and if it's just a ton of shared
libraries). I think some $PROGs should lose weight first, then
perhaps they do not even need to be dropped.

And now note that I do not have a sparc32, so I can't quite compare,
but I know what pain sparc32 owners are in, because they usually got
less memory than most 'small' (understatement for 'a lot of weight')
sparc64 servers (thinking of E250).

I guess that was a bit offtopic now.


Jan
-- 
