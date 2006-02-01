From: "J.O. Aho" <trizt@iname.com>
Date: Wed, 01 Feb 2006 13:15:21 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <Pine.LNX.4.64.0602011406260.27149@lai.local.lan>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512102350310.4739@lai.local.lan>
 <20051210.150034.67577008.davem@davemloft.net> <Pine.LNX.4.64.0512110020050.4809@lai.local.lan>
 <20051211.210752.83944980.davem@davemloft.net>
In-Reply-To: <20051211.210752.83944980.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel maillist <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org

On Sun, 11 Dec 2005, David S. Miller wrote:

> I strongly believe your kernel is being miscompiled by whatever
> gcc is being used to build your kernels.

After a bit posting at comp.sys.sun.hardware I found a person with an 
Ultra60 using Creator3D (UPA) too on it, he had a working X. He did run 
kernel 2.6.8, so today I did install 2.6.8.1 (vanilla) and tested Xorg 
and it worked as well as it does under 2.4.x.

I guess there has been some bad change in the sparc kernel code somewhere 
between 2.6.8.1 and 2.6.13. I can say that 2.6.15.1 still "crashes" the 
kernel. I don't know if there has been any discussion if it's the small 
amount of UPA relatad code that causes the problem or not, but I think 
it's plausible that the UPA code has been "damaged" in the later versions 
of the kernel.


-- 
      //Aho

  ------------------------------------------------------------------------
   E-Mail: trizt@iname.com            URL: http://www.kotiaho.net/~trizt/
      ICQ: 13696780
   System: Linux System                        (PPC7447/1000 AMD K7A/2000)
  ------------------------------------------------------------------------
             EU forbids you to send spam without my permission
  ------------------------------------------------------------------------
