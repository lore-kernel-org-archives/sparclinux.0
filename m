From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 21 Feb 2012 22:51:08 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120221225108.GA4293@wooyd.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Feb 21, 2012 at 02:36:40PM -0500, David Miller wrote:
> From: Meelis Roos <mroos@linux.ee>
> Date: Tue, 21 Feb 2012 15:43:07 +0200 (EET)
> 
> > Short summary: silo can not find any files from my ext3. Was this 
> > the problem recently discussed here about silo?
> > 
> > Debian unstable's silo 1.4.14+git20120127-1 and 110G ext3 filesystem. 
> > The same machine worked fine for years, running all the kernels and 
> > Debian unstable. Last successful reboot was less than a week ago, and 
> > Debian was updated after that (probably updating silo package).
> > Today I compiled 3.3-rc4+git and rebooted to try it, and silo can not 
> > find anything. silo itself loads but can not open neither /etc/silo.conf 
> > nor any kernel image by direct name:
> 
> I really wish they hadn't pushed this new SILO into debian without a
> couple months more testing of the new ext{2,3,4} code I wrote.

That would be my handywork :-).

> I knew there would be regressions like this and it's not ready at all
> for mass consumption.

To clarify, the new SILO has only appeared in Debian testing (wheezy) 
and unstable (sid) distributions and not in the released version 
(squeeze), to which it will never propagate. I've announced new SILO 
availability for early testing a few days before uploading it to 
unstable [0] and then it spent the usual 10 days in unstable before 
propagating to testing [1] (any bug reported against the new version 
during that time would have blocked this propagation). 

If needed, the version can be rolled back pretty easily in 
testing/unstable (will take just a couple of days), but that will 
minimize the chances of the new version getting any mileage. Given 
that the next Debian release is something like 6 months to a year away 
and the fixes will be forthcoming sooner than that :-), I don't really 
see a reason to do such a rollback, especially considering that vast 
majority of the Debian sparc users, who followed the default 
installation procedure, will not be affected by it. Default install 
still creates a small ext2 partition at the beginning of the disk for 
kernels and initrds (legacy of the sparc32 days, when kernel would 
refuse to boot if it was further than 1GB away from the beginning of 
the disk, or something like that). That was the reason why I did not 
get any problem reports and have not seen any problems on my machine. 

Meelis, sorry for the trouble. You can restore your machine's ability 
to boot by installing the stable SILO version [2]. Please let me know 
off-list if you would like more detailed recovery instructions.

[0] http://lists.debian.org/debian-sparc/2012/01/msg00038.html
[1] http://packages.qa.debian.org/s/silo.html
[2] http://ftp.ie.debian.org/debian/pool/main/s/silo/silo_1.4.14+git20100228-1+b1_sparc.deb

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
