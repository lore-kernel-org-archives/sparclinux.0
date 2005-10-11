From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 11 Oct 2005 21:42:30 +0000
Subject: Re: linux-2.6.14-rc does not boot on Ultra 5
Message-Id: <20051011.144230.126765097.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051011210428.GC2865@leonov.stosberg.net>
In-Reply-To: <20051011210428.GC2865@leonov.stosberg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Stosberg <dennis@stosberg.net>
Date: Tue, 11 Oct 2005 23:04:28 +0200

>   Sun Ultra 5/10 UPA/PCI (UltraSPARC-IIi 270MHz), Keyboard Present
>   OpenBoot 3.11, 64 MB memory installed, Serial #xxxxxxxx.
>   Ethernet address x:x:xx:xx:xx:xx, Host ID: xxxxxxxx.
>   Rebooting with command: boot net
>   Boot device: /pci@1f,0/pci@1,1/network@1,1  File and args:
>   29e000 Illegal Instruction
>   ok

I have an Ultra5 here and will try to reproduce, but meanwhile if you
could send the output of the ".registers" command when it fails like
this it would be appreciated.  Thanks.

