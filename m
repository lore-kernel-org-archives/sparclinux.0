From: Steven Rostedt <rostedt@goodmis.org>
Date: Tue, 21 May 2019 14:59:26 +0000
Subject: Re: [PATCH] tracing: fix typos in code and comments
Message-Id: <20190521105926.5fa601da@gandalf.local.home>
List-Id: <sparclinux.vger.kernel.org>
References: <20190521144740.22490-1-houweitao@xiaomi.com>
In-Reply-To: <20190521144740.22490-1-houweitao@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: houweitao <houweitaoo@gmail.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it, alexandre.belloni@bootlin.com, festevam@gmail.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, baohua@kernel.org, davem@davemloft.net, yamada.masahiro@socionext.com, mingo@redhat.com, linux-imx@nxp.com, kernel@pengutronix.de, jslaby@suse.com, sparclinux@vger.kernel.org, houweitao <houweitao@xiaomi.com>, shawnguo@kernel.org, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Tue, 21 May 2019 22:47:40 +0800
houweitao <houweitaoo@gmail.com> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2c92b3d9ea30..bfa5ab0663e7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8554,7 +8554,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
>  	ftrace_init_tracefs(tr, d_tracer);
>  }
>  
> -static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
> +static struct vfsmount *trace_automount(struct dentry *mntpt, void *ignore)

"ingore we trust"

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  {
>  	struct vfsmount *mnt;
>  	struct file_system_type *type;
> -- 
