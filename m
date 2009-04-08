From: seb@frankengul.org
Date: Wed, 08 Apr 2009 22:44:19 +0000
Subject: Re: SunFire V240 hangs
Message-Id: <20090408224419.GD1142@frankengul.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090408200711.GA1142@frankengul.org>
In-Reply-To: <20090408200711.GA1142@frankengul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 08, 2009 at 03:26:26PM -0700, David Miller wrote:
> +#endif
>  
>  	switch (tlb_type) {
>  	case hypervisor:

Strange, with arch_initcall(pcr_arch_init); commented, the kernel builds fine;

However, the good news is that this kernel boots fine.

	Seb

