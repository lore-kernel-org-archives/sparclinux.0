From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 25 Nov 2016 21:22:58 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <20161125212258.GC27864@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi John.

On Thu, Nov 24, 2016 at 11:59:32PM +0100, John Paul Adrian Glaubitz wrote:
> This patch adds the necessary changes to compile silo
> on sparc64. It adds the required stack bias for stack
> operations and makes sure that all variables are properly
> aligned and have the proper size, both on 32- and 64-bit
> targets. These changes have been verified to work and
> have been used in Debian to ship silo as a 64-bit package.
> 
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
>  Rules.make          |  5 ++---
>  common/console.c    |  6 +++---
>  common/divdi3.S     | 11 ++++++++++-
>  common/jmp.S        | 10 ++++++++--
>  common/prom.c       |  4 ++--
>  common/tree.c       |  8 ++++----
>  common/udivdi3.S    | 10 +++++++++-
>  first-isofs/crt0.S  |  8 +++++++-
>  first-isofs/isofs.c |  6 +++---
>  second/crt0.S       | 21 +++++++++++++++++++--
>  second/disk.c       |  8 ++++----
>  second/file.c       |  2 +-
>  second/muldi3.S     | 10 +++++++++-
>  silo/silo.c         | 12 ++++++------
>  14 files changed, 87 insertions(+), 34 deletions(-)
> 
> diff --git a/Rules.make b/Rules.make
> index 0f176db..e46af48 100644
> --- a/Rules.make
> +++ b/Rules.make
> @@ -2,10 +2,9 @@ VERSION=1.4.14
>  IMGVERSION=0.99
>  SHELL=/bin/bash
>  RM=rm -f
> -# We want to force 32-bit builds
> -CC=gcc -m32
> +CC=gcc
>  HOSTCC=gcc
> -LD=ld -m elf32_sparc
> +LD=ld
>  AS=as
>  STRIP=strip
>  NM=nm
> diff --git a/common/console.c b/common/console.c
> index 44d7efb..270caca 100644
> --- a/common/console.c
> +++ b/common/console.c
> @@ -27,7 +27,7 @@ prom_nbgetchar(void)
>  			i = inc;
>  		break;
>  	case PROM_P1275:
> -		if (p1275_cmd ("read", 3, prom_stdin, &inc, 1) = 1)
> +		if (p1275_cmd ("read", 3, (unsigned int) prom_stdin, &inc, 1) = 1)
This is unrelated to the changelog.

The prototype:
int p1275_cmd (char *service, unsigned fmt, ...)

The above fixes a warning, where the right fix would be to let p1275_cmd()
take a signed paramter.

Likewise for all other cases that cast when calling p1275_cmd().

> +#define _SV save %sp, -STACK_BIAS-0x40, %sp

Spaces arounf "-" please.


>  #define _RV restore
>  #define FLUSH_ALL_WINDOWS \
>  	_SV; _SV; _SV; _SV; _SV; _SV; _SV; \
> @@ -46,7 +52,7 @@ __longjmp:
>  	FLUSH_ALL_WINDOWS
>  	ld [%o0], %o7		/* Return PC.  */
>  	ld [%o0 + 4], %fp	/* Saved SP.  */
> -	sub %fp, 64, %sp	/* Allocate a register save area.  */
> +	sub %fp, 64+STACK_BIAS, %sp	/* Allocate a register save area.  */
Spaces around "+"

>  	tst %o1
>  	be,a 1f
>  	mov 1, %o1
> diff --git a/common/prom.c b/common/prom.c
> index 939bbb9..7585e10 100644
> --- a/common/prom.c
> +++ b/common/prom.c
> @@ -196,7 +196,7 @@ int prom_map(int mode, unsigned long long size,
>  			    P1275_ARG_64B(3) | P1275_ARG_64B(4) |
>  			    P1275_ARG_64B(6) | 7,
>  			    "map",
> -			    prom_get_mmu_ihandle(),
> +			    (unsigned int) prom_get_mmu_ihandle(),
>  			    mode,
>  			    size,
>  			    vaddr,
> @@ -211,7 +211,7 @@ void prom_unmap(unsigned long long size, unsigned long long vaddr)
>  	p1275_cmd("call-method",
>  		  P1275_ARG_64B(2) | P1275_ARG_64B(3) | 4,
>  		  "unmap",
> -		  prom_get_mmu_ihandle(),
> +		  (unsigned int) prom_get_mmu_ihandle(),
>  		  size,
>  		  vaddr);
>  }

In both cases where the static prom_get_mmu_ihandle() is used
the return value has a cast int => unsigned int
If the unsigned variable is required then fix the function.


> diff --git a/common/tree.c b/common/tree.c
> index 56da8b8..65a7743 100644
> --- a/common/tree.c
> +++ b/common/tree.c
> @@ -22,7 +22,7 @@ int prom_getchild(int node)
>  	if (prom_vers != PROM_P1275)
>  		cnode = prom_nodeops->no_child(node);
>  	else
> -		cnode = p1275_cmd ("child", 1, node);
> +		cnode = p1275_cmd ("child", 1, (unsigned int) node);
Cannot see why this is required?

>  		
>  	if (cnode = 0 || cnode = -1)
>  		return 0;
> @@ -43,7 +43,7 @@ int prom_getsibling(int node)
>  	if (prom_vers != PROM_P1275)
>  		sibnode = prom_nodeops->no_nextnode(node);
>  	else
> -		sibnode = p1275_cmd ("peer", 1, node);
> +		sibnode = p1275_cmd ("peer", 1, (unsigned int) node);
Cannot see why this is required?

>  		
>  	if (sibnode = 0 || sibnode = -1)
>  		return 0;
> @@ -64,7 +64,7 @@ int prom_getproplen(int node, char *prop)
>  		if (prom_vers != PROM_P1275)
>  			ret = prom_nodeops->no_proplen(node, prop);
>  		else
> -			ret = p1275_cmd ("getproplen", 2, node, prop);
> +			ret = p1275_cmd ("getproplen", 2, (unsigned int) node, prop)
Likewise...


>  	}
>  	return ret;
>  }
> @@ -85,7 +85,7 @@ int prom_getproperty(int node, char *prop, char *buffer, int bufsize)
>  		if (prom_vers != PROM_P1275)
>  			ret = prom_nodeops->no_getprop(node, prop, buffer);
>  		else
> -			ret = p1275_cmd ("getprop", 4, node, prop, buffer, bufsize);
> +			ret = p1275_cmd ("getprop", 4, (unsigned int) node, prop, buffer, bufsize);
Likewise..
Same ges for reaming uses of cast to unisged int in p1275_cmd() calls.
Maybe I have missed something obvious?

> --- a/second/disk.c
> +++ b/second/disk.c
> @@ -79,7 +79,7 @@ int silo_disk_open(char *device)
>  
>          	fd = p1275_cmd ("open", 1, device);
>          	if ((unsigned)(fd + 1) > 1) {
> -		    node = p1275_cmd ("instance-to-package", 1, fd);
> +		    node = p1275_cmd ("instance-to-package", 1, (unsigned)fd);
New pattern. Now a cast to (unsigned) not (unsigend int) as before.
Goes for the rest of the file.

> diff --git a/second/file.c b/second/file.c
> index c7c1ed2..379af2f 100644
> --- a/second/file.c
> +++ b/second/file.c
> @@ -193,7 +193,7 @@ int dump_block (blk_t * blocknr, int blockcnt)
>                  }
>                  last_blockcnt = -1;
>              }
> -            if ((char *)filebuffer + (block_cnt + ((*blocknr) ? (blockcnt - last_blockcnt - 1) : 0)) * bs > filelimit) {
> +            if ((unsigned int)filebuffer + (block_cnt + ((*blocknr) ? (blockcnt - last_blockcnt - 1) : 0)) * bs > filelimit) {

That if () needs a rewrite to somethign readable - which is not
the fault of this patch.

> +++ b/second/muldi3.S
> @@ -17,11 +17,19 @@ along with GNU CC; see the file COPYING.  If not, write to
>  the Free Software Foundation, 59 Temple Place - Suite 330,
>  Boston, MA 02111-1307, USA.  */
>  
> +#if __WORDSIZE = 32
> +# define STACK_BIAS 0
> +#else
> +# define STACK_BIAS 2047
> +#endif

The above have been repeated a few times now.
Stuff it in a header so we have on place to define this.


> diff --git a/silo/silo.c b/silo/silo.c
> index 9728af2..20b7a0c 100644
> --- a/silo/silo.c
> +++ b/silo/silo.c
> @@ -107,14 +107,14 @@ static int allow_confchk_fail = 0;
>  
>  /* This is just so that we don't have to fight with incompatible ufs_fs.h headers */
>  #define SILO_UFS_MAGIC 0x00011954
> -struct silo_ufs_super_block {
> +struct __attribute__((packed)) silo_ufs_super_block {
>  	unsigned char xxx1[36];
>  	unsigned int fs_fsize;
>  	unsigned char xxx2[1332];
>  	unsigned int fs_magic;
>  };
>                                  
> -struct sun_disklabel {
> +struct __attribute__((packed)) sun_disklabel {
>      unsigned char info[128];	/* Informative text string */
>      unsigned char spare[292];	/* Boot information etc. */
>      unsigned short rspeed;	/* Disk rotational speed */
> @@ -127,9 +127,9 @@ struct sun_disklabel {
>      unsigned short ntrks;	/* Tracks per cylinder */
>      unsigned short nsect;	/* Sectors per track */
>      unsigned char spare3[4];	/* Even more magic... */
> -    struct sun_partition {
> -	unsigned long start_cylinder;
> -	unsigned long num_sectors;
> +    struct __attribute__((packed)) sun_partition {
> +	unsigned int start_cylinder;
> +	unsigned int num_sectors;
>      } partitions[8];
>      unsigned short magic;	/* Magic number */
>      unsigned short csum;	/* Label xor'd checksum */

The kernel variant uses __be16/__be32 - we should maybe do the same here.
And the kernel do not need any packer attribute?!?

> @@ -205,7 +205,7 @@ int check_fs (int fd)
>  {
>      struct silo_ufs_super_block ufs;
>      struct ext2_super_block sb;	/* Super Block Info */
> -    struct romfs_super_block {
> +    struct __attribute__((packed)) romfs_super_block {
>  	__u32 word0;
>  	__u32 word1;
>  	__u32 size;
See how the kernel define this wwithout packed attribute. Maybe better?

	Sam
