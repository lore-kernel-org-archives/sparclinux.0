From: Dave Hansen <dave.hansen@intel.com>
Date: Thu, 11 Oct 2018 23:47:29 +0000
Subject: Re: [PATCH v2 4/7] arm64/modules: Add rlimit checking for arm64 modules
Message-Id: <25951d99-8ba7-5c9e-938e-baf92395f9e0@intel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20181011233117.7883-1-rick.p.edgecombe@intel.com>
 <20181011233117.7883-5-rick.p.edgecombe@intel.com>
In-Reply-To: <20181011233117.7883-5-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, kernel-hardening@lists.openwall.com, daniel@iogearbox.net, keescook@chromium.org, catalin.marinas@arm.com, will.deacon@arm.com, davem@davemloft.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, arnd@arndb.de, jeyu@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: kristen@linux.intel.com, arjan@linux.intel.com, deneen.t.dock@intel.com

On 10/11/2018 04:31 PM, Rick Edgecombe wrote:
> +	if (check_inc_mod_rlimit(size))
> +		return NULL;
> +
>  	p = __vmalloc_node_range(size, MODULE_ALIGN, module_alloc_base,
>  				module_alloc_base + MODULES_VSIZE,
>  				gfp_mask, PAGE_KERNEL_EXEC, 0,
> @@ -65,6 +68,8 @@ void *module_alloc(unsigned long size)
>  		return NULL;
>  	}
>  
> +	update_mod_rlimit(p, size);

Is there a reason we couldn't just rename all of the existing per-arch
module_alloc() calls to be called, say, "arch_module_alloc()", then put
this new rlimit code in a generic helper that does:


	if (check_inc_mod_rlimit(size))
		return NULL;

	p = arch_module_alloc(...);

	...

	update_mod_rlimit(p, size);
