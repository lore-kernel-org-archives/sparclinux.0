From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 01 May 2020 02:29:00 +0000
Subject: Re: [PATCH V1 00/10] Remove duplicated kmap code
Message-Id: <87imhge6c3.fsf@mpe.ellerman.id.au>
List-Id: <sparclinux.vger.kernel.org>
References: <20200430203845.582900-1-ira.weiny@intel.com>
In-Reply-To: <20200430203845.582900-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ira.weiny@intel.com, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@linux.intel.com>, dri-devel@lists.freedesktop.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Helge Deller <deller@gmx.de>, x86@kernel.org, linux-csky@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-parisc@vger.kernel.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>

ira.weiny@intel.com writes:
> From: Ira Weiny <ira.weiny@intel.com>
>
> The kmap infrastructure has been copied almost verbatim to every architecture.
> This series consolidates obvious duplicated code by defining core functions
> which call into the architectures only when needed.
>
> Some of the k[un]map_atomic() implementations have some similarities but the
> similarities were not sufficient to warrant further changes.
>
> In addition we remove a duplicate implementation of kmap() in DRM.
>
> Testing was done by 0day to cover all the architectures I can't readily
> build/test.

I threw some powerpc builds at it and they all passed, so LGTM.

cheers
