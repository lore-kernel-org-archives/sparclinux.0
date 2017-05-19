From: David Miller <davem@davemloft.net>
Date: Fri, 19 May 2017 02:26:29 +0000
Subject: Re: [PATCH 2/6] arch/sparc: Define config parameter CPU_BIG_ENDIAN
Message-Id: <20170518.222629.750013339888739217.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1495154170-854693-1-git-send-email-babu.moger@oracle.com>
        <1495154170-854693-3-git-send-email-babu.moger@oracle.com>
In-Reply-To: <1495154170-854693-3-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: babu.moger@oracle.com
Cc: peterz@infradead.org, mingo@redhat.com, arnd@arndb.de, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 18 May 2017 18:36:06 -0600

> @@ -91,6 +91,10 @@ config ARCH_DEFCONFIG
>  config ARCH_PROC_KCORE_TEXT
>  	def_bool y
>  
> +config CPU_BIG_ENDIAN
> +	bool
> +	default y if SPARC64
> +

32-bit sparc is big-endian too :-)

So please don't use SPARC64 for the setting, use plain SPARC instead.
