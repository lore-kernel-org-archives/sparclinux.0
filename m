From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Tue, 16 Sep 2008 10:54:00 +0000
Subject: Re: Allow 8250 to work on sparc.
Message-Id: <20080916115400.31522d77@lxorguk.ukuu.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20080912.211854.102505246.davem@davemloft.net>
	<Pine.LNX.4.61.0809151507250.23201@mtfhpc.demon.co.uk>
	<20080915172211.6751bb17@the-village.bc.nu>
	<Pine.LNX.4.61.0809151934040.23817@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0809151934040.23817@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Cc: David Miller <davem@davemloft.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, joy@entuzijast.net

> I am intrigued. Other than the valid baud rates what differences are 
> visible at the user level?

There are lots of variations between hardware of all kinds but the big
one with USB devices is generally latency.

> Yes, but I have not found a simple way to configure it to add serial port 
> devices to the next available /dev/ttyS<xx>. If this was the default, it 
> would be much easier for me :). (I am assuming that all the different 

That still isn't a kernel problem but a udev one and one for the udev
lists ?

Alan
