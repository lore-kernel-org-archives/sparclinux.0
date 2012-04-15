From: David Miller <davem@davemloft.net>
Date: Sun, 15 Apr 2012 17:31:33 +0000
Subject: Re: [PATCH 1/2] sparc32: rename sparc_irq_config to sparc_config
Message-Id: <20120415.133133.1233298562384861100.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404201006.GA16978@merkur.ravnborg.org>
In-Reply-To: <20120404201006.GA16978@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 6 Apr 2012 18:10:03 +0200

>>From e12a1c767cf41a9dbeaf333e71b437731b20c0c8 Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Wed, 4 Apr 2012 13:21:13 +0200
> Subject: [PATCH 1/2] sparc32: rename sparc_irq_config to sparc_config
> 
> This struct holds platform specific config and is thus not
> limited to irq stuff.
> Do not let the name confuse us to think this is irq only.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
