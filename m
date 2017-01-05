From: David Miller <davem@davemloft.net>
Date: Thu, 05 Jan 2017 00:08:43 +0000
Subject: Re: [PATCH v3] sparc64: shut down to OBP correctly
Message-Id: <20170104.190843.1262530595375443598.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1483574786-109088-1-git-send-email-larry.bassel@oracle.com>
In-Reply-To: <1483574786-109088-1-git-send-email-larry.bassel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Larry Bassel <larry.bassel@oracle.com>
Date: Wed,  4 Jan 2017 16:06:26 -0800

> @@ -116,8 +116,16 @@ void notrace prom_halt(void)
>  	unsigned long args[3];
>  
>  #ifdef CONFIG_SUN_LDOMS
> +    /*
> +     * By storing a no-op command
> +     * in the 'reboot-command' variable we cause OBP
> +     * to ignore the setting of 'auto-boot?' after
> +     * it completes the reset.  This causes the system
> +     * to stop at the ok prompt.
> +     */
> +

Please use a proper TAB character to indent this comment,
just like all of the code surrounding it.
