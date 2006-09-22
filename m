From: David Miller <davem@davemloft.net>
Date: Fri, 22 Sep 2006 22:22:59 +0000
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
Message-Id: <20060922.152259.54193010.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200609222215.k8MMFfAj023040@harpo.it.uu.se>
In-Reply-To: <200609222215.k8MMFfAj023040@harpo.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: linux-kernel@vger.kernel.org, simoneau@ele.uri.edu, sparclinux@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sat, 23 Sep 2006 00:15:41 +0200 (MEST)

> I rechecked with 2.6.18 final, and the behaviour is as I described:
> gcc-4.1.1 causes the alignment exceptions, while gcc-3.4.6 does not.
> I didn't get any PCI errors now, but I'm sure I did get them in the
> 2.6.17 or early 2.6.18-rc kernels.
> 
> Here's a dmesg diff to show what happens, between the gcc-4.1.1
> and gcc-3.4.6 compiled kernels. The first part is from kernel
> bootup + user-space modprobe of the USB EHCI etc modules:

Thanks for taking a look into this, I'll dig deeper when
I get a chance.
