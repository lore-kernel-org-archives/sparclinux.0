From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sun, 25 Nov 2007 14:53:37 +0000
Subject: Re: Bus error while building Erlang
Message-Id: <47498C71.2080206@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sergei Golovan wrote:
> Hi!

	Hello,

> Recent build of erlang package failed on sparc architecture
> (http://buildd.debian.org/build.php?&pkg=erlang&arch=sparc&file=log).
> I cannot find a reason looking at the log file, and I don't have an
> access to any sparc machine to debug the failure.

	I have seen the same bus error with gcc 4.x (internal error that 
returns a bus error on Sbus based sparc _and_ sparc64 linux boxes). I'm 
trying to find this bug for a long time without any success. I never 
have seen this bug on PCI based sparc64 boxes. Please note that I'm not 
sure that this trouble comes from Sbus subsystem ;-) I suspect a bug in 
sparc/sparc64 kernel.

Tested boxes :
- SS5 (MS/85), 256 MB -> bug (but system not stable)
- SS20 (SM71), 512 MB -> bug (but system not stable)
- SS20 (RT626) 512 MB -> system crashes before I can launch a gcc ;-)
- U1E (U1/170), 640 MB -> bug
- U2E (2*U2/300), 2048 MB -> bug
- U5 (U2/270), 512 MB -> works fine
- U60 (2*U2/450), 1024 MB -> works fine
- U80 (4*U2/450), 2048 MB -> works fine
- U420 (4*U2/450), 4096 MB -> works fine

	Today, I don't try to debug on sparc32 due to a bad support of SMP 
boxes (even in UP, I have some trouble with sparc32). I use a U2/SMP, 
but this bug randomly appears and is very difficult to reproduce. I have 
seen if only with iceape (all versions) and gcc 4.x.
In a first time, I though that my U2 was broken, or that fans were 
halted for some reasons. I have used SUNvts on Solaris9 to test hardware 
and it don't return error.

	I have seen this bug on 2.6.23.1 kernel. Now, my U2 runs with a 
2.6.23.8 (built by gcc-4.1) and I don't see any bus error when I write 
these lines.

	Regards,

	JKB

CC: sparc kernel mailing list
