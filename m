From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 10 Apr 2019 19:05:38 +0000
Subject: Re: [PATCH] sparc: use struct_size() in kzalloc()
Message-Id: <b26b5a26-4a6b-1df8-bdda-4b5e14950970@embeddedor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190108161356.GA23617@embeddedor>
In-Reply-To: <20190108161356.GA23617@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dave,

I wonder if you can take this.

Thanks
--
Gustavo

On 1/8/19 10:13 AM, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  arch/sparc/kernel/cpumap.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
> index d1d52822603d..1cb62bfeaa1f 100644
> --- a/arch/sparc/kernel/cpumap.c
> +++ b/arch/sparc/kernel/cpumap.c
> @@ -194,8 +194,7 @@ static struct cpuinfo_tree *build_cpuinfo_tree(void)
>  
>  	n = enumerate_cpuinfo_nodes(tmp_level);
>  
> -	new_tree = kzalloc(sizeof(struct cpuinfo_tree) +
> -	                   (sizeof(struct cpuinfo_node) * n), GFP_ATOMIC);
> +	new_tree = kzalloc(struct_size(new_tree, nodes, n), GFP_ATOMIC);
>  	if (!new_tree)
>  		return NULL;
>  
> 
