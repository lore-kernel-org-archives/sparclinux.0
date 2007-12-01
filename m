From: Bernd Zeimetz <bernd@bzed.de>
Date: Sat, 01 Dec 2007 12:43:30 +0000
Subject: Re: [ANNOUNCE] Aurora SPARC Linux Build 2.99 (Beta 2 for 3.0)
Message-Id: <475156F2.5020205@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <1196454535.3432.18.camel@localhost.localdomain>
In-Reply-To: <1196454535.3432.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>> - Systems that boot off qlogic attached disks are not supported, because 
>> there is no working firmware loader in anaconda, and the qlogic driver 
>> needs firmware.
> 
> That's very unfortunate, how are qlogic device handled on other
> platforms?

In Debian you just install the firmware package, udevl will handle it
then. If you have to boot from it, you need to rebuild your initrd after
installing the firmware package.
The installer doesn't support non-free modules yet unfortunately, but
with some not too complicated tricks you can install Debian without
problems.


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>
