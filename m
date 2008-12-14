From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 14 Dec 2008 11:19:01 +0000
Subject: Re: [PATCH] Adding additional PCI ID for XVR-500 fb driver
Message-Id: <20081214111901.GA4906@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081201210534.GA5457@droopy.oc.cox.net>
In-Reply-To: <20081201210534.GA5457@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 01, 2008 at 09:05:34PM +0000, Jurij Smakov wrote:
> Hi,
> 
> My SunBlade 1000 has the following graphics chip:
> 
> 0000:00:01.0 VGA compatible controller: Intergraph Corporation Sun Expert3D-Lite Graphics Accelerator
> 
> with PCI ID 1091:07a0 (vendor ID is Intergraph Corporation). I've 
> noticed that XVR-500 framebuffer driver (drivers/video/sunxvr500.c) 
> supports the framebuffer device 3d3d:07a0, which only has the same 
> device ID but a different vendor (3D Labs). Given that 3D Labs bought 
> up Intergraph Corporation at some point, it's probably the same chip, 
> so I tried adding 1091:07a0 to the list of supported PCI IDs for 
> sunxvr500.c and it worked without problems, the console now is much 
> nicer than the default PROM monochrome one. Please consider applying 
> the included patch, which adds this card to the list of supported 
> devices for XVR-500 driver.
> 
> Signed-off-by: Jurij Smakov <jurij@wooyd.org>
> Tested-by: Jurij Smakov <jurij@wooyd.org>

Ping.

Dave, can you please either apply it or tell me whether there is 
something wrong with this patch?

Thanks.
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
