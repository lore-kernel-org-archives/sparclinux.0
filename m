From: Frans van Berckel <fberckel@xs4all.nl>
Date: Tue, 07 Dec 2010 11:14:38 +0000
Subject: Re: [PATCH 0/9] Fix PROM call regression.
Message-Id: <1291720478.1567.35.camel@deblnxsrv222>
List-Id: <sparclinux.vger.kernel.org>
References: <20101203.104041.116387856.davem@davemloft.net>
In-Reply-To: <20101203.104041.116387856.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi David,

Thanks for debugging. I wanna compile a new sparc kernel but in witch
git tree did you or are you gonna commit the PROM patches?

Thanks,


Frans van Berckel

The commit to fix huge PROM device node property fetching
25edd6946a1d74e5e77813c2324a0908c68bcf9e ("sparc64: Get rid of
indirect p1275 PROM call buffer.") added a regresion for console
I/O via the PROM.

The issue is that the firmware is not %100 64-bit clean for buffer
addresses, and the code to do firmware console output/input uses an
on-stack buffer which can be above 4GB.

We can't just use a static variable to solve this issue otherwise two
threads can race and corrupt the static variable by trying to use it
at the same time.

