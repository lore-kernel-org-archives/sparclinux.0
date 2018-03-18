From: David Miller <davem@davemloft.net>
Date: Sun, 18 Mar 2018 15:54:38 +0000
Subject: Re: [PATCH] sparc64: Oracle DAX driver depends on SPARC64
Message-Id: <20180318.115438.1484174295219956260.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1519687278-9785-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1519687278-9785-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, keescook@chromium.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 26 Feb 2018 15:21:18 -0800

> sparc:allmodconfig fails to build as follows.
> 
> ERROR: "mdesc_release" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "sun4v_hvapi_register" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "mdesc_get_property" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "mdesc_node_by_name" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "mdesc_grab" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "sun4v_ccb_info" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "sun4v_ccb_submit" [drivers/sbus/char/oradax.ko] undefined!
> ERROR: "sun4v_ccb_kill" [drivers/sbus/char/oradax.ko] undefined!
> 
> The symbols are only available with SPARC64 builds, thus the driver
> depends on it.
> 
> Fixes: dd0273284c74 ("sparc64: Oracle DAX driver")
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you.
