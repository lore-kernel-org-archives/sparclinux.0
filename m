From: Josip Rodin <joy@entuzijast.net>
Date: Fri, 21 Jan 2011 23:43:44 +0000
Subject: Re: [PATCH 5/5] sparc64: use up-to-data genirq functions
Message-Id: <20110121234344.GA19257@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1295648816-29516-5-git-send-email-sam@ravnborg.org>
In-Reply-To: <1295648816-29516-5-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 21, 2011 at 11:26:56PM +0100, Sam Ravnborg wrote:
> Drop all uses of deprecated genirq features

> -static int sun4u_set_affinity(unsigned int virt_irq,
> -			       const struct cpumask *mask)
> +static int sun4u_set_affinity(struct irq_data *data,
> +			       const struct cpumask *mask, bool force)
> -static int sun4v_set_affinity(unsigned int virt_irq,
> -			       const struct cpumask *mask)
> +static int sun4v_set_affinity(struct irq_data *data,
> +			       const struct cpumask *mask, bool force)
> -static int sun4v_virt_set_affinity(unsigned int virt_irq,
> -				    const struct cpumask *mask)
> +static int sun4v_virt_set_affinity(struct irq_data *data,
> +				    const struct cpumask *mask, bool force)

For the benefit of future readers, maybe add a short comment to the commit
description to explain why these functions are now apparently ignoring the
'force' parameter, that is, does it not apply because it's not presently
implemented, or because it just doesn't make sense.

Just nitpicking, feel free to ignore :)

-- 
     2. That which causes joy or happiness.
