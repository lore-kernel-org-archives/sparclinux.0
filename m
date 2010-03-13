From: David Miller <davem@davemloft.net>
Date: Sat, 13 Mar 2010 19:19:42 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <20100313.111942.115594162.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 13 Mar 2010 11:12:41 -0800 (PST)

> From: Frans van Berckel <fberckel@xs4all.nl>
> Date: Sat, 13 Mar 2010 18:57:28 +0100
> 
>> Next the screen is switching into blue letters, it scrolls on and on, as
>> expected. At the end it prints a blinking cursor. It freezes the cursor.
>> But the system goes on and is still accessible with ssh.
> 
> So once the kernel switches from the PROM console output and
> into the framebuffer driver, the characters printed are blue?
> 
> What color is the screen background when this happens?

Meanwhile I think I know what the problem is, please try
this patch on top of what you have:

diff --git a/drivers/video/sunxvr1000.c b/drivers/video/sunxvr1000.c
index 8066e88..a8248c0 100644
--- a/drivers/video/sunxvr1000.c
+++ b/drivers/video/sunxvr1000.c
@@ -52,7 +52,7 @@ static int gfb_setcolreg(unsigned regno,
 		green >>= 8;
 		blue >>= 8;
 
-		value = (blue << 24) | (green << 16) | (red << 8);
+		value = (blue << 16) | (green << 8) | red;
 		((u32 *)info->pseudo_palette)[regno] = value;
 	}
 
