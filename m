From: William Lee Irwin III <wli@holomorphy.com>
Date: Tue, 21 Dec 2004 04:39:46 +0000
Subject: Re: [2/3] sun4d updates (guys, please send me real descriptions!)
Message-Id: <20041221043946.GB771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20041221042836.GZ771@holomorphy.com>
In-Reply-To: <20041221042836.GZ771@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dave, I got the following hunk from Chris Newport and Thomas Bogendoerfer.
I'm not sure of your opinion regarding sun4d impact on generic sbus
driver code. I can drop this hunk (vs. 2.6.10-rc3) if it's not acceptable.

-- wli

On Mon, Dec 20, 2004 at 08:28:36PM -0800, William Lee Irwin III wrote:
>   * prom_sbus_ranges_init(), with all sun4d stuff cut away.
>   * Ask DaveM what is going on here, how is sun4d supposed to work... XXX
>   */
> +/* added back sun4d patch from Thomas Bogendoerfer - should be OK (crn) */
> +
>  static void __init sbus_bus_ranges_init(int parent_node, struct sbus_bus *sbus)
>  {
>  	int len;
> @@ -229,6 +231,18 @@
>  		return;
>  	}
>  	sbus->num_sbus_ranges = len / sizeof(struct linux_prom_ranges);
> +	if (sparc_cpu_model = sun4d) {
> +		struct linux_prom_ranges iounit_ranges[PROMREG_MAX];
> +		int num_iounit_ranges;
> +
> +	len = prom_getproperty(parent_node, "ranges",
> +				(char *) iounit_ranges,
> +				sizeof (iounit_ranges));
> +		if (len != -1) {
> +			num_iounit_ranges = (len/sizeof(struct linux_prom_ranges));
> +			prom_adjust_ranges (sbus->sbus_ranges, sbus->num_sbus_ranges, iounit_ranges, num_iounit_ranges);
> +		}
> +	}
