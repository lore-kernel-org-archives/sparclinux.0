From: Roland Stigge <stigge@antcom.de>
Date: Tue, 31 Oct 2006 09:55:42 +0000
Subject: Re: Another 2.6.18 regression? (SunBlade1000)
Message-Id: <45471D9E.8040409@antcom.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20061024031642.GA4403@droopy.oc.cox.net>
In-Reply-To: <20061024031642.GA4403@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
>>>> After removing the floppy driver, the result looks a bit different: The
>>>> bootup proceeds a bit further, but the error message is similar.
>>>>
>>>> See http://people.debian.org/~stigge/sun4u-nofd.jpg
>>> What does 0x4268e8 match up to in your System.map?
>> Looks like tomatillo_wsync_handler:
> 
> That explains the bug clearly.
> 
> Please try this patch, thanks a lot!
> [...]

Yes, that works! Thanks very much! :-)

Roland
