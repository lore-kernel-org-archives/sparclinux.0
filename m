From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Tue, 16 Sep 2008 13:15:43 +0000
Subject: Re: Allow 8250 to work on sparc.
Message-Id: <Pine.LNX.4.61.0809161343450.25955@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20080912.211854.102505246.davem@davemloft.net>
 <Pine.LNX.4.61.0809151507250.23201@mtfhpc.demon.co.uk>
 <20080915172211.6751bb17@the-village.bc.nu> <Pine.LNX.4.61.0809151934040.23817@mtfhpc.demon.co.uk>
 <20080916115400.31522d77@lxorguk.ukuu.org.uk>
In-Reply-To: <20080916115400.31522d77@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, joy@entuzijast.net

Hi Alan,

On Tue, 16 Sep 2008, Alan Cox wrote:

>> I am intrigued. Other than the valid baud rates what differences are
>> visible at the user level?
>
> There are lots of variations between hardware of all kinds but the big
> one with USB devices is generally latency.
>

At the driver level there are lots of varients but I was under the 
impression that at the user level, the interface is common for async 
serial ports.

Latency can be an issue, but can it be read/changed via the user <-> 
kernel interface in a way that is not common to all async serial ports?

If not, it is transparent at the programming interface for user level code 
so the USB serial ports are no different at this level to classic PC AT 
serial ports and as such I see no reason why, in the long run, they should 
not share minor number space.

Taking the argument to its logical conclusion, all devices that have a 
common user <-> kernel interface should have device drivers that are 
capable of sharing minor device number space.

I am sure this discusion will crop up again in the future :).

Regards
 	Mark.
