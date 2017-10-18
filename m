From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Date: Wed, 18 Oct 2017 16:55:02 +0000
Subject: Re: [PATCH v12 08/11] arm64/kasan: add and use kasan_map_populate()
Message-Id: <0ae84532-8dcb-10aa-9d69-79d7025b089e@virtuozzo.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171013173214.27300-1-pasha.tatashin@oracle.com>
 <20171013173214.27300-9-pasha.tatashin@oracle.com>
In-Reply-To: <20171013173214.27300-9-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 10/13/2017 08:32 PM, Pavel Tatashin wrote:
> During early boot, kasan uses vmemmap_populate() to establish its shadow
> memory. But, that interface is intended for struct pages use.
> 
> Because of the current project, vmemmap won't be zeroed during allocation,
> but kasan expects that memory to be zeroed. We are adding a new
> kasan_map_populate() function to resolve this difference.
> 
> Therefore, we must use a new interface to allocate and map kasan shadow
> memory, that also zeroes memory for us.
> 

What's the point of this patch? We have "arm64: kasan: Avoid using vmemmap_populate to initialise shadow"
which does the right thing and basically reverts this patch.
This patch as intermediate step looks absolutely useless. We can just avoid vemmap_populate() right away.

> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> ---
>  arch/arm64/mm/kasan_init.c | 72 ++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
> index 81f03959a4ab..cb4af2951c90 100644
> --- a/arch/arm64/mm/kasan_init.c
> +++ b/arch/arm64/mm/kasan_init.c
> @@ -28,6 +28,66 @@
>  
