From: Andrew Walrond <andrew@walrond.org>
Date: Wed, 08 Aug 2007 09:32:35 +0000
Subject: Re: 2.6.22.1 kernel grinds...to......a............halt......
Message-Id: <46B98DB3.90408@walrond.org>
List-Id: <sparclinux.vger.kernel.org>
References: <46B98697.8090802@walrond.org>
In-Reply-To: <46B98697.8090802@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Andrew Walrond wrote:

> This is a 2Gb machine with 2Gb of swap running a distro (<1Gb) out of
> initramfs. It has plenty of free ram at the start of the build (~1Gb)
> so it really shouldn't be invoking the oom-killer I suspect.
> 
> Any clues as to what is going on? I can supply my .config if that will help.
> 

Please disregard. I have just realised that initramfs uses ramfs, not
tmpfs as I assumed, so is not swappable and the oom-killer is quite
possible in these circumstances given the size of the build job.

(There was a patch by Al Boldi around 2.6.18 to use tmpfs but it seems
it didn't go into the kernel)

Ho hum

> Andrew Walrond
> 

