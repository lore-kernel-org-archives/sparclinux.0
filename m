From: "C.Newport" <crn@netunix.com>
Date: Thu, 01 Jan 2004 02:57:21 +0000
Subject: Re: socal
Message-Id: <200401010257.21123.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200312311429.26841.awirtz@novapointe.com>
In-Reply-To: <200312311429.26841.awirtz@novapointe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thursday 01 January 2004 2:41 am, Pete Zaitcev wrote:
> On Thu, Jan 01, 2004 at 02:06:56AM +0000, C.Newport wrote:
> > The E3500 can boot from fcal, so the required code is in the OBP.
> > You could probably hack up a driver by calling the OBP code.
>
> Anything can boot from the SOCAL card, even sun4d. In fact it's
> exactly the same FCode, and even more - it's exactly the same binary
> image! The build procedure for the Sunfire OBP builds an FCode as
> if it were for the card, then incorporates it into OBP as a binary
> with a little od(1) and ld(1) magic.
>
> Calling OBP driver is probably not a good idea, it's beyond
> slow. It's glacial. Also, its error recovery is not stellar.
> I hardened it a bit when I took over from Ping, but there are
> limits to what you could do to FCode. I advise against it.

Agreed, I was thinking in terms of a temporary driver as an aid
to understanding how to build a production version.


