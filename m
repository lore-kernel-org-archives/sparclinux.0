From: "Blue Swirl" <blueswir1@hotmail.com>
Date: Thu, 26 May 2005 16:20:36 +0000
Subject: Power fail handler
Message-Id: <BAY104-F356724EEBC319B7F41103AFF0F0@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I implemented to Qemu a part of Slavio chip which sends a level 15 interrupt 
when the power is failing. After that I was surprised to find out that Linux 
doesn't handle that at all.

It shouldn't be very difficult to add a driver to Linux, but would it be 
useful? In Qemu, user could send the power fail event to conveniently signal 
shutdown. Do you know if some real-life power supply generates the signal? 
Or are drivers for Qemu-only stuff OK?

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

