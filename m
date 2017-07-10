From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 Jul 2017 11:46:19 +0000
Subject: Re: in:imklog segfault in 4.12+git on most sparc64's
Message-Id: <alpine.LRH.2.20.1707101442220.5280@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1707101111290.5280@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> > This is with Debian unstable 32-bit userland as of 2015 summer. It did 
> > not happen with 4.12.
> 
> Did you also perform tests with a current 64-bit userland?

No, for the current test this is not relevant since if the breakage 
happens with some userlan, it is kernel at fault.

I have tested sparc64 debian-port on my T5120 where I expected it to be 
fast. For some test it was faster than 32-bit userland. for some things 
slower, but it worked.

I never tested it on older machines so far. I might have tried 
installing on Blade 150 (I am not sure if it was sparc or sparc64) but 
the install was hanging, and I have not finished with it as I suspected 
the PSU that I had just replaced and I have had no time to to hardware 
bisecting with Blade 100.

-- 
Meelis Roos (mroos@linux.ee)
