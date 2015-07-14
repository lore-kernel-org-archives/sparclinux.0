From: Thomas Graf <tgraf@suug.ch>
Date: Tue, 14 Jul 2015 21:48:40 +0000
Subject: Re: [PATCH v2] rhashtable: fix for resize events during table walk
Message-Id: <20150714214840.GB20648@pox.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <1436190680-21887-1-git-send-email-phil@nwl.cc>
 <alpine.LRH.2.11.1507150031550.15113@math.ut.ee>
In-Reply-To: <alpine.LRH.2.11.1507150031550.15113@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: Phil Sutter <phil@nwl.cc>, sparclinux@vger.kernel.org, Linux Kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, davem@davemloft.net, herbert@gondor.apana.org.au, daniel@iogearbox.net, geert@linux-m68k.org

On 07/15/15 at 12:35am, mroos@linux.ee wrote:
> Yes, this fixes the error, thank you.
> 
> The new problem with the test - soft lockup - CPU#0 stuck for 22s! is 
> still there on 360 MHz UltraSparc IIi. I understand it is harmless but 
> is there some easy way to make the test avoid NMI watchdog?
> 
> [   58.374173] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper:1]

They don't show up on my system. I will add a schedule() call to the
long loops.
