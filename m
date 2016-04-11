From: David Miller <davem@davemloft.net>
Date: Mon, 11 Apr 2016 16:08:19 +0000
Subject: Re: Kernel panic under qemu-system-sparc64 when adding kb_ps2/kdmouse DT nodes
Message-Id: <20160411.120819.530596837437685059.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <570BA28F.3020407@ilande.co.uk>
In-Reply-To: <570BA28F.3020407@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 11 Apr 2016 14:11:43 +0100

> 0 > cd kb_ps2  ok
> 0 > .properties
> name                      "kb_ps2"
> device_type               "serial"
> reg                       00000000
> keyboard                  ffffffff
> address                   60
>  ok
> 0 > cd ..  ok
> 0 > cd kdmouse  ok
> 0 > .properties
> name                      "kdmouse"
> device_type               "mouse"
> reg                       00000001
> mouse                     ffffffff
> address                   60
>  ok

The kbd and mouse nodes must have interrupts properties too.
