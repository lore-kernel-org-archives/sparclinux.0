From: "C.Newport" <crn@netunix.com>
Date: Wed, 25 Aug 2004 18:34:39 +0000
Subject: Re: future of drivers/fc4/
Message-Id: <200408251934.39486.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <412CB453.2050504@sms-softwaretechnik.de>
In-Reply-To: <412CB453.2050504@sms-softwaretechnik.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wednesday 25 August 2004 4:46 pm, Matthias Schulz wrote:
> Hi,
>
> I saw your posts on vger.kernel.org but it doesn't seem to find a lot of
> reaction there.
>
> I do have a lot of hardware to test this (S1000E, SSA 100, E5000,
> A5000). A while back, I had the 2.2.20 kernel running with my SS1000E
> and the SSA 100 attached. Worked fine. But any version of Linux later
> than 2.2.20 didn't do it.
>
> Could it be, that the mayjor changes from 2.2 -> 2.4 (SMP, scsi etc.)
> are the REAL reason for that ?
>
> I don't think it has to do woth hardware issues other than having the
> right firmwar on either the soc-board (1.33) and the SSA (3.??).
>
> Did you get any further ?
>
> Did you have it running with 2.2.??

I have the soc/pluto combination working here with 2.2.20 on the SS1000E 
but I have not looked at this in a while. The problem is that there were major 
changes to the scsi subsystem in the 2.2 to 2.4 transition and noboby did
any work on the soc or socal stuff. The changes are rather major so 
someone with good kernel skills needs to spend some time updating this.

Does anyone know if the fcal based Ultrasparcs such as the SF1000 are
also affected ?.

