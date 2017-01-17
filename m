From: David Miller <davem@davemloft.net>
Date: Tue, 17 Jan 2017 03:26:38 +0000
Subject: Re: [PATCH v2 2/2] sparc64: Handle PIO & MEM non-resumable errors.
Message-Id: <20170116.222638.1303554288572754989.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1484590334-15668-3-git-send-email-Liam.Howlett@Oracle.com>
In-Reply-To: <1484590334-15668-3-git-send-email-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Mon, 16 Jan 2017 13:12:14 -0500

> +		return compute_effective_address(regs, insn, (insn >> 25) &
> +				0x1f);

Please do not split up an expression as an argument over multiple lines.

Also, when a call spans multiple lines, the second and subsequent lines
must start precisely at the first column after the openning parenthesis
of the first line.

> +			unsigned long page_cnt = DIV_ROUND_UP(ent->err_size,
> +							      PAGE_SIZE);
> +
> +
> +			/* Break the unfortunate news. */

No need for two empty line there, one is enough.

Otherwise this looks good.

Please fix this up and resubmit the entire series.

Thanks.
