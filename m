From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 25 Oct 2014 21:13:52 +0000
Subject: Re: Current git: good!
Message-Id: <20141025211351.GA13818@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410252253420.11445@adalberg.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1410252253420.11445@adalberg.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Oct 25, 2014 at 11:03:17PM +0300, Meelis Roos wrote:
> I tested todays git (3.18.0-rc1-00422-g2cc9188) on a bunch of machines 
> and it seems good. THP, RED state on reboot, SIGBUS and gcc-4.9 problems 
> are all gone and I did not notice any new (except already broken V480 
> but I will dig some more to make a better report or two). Than you for 
> the good work!
> 
> The machines tested:
> 
> U1, U2 (with esp blkmq patch)
> U5, Blade 100, V100, E3500, Netra X1
> V210, V245, V440
> T2000 (bare hardware)
> 
> Not tested yet:
> U10 - has radeon detection hang now that PCI allocation is fixed
> E220R, E420R - I need to set up RSC, no problems expected
> E250, E450 - not currently wired up (need to set up RSC on E250).
> 
> There are some warnings in dmesg, I will look when I have time and 
> report (RCU on E3500 is probably new, others not).
> 
> Additionally, I have noted network instability with tulip driver on 
> Netra X1 in the past, but during testing with iperf it seems stable but 
> asymmetric (91 Mbps in one direction, 31 in another) - I will keep an 
> eye open.

Considering the state of your machines half a year ago this really looks good.
Well done from both of you.

	Sam
