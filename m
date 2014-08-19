From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 19 Aug 2014 21:18:16 +0000
Subject: Re: [PATCH] sparc: i8042-sparcio.h: fix unused kbd_res warning
Message-Id: <20140819211816.GA12231@core.coreip.homeip.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1408482577-17837-1-git-send-email-vincent.stehle@laposte.net>
In-Reply-To: <1408482577-17837-1-git-send-email-vincent.stehle@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Tue, Aug 19, 2014 at 11:09:37PM +0200, Vincent Stehlé wrote:
> kbd_res is used only when CONFIG_PCI is defined; condition its declaration as
> well. This fixes the following compilation warning:
> 
>   drivers/input/serio/i8042-sparcio.h:20:25: warning: ‘kbd_res’ defined but not used [-Wunused-variable]
> 
> Signed-off-by: Vincent Stehlé <vincent.stehle@laposte.net>

Applied, thank you.

-- 
Dmitry
