From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Thu, 02 Aug 2007 12:26:59 +0000
Subject: Re: Build failures on a sparcstation10 with 2.6.23-rc1
Message-Id: <Pine.LNX.4.61.0708021323040.18689@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
In-Reply-To: <646765f40707272039u27113c20ie98cbd42b9742c0f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

Build OK, Module Load OK first time around.
Module unload silently fails to release the IRQ so a module reload 
fails because the IRQ is not free.
I can probably sort this out over the weekend if you don't already have 
appropriate changes in hand.

Regards
 	Mark Fortescue.


