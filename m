From: David Miller <davem@davemloft.net>
Date: Thu, 25 Oct 2007 00:03:50 +0000
Subject: Re: [BUG] Raid1/5 over iSCSI trouble
Message-Id: <20071024.170350.195077498.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4719B6DE.9040403@systella.fr>
	<471EF07A.5040007@systella.fr>
	<e9c3a7c20710241649qb26c36by5733a93cff394c40@mail.gmail.com>
In-Reply-To: <e9c3a7c20710241649qb26c36by5733a93cff394c40@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dan.j.williams@intel.com
Cc: joel.bertrand@systella.fr, davidsen@tmr.com, linux-raid@vger.kernel.org, sparclinux@vger.kernel.org, iscsitarget-devel@lists.sourceforge.net, blackmagic02881@gmail.com

From: "Dan Williams" <dan.j.williams@intel.com>
Date: Wed, 24 Oct 2007 16:49:28 -0700

> Hopefully it is as painless to run on sparc as it is on IA:
> 
> opcontrol --start --vmlinux=/path/to/vmlinux
> <wait>
> opcontrol --stop
> opreport --image-path=/lib/modules/`uname -r` -l

It is painless, I use it all the time.

The only caveat is to make sure the /path/to/vmlinux is
the pre-stripped kernel image.  The images installed
under /boot/ are usually stripped and thus not suitable
for profiling.
