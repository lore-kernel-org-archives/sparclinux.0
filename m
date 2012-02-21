From: David Miller <davem@davemloft.net>
Date: Tue, 21 Feb 2012 19:36:40 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120221.143640.17519868920156239.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 21 Feb 2012 15:43:07 +0200 (EET)

> Short summary: silo can not find any files from my ext3. Was this 
> the problem recently discussed here about silo?
> 
> Debian unstable's silo 1.4.14+git20120127-1 and 110G ext3 filesystem. 
> The same machine worked fine for years, running all the kernels and 
> Debian unstable. Last successful reboot was less than a week ago, and 
> Debian was updated after that (probably updating silo package).
> Today I compiled 3.3-rc4+git and rebooted to try it, and silo can not 
> find anything. silo itself loads but can not open neither /etc/silo.conf 
> nor any kernel image by direct name:

I really wish they hadn't pushed this new SILO into debian without a
couple months more testing of the new ext{2,3,4} code I wrote.

I knew there would be regressions like this and it's not ready at all
for mass consumption.
