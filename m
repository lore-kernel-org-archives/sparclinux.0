From: Yann Droneaud <ydroneaud@opteya.com>
Date: Mon, 27 Jan 2014 21:42:22 +0000
Subject: Re: [PATCH] arm64: Add pdev_archdata for dmamask
Message-Id: <1390858942-10904-1-git-send-email-ydroneaud@opteya.com>
List-Id: <sparclinux.vger.kernel.org>
References: <y> <1390845177-2626-1-git-send-email-lauraa@codeaurora.org>
 <20140127181836.GH26766@pengutronix.de>
 <1390854331.23180.22.camel@localhost.localdomain>
 <20140127203635.GA15937@n2100.arm.linux.org.uk>
In-Reply-To: <20140127203635.GA15937@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi Russel,

Le lundi 27 janvier 2014 à 20:36 +0000, Russell King - ARM Linux a
écrit :
> On Mon, Jan 27, 2014 at 09:25:31PM +0100, Yann Droneaud wrote:
> > ARM, even AAAAARGH64 [1], doesn't need a special treatement regarding
> > the infamous dma_mask pointer. So perhaps my solution is better.
> > 
> > This solution (adding dma_mask in pdev_archdata) is already in use in
> > powerpc architecture. See arch/powerpc/kernel/setup-common.c
> > 
> > The advantage of this solution is that it makes a dma_mask placeholder
> > available to statically allocated platform_device struct, while mine
> > only address the problem for platform_device struct allocated with
> > platform_device_alloc().
> 
> As I've already said in this thread, the basic problem comes from DT's
> platform device creation.  It's the responsibility of the device creator
> to set the dma_mask pointer appropriately, and DT doesn't do that.  So,
> DT needs to be fixed rather than everyone introducing their own
> workarounds for this.
>

Sure proliferation of fixes is not what we want.

Note that Uwe added me to the thread not because I tried to address
the same issue, but I tried to improve platform_device_register_full() to
not allocate and leak an u64 used to hold the dma mask provided as part of
platform_device_info. I believe he thought the two issues could be solved
at the same time.

> > I'm also considering using dma_set_mask_and_coherent() in
> > platform_device_register_full() and drivers using
> > platform_device_alloc().
> 
> As the one who introduced dma_set_mask_and_coherent, consider this a
> strong NAK on that.  The reason is dma_set_mask_and_coherent() is
> for drivers to set their requirements, not for the bus requirements
> to be set in the first place.
> 
> It also means that drivers which need no DMA support are subjected to
> DMA restrictions (in that dma_set_mask_and_coherent can error out if
> the platform can't support the DMA mask.)
> 

I'm not sure to understand your point here. If the driver explicitly set
a DMA mask in its call to platform_device_register_full(), can't we suppose
it should be subject to restriction from the platform ?

As I'm not sure to be clear on this particular point, here's the patch I
was considering, (sorry of being quite out of topic):

                           ---8<---

Subject: [PATCH] driver core/platform: use dma_set_mask_and_coherent() in
 platform_device_register_full()

dma_set_mask_and_coherent() is a nice function for setting the
various DMA masks in struct device. Additionnaly, it checks the
mask value against arch limits.

It may be used to control the validity of the dma_mask given to
platform_device_register_full() and setting the masks in struct
platform_device.

Note: as dma_set_mask() does nothing on m68k, or returns -EINVAL
      on sparc (if PCI support not built), etc. this could break
      in unpleasant ways I'm not yet able to detail ...

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 drivers/base/platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index bc78848dd59a..ada1d366e1b6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -446,8 +446,10 @@ struct platform_device *platform_device_register_full(
 		if (!pdev->dev.dma_mask)
 			goto err;
 
-		*pdev->dev.dma_mask = pdevinfo->dma_mask;
-		pdev->dev.coherent_dma_mask = pdevinfo->dma_mask;
+		ret = dma_set_mask_and_coherent(&pdev->dev,
+						pdevinfo->dma_mask);
+		if (ret)
+			goto err;
 	}
 
 	ret = platform_device_add_resources(pdev,
-- 
1.8.5.3
