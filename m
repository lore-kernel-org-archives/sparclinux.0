From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Mon, 15 Sep 2008 18:51:12 +0000
Subject: Re: Allow 8250 to work on sparc.
Message-Id: <Pine.LNX.4.61.0809151934040.23817@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20080912.211854.102505246.davem@davemloft.net>
 <Pine.LNX.4.61.0809151507250.23201@mtfhpc.demon.co.uk>
 <20080915172211.6751bb17@the-village.bc.nu>
In-Reply-To: <20080915172211.6751bb17@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Miller <davem@davemloft.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, joy@entuzijast.net

Hi Alan,

On Mon, 15 Sep 2008, Alan Cox wrote:

>> At the user level, there is no difference between a sun zilog serial port,
>> an 8250 serial port or a USB serial port so these should be allocated
>> using the same allocation system.
>
> That isn't strictly true.

I am intrigued. Other than the valid baud rates what differences are 
visible at the user level?

>
>> For me, it would also simplify the issue of trying to work what devive to
>> look for when I plug in a new USB serial port device. It would be the new
>> /dev/ttyS<x> to appear in /dev.
>
> Naming is a private matter for udev anyway, independant of numbering for
> major/minor
>

Yes, but I have not found a simple way to configure it to add serial port 
devices to the next available /dev/ttyS<xx>. If this was the default, it 
would be much easier for me :). (I am assuming that all the different 
serial port devices I use are transparent at the user level, hence my 
question above.)

Regards
 	Mark.
