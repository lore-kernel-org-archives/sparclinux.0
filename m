From: David Miller <davem@davemloft.net>
Date: Wed, 18 Nov 2009 07:13:20 +0000
Subject: Re: Fan tuning on T1000
Message-Id: <20091117.231320.137110607.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.00.0911180030200.19767@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.00.0911180030200.19767@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@medozas.de>
Date: Wed, 18 Nov 2009 00:36:33 +0100 (CET)

> spot advised me trying to ask here; is there some way to tune the speed 
> level of the fans in a T1000 so that they do not run at their full 
> 15000rpm?

The fans and other environmental aspects are controlled completely by
the ALOM based upon temperature and other sensor reading.  And if the
ALOM should die, special circuits kick in which make sure the system
doesn't overheat.

As far as I know you really can't control any of this, unfortunately.

I put my machines in a rack I have in a seperate room fully seperated
by walls from where I do work in my office.  I used to keep my T1000
in the same room where I worked, but that required wearing noise
cancelling headphones all the time :-/
