From: David Miller <davem@davemloft.net>
Date: Sat, 13 Mar 2010 19:12:41 +0000
Subject: Re: XVR-500 additional pci ids
Message-Id: <20100313.111241.60535203.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201002251955.23519.dennis@ausil.us>
In-Reply-To: <201002251955.23519.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans van Berckel <fberckel@xs4all.nl>
Date: Sat, 13 Mar 2010 18:57:28 +0100

> Next the screen is switching into blue letters, it scrolls on and on, as
> expected. At the end it prints a blinking cursor. It freezes the cursor.
> But the system goes on and is still accessible with ssh.

So once the kernel switches from the PROM console output and
into the framebuffer driver, the characters printed are blue?

What color is the screen background when this happens?
