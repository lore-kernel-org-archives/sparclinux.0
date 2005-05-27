From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Fri, 27 May 2005 14:53:31 +0000
Subject: Re: Power fail handler
Message-Id: <BAY104-F24BF251A0192039DE12991FF000@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <BAY104-F356724EEBC319B7F41103AFF0F0@phx.gbl>
In-Reply-To: <BAY104-F356724EEBC319B7F41103AFF0F0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>You should print a message when this event occurs, not shut
>the system down, so the administrator can come down to the
>machine room and replace the failing power supply.  The redundant
>power is still working when this event is received, so the
>system should stay up.

Well, printing stuff not very useful in the Qemu case. I thought the driver 
would send SIGPWR to init process or something like APM/ACPI in x86.

How about Sparc laptops, what happens when operating without AC power and 
battery gets almost drained?

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

