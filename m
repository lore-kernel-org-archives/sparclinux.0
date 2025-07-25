Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB98D8F5B;
	Fri, 25 Jul 2025 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476414; cv=none; b=Vxwc6hJe8elBhFXHMkPpglM+m2xhjsZ7EChy07jkbWcvfZNU3eWvWOvAYPikfVK/v3a+uRz1uIeSMCzKf0IVJXwPZDspETH7uFZYq6G5Z6gCBicuYb5MSlOXZTdxSVpDCVN8Io6c1ZDmDOvB6SH0JJkm6pfFjTHAzFjDEoAmk4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476414; c=relaxed/simple;
	bh=Eb7R0vzNuvkhp+R9nVIJ+98RwJOhOd8/YjU7nb6954w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H4fp5WzYmhL02k2AiRzHU4uqh2bojKW0Cc7Q42hUQu3bqqASAXCMV+p3AzGbdVQ+p2NUPxk+bcwsezHS/jQPfpN8q00bSqOeAYGpS+TmlrHhXVNMjSi8Fm+BhSypWBbrPg2ccQG3h2xbo6fFVZofCjLVOU2WVE0uaKJ6vlLkTN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=JtX0Cj0n; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="JtX0Cj0n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3hXHPUeUxmvEcsmfEiNfh97OtvJUeX+1R3CwdMPhUMU=; t=1753476410; x=1754081210; 
	b=JtX0Cj0n2zbdsees+8RsdWTbe/VQpu/H3zRj66Dd5x22LOnBatUve5Xp6wt0Fq47V/WWCFsgEAU
	mWClUF+ZAPOVJ+veBzKCH8WjQj7MA/kWU8GEQJd+hXN2cCyGTdImGnEau7gllTZp8wFzkPElR+UKd
	l6s0ztQjhL4A+EVVMh7WgzLy2eK0D8di5SONPEAFgaCV5c2UCMsq1CWaF25UyHWpOo4hxJH9ne8+a
	cUNFcZj4R5ey0WLj/c2oUHlAknxMhuJu3s98nyruVoD0X3T/inwXzrDLNu2c+fwYd+2RL2irS8XHi
	rVoFcuF7/ds7AgkBftIAHle7yCq3Ry66XG/w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ufPJW-00000001cyG-2WJf; Fri, 25 Jul 2025 22:46:46 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ufPJW-00000003PRb-1HGh; Fri, 25 Jul 2025 22:46:46 +0200
Message-ID: <75cd8cf5b1cddc0914d29df20d3f664efd173b3c.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Fri, 25 Jul 2025 22:46:45 +0200
In-Reply-To: <20250716012446.10357-1-anthony.yznaga@oracle.com>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Anthony,

On Tue, 2025-07-15 at 18:24 -0700, Anthony Yznaga wrote:
> An attempt to exercise sparc hugetlb code in a sun4u-based guest
> running under qemu results in the guest hanging due to being stuck
> in a trap loop. This is due to invalid hugetlb TTEs being installed
> that do not have the expected _PAGE_PMD_HUGE and page size bits set.
> Although the breakage has gone apparently unnoticed for several years,
> fix it now so there is the option to exercise sparc hugetlb code under
> qemu. This can be useful because sun4v support in qemu does not support
> linux guests currently and sun4v-based hardware resources may not be
> readily available.
>=20
> Fix tested with a 6.15.2 and 6.16-rc6 kernels by running libhugetlbfs
> tests on a qemu guest running Debian 13.
>=20
> Fixes: c7d9f77d33a7 ("sparc64: Multi-page size support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
> ---
>  arch/sparc/mm/hugetlbpage.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
> index 80504148d8a5..2048b5c42ca8 100644
> --- a/arch/sparc/mm/hugetlbpage.c
> +++ b/arch/sparc/mm/hugetlbpage.c
> @@ -22,6 +22,26 @@
> =20
>  static pte_t sun4u_hugepage_shift_to_tte(pte_t entry, unsigned int shift=
)
>  {
> +	unsigned long hugepage_size =3D _PAGE_SZ4MB_4U;
> +
> +	pte_val(entry) =3D pte_val(entry) & ~_PAGE_SZALL_4U;
> +
> +	switch (shift) {
> +	case HPAGE_256MB_SHIFT:
> +		hugepage_size =3D _PAGE_SZ256MB_4U;
> +		pte_val(entry) |=3D _PAGE_PMD_HUGE;
> +		break;
> +	case HPAGE_SHIFT:
> +		pte_val(entry) |=3D _PAGE_PMD_HUGE;
> +		break;
> +	case HPAGE_64K_SHIFT:
> +		hugepage_size =3D _PAGE_SZ64K_4U;
> +		break;
> +	default:
> +		WARN_ONCE(1, "unsupported hugepage shift=3D%u\n", shift);
> +	}
> +
> +	pte_val(entry) =3D pte_val(entry) | hugepage_size;
>  	return entry;
>  }
> =20

I have compiled a 4.19.325 kernel with the patched applied on top and boote=
d
that kernel onto an UltraSPARC IIIi machine. I cannot test a current kernel
at the moment as newer kernels do not run stable on sun4u machines at the
moment.

I will try to bisect this problem within the next days. Currently, I don't =
have
serial access to this machine, so I cannot easily reboot it when the kernel
crashes but this should be resolved within the next days.

Here is the output from /proc/cpuinfo:

root@raverin:/home/glaubitz/libhugetlbfs# cat /proc/cpuinfo=20
cpu             : TI UltraSparc IIIi (Jalapeno)
fpu             : UltraSparc IIIi integrated FPU
pmu             : ultra3i
prom            : OBP 4.22.33 2007/06/18 12:45
type            : sun4u
ncpus probed    : 1
ncpus active    : 1
D$ parity tl1   : 0
I$ parity tl1   : 0
Cpu0ClkTck      : 000000005995f5c0
cpucaps         : flush,stbar,swap,muldiv,v9,ultra3,mul32,div32,v8plus,vis,=
vis2
MMU Type        : Cheetah+
MMU PGSZs       : 8K,64K,512K,4MB
root@raverin:/home/glaubitz/libhugetlbfs#

I allocated 25 huge pages:

root@raverin:/home/glaubitz/libhugetlbfs# echo 25 > /proc/sys/vm/nr_hugepag=
es
root@raverin:/home/glaubitz/libhugetlbfs# hugeadm --pool-list
      Size  Minimum  Current  Maximum  Default
     65536        0        0        0        =20
   8388608       25       25       25        *
 268435456        0        0        0        =20
2147483648        0        0        0        =20
root@raverin:/home/glaubitz/libhugetlbfs#

The testsuite then passed without any problems:

root@raverin:/home/glaubitz/libhugetlbfs# make check
PASS
zero_filesize_segment (8M: 64):
test_root (8M: 64):     PASS
meminfo_nohuge (8M: 64):        PASS
gethugepagesize (8M: 64):       PASS
gethugepagesizes (8M: 64):      PASS
HUGETLB_VERBOSE=3D1 empty_mounts (8M: 64):        PASS
HUGETLB_VERBOSE=3D1 large_mounts (8M: 64):        PASS
find_path (8M: 64):     PASS
unlinked_fd (8M: 64):   PASS
readback (8M: 64):      PASS
truncate (8M: 64):      PASS
shared (8M: 64):        PASS
mprotect (8M: 64):      PASS
mlock (8M: 64): PASS
misalign (8M: 64):      PASS
fallocate_basic.sh (8M: 64):    PASS
fallocate_align.sh (8M: 64):    PASS
ptrace-write-hugepage (8M: 64): PASS
icache-hygiene (8M: 64):        PASS
slbpacaflush (8M: 64):  Bad configuration: Atleast online 2 cpus are requir=
ed
straddle_4GB_static (8M: 64):   PASS
huge_at_4GB_normal_below_static (8M: 64):       FAIL    Wrong address with =
MAP_FIXED normal
huge_below_4GB_normal_above_static (8M: 64):    PASS
map_high_truncate_2 (8M: 64):   PASS
misaligned_offset (8M: 64):     PASS (inconclusive)
truncate_above_4GB (8M: 64):    PASS
brk_near_huge (8M: 64): Fatal glibc error: malloc.c:2601 (sysmalloc): asser=
tion failed:=20
task-size-overrun (8M: 64):     PASS
stack_grow_into_huge (8M: 64):  PASS
corrupt-by-cow-opt (8M: 64):    PASS
noresv-preserve-resv-page (8M: 64):     PASS
noresv-regarded-as-resv (8M: 64):       PASS
readahead_reserve.sh (8M: 64):  PASS
madvise_reserve.sh (8M: 64):    PASS
fadvise_reserve.sh (8M: 64):    PASS
mremap-expand-slice-collision.sh (8M: 64):      PASS
mremap-fixed-normal-near-huge.sh (8M: 64):      PASS
mremap-fixed-huge-near-normal.sh (8M: 64):      PASS
set shmmax limit to 67108864
shm-perms (8M: 64):     PASS
private (8M: 64):       PASS
fork-cow (8M: 64):      PASS
direct (8M: 64):        Bad configuration: Failed to open direct-IO file: I=
nvalid argument
malloc (8M: 64):        PASS
LD_PRELOAD=3Dlibhugetlbfs.so HUGETLB_MORECORE=3Dyes malloc (8M: 64):       =
 SKIPPED
LD_PRELOAD=3Dlibhugetlbfs.so HUGETLB_MORECORE=3Dyes HUGETLB_RESTRICT_EXE=3D=
unknown:none malloc (8M: 64):      SKIPPED
LD_PRELOAD=3Dlibhugetlbfs.so HUGETLB_MORECORE=3Dyes HUGETLB_RESTRICT_EXE=3D=
unknown:malloc malloc (8M: 64):    SKIPPED
malloc_manysmall (8M: 64):      PASS
LD_PRELOAD=3Dlibhugetlbfs.so HUGETLB_MORECORE=3Dyes malloc_manysmall (8M: 6=
4):      SKIPPED
GLIBC_TUNABLES=3Dglibc.malloc.tcache_count=3D0 heapshrink (8M: 64): PASS
GLIBC_TUNABLES=3Dglibc.malloc.tcache_count=3D0 LD_PRELOAD=3Dlibheapshrink.s=
o heapshrink (8M: 64):     PASS
GLIBC_TUNABLES=3Dglibc.malloc.tcache_count=3D0 LD_PRELOAD=3Dlibhugetlbfs.so=
 HUGETLB_MORECORE=3Dyes heapshrink (8M: 64): SKIPPED
GLIBC_TUNABLES=3Dglibc.malloc.tcache_count=3D0 LD_PRELOAD=3Dlibhugetlbfs.so=
 libheapshrink.so HUGETLB_MORECORE=3Dyes heapshrink (8M: 64):        SKIPPE=
D
GLIBC_TUNABLES=3Dglibc.malloc.tcache_count=3D0 LD_PRELOAD=3Dlibheapshrink.s=
o HUGETLB_MORECORE=3Dyes HUGETLB_MORECORE_SHRINK=3Dyes heapshrink (8M: 64):=
    SKIPPED
GLIBC_TUNABLES=3Dglibc.malloc.tcache_count=3D0 LD_PRELOAD=3Dlibhugetlbfs.so=
 libheapshrink.so HUGETLB_MORECORE=3Dyes HUGETLB_MORECORE_SHRINK=3Dyes heap=
shrink (8M: 64):    SKIPPED
HUGETLB_VERBOSE=3D1 HUGETLB_MORECORE=3Dyes heap-overflow (8M: 64):  SKIPPED
HUGETLB_VERBOSE=3D0 linkhuge_nofd (8M: 64):
LD_PRELOAD=3Dlibhugetlbfs.so HUGETLB_VERBOSE=3D0 linkhuge_nofd (8M: 64):
HUGETLB_VERBOSE=3D0 xB.linkhuge_nofd (8M: 64):
HUGETLB_VERBOSE=3D0 xBDT.linkhuge_nofd (8M: 64):
HUGETLB_MINIMAL_COPY=3Dno HUGETLB_VERBOSE=3D0 xB.linkhuge_nofd (8M: 64):
HUGETLB_MINIMAL_COPY=3Dno HUGETLB_VERBOSE=3D0 xBDT.linkhuge_nofd (8M: 64):
HUGETLB_ELFMAP=3Dno HUGETLB_VERBOSE=3D0 xB.linkhuge_nofd (8M: 64):
HUGETLB_ELFMAP=3Dno HUGETLB_VERBOSE=3D0 xBDT.linkhuge_nofd (8M: 64):
linkhuge (8M: 64):
LD_PRELOAD=3Dlibhugetlbfs.so linkhuge (8M: 64):
xB.linkhuge (8M: 64):
xBDT.linkhuge (8M: 64):
HUGETLB_MINIMAL_COPY=3Dno xB.linkhuge (8M: 64):
HUGETLB_MINIMAL_COPY=3Dno xBDT.linkhuge (8M: 64):
HUGETLB_ELFMAP=3Dno xB.linkhuge (8M: 64):
HUGETLB_ELFMAP=3Dno xBDT.linkhuge (8M: 64):
HUGETLB_SHARE=3D1 xB.linkshare (8M: 64):
HUGETLB_SHARE=3D1 xBDT.linkshare (8M: 64):
HUGETLB_SHARE=3D1 xB.linkshare (8M: 64):
HUGETLB_SHARE=3D1 xBDT.linkshare (8M: 64):
HUGETLB_SHARE=3D0 xB.linkhuge (8M: 64):
HUGETLB_SHARE=3D1 xB.linkhuge (8M: 64):
HUGETLB_SHARE=3D0 xBDT.linkhuge (8M: 64):
HUGETLB_SHARE=3D1 xBDT.linkhuge (8M: 64):
linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3DR linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3DW linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3DRW linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3Dno linkhuge_rw (8M: 64):
HUGETLB_MINIMAL_COPY=3Dno HUGETLB_ELFMAP=3DR linkhuge_rw (8M: 64):
HUGETLB_MINIMAL_COPY=3Dno HUGETLB_ELFMAP=3DW linkhuge_rw (8M: 64):
HUGETLB_MINIMAL_COPY=3Dno HUGETLB_ELFMAP=3DRW linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3DR HUGETLB_SHARE=3D0 linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3DR HUGETLB_SHARE=3D1 linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3DW HUGETLB_SHARE=3D0 linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3DW HUGETLB_SHARE=3D1 linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3DRW HUGETLB_SHARE=3D0 linkhuge_rw (8M: 64):
HUGETLB_ELFMAP=3DRW HUGETLB_SHARE=3D1 linkhuge_rw (8M: 64):
chunk-overcommit (8M: 64):      PASS
alloc-instantiate-race shared (8M: 64): Bad configuration: Atleast online 2=
 cpus are required
alloc-instantiate-race private (8M: 64):        Bad configuration: Atleast =
online 2 cpus are required
truncate_reserve_wraparound (8M: 64):   PASS
truncate_sigbus_versus_oom (8M: 64):    PASS
get_huge_pages (8M: 64):        PASS
shmoverride_linked (8M: 64):    PASS
HUGETLB_SHM=3Dyes shmoverride_linked (8M: 64):    PASS
LD_PRELOAD=3Dlibhugetlbfs.so shmoverride_unlinked (8M: 64):       PASS
LD_PRELOAD=3Dlibhugetlbfs.so HUGETLB_SHM=3Dyes shmoverride_unlinked (8M: 64=
):       PASS
quota.sh (8M: 64):      PASS
counters.sh (8M: 64):   PASS
mmap-gettest 10 25 (8M: 64):    PASS
mmap-cow 24 25 (8M: 64):        PASS
set shmmax limit to 209715200
shm-fork 10 12 (8M: 64):        PASS
set shmmax limit to 209715200
shm-fork 10 25 (8M: 64):        PASS
set shmmax limit to 209715200
shm-getraw 25 /dev/full (8M: 64):       PASS
fallocate_stress.sh (8M: 64):   PASS
********** TEST SUMMARY
*                      8M           =20
*                      32-bit 64-bit=20
*     Total testcases:     0    111  =20
*             Skipped:     0      9  =20
*                PASS:     0     57  =20
*                FAIL:     0      1  =20
*    Killed by signal:     0      1  =20
*   Bad configuration:     0      4  =20
*       Expected FAIL:     0      0  =20
*     Unexpected PASS:     0      0  =20
*    Test not present:     0     39  =20
* Strange test result:     0      0  =20
**********
root@raverin:/home/glaubitz/libhugetlbfs#

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
