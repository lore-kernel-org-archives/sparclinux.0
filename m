From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sun, 24 Sep 2006 13:58:46 +0000
Subject: Re: [sparc64] 2.6.18 unaligned acccess in ehci_hub_control
Message-Id: <200609241358.k8ODwkZJ016350@harpo.it.uu.se>
List-Id: <sparclinux.vger.kernel.org>
References: <20060920172123.GA9334@ele.uri.edu>
In-Reply-To: <20060920172123.GA9334@ele.uri.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, greg@kroah.com
Cc: linux-kernel@vger.kernel.org, simoneau@ele.uri.edu, sparclinux@vger.kernel.org

On Sat, 23 Sep 2006 17:05:31 -0700 (PDT), David Miller wrote:
>[USB]: Fix alignment of buffer passed down to ->hub_control()
>
>Implementations assume the buffer is at least 4 byte aligned.
>
>Signed-off-by: David S. Miller <davem@davemloft.net>
>
>diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>index fb4d058..7766d7b 100644
>--- a/drivers/usb/core/hcd.c
>+++ b/drivers/usb/core/hcd.c
>@@ -344,7 +344,8 @@ static int rh_call_control (struct usb_h
> 	struct usb_ctrlrequest *cmd;
>  	u16		typeReq, wValue, wIndex, wLength;
> 	u8		*ubuf = urb->transfer_buffer;
>-	u8		tbuf [sizeof (struct usb_hub_descriptor)];
>+	u8		tbuf [sizeof (struct usb_hub_descriptor)]
>+		__attribute__((aligned(4)));
> 	const u8	*bufp = tbuf;
> 	int		len = 0;
> 	int		patch_wakeup = 0;
>

Thanks, this eliminated the USB alignment traps in my
gcc-4.1.1 compiled sparc64 kernel.

/Mikael
